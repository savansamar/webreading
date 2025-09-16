
import SwiftUI

struct ReadingDetailView: View {
    
    let reading: ReadingItem
    @Bindable var readingViewModel : ReadingDataViewModel
    @State private var webViewState = WebViewState()
    
    var body: some View {
        
        VStack{
            ZStack {
                // TODO: Add WebView
            
                WebView(webViewState: webViewState)
                    .ignoresSafeArea()
             
                if webViewState.isLoading {
                     ProgressView()
                         .controlSize(.large)
                         .tint(Color.accentColor)
                 }
                else if let error = webViewState.error {
                    Text(error.localizedDescription)
                        .foregroundStyle(.pink)
                }
                
                if let url = webViewState.successGeneratePDFURL {
                    SuccessSaveFileView(url: url)
                        .transition(.move(edge: .bottom))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                print("🟡 Hiding SuccessSaveFileView...")
                                withAnimation(.bouncy(duration: 2)){
                                    webViewState.successGeneratePDFURL = nil
                                }
                            }
                        }
                        .onDisappear {
                                    print("❌ SuccessSaveFileView DISAPPEARED")
                    }
                }
                
            }
//            WebNavigatonBar(webViewState: webViewState)
//                .padding()
//                .background(.thinMaterial)
        }
//        .onChange(of: webViewState) { old, new in ... } //  doesn't work
        .onChange(of: reading){ oldValye, newValue in
            webViewState.userRequestedToOpen(newValue.url)
        }
        .onAppear{
            webViewState.userRequestedToOpen(reading.url)
        }
        .toolbar {
            Menu("More",systemImage:"ellipsis.circle" ){
                if let new  = webViewState.currentURL ,
                   webViewState.url != new {
                    Button("Create New Reading"){
                        readingViewModel.addNewReadingItem(title: webViewState.currentTitle ?? "title", url: new)
                    }
                }
                
                Button(action: {
                    webViewState.createPDF()
                }, label: {
                    Text("Save as PDF")
                })
                
            }
        }
        
    }
}

#Preview {
    NavigationStack{
        ReadingDetailView(reading: ReadingItem.example , readingViewModel: ReadingDataViewModel())
    }
   
}

