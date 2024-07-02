//
//  AlbumViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 12/28/23.
//

import Foundation

struct AlbumViewModel: Identifiable, Hashable {
    let id: String
    let name: String
    let release_date: String?
    let image: String?
    
    init(album: Album) {
        self.id = album.id
        self.name = album.name
        self.release_date = album.release_date.components(separatedBy: "-").first
        self.image = album.images.first?.url
    }
}

extension AlbumViewModel {
    var imageURL: URL? {
        guard let image = image else { return nil }
        return URL(string: image)
    }
}
