//
//  PDFSelectionView.swift
//  WebReading
//
//  Created by MACM72 on 11/09/25.
//

import SwiftUI

struct PDFSectionView: View {
    
    @Bindable  var pdfViewModal: PDFViewModel
    @State private var isExpanded:Bool = false
    
    var body: some View {
        Section("Saved PDFs", isExpanded: $isExpanded){
            // MARK: Use .self as the ID for Unique identity
            ForEach(pdfViewModal.pdfFile, id: \.self){ file in
                Text(file.lastPathComponent)
                    .tag(ContentView.NavigationSelection.pdf(url: file))
            }
            
        }
        .onAppear {
            pdfViewModal.loadPdfFiles()
        }
    }
}

#Preview {
    List{
        PDFSectionView(pdfViewModal: PDFViewModel())
    }
    
}
