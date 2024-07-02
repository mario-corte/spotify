//
//  WebView.swift
//  MAKS
//
//  Created by Mario Corte on 12/23/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    @Binding var isLoading: Bool
    @Binding var error: Error?
    var completionHandler: ((Bool) -> Void)?
    var dismissCompletionHandler: (() -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
//        webView.backgroundColor = .black
//        webView.scrollView.backgroundColor = .black
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            print("URL: \(webView.url?.absoluteString ?? "Wrong URL")")
            
            guard let urlString = webView.url?.absoluteString else { return }
            let components = URLComponents(string: urlString)
            
            guard let code = components?.queryItems?.first(where: { $0.name == "code"})?.value else { return }
            print("Code: \(code)")
            
            webView.isHidden = true
            
            AuthManager.shared.exchangeCodeForToken(code: code) { success in
                self.parent.completionHandler?(success)
                self.parent.dismissCompletionHandler?()
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("loading error: \(error)")
            parent.isLoading = false
            parent.error = error
        }
    }
}
