//
//  PlaylistsView.swift
//  MAKS
//
//  Created by Mario Corte on 12/23/23.
//

import SwiftUI

struct PlaylistsView: View {
    @StateObject var viewModel: PlaylistsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                if let playlists = viewModel.filteredPlaylists {
                    ScrollView() {
                        LazyVGrid(columns: viewModel.playlistsColumns, alignment: .center) {
                            ForEach(playlists, id: \.self) { playlist in
                                PlaylistItemView(playlist: playlist)
                            }
                        }
                        .padding(.bottom)
                    }
                    .preferredColorScheme(.dark)
                    .searchable(text: $viewModel.playlistToSearch, prompt: viewModel.searchBarPrompt)
                    .onChange(of: viewModel.playlistToSearch) { oldValue, newValue in
                        withAnimation {
                            viewModel.filterPlaylist(name: newValue)
                        }
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.accentColor)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(viewModel.title)
        }
        .tabItem {
            Label(viewModel.title, systemImage: viewModel.tabItemImageString)
        }
    }
}

//#Preview {
//    PlaylistsView()
//}
