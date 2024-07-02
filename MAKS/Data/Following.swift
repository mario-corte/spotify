//
//  Following.swift
//  MAKS
//
//  Created by Mario Corte on 12/27/23.
//

import Foundation

struct Following: Codable {
    let artists: FollowingArtists
}

struct FollowingArtists: Codable {
    let href: String
    let limit: Int
    let next: String
    let cursors: [String: String]
    let total: Int
    let items: [Artist]
}


//{
//    "href": "string",
//    "limit": 0,
//    "next": "string",
//    "cursors": {
//        "after": "string",
//        "before": "string"
//    },
//    "total": 0,
//    "items": [ ]
//}
