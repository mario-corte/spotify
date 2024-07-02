//
//  ProfileDetailViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

class ProfileDetailViewModel: ObservableObject {
    let title = "Profile"
    
    @Published var isLoading = false
    @Published var isAlertPresented = false
    @Published var followingTitle: String?
    @Published var following: [ArtistViewModel]?
    
    init() {
        getFollowing()
    }
}

private extension ProfileDetailViewModel {
    func getFollowing() {
        isLoading = true
        APICaller.shared.getFollowedArtist { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let model):
                    self.followingTitle = "Following \(model.artists.total)"
                    self.following = model.artists.items.map { ArtistViewModel(artist: $0) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
