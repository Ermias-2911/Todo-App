
import Foundation

class TodoStore {
    // Arrays for finsh and unfinished
    var tasks = [
        [TodoObject](),
        [TodoObject]()
    ]
    
    // Task holder
    func addTaskInList(_ task: TodoObject, at index: Int, isCompleted: Bool = false) {
        let taskSection = isCompleted ? 1 : 0
        
        tasks[ taskSection ].insert(task, at: index)
    }

    @discardableResult func removeTaskInList(at index: Int, isCompleted: Bool = false) -> TodoObject {
        let taskSection = isCompleted ? 1 : 0
    
        return tasks[ taskSection ].remove(at: index)
    }
    
    // Change task
    func updateTaskInList(_ task: TodoObject, at index: Int, with name: String, isCompleted: Bool = false) {
        let taskSection = isCompleted ? 1 : 0
        
        tasks[ taskSection ][ index ].taskName = name
    }
}
