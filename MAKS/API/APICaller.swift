//
//  APICaller.swift
//  MAKS
//
//  Created by Mario Corte on 12/26/23.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    private init() { }
    
    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.currentProfileURL), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(HTTPError.failedGettingData))
                    return
                }
                
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    func getFollowedArtist(completion: @escaping (Result<Following, Error>) -> Void) {
        var url = URL(string: Constants.followingURL)
        url?.append(queryItems: [
            URLQueryItem(name: "type", value: "artist"),
            URLQueryItem(name: "limit", value: "50")
        ])
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(HTTPError.failedGettingData))
                    return
                }
                
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    
                    let result = try JSONDecoder().decode(Following.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    func getPlaylists(userID: String, completion: @escaping (Result<Playlists, Error>) -> Void) {
        var url = URL(string: String(format: Constants.playlistsURL, userID))
        url?.append(queryItems: [
            URLQueryItem(name: "user_id", value: userID),
            URLQueryItem(name: "limit", value: "41")
        ])
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(HTTPError.failedGettingData))
                    return
                }
                
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    
                    let result = try JSONDecoder().decode(Playlists.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    func getPlaylistTracks(playlistID: String, completion: @escaping (Result<Tracks, Error>) -> Void) {
        let urlString = Constants.baseAPIURL + Constants.playlistsPath + "/\(playlistID)" + Constants.tracksPath
        var url = URL(string: urlString)
        url?.append(queryItems: [
            URLQueryItem(name: "playlist_id", value: playlistID),
            URLQueryItem(name: "market", value: "ES")
        ])
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(HTTPError.failedGettingData))
                    return
                }
                
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    
                    let result = try JSONDecoder().decode(Tracks.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    func getArtistAlbums(artistID: String, completion: @escaping (Result<AlbumResponse, Error>) -> Void) {
        let urlString = Constants.baseAPIURL + Constants.artistsPath + "/\(artistID)" + Constants.albumsPath
        var url = URL(string: urlString)
        url?.append(queryItems: [
            URLQueryItem(name: "id", value: artistID),
            URLQueryItem(name: "include_groups", value: "album")
        ])
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(HTTPError.failedGettingData))
                    return
                }
                
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    
                    let result = try JSONDecoder().decode(AlbumResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    func getTopItems<T: Decodable>(_ type: T.Type = T.self, 
                                   itemType: String,
                                   limit: Int,
                                   completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = Constants.baseAPIURL + Constants.currentProfilePath + Constants.topPath + "/\(itemType)"
        var url = URL(string: urlString)
        url?.append(queryItems: [
            URLQueryItem(name: "limit", value: String(limit))
        ])
        createRequest(with: url, type: .GET) { [weak self] request in
            self?.sendRequest(request: request, type: T.self) { result in
                completion(result)
            }
        }
    }
}

// MARK: - Private

extension APICaller {
    private struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
        static let currentProfilePath = "/me"
        static let followingPath = "/following"
        static let usersPath = "/users"
        static let playlistsPath = "/playlists"
        static let tracksPath = "/tracks"
        static let artistsPath = "/artists"
        static let albumsPath = "/albums"
        static let topPath = "/top"
        static let currentProfileURL = baseAPIURL + currentProfilePath
        static let followingURL = baseAPIURL + currentProfilePath + followingPath
        static let playlistsURL = baseAPIURL + usersPath + "/%@" + playlistsPath
    }
    
    private enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private enum HTTPError: Error {
        case failedGettingData
    }
    
    private func createRequest(with url : URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        guard let url = url else { return }
        AuthManager.shared.withValidAccessToken { accessToken in
            var request = URLRequest(url: url)
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
    func sendRequest<T>(request: URLRequest, 
                        type: T.Type,
                        completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(HTTPError.failedGettingData))
                return
            }
            do {
//                let r = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(r)
                
                let result = try JSONDecoder().decode(type, from: data)
                completion(.success(result))
            }
            catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
