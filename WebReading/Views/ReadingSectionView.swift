//
//  ReadingListView.swift
//  WebReading
//
//  Created by MACM72 on 05/09/25.
//

import SwiftUI

struct ReadingSectionView: View {
    
    @Bindable var readingViewModel: ReadingDataViewModel
   
    
    @Environment(\.editMode) var editMode
    // USE ForEach , for moddifier like onDete andf all , EditMode not work with  binding-based List initializer with editActions
    
    var body: some View {
        
        
        Section("Reading List") {
            ForEach(
                $readingViewModel.readingList,
                editActions: [.move, .delete]
            ) { $item in
                ReadingItemRow(readingItem: item)
                    .tag(ContentView.NavigationSelection.readingItem(item: item))
                    .swipeActions(edge: .leading) {
                        Button("Toggle isFinished") {
                            item.hasFinishedReading.toggle()
                        }
                    }
            }
        }
        .onChange(of: editMode?.wrappedValue) { _, newMode in
            guard let mode = newMode else { return }
            switch mode {
            case .active:
                print("Editing started")
            case .inactive:
                print("Editing ended")
            case .transient:
                print("Transient editing")
            @unknown default:
                break
            }
        }
       
    }
}


fileprivate struct ReadingItemRow: View {
    
    let readingItem: ReadingItem
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment:.firstTextBaseline ,spacing: 10){
                Image(systemName: readingItem.hasFinishedReading ? "book.fill" : "book" )
                    .foregroundStyle(.green)
                   
                
                VStack(alignment: .leading) {
                    Text(readingItem.title)
                    Text(readingItem.creationData.formatted(Date.FormatStyle.dateTime))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

        }
    }
}


#Preview {
    @State @Previewable var selection:ReadingItem?
    NavigationStack {
        List {
            ReadingSectionView(readingViewModel:ReadingDataViewModel())
        }
    }
    
}
