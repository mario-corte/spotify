//
//  AuthView.swift
//  MAKS
//
//  Created by Mario Corte on 12/23/23.
//

import SwiftUI

struct AuthView: View {
    private let title = "Sign In"
    @State private var isLoading = true
    @State private var error: Error?
    @Binding var rootIsActive : Bool
    var completionHandler: ((Bool) -> ())?
    
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    private let url = AuthManager.shared.signInURL
    
    var body: some View {
        NavigationStack {
            ZStack {
//                Color.black.ignoresSafeArea()
                if let url = url {
                    WebView(url: url, 
                            isLoading: $isLoading,
                            error: $error,
                            completionHandler: completionHandler,
                            dismissCompletionHandler: {
                        rootIsActive = false
//                        DispatchQueue.main.async {
//                            presentationMode.wrappedValue.dismiss()
//                        }
                    })
                    .ignoresSafeArea()
                    if isLoading {
                        LoadingView()
                    }
                }
                else {
                    LoadingView()
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitle(title, displayMode: .inline)
        }
    }
    
    struct LoadingView: View {
        var body: some View {
            ProgressView()
                .scaleEffect(1.5)
                .tint(.accentColor)
        }
    }
}
