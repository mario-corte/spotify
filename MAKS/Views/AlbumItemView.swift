//
//  AlbumItemView.swift
//  MAKS
//
//  Created by Mario Corte on 1/15/24.
//

import SwiftUI

struct AlbumItemView: View {
    var album: AlbumViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: album.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .tint(.accentColor)
            }
            .frame(width: 170, height: 170)
            .background(.gray)
            Text(album.name)
                .foregroundColor(.white)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 1)
                .bold()
                .frame(height: 40)
            if let release_date = album.release_date {
                Text(release_date)
                    .foregroundStyle(.white)
                    .font(.subheadline)
            }
        }
        .padding(.bottom)
    }
}

