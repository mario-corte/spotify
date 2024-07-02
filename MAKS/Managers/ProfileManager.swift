//
//  ProfileManager.swift
//  MAKS
//
//  Created by Mario Corte on 1/15/24.
//

import Foundation

class ProfileManager {
    static let shared = ProfileManager()
    
    var profile: ProfileViewModel? {
        get {
            guard let data = UserDefaults.standard.data(forKey: "profile") else {
                return nil
            }
            do {
                return try JSONDecoder().decode(ProfileViewModel.self, from: data)
            } catch {
                print("Unable to get profile from User Defaults")
                return nil
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: "profile")
            }
            catch {
                print("Unable to store profile in User Defaults")
            }
        }
    }
}

extension ProfileManager {
    func getProfile(completion: @escaping (Error?) -> Void) {
        APICaller.shared.getCurrentUserProfile { result in
            switch result {
            case .success(let model):
                let image = model.images[1].url
                let name = model.display_name
                let id = model.id
                let followers = model.followers["total"] ?? 0
                let email = model.email
                self.profile = ProfileViewModel(image: image, name: name, id: id, followers: followers ?? 0, email: email)
                completion(nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
}
