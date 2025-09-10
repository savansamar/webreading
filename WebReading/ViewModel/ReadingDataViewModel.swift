import Foundation
import Observation


@Observable
class ReadingDataViewModel {
    
    var readingList: [ReadingItem] = ReadingItem.examples
    
    init() {
//        load()
        //   @Environment(\.scenePhase) var scenePhase use this
        // on ContentView file to track app state like background , foreground
    }
    
    // MARK: Add data in list
    func addNewReadingItem(title:String,urlString: String) {
        guard let url = URL(string: urlString) else { return }
            
        addNewReadingItem(title: title, url: url)
    }
    
    // MARK: Create direct new reading from nested URL
    func addNewReadingItem(title:String,url: URL) {
        let new = ReadingItem(title: title ,url: url)
        readingList.append(new)
        save()
    }
   
    
    func fileURl() -> URL {
        let directory = URL.documentsDirectory
        return directory.appendingPathComponent("readingList.json")
    }
    
    // MARK: Save data into list
    func save(){
        do {
            let data = try JSONEncoder().encode(readingList)
            let url = fileURl()
            try data.write(to: url)
            print("file location \(url.absoluteString)")
            
        } catch {
            print("error \(error)")
        }
    }
    
    // MARK: Retrieve data
    func load() {
        let url = fileURl()
        do {
            let data = try Data(contentsOf: url)
            self.readingList =  try JSONDecoder().decode([ReadingItem].self, from: data)
        }
        catch {
            print("error while loading data \(error)")
//            self.readingList = []
            useSampleData()
        }
    }
    
    func useSampleData () {
        self.readingList = ReadingItem.examples
    }
    
}
