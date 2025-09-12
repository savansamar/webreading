//
//  WebViewState.swift
//  WebReading
//
//  Created by MACM72 on 09/09/25.
//

import SwiftUI
import Observation
import WebKit


@Observable
class WebViewState {
    
    var url:URL? = nil
    var isLoading = false
    var error: Error?
    var currentURL : URL? = nil
    var currentTitle : String? = ""
    
    var successGeneratePDFURL: URL? = nil
    
    var canGoBack = false
    var canGoForward = false
    
//    •    weak → avoids memory leaks by not owning the object.
//    •    ? → required because weak references auto-reset to nil.
    weak var webView: WKWebView?
    
    init(url: URL? = nil){
        self.url = url
        
    }
    
    func userRequestedToOpen(_ url: URL?) {
        self.url = url
        self.error = nil
        self.currentURL = nil
    }
    
    
    func update(isLoading: Bool , error: Error? = nil){
        self.isLoading = isLoading
        self.error = error
    }
    
    func update(currentURL:URL?,currentTitle:String?) {
        self.currentURL = currentURL
        self.currentTitle = currentTitle
        updateNavigationState()
    }
    
    func updateNavigationState(){
        self.canGoBack = webView?.canGoBack ?? false
        self.canGoForward = webView?.canGoForward ?? false
    }
    
    func goBack() {
        webView?.goBack()
    }
    
    func goForward() {
        webView?.goForward()
    }
    
    func reload(){
        webView?.reload()
    }
    
    // MARK: Create PDF , Make sure  this key in info is set to yes "Supports Document Browser".
    func createPDF() {
        guard let webView else { return }
        webView.createPDF { result in
            switch result {
                case .success(let data) :
                self.savePDFToDisk(data)
                
            case .failure(let failure):
                print("Error while creating pdf : \(failure)")
            }
        }
    }
    
    func savePDFToDisk(_ data:Data){
        let doucumentURL = URL.documentsDirectory
        
        let title = webView?.title ?? "untitled"
        let fileURL = doucumentURL.appendingPathComponent("\(title).pdf")
        do {
            try data.write(to: fileURL )
            withAnimation(.bouncy(duration:2)){
                self.successGeneratePDFURL = fileURL
            }
            
            print("successfully save PDF : \(fileURL)")
        } catch {
            print("error while saving pdf: \(error)")
        }
        
        
    }
    
}
