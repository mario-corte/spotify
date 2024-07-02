//
//  ArtistCellView.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

struct ArtistCellView: View {
    var artist: ArtistViewModel
    
    var body: some View {
        NavigationLink(destination: ArtistDetailView(viewModel: ArtistDetailViewModel(artist: artist))) {
            HStack {
                if let imageURL = artist.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                            .tint(.accentColor)
                    }
                    .frame(width: 50, height: 50)
                    .background(.gray)
                    .clipShape(.circle)
                }
                VStack(alignment: .leading) {
                    Text(artist.name)
                        .font(.subheadline)
                        .bold()
                    if let followers = artist.followers {
                        Text("\(followers) followers")
                            .font(.caption)
                            .padding(.top, 1)
                    }
                }
                .padding(.leading)
            }
        }
    }
}
