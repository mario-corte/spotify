//
//  AboutView.swift
//  MAKS
//
//  Created by Mario Corte on 12/26/23.
//

import SwiftUI

struct AboutView: View {
    private let title = "About Us"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Image("Spotify-AppIcon")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text("Spotify is a digital music, podcast, and video service that gives you access to millions of songs and other content from creators all over the world.")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    if let spotifyURL = URL(string: "https://open.spotify.com") {
                        Link("Go to Spotify", destination: spotifyURL)
                            .padding()
                    }
                    Text("by Mario Corte")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .bold()
                }
                .padding()
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(title)
        }
    }
}

#Preview {
    AboutView()
}
