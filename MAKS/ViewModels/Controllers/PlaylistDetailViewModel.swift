//
//  PlaylistDetailViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import Foundation

class PlaylistDetailViewModel: ObservableObject {
    let playlist: PlaylistViewModel
    
    @Published var isLoading = false
    @Published var tracks: [TrackViewModel]?
    
    init(playlist: PlaylistViewModel) {
        self.playlist = playlist
        getTracks()
    }
}

private extension PlaylistDetailViewModel {
    func getTracks() {
        isLoading = true
        APICaller.shared.getPlaylistTracks(playlistID: playlist.id) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let model):
                    self.tracks = model.items.map { TrackViewModel(track: $0.track) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
