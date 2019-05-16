

import XCTest
@testable import ToDoApp

class ToDoAppTests: XCTestCase {
    
    func test_creatingANewTaskWithNameInitializer() {
        let task = Task(name: "Test Task")
        
        XCTAssertEqual(task.name, "Test Task")
        XCTAssertEqual(task.isCompleted, false)
    }
    
    func test_creatingANewTaskWithNameAndIsCompletedInitializer() {
        let task = Task(name: "Test Task", isCompleted: true)
        
        XCTAssertEqual(task.name, "Test Task")
        XCTAssertEqual(task.isCompleted, true)
    }
    
    func test_addUnfinishedTaskToTaskStore() {
        let task = Task(name: "Test Task")
        let taskStore = TaskStore()
        
        taskStore.addTask(task, at: 0)
        
        // For task section
        let updatedTask = taskStore.tasks[0][0]
        
        XCTAssertEqual(updatedTask.name, "Test Task")
        XCTAssertEqual(updatedTask.isCompleted, false)
    }
    
    func test_addAndRemoveUnfinishedTask() {
        let task = Task(name: "Test Task")
        let taskStore = TaskStore()
        
        taskStore.addTask(task, at: 0)
        let removedTask = taskStore.removeTask(at: 0)
        
        XCTAssertEqual(removedTask.name, "Test Task")
        XCTAssertEqual(removedTask.isCompleted, false)
    }
    
    // To make finishd task
    func test_addFinishedTaskToTaskStore() {
        let task = Task(name: "Test Task", isCompleted: true)
        let taskStore = TaskStore()
    
        taskStore.addTask(task, at: 0, isCompleted: task.isCompleted!)
        
        let updatedTask = taskStore.tasks[1][0]
        
        XCTAssertEqual(updatedTask.name, "Test Task")
        XCTAssertEqual(updatedTask.isCompleted, true)
    }
    
    func test_addAndRemoveFinishedTask() {
        let task = Task(name: "Test Task", isCompleted: true)
        let taskStore = TaskStore()
        
        taskStore.addTask(task, at: 0)
        let removedTask = taskStore.removeTask(at: 0)
        
        XCTAssertEqual(removedTask.name, "Test Task")
        XCTAssertEqual(removedTask.isCompleted, true)
    }
    
    
    func test_addAndUpdateTaskNameInTaskStore() {
        let task = Task(name: "Test Task")
        let taskStore = TaskStore()
        
        taskStore.addTask(task, at: 0)
        taskStore.updateTask(task, at: 0, with: "Updated Task")
        
        let updatedTask = taskStore.tasks[0][0]
        
        XCTAssertEqual(updatedTask.name, "Updated Task")
        XCTAssertEqual(updatedTask.isCompleted, false)
        
    }
}
