
import Foundation

class TodoUtility {
    
    private static let key = "tasks"

    private static func archiveData(_ tasks: [[TodoObject]]) -> NSData {
        var returnData: NSData?
        
        do {
            returnData = try NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false) as NSData
            
        } catch {
            print(error.localizedDescription)
        }
        
        return returnData!
    }
    
    // To get either task finished or not
    static func fetchData() -> [[TodoObject]]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        
        var returnData: [[TodoObject]]?
        
        do {
            returnData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [[TodoObject]]
            
        } catch {
            print(error.localizedDescription)
        }
        
        return returnData
    }
    
    // To store task
    static func saveData(_ tasks: [[TodoObject]]) {
        
        let archivedTasks = archiveData(tasks)
        UserDefaults.standard.set(archivedTasks, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
