//
//  ArtistDetailView.swift
//  MAKS
//
//  Created by Mario Corte on 12/28/23.
//

import SwiftUI

struct ArtistDetailView: View {
    @StateObject var viewModel: ArtistDetailViewModel
    
    var body: some View {
        ScrollView {
            ArtistDetailHeaderView(artist: viewModel.artist)
            if let albumsTitle = viewModel.albumsTitle,
               let albums = viewModel.albums {
                Text(albumsTitle)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .padding(.top)
                    .bold()
                LazyVGrid(columns: viewModel.albumsColumns) {
                    ForEach(albums, id: \.self) { album in
                        AlbumItemView(album: album)
                    }
                }
                .padding(.top)
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitle(viewModel.artist.name)
    }
}

//#Preview {
//    ArtistDetailView()
//}
