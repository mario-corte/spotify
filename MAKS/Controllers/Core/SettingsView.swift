//
//  SettingsView.swift
//  MAKS
//
//  Created by Mario Corte on 12/26/23.
//

import SwiftUI

struct SettingsView: View {
    private let title = "Settings"
    @State private var isAlertPresented: Bool = false
    @Binding var isSignedIn: Bool
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                List {
                    Section("Profile") {
                        NavigationLink {
                            ProfileDetailView(isSignedIn: $isSignedIn, profile: ProfileDetailViewModel())
                        } label: {
                            Label("My Profile", systemImage: "person")
                        }
                    }
                    Section {
                        NavigationLink {
                            AboutView()
                        } label: {
                            Label("About Us", systemImage: "info.circle")
                        }
                        Button {
                            guard let spotifyURL = URL(string: "https://open.spotify.com") else { return }
                            openURL(spotifyURL)
                        } label: {
                            Label("Go to Spotify", systemImage: "music.note")
                                .tint(.white)
                        }
                    } header: {
                        Text("About")
                    }
                    Section {
                        Button {
                            isAlertPresented = true
                        } label: {
                            Label("Log Out", systemImage: "person.slash")
                                .foregroundStyle(.red)
                        }
                    } header: {
                        Text("Session")
                    } footer: {
                        Text("Tap this option just in case you wanna sign out of this app session")
                            .padding(.top, 7)
                    }
                    Section {
                        Button {
                            /*
                             guard let spotifyURL = URL(string: "https://www.instagram.com/mak5__") else { return }
                            openURL(spotifyURL)
                             */
                        } label: {
                            Label("Mario Corte", systemImage: "person.crop.circle")
                                .tint(.white)
                        }
                    } header: {
                        Text("Author")
                    } footer: {
                        /* 
                         HStack {
                            Spacer()
                            Text("Go to Mario Corte Instagram profile")
                                .padding(.top, 7)
                        } 
                        */
                    }
                }
                .headerProminence(.increased)
                .preferredColorScheme(.dark)
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(title)
        }
        .tabItem {
            Label(title, systemImage: "gear")
        }
        .background(TabBarAccessor { tabBar in
            tabBar.unselectedItemTintColor = .white
        })
        .alert("Sign Out", isPresented: $isAlertPresented) {
            Button("Log Out", role: .destructive) {
                isSignedIn = false
                AuthManager.shared.signOut()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you wanna sign out?")
        }
    }
}

#Preview {
    SettingsView(isSignedIn: .constant(false))
}
