//
//  AuthManager.swift
//  MAKS
//
//  Created by Mario Corte on 12/23/23.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    private var isRefreshingToken = false
    private var onRefreshBlocks = [(String) -> Void]()
}

extension AuthManager {
    struct Constants {
        static let clientID = "c3bd350bbe084528be3ae3021e59bb2b"
        static let clientSecret = "f4c6d1bc52a047adb79cd1776a21a5f3"
        static let responseType = "code"
        static let scopes = [
            "user-read-private",
            "user-read-email",
            "user-follow-read",
            "user-library-read",
            "user-library-modify",
            "user-top-read",
            "playlist-read-private",
            "playlist-read-collaborative",
            "playlist-modify-private",
            "playlist-modify-public"
        ].joined(separator: " ")
        static let redirectURI = "https://www.google.com"
        static let authorizeBaseStringURL = "https://accounts.spotify.com/authorize"
        static let tokenBaseStringURL = "https://accounts.spotify.com/api/token"
    }
}

extension AuthManager {
    var signInURL: URL? {
        var urlComponents = URLComponents(string: Constants.authorizeBaseStringURL)
        let queryItems = [
            URLQueryItem(name: "response_type", value: Constants.responseType),
            URLQueryItem(name: "client_id", value: Constants.clientID),
            URLQueryItem(name: "scope", value: Constants.scopes),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "show_dialog", value: String(true))
        ]
        urlComponents?.queryItems = queryItems
        
        let fullStringURL = urlComponents?.url?.absoluteString
        guard let fullStringURL = fullStringURL else { return nil }
        return URL(string: fullStringURL)
    }
    
    var isSignedIn: Bool { accessToken != nil }
}

extension AuthManager {
    func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: Constants.tokenBaseStringURL) else { return }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI)
        ]
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let basicTokenData = basicToken.data(using: .utf8)
        guard let basicTokenBase64String = basicTokenData?.base64EncodedString() else {
            print("Failure getting Base64 Basic Token")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(basicTokenBase64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        print(request.url?.absoluteString ?? "")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                completion(false)
                return
            }
            
            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print("SUCCESS: \(json)")
                
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        
        task.resume()
    }
    
    func withValidAccessToken(completion: @escaping (String) -> Void) {
        guard !isRefreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            refreshAccessTokenIfNeeded { [weak self] success in
                if success, let accessToken = self?.accessToken {
                    completion(accessToken)
                }
            }
        }
        else if let accessToken = accessToken {
            completion(accessToken)
        }
    }
    
    func refreshAccessTokenIfNeeded(completion: @escaping (Bool) -> Void) {
        guard !isRefreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let refreshToken = refreshToken else { return }
        
        guard let url = URL(string: Constants.tokenBaseStringURL) else { return }
        
        isRefreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let basicTokenData = basicToken.data(using: .utf8)
        guard let basicTokenBase64String = basicTokenData?.base64EncodedString() else {
            print("Failure getting Base64 Basic Token")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(basicTokenBase64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        print(request.url?.absoluteString ?? "")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            
            self?.isRefreshingToken = false
            
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.onRefreshBlocks.forEach({$0(result.access_token)})
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        
        task.resume()
    }
    
    func signOut() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
        UserDefaults.standard.removeObject(forKey: "token_expiration_date")
    }
}

extension AuthManager {
    private var accessToken: String? {
        UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        UserDefaults.standard.object(forKey: "token_expiration_date") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        
        let currentDate = Date()
        let fiveMinutes = TimeInterval(300)
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
}

extension AuthManager {
    private func cacheToken(_ result: AuthResponse) {
        let access_token = result.access_token
        let refresh_token = result.refresh_token
        let expires_in = result.expires_in
//        let scope = result.scope
//        let tokenType = result.token_type
        
        UserDefaults.standard.setValue(access_token, forKey: "access_token")
        
        if let refresh_token = refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(expires_in)), forKey: "token_expiration_date")
    }
}
