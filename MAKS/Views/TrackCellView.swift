//
//  TrackCellView.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

struct TrackCellView: View {
    var track: TrackViewModel
    
    var body: some View {
        HStack {
            if let imageURL = track.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .tint(.accentColor)
                }
                .frame(width: 40, height: 40)
                .background(.gray)
                .clipShape(.circle)
            }
            VStack(alignment: .leading) {
                Text(track.name)
                    .font(.subheadline)
                    .bold()
                Text(track.artists)
                    .font(.caption)
            }
            .padding(.leading)
        }
    }
}
