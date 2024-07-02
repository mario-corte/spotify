//
//  WelcomeSwiftUIView.swift
//  MAKS
//
//  Created by Mario Corte on 12/23/23.
//

import SwiftUI

struct WelcomeView: View {
    private let title = "Spotify"
    @State private var isActive : Bool = false
    @Binding var isSignedIn : Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Welcome to Spotify Demo")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.accent)
                        .bold()
                    Text("by Mario Corte")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .bold()
                    Spacer()
                    Button(action: {
                        isActive = true
                    }, label: {
                        Text("SIGN IN TO SPOTIFY")
                            .frame(maxWidth: .infinity)
                            .padding(20)
                            .background(.accent)
                            .foregroundColor(.black)
                            .cornerRadius(50)
                            .bold()
                    })
//                    NavigationLink {
//                        authView
//                    } label: {
//                        Text("SIGN IN TO SPOTIFY")
//                            .frame(maxWidth: .infinity)
//                            .padding(20)
//                            .background(.accent)
//                            .foregroundColor(.black)
//                            .cornerRadius(50)
//                            .bold()
//                    }
                }
                .padding()
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark)
            .navigationBarTitle(title, displayMode: .large)
            .navigationDestination(isPresented: $isActive) {
                authView
            }
        }
    }
}

extension WelcomeView {
    private var authView: AuthView {
        return AuthView(rootIsActive: $isActive) { success in
            DispatchQueue.main.async() {
                handleRequest(success)
            }
        }
    }
    
    private func handleRequest(_ success: Bool) {        
        guard success else {
            return
        }
        
        isSignedIn = true
        
//        ProfileManager.shared.getProfile { error in
//            guard let _ = error else {
//                print("Error getting user profile")
//                return
//            }
//            
//            isSignedIn = true
//        }
    }
}

#Preview {
    WelcomeView(isSignedIn: .constant(false))
}
