//
//  TopTracks.swift
//  MAKS
//
//  Created by Mario Corte on 1/16/24.
//

import Foundation

struct TopTracks: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Track]
}


//{
//  "href": "https://api.spotify.com/v1/me/top/tracks?limit=1&offset=1",
//  "limit": 1,
//  "next": "https://api.spotify.com/v1/me/top/tracks?limit=1&offset=2",
//  "offset": 1,
//  "previous": "https://api.spotify.com/v1/me/top/tracks?limit=1&offset=0",
//  "total": 50,
//  "items": [
//    {
//      "album": {
//        "album_type": "ALBUM",
//        "total_tracks": 15,
//        "available_markets": [],
//        "external_urls": {
//          "spotify": "https://open.spotify.com/album/4qNUVazTslSUfkTycl0Axs"
//        },
//        "href": "https://api.spotify.com/v1/albums/4qNUVazTslSUfkTycl0Axs",
//        "id": "4qNUVazTslSUfkTycl0Axs",
//        "images": [
//          {
//            "url": "https://i.scdn.co/image/ab67616d0000b273d7071c1defa5a6584cd57c16",
//            "height": 640,
//            "width": 640
//          },
//          {
//            "url": "https://i.scdn.co/image/ab67616d00001e02d7071c1defa5a6584cd57c16",
//            "height": 300,
//            "width": 300
//          },
//          {
//            "url": "https://i.scdn.co/image/ab67616d00004851d7071c1defa5a6584cd57c16",
//            "height": 64,
//            "width": 64
//          }
//        ],
//        "name": "MOR, No Le Temas a La Oscuridad",
//        "release_date": "2023-09-29",
//        "release_date_precision": "day",
//        "type": "album",
//        "uri": "spotify:album:4qNUVazTslSUfkTycl0Axs",
//        "artists": [
//          {
//            "external_urls": {
//              "spotify": "https://open.spotify.com/artist/2LRoIwlKmHjgvigdNGBHNo"
//            },
//            "href": "https://api.spotify.com/v1/artists/2LRoIwlKmHjgvigdNGBHNo",
//            "id": "2LRoIwlKmHjgvigdNGBHNo",
//            "name": "Feid",
//            "type": "artist",
//            "uri": "spotify:artist:2LRoIwlKmHjgvigdNGBHNo"
//          }
//        ]
//      },
//      "artists": [
//        {
//          "external_urls": {
//            "spotify": "https://open.spotify.com/artist/2LRoIwlKmHjgvigdNGBHNo"
//          },
//          "href": "https://api.spotify.com/v1/artists/2LRoIwlKmHjgvigdNGBHNo",
//          "id": "2LRoIwlKmHjgvigdNGBHNo",
//          "name": "Feid",
//          "type": "artist",
//          "uri": "spotify:artist:2LRoIwlKmHjgvigdNGBHNo"
//        }
//      ],
//      "available_markets": [],
//      "disc_number": 1,
//      "duration_ms": 161746,
//      "explicit": false,
//      "external_ids": {
//        "isrc": "USUM72312330"
//      },
//      "external_urls": {
//        "spotify": "https://open.spotify.com/track/1XliaOvtQuV1hoXiIik2aQ"
//      },
//      "href": "https://api.spotify.com/v1/tracks/1XliaOvtQuV1hoXiIik2aQ",
//      "id": "1XliaOvtQuV1hoXiIik2aQ",
//      "name": "FERXXO EDITION",
//      "popularity": 42,
//      "preview_url": null,
//      "track_number": 8,
//      "type": "track",
//      "uri": "spotify:track:1XliaOvtQuV1hoXiIik2aQ",
//      "is_local": false
//    }
//  ]
//}
