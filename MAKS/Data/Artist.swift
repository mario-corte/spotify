//
//  Artist.swift
//  MAKS
//
//  Created by Mario Corte on 12/27/23.
//

import Foundation

struct Artist: Codable {
    var id : String
    let external_urls: [String: String]
    let followers: [String: Int?]
    let genres: [String]
    let images: [UserImage]
    let name: String
}


//{
//    "external_urls" =                 {
//        spotify = "https://open.spotify.com/artist/014WIDx7H4BRCHB1faiisK";
//    };
//    followers =                 {
//        href = "<null>";
//        total = 2801542;
//    };
//    genres =                 (
//        banda,
//        corrido,
//        "musica bajacaliforniana",
//        "musica mexicana",
//        norteno,
//        sierreno
//    );
//    href = "https://api.spotify.com/v1/artists/014WIDx7H4BRCHB1faiisK";
//    id = 014WIDx7H4BRCHB1faiisK;
//    images =                 (
//        {
//            height = 640;
//            url = "https://i.scdn.co/image/ab6761610000e5ebab5c7f6d0b8084c74613d6a3";
//            width = 640;
//        },
//        {
//            height = 320;
//            url = "https://i.scdn.co/image/ab67616100005174ab5c7f6d0b8084c74613d6a3";
//            width = 320;
//        },
//        {
//            height = 160;
//            url = "https://i.scdn.co/image/ab6761610000f178ab5c7f6d0b8084c74613d6a3";
//            width = 160;
//        }
//    );
//    name = "Los Tucanes De Tijuana";
//    popularity = 74;
//    type = artist;
//    uri = "spotify:artist:014WIDx7H4BRCHB1faiisK";
//}
