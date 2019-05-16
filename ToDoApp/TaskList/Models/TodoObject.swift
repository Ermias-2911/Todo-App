
import Foundation

class TodoObject: NSObject, NSCoding {
    
    // variables
    var taskName: String?
    var isCompleted: Bool?
    
    private let taskNameKey = "taskName"
    private let completedKey = "isCompleted"
    
    init(taskName: String) {
        self.taskName = taskName
        self.isCompleted = false
    }
    
    init(taskName: String, isCompleted: Bool) {
        self.taskName = taskName
        self.isCompleted = isCompleted
    }
    
   // Function for encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode( self.taskName, forKey: taskNameKey)
        aCoder.encode( self.isCompleted, forKey: completedKey)
    }
    
   // Functioin for decode
    required init?(coder aDecoder: NSCoder) {
        guard let taskName = aDecoder.decodeObject(forKey: taskNameKey) as? String,
            let isCompleted = aDecoder.decodeObject(forKey: completedKey) as? Bool
            else { return }
        
        // To read data 
        self.taskName = taskName
        self.isCompleted = isCompleted
    }
}
