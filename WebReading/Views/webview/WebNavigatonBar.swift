//
//  WebNavigatonBar.swift
//  WebReading
//
//  Created by MACM72 on 10/09/25.
//

import Foundation
import SwiftUI


struct WebNavigatonBar:View {
    
    @Bindable var webViewState : WebViewState
    @State private var currentWebURL: String = ""
    
    var body: some View {
        HStack {
            Button(action:{
                webViewState.goBack()
            }){
                Image(systemName: "chevron.backward")
            }
            .disabled(!webViewState.canGoBack)
            
            Button(action: {
                webViewState.goForward()
            }, label: {
                Image(systemName: "chevron.forward")
            })
            .disabled(!webViewState.canGoForward)
            
//            TextField("Search",text: $webViewState.currentURL.absoluteString)
            TextField("current url" , text: $currentWebURL)
                .truncationMode(.middle)
                .textFieldStyle(.roundedBorder)
        }
        .onAppear {
            currentWebURL = webViewState.url?.absoluteString ?? ""
        }
        .onChange(of: webViewState.currentURL) { oldValue , newValue in
            currentWebURL = newValue?.absoluteString ?? ""
        }
    }
}
