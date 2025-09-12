
import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewRepresentable {
    let fileURL : URL
    
    func makeUIView(context: Context) -> PDFView {
        PDFView()
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(url: fileURL)
        
    }
    
}

