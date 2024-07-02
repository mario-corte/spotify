//
//  ProfileDetailView.swift
//  MAKS
//
//  Created by Mario Corte on 12/23/23.
//

import SwiftUI

struct ProfileDetailView: View {
    @Binding var isSignedIn : Bool
    @StateObject var profile: ProfileDetailViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                List {
                    if let profile = ProfileManager.shared.profile {
                        Section("") {
                            ProfileDetailHeaderView(viewModel: profile)
                        }
                    }
                    if let followingTitle = profile.followingTitle, let following = profile.following {
                        Section(followingTitle) {
                            ForEach(following, id: \.self) { artist in
                                ArtistCellView(artist: artist)
                            }
                        }
                    }
                }
                .headerProminence(.increased)
                .preferredColorScheme(.dark)
                if profile.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.accentColor)
                        .offset(y: 50)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(profile.title)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Log-Out", systemImage: "person.slash") {
                        profile.isAlertPresented = true
                    }
                    .tint(.red)
                }
            }
        }
        .tabItem {
            Label(profile.title, systemImage: "person")
        }
        .alert("Sign Out", isPresented: $profile.isAlertPresented) {
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

//#Preview {
//    ProfileDetailView(isSignedIn: .constant(false))
//}
