//
//  MAKSApp.swift
//  MAKS
//
//  Created by Mario Corte on 12/20/23.
//

import SwiftUI

@main
struct MAKSApp: App {
    @State private var isSignedIn: Bool = AuthManager.shared.isSignedIn
    
    var body: some Scene {
        WindowGroup {
            if isSignedIn {
                TabBarView(isSignedIn: $isSignedIn)
            }
            else {
                WelcomeView(isSignedIn: $isSignedIn)
            }
        }
    }
}
