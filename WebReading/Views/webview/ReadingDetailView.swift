//
//  ReadingDetailView.swift
//  WebReading
//
//  Created by MACM72 on 05/09/25.
//

import SwiftUI

struct ReadingDetailView: View {
    
    let reading: ReadingItem
    @Bindable var readingViewModel : ReadingDataViewModel
    @State private var webViewState = WebViewState()
    
    var body: some View {
        
        VStack{
            ZStack {
                // TODO: Add WebView
                WebView(webViewState: webViewState)
                    .ignoresSafeArea()
                
                if webViewState.isLoading {
                     ProgressView()
                         .controlSize(.large)
                         .tint(Color.accentColor)
                 }
                else if let error = webViewState.error {
                    Text(error.localizedDescription)
                        .foregroundStyle(.pink)
                }
            }
            WebNavigatonBar(webViewState: webViewState)
                .padding()
                .background(.thinMaterial)
        }
//        .onChange(of: webViewState) { old, new in ... } //  doesn't work
        .onChange(of: reading){ oldValye, newValue in
            webViewState.userRequestedToOpen(newValue.url)
        }
        .onAppear{
            webViewState.userRequestedToOpen(reading.url)
        }
        .toolbar {
            if let new  = webViewState.currentURL ,
            webViewState.url != new {
                Button("Create New Reading"){
                    readingViewModel.addNewReadingItem(title: webViewState.currentTitle ?? "title", url: new)
                }
            }
            
        }
        
    }
}

#Preview {
    ReadingDetailView(reading: ReadingItem.example , readingViewModel: ReadingDataViewModel() )
}

