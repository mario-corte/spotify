//
//  PlaylistsViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

class PlaylistsViewModel: ObservableObject {
    let title = "Playlists"
    let tabItemImageString = "music.note.list"
    let searchBarPrompt = "Search for playlist"
        
    @Published var isLoading = false
    @Published var totalPlaylists: String?
    @Published var playlists: [PlaylistViewModel]?
    @Published var filteredPlaylists: [PlaylistViewModel]?
    @Published var playlistToSearch = String()
    
    let playlistsColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init() {
        getPlaylists()
    }
}

extension PlaylistsViewModel {
    func filterPlaylist(name: String) {
        guard let playlists = playlists else {
            return
        }
        if name.isEmpty {
            filteredPlaylists = playlists
            return
        }
        filteredPlaylists = playlists.filter({ playlist in
            playlist.name.lowercased().contains(name.lowercased())
        })
    }
}

private extension PlaylistsViewModel {
    func getPlaylists() {
        guard let profileID = ProfileManager.shared.profile?.id else { return }
        isLoading = true
        APICaller.shared.getPlaylists(userID: profileID) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let model):
                    self.totalPlaylists = "My Playlists \(model.total)"
                    self.playlists = model.items.map { PlaylistViewModel(playlist: $0) }
                    self.filteredPlaylists = self.playlists
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
