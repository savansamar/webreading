//
//  ContentView.swift
//  WebReading
//
//  Created by MACM72 on 05/09/25.
//

import SwiftUI

struct ContentView: View {
    
//    let readingList : [ReadingItem] = ReadingItem.examples
    @State private var selection: ReadingItem? = nil
    // MARK: Need to update @State to @StateObject ,also R&D on this
    @State private var readingViewModel = ReadingDataViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationSplitView {
            ReadingListView(readingViewModel:readingViewModel ,selection: $selection)
        } detail: {
            
            // Guard is early exit can not work with Views, but can wrok with funcitons
//            guard selection != nil {
//                ContentUnavailableView("Select a Reading Item",systemImage: "book")
//            }
//            Text(selection.title)
            if let selection {
                ReadingDetailView(reading: selection, readingViewModel: readingViewModel)
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
