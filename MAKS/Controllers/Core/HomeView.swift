//
//  HomeView.swift
//  MAKS
//
//  Created by Mario Corte on 12/23/23.
//

import SwiftUI

struct HomeView: View {    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    if let topTracks = viewModel.topTracks {
                        HStack {
                            Text("Top Tracks")
                                .foregroundStyle(.white)
                                .font(.title3)
                                .padding(.top, 8)
                                .padding(.leading, 30)
                                .bold()
                            Spacer()
                        }
                        LazyVGrid(columns: viewModel.topTracksColumns) {
                            ForEach(topTracks, id: \.self) { track in
                                TopTrackItemView(track: track)
                            }
                        }
                    }
                    if let topArtists = viewModel.topArtists {
                        HStack {
                            Text("Top Artists")
                                .foregroundStyle(.white)
                                .font(.title3)
                                .padding(.top, 8)
                                .padding(.leading, 30)
                                .bold()
                            Spacer()
                        }
                        .padding(.top, 15)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: viewModel.topArtistsColumns) {
                                ForEach(topArtists, id: \.self) { artist in
                                    TopArtistItemView(artist: artist)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                .preferredColorScheme(.dark)
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.accentColor)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark)
            .navigationBarTitle(viewModel.title, displayMode: .large)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    AsyncImage(url: ProfileManager.shared.profile?.imageURL) { image in
                        image.resizable()
                    } placeholder: { }
                    .frame(width: 30, height: 30)
                    .background(.gray)
                    .clipShape(.circle)
                }
            }
        }
        .tabItem {
            Label(viewModel.title, systemImage: viewModel.tabItemImageString)
        }
        .background(TabBarAccessor { tabBar in
            tabBar.unselectedItemTintColor = .white
        })
    }
}

//#Preview {
//    HomeView()
//}
