//
//  Playlists.swift
//  MAKS
//
//  Created by Mario Corte on 12/27/23.
//

import Foundation

struct Playlists: Codable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Playlist]
}

struct Playlist: Codable {
    let collaborative: Bool
    let description: String
    let external_urls: [String: String]
    let href: String
    let id: String
    let images: [PlaylistImage]
    let name: String
    let owner: PlaylistOwner
//    let public: Bool
    let snapshot_id: String
    let tracks: PlaylistTraks
    let type: String
    let uri: String
}

struct PlaylistImage: Codable {
    let url: String
}

struct PlaylistOwner: Codable {
    let external_urls: [String: String]
//    let followers: PlaylistOwnerFollowers
    let href: String
    let id: String?
    let type: String
    let uri: String
    let display_name: String?
}

struct PlaylistTraks: Codable {
    let href: String
    let total: Int
}

struct PlaylistOwnerFollowers: Codable {
    let href: String?
    let total: Int
}


//{
//  "href": "https://api.spotify.com/v1/me/shows?offset=0&limit=20",
//  "limit": 20,
//  "next": "https://api.spotify.com/v1/me/shows?offset=1&limit=1",
//  "offset": 0,
//  "previous": "https://api.spotify.com/v1/me/shows?offset=1&limit=1",
//  "total": 4,
//  "items": [
//    {
//      "collaborative": false,
//      "description": "string",
//      "external_urls": {
//        "spotify": "string"
//      },
//      "href": "string",
//      "id": "string",
//      "images": [
//        {
//          "url": "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
//          "height": 300,
//          "width": 300
//        }
//      ],
//      "name": "string",
//      "owner": {
//        "external_urls": {
//          "spotify": "string"
//        },
//        "followers": {
//          "href": "string",
//          "total": 0
//        },
//        "href": "string",
//        "id": "string",
//        "type": "user",
//        "uri": "string",
//        "display_name": "string"
//      },
//      "public": false,
//      "snapshot_id": "string",
//      "tracks": {
//        "href": "string",
//        "total": 0
//      },
//      "type": "string",
//      "uri": "string"
//    }
//  ]
//}
