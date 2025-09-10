//
//  WebView.swift
//  WebReading
//
//  Created by MACM72 on 08/09/25.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
   
    // What about let
    @Bindable var webViewState: WebViewState
    
    
    
    func makeUIView(context: Context) ->  WKWebView {
        print("makeUIView")
        let view =  WKWebView()
        load(view)
//        view.load(URLRequest(url:url))
        view.navigationDelegate = context.coordinator
        webViewState.webView = view
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // MARK: Checking current is same as previous or not
        print("upateuiview")
        print("uiView.url \(uiView.url)")
        print("webViewState \(webViewState.url)")
        guard let url = webViewState.url else { return }
        
        if uiView.url == nil {
            load(uiView)
        } else if uiView.url != url {
            load(uiView)
        }
   
        
    }
    
    func load(_ uiView: WKWebView) {
        guard let url = webViewState.url else { return }
        uiView.load(URLRequest(url:url))
        webViewState.update(isLoading: true)
    }
    
    
    // MARK: Coordinator is a bridge between SwiftUI and UIKit.
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject , WKNavigationDelegate {
        
        var parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
        }
        
        
        // MARK: Delegate methods - use for handle loading state
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("didStartProvisionalNavigation")
            parent.webViewState.update(isLoading: true)
        }
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            print("didCommit")
//            parent.isLoading = false
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
             print("didFinish")
             parent.webViewState.update(isLoading: false)
            parent.webViewState.update(currentURL: webView.url , currentTitle: webView.title)
         }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
            print("didFail")
            parent.webViewState.update(isLoading: false , error: error)
        }
        
    }
    
}

#Preview {
    @State @Previewable var isLoading:Bool = false
    WebView(webViewState: WebViewState(url: URL(string:"www.google.com")))
}

