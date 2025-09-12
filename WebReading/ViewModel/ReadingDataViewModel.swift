import Foundation
import Observation


@Observable
class ReadingDataViewModel {
    
    var readingList: [ReadingItem] = []
    
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
   
    // MARK: Create path in Support Directory
    
//    •    App Sandbox = your app’s private jail.
//    •    Documents Directory = user-visible, backed up.
//    •    Application Support Directory = app’s private storage, backed up.
//    •    Caches/tmp = temporary, system may delete.
//    •    FileManager is used to find and manage these folders in a safe,
//    system-approved way (because paths can change depending on device, iOS version, etc.).
    
    func supportDirectory() -> URL? {
        // MARK: this function ensures the folder exists.
        do {
          return try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
        } catch {
            print("Error creating support directory : \(error)")
            return nil
        }
    }
    
    func fileURl() -> URL {
//        let directory = supportDirectory() ??  URL.documentsDirectory
//
//        let directory = URL.applicationSupportDirectory
//        return directory.appendingPathComponent("readingList.json")
        
        
        let directory = URL.applicationSupportDirectory
        // ensure Application Support exists
            try? FileManager.default.createDirectory(
                at: directory,
                withIntermediateDirectories: true,
                attributes: nil
            )
            
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
            print("error while save is :  \(error)")
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
