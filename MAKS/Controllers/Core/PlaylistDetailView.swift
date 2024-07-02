//
//  PlaylistDetailView.swift
//  MAKS
//
//  Created by Mario Corte on 12/28/23.
//

import SwiftUI

struct PlaylistDetailView: View {
    @StateObject var viewModel: PlaylistDetailViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                List {
                    Section() { } header: {
                        PlaylistDetailHeaderView(playlist: viewModel.playlist)
                    }
                    if let tracks = viewModel.tracks {
                        Section {
                            ForEach(tracks, id: \.self) { track in
                                TrackCellView(track: track)
                            }
                        }
                    }
                }
                .headerProminence(.increased)
                .preferredColorScheme(.dark)
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.accentColor)
                        .offset(y: 100)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitle(viewModel.playlist.name)
        }
    }
}

//#Preview {
//    PlaylistDetailView()
//}
