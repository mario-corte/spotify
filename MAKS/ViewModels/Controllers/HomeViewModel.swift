//
//  HomeViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let title = "Home"
    let tabItemImageString = "house"
    
    let topTracksColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let topArtistsColumns = [
        GridItem(.flexible())
    ]
    
    @Published var isLoading = false
    @Published var topTracks: [TrackViewModel]?
    @Published var topArtists: [ArtistViewModel]?
    
    init() {
        getTopTracks()
        getTopArtists()
    }
}

private extension HomeViewModel {
    func getTopTracks() {
        isLoading = true
        APICaller.shared.getTopItems(TopTracks.self, itemType: "tracks", limit: 12) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let model):
                    self.topTracks = model.items.map { TrackViewModel(track: $0) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getTopArtists() {
        isLoading = true
        APICaller.shared.getTopItems(TopArtists.self, itemType: "artists", limit: 12) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let model):
                    self.topArtists = model.items.map { ArtistViewModel(artist: $0) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
