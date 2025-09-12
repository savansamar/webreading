//
//  PDFViewer.swift
//  WebReading
//
//  Created by MACM72 on 11/09/25.
//

import SwiftUI

struct PDFDetailViewer: View {
    
    let fileURL:URL
    
    @Bindable var pdfViewModel: PDFViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        PDFViewWrapper(fileURL: fileURL)
            .toolbar {
                Button {
                    pdfViewModel.delete(fileURL)
                    dismiss()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
    }
}

#Preview {
    PDFDetailViewer(fileURL: URL(string: "https://www.youtube.com/watch?v=cP7UVhyPmfY&list=PLWHegwAgjOkrhsA_OQD58x0rm2AffzKgU&index=6")!,pdfViewModel: PDFViewModel())
}
