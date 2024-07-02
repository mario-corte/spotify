//
//  ArtistDetailViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

class ArtistDetailViewModel: ObservableObject {
    var artist: ArtistViewModel
    
    @Published var isLoading = false
    @Published var albumsTitle: String?
    @Published var albums: [AlbumViewModel]?
        
    let albumsColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(artist: ArtistViewModel) {
        self.artist = artist
        getAlbums()
    }
}

private extension ArtistDetailViewModel {
    func getAlbums() {
        isLoading = true
        APICaller.shared.getArtistAlbums(artistID: artist.id) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let model):
                    self.albumsTitle = "\(model.total) Albums"
                    self.albums = model.items.map { AlbumViewModel(album: $0) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
