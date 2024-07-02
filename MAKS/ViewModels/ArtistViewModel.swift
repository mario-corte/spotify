//
//  ArtistViewModel.swift
//  MAKS
//
//  Created by Mario Corte on 12/27/23.
//

import Foundation

struct ArtistViewModel: Identifiable, Hashable {
    let id: String
    let external_urls: [String: String]
    let followersDict: [String: Int?]
    let genres: [String]
    let artistID: String
    let image: String?
    let name: String
    
    init(artist: Artist) {
        self.id = artist.id
        self.external_urls = artist.external_urls
        self.followersDict = artist.followers
        self.genres = artist.genres
        self.artistID = artist.id
        self.image = artist.images.first?.url
        self.name = artist.name
    }
}

extension ArtistViewModel {
    var imageURL: URL? {
        guard let image = image else { return nil }
        return URL(string: image)
    }
    
    var followers: Int? {
        followersDict["total"] ?? nil
    }
    
    var artistGenres: String {
        genres.map { $0.capitalized }.joined(separator: ", ")
    }
}
