//
//  ProfileViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

class ProfileViewModel: Codable {
    var image: String?
    var name: String
    var id: String
    var followers: Int
    var email: String
    
    init(image: String?, name: String, id: String, followers: Int, email: String) {
        self.image = image
        self.name = name
        self.id = id
        self.followers = followers
        self.email = email
    }
}

extension ProfileViewModel {
    var imageURL: URL? {
        guard let image = image else { return nil }
        return URL(string: image)
    }
}
