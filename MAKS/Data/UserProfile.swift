//
//  UserProfile.swift
//  MAKS
//
//  Created by Mario Corte on 12/26/23.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let followers: [String: Int?]
    let id: String
    let images: [UserImage]
    let product: String
}

struct UserImage: Codable {
    let url: String
}


//{
//    country = US;
//    "display_name" = "Mario Corte";
//    email = "mariocorte14@gmail.com";
//    "explicit_content" =     {
//        "filter_enabled" = 0;
//        "filter_locked" = 0;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/user/makass";
//    };
//    followers =     {
//        href = "<null>";
//        total = 81;
//    };
//    href = "https://api.spotify.com/v1/users/makass";
//    id = makass;
//    images =     (
//                {
//            height = 64;
//            url = "https://i.scdn.co/image/ab67757000003b82f5404e9e02b19f60825d1ae8";
//            width = 64;
//        },
//                {
//            height = 300;
//            url = "https://i.scdn.co/image/ab6775700000ee85f5404e9e02b19f60825d1ae8";
//            width = 300;
//        }
//    );
//    product = premium;
//    type = user;
//    uri = "spotify:user:makass";
//}
