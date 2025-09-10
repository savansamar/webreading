

import Foundation
import Observation

@Observable
class ReadingItem: Identifiable, Hashable , Equatable, Codable {
    
    let id:UUID
    var title:String
    var url: URL?
    let creationData:Date
    var hasFinishedReading:Bool
    
    init(
        id:UUID = UUID(),
        title: String,
        url: URL? = nil,
        creationData: Date = Date(),
        hasFinishedReading: Bool = false
    ) {
        self.title = title
        self.url = url
        self.creationData = creationData
        self.hasFinishedReading = hasFinishedReading
        self.id = id
    }
    
    
    static func ==(lhs: ReadingItem , rhs: ReadingItem) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: Preview helper
    
    static var example:ReadingItem {
        ReadingItem(title: "Apple",url: URL(string: "https://apple.com") ,hasFinishedReading: true)
    }
    
    
    static var examples:[ReadingItem] {
        [
            .example ,
            ReadingItem(title: "Google",url: URL(string: "https://Google.com")),
            ReadingItem(title: "Youtub",url: URL(string: "https://youtube.com")),
        ]
    }
    
}

