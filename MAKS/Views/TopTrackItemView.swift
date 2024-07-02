//
//  TopTrackItemView.swift
//  MAKS
//
//  Created by Mario Corte on 1/19/24.
//

import SwiftUI

struct TopTrackItemView: View {
    var track: TrackViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: track.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .tint(.accentColor)
            }
            .frame(width: 60, height: 60)
            .background(.gray)
            Text(track.name)
                .lineLimit(2)
                .foregroundColor(.white)
                .font(.caption)
                .bold()
        }
        .frame(width: 160, height: 60, alignment: .leading)
    }
}
