//
//  SuccessSaveFileView.swift
//  WebReading
//
//  Created by MACM72 on 11/09/25.
//

import SwiftUI

struct SuccessSaveFileView: View {
    
    let url:URL
    
    var body: some View {
        Label("Saved PDF to :\(url)", systemImage: "checkmark.circle.fill")
            .padding()
            .background(Color.green)
            .cornerRadius(5)
            .shadow(radius: 5)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
            .padding(50)
            .padding(.bottom ,0)
//            .transition(.move(edge: .bottom))
    }
}

#Preview {
    SuccessSaveFileView(url: URL(string: "//Users")!)
}
