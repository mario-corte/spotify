//
//  TabBarView.swift
//  MAKS
//
//  Created by Mario Corte on 12/23/23.
//

import SwiftUI

struct TabBarView: View {
    @State var profileLoading = true
    @Binding var isSignedIn: Bool
    
    var body: some View {
        ZStack {
            if profileLoading {
                Color.black.ignoresSafeArea()
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.accentColor)
            }
            else {
                TabView {
                    HomeView(viewModel: HomeViewModel())
                    PlaylistsView(viewModel: PlaylistsViewModel())
                    SettingsView(isSignedIn: $isSignedIn)
                }
                .tint(.accentColor)
            }
        }
        .onAppear {
            ProfileManager.shared.getProfile { error in
                profileLoading = false
            }
        }
    }
}

#Preview {
    TabBarView(isSignedIn: .constant(false))
}
