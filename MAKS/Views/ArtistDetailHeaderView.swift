//
//  ArtistDetailHeaderView.swift
//  MAKS
//
//  Created by Mario Corte on 1/15/24.
//

import SwiftUI

struct ArtistDetailHeaderView: View {
    var artist: ArtistViewModel
    
    var body: some View {
        HStack {
            VStack {
                AsyncImage(url: artist.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .tint(.accentColor)
                }
                .frame(width: 200, height: 200)
                .background(.gray)
                .clipShape(.circle)
                .padding(.top, 30)
                Text(artist.artistGenres)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding()
                if let followers = artist.followers {
                    Text("\(followers) followers")
                        .foregroundStyle(.accent)
                        .font(.subheadline)
                        .bold()
                }
            }
        }
    }
}
