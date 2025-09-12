//
//  PDFViewModel.swift
//  WebReading
//
//  Created by MACM72 on 11/09/25.
//

import Foundation
import Observation

@Observable
class PDFViewModel {
    
    var pdfFile: [URL] = []
    
    init() {
        loadPdfFiles()
    }
    
    
    func loadPdfFiles() {
        let directory = URL.documentsDirectory
        
        do {
            let fileURls =  try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            self.pdfFile = fileURls.filter { $0.pathExtension == "pdf" }
            
        } catch {
            print("Error while getting pdf file from urls : \(error)")
        }
    }
        
    
    func delete(_ fileURL: URL){
        do {
           try FileManager.default.removeItem(at: fileURL)
            loadPdfFiles()
        } catch {
            print("Error while delteing pdf : \(error)")
        }
    }
}
