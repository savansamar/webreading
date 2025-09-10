//
//  ReadingListView.swift
//  WebReading
//
//  Created by MACM72 on 05/09/25.
//

import SwiftUI

struct ReadingListView: View {
    
    @Bindable var readingViewModel: ReadingDataViewModel
    @Binding var selection:ReadingItem?
    @State private var newReadingEdiorIsShown: Bool = false
    
    @Environment(\.editMode) var editMode
    // USE ForEach , for moddifier like onDete andf all , EditMode not work with  binding-based List initializer with editActions
    
    var body: some View {
        // MARK: Use binding-based List initializer with editActions
        List(
            $readingViewModel.readingList ,
            editActions:[.move,.delete],
            selection: $selection
            
        ){
            $item in
            ReadingItemRow(readingItem: item)
                .tag(item)
                .swipeActions(edge: .leading){
                    Button("Toogle isFinished"){
                        item.hasFinishedReading.toggle()
                    }
                }
            
        }
        
        .toolbar {
            Button {
                newReadingEdiorIsShown.toggle()
            } label: {
                Label("Add New Reading Item",systemImage: "plus")
            }
            
            EditButton()
        }
//        .onChange(of: editMode?.wrappedValue) { newMode in
//            switch newMode {
//            case .active:
//                print("Editing started")
//            case .inactive:
//                print("Editing ended")
//            case .transient:
//                print("Transient mode")
//            case .none:
//                break
//            }
//        }

        .onChange(of: editMode?.wrappedValue) { _ ,newMode in
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
//
        .sheet(isPresented: $newReadingEdiorIsShown){
            ReadingDataEditorView(readingViewModel: readingViewModel)
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
        ReadingListView(readingViewModel:ReadingDataViewModel() , selection: $selection)
    }
    
}
