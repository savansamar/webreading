//
//  ContentView.swift
//  WebReading
//
//  Created by MACM72 on 05/09/25.
//

import SwiftUI

struct ContentView: View {
    
    // ENUM with Associated value
    
    enum NavigationSelection: Identifiable , Hashable {
        case pdf(url: URL)
        case readingItem(item: ReadingItem)

        var id: String {
            switch self {
            case .pdf(let url):
                return url.absoluteString
            case .readingItem(let item):
                return item.id.uuidString
            }
        }
    }
    
//    let readingList : [ReadingItem] = ReadingItem.examples
    @State private var selection: NavigationSelection? = nil
    // MARK: Need to update @State to @StateObject ,also R&D on this
    @State private var readingViewModel = ReadingDataViewModel()
    @State private var pdfViewModal = PDFViewModel()
    @State private var newReadingEdiorIsShown: Bool = false
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        
        NavigationSplitView {
            List(selection: $selection){
                PDFSectionView(pdfViewModal: pdfViewModal )
                ReadingSectionView(readingViewModel:readingViewModel)
            }
            .toolbar {   // 👈 now only once
                Button {
                    newReadingEdiorIsShown.toggle()
                } label: {
                    Label("Add New Reading Item", systemImage: "plus")
                }

                EditButton()
            }
            .sheet(isPresented: $newReadingEdiorIsShown) {
                ReadingDataEditorView(readingViewModel: readingViewModel)
            }
        } detail: {
            if let selection {
                switch selection {
                case .pdf(let url):
                    PDFDetailViewer(fileURL: url, pdfViewModel: pdfViewModal)
                case .readingItem(let item):
                    ReadingDetailView(reading: item, readingViewModel: readingViewModel)
                }
                
            } else{
                ContentUnavailableView("Select a Reading Item",systemImage: "book")
            }
        }
        .onChange(of: scenePhase) { _ ,phase in
            switch phase {
            case .active:
                readingViewModel.load()
            case .background, .inactive:
                readingViewModel.save()
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    ContentView()
}
