//
//  PlaylistViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 12/27/23.
//

import Foundation

struct PlaylistViewModel: Identifiable, Hashable {
    let id: String
    let name: String
    let image: String?
    let tracks: Int
    let owner: String?
    
    init(playlist: Playlist) {
        self.id = playlist.id
        self.name = playlist.name
        self.image = playlist.images.first?.url
        self.tracks = playlist.tracks.total
        self.owner = playlist.owner.display_name
    }
}

extension PlaylistViewModel {
    var imageURL: URL? {
        guard let image = image else { return nil }
        return URL(string: image)
    }
}

//struct Playlist: Codable {
//    let collaborative: Bool
//    let description: String
//    let external_urls: [String: String]
//    let href: String
//    let id: String
//    let images: [PlaylistImage]
//    let name: String
//    let owner: PlaylistOwner
////    let public: Bool
//    let snapshot_id: String
//    let tracks: PlaylistTraks
//    let type: String
//    let uri: String
//}
//
//struct PlaylistImage: Codable {
//    let url: String
//}
//
//struct PlaylistOwner: Codable {
//    let external_urls: [String: String]
////    let followers: PlaylistOwnerFollowers
//    let href: String
//    let id: String?
//    let type: String
//    let uri: String
//    let display_name: String?
//}
//
//struct PlaylistTraks: Codable {
//    let href: String
//    let total: Int
//}
