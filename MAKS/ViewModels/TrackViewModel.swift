//
//  TrackViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 12/28/23.
//

import Foundation

struct TrackViewModel: Identifiable, Hashable {
    let id: String
    let name: String
    let album: String
    let artists: String
    let image: String?
    
    init(track: Track) {
        self.id = track.id
        self.name = track.name
        self.album = track.album.name
        self.artists = track.artists.map { $0.name }.joined(separator: ", ")
        self.image = track.album.images.first?.url
    }
}

extension TrackViewModel {
    var imageURL: URL? {
        guard let image = image else { return nil }
        return URL(string: image)
    }
}


//struct TrackItem: Codable {
//    let track: Track
//}
//
//struct Track: Codable {
//    let id: String
//    let name: String
//    let album: Album
//    let artists: [TrackArtist]
//}
//
//struct Album: Codable {
//    let name: String
//    let images: [AlbumImage]
//}
//
//struct TrackArtist: Codable {
//    let name: String
//}
//
//struct AlbumImage: Codable {
//    let url: String
//}
