//
//  PlaylistDetailHeaderView.swift
//  MAKS
//
//  Created by Mario Corte on 1/14/24.
//

import SwiftUI

struct PlaylistDetailHeaderView: View {
    var playlist: PlaylistViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                AsyncImage(url: playlist.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .tint(.accentColor)
                }
                .frame(width: 250, height: 250)
                .background(.gray)
                .clipShape(.circle)
                .padding()
                Text("\(playlist.tracks) Tracks")
                    .font(.title3)
                    .foregroundStyle(.white)
                if let owner = playlist.owner {
                    Text("by \(owner)")
                        .font(.footnote)
                        .foregroundColor(.accentColor)
                }
            }
            Spacer()
        }
    }
}
