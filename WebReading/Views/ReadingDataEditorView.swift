//
//  ReadingDataEditorView.swift
//  WebReading
//
//  Created by MACM72 on 08/09/25.
//

import SwiftUI

struct ReadingDataEditorView: View {
    
    // @Bindable expects you to inject an @Observable object from outside.
    @Bindable var readingViewModel: ReadingDataViewModel
    @State var newURLStrig = ""
    @State var title = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create New Reading Item")
            TextField("Title", text: $title)
            TextField("URL", text: $newURLStrig)
                .textInputAutocapitalization(.never)
            
            HStack{
                Spacer()
                Button("Cancel"){
                    dismiss()
                }
                .buttonStyle(.bordered)
//                .buttonStyle(style.bordered) this not work
                
                Button("Save"){
                    readingViewModel.addNewReadingItem(title: title, urlString: newURLStrig)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
        .padding()
    }
}

#Preview {
    ReadingDataEditorView(readingViewModel:ReadingDataViewModel())
}
