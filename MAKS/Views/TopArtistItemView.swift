//
//  TopArtistItemView.swift
//  MAKS
//
//  Created by Mario Corte on 1/19/24.
//

import SwiftUI

struct TopArtistItemView: View {
    var artist: ArtistViewModel
    
    var body: some View {
        NavigationLink(destination: ArtistDetailView(viewModel: ArtistDetailViewModel(artist: artist))) {
            AsyncImage(url: artist.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .tint(.accentColor)
            }
            .frame(width: 110, height: 110)
            .background(.gray)
            .clipShape(.circle)
            .padding(.leading, 15)
        }
    }
}
