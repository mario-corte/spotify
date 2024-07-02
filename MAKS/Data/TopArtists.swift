//
//  TopArtists.swift
//  MAKS
//
//  Created by Mario Corte on 1/16/24.
//

import Foundation

struct TopArtists: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Artist]
}


//{
//  "href": "https://api.spotify.com/v1/me/top/artists?limit=1&offset=1",
//  "limit": 1,
//  "next": "https://api.spotify.com/v1/me/top/artists?limit=1&offset=2",
//  "offset": 1,
//  "previous": "https://api.spotify.com/v1/me/top/artists?limit=1&offset=0",
//  "total": 50,
//  "items": [
//    {
//      "external_urls": {
//        "spotify": "https://open.spotify.com/artist/2LRoIwlKmHjgvigdNGBHNo"
//      },
//      "followers": {
//        "href": null,
//        "total": 0
//      },
//      "genres": ["colombian pop", "pop reggaeton", "reggaeton", "reggaeton colombiano", "trap latino", "urbano latino"],
//      "href": "https://api.spotify.com/v1/artists/2LRoIwlKmHjgvigdNGBHNo",
//      "id": "2LRoIwlKmHjgvigdNGBHNo",
//      "images": [
//        {
//          "url": "https://i.scdn.co/image/ab6761610000e5eb9e7c05016af970bb9bf76cc1",
//          "height": 640,
//          "width": 640
//        },
//        {
//          "url": "https://i.scdn.co/image/ab676161000051749e7c05016af970bb9bf76cc1",
//          "height": 320,
//          "width": 320
//        },
//        {
//          "url": "https://i.scdn.co/image/ab6761610000f1789e7c05016af970bb9bf76cc1",
//          "height": 160,
//          "width": 160
//        }
//      ],
//      "name": "Feid",
//      "popularity": 90,
//      "type": "artist",
//      "uri": "spotify:artist:2LRoIwlKmHjgvigdNGBHNo"
//    }
//  ]
//}
