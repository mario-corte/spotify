//
//  PlaylistItemView.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

struct PlaylistItemView: View {
    var playlist : PlaylistViewModel
    
    var body: some View {
        NavigationLink(destination: PlaylistDetailView(viewModel: PlaylistDetailViewModel(playlist: playlist))) {
            VStack {
                AsyncImage(url: playlist.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .tint(.accentColor)
                }
                .frame(width: 170, height: 170)
                .background(.gray)
                Text(playlist.name)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.top, 1)
                    .bold()
                    .frame(height: 50)
            }
            .padding(.top)
            .padding(.horizontal)
        }
    }
}
