import UIKit

class TaskViewController: UITableViewController {
    
   // Controller
    var todoStore = TodoStore() {
        didSet {
            todoStore.tasks = TodoUtility.fetchData() ?? [[TodoObject](), [TodoObject]()]
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(white: 45.0/255, alpha: 1)
    }
    
    // New task
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add A New Task", message: nil, preferredStyle: .alert)

        // Add
        let addTask = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alertController.textFields?.first?.text else {
                return
            }

            // New task
            let newTask = TodoObject(taskName: name)
            self.todoStore.addTaskInList(newTask, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            TodoUtility.saveData(self.todoStore.tasks)
            self.tableView.reloadData()
        }

        addTask.isEnabled = false
        let cancelTask = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addTextField{ textField in
            textField.placeholder = "Enter Task"
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }

        // To move task into Finished task
        alertController.addAction(addTask)
        alertController.addAction(cancelTask)
        present(alertController, animated: true)
    }
 
    // To add and delet
    @objc private func handleTextChanged(_ sender: UITextField) {
        guard let alertController = presentedViewController as? UIAlertController,
            let addTask = alertController.actions.first,
            let text = sender.text
            else { return }
    
        addTask.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

extension TaskViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0 ) ? "Unfinished Tasks" : "Finished Tasks"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(white: 200.0/255, alpha: 1)
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return todoStore.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoStore.tasks[ section ].count
    }
    
    // To use cells and update
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell)
        cell.label.text = todoStore.tasks[indexPath.section][indexPath.row].taskName
        cell.deleteButton.tag = indexPath.section * 1000 + indexPath.row
        cell.completedButton.tag = indexPath.section * 1000 + indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteTask(_:)), for: .touchUpInside)
        cell.completedButton.addTarget(self, action: #selector(completeTask(_:)), for: .touchUpInside)
        cell.backgroundColor = UIColor(white: 45.0/255, alpha: 1)
        if self.todoStore.tasks[indexPath.section][indexPath.row].isCompleted == true {
            cell.completedButton.isHidden = true
        } else {
            cell.completedButton.isHidden = false
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension TaskViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit Your Task", message: nil, preferredStyle: .alert)
    
        let currentTask = self.todoStore.tasks[indexPath.section][indexPath.row]
        
        let editTask = UIAlertAction(title: "Edit", style: .default) { _ in
            
            guard let newName = alertController.textFields?.first?.text else {
                return
            }
            
            let currentRow = indexPath.row

            self.todoStore.updateTaskInList(currentTask, at: currentRow, with: newName)
            

            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)

            TodoUtility.saveData(self.todoStore.tasks)
        }
        editTask.isEnabled = false
 
        let cancelTask = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addTextField{ textField in
            textField.text = currentTask.taskName
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
        
        alertController.addAction(editTask)
        alertController.addAction(cancelTask)
        
        present(alertController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension TaskViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
extension TaskViewController {
    @IBAction func deleteTask(_ button: UIButton) {
        let indexPath = IndexPath(row: button.tag%1000, section: button.tag/1000)
        guard let isCompleted = self.todoStore.tasks[indexPath.section][indexPath.row].isCompleted else { return }
        
        self.todoStore.removeTaskInList(at: indexPath.row, isCompleted: isCompleted)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        TodoUtility.saveData(self.todoStore.tasks)
        tableView.reloadData()
        

    }
    
    @IBAction func completeTask(_ button: UIButton) {
        let indexPath = IndexPath(row: button.tag%1000, section: button.tag/1000)
        self.todoStore.tasks[0][indexPath.row].isCompleted = true
        
        let completedTask = self.todoStore.removeTaskInList(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        self.todoStore.addTaskInList(completedTask, at: 0, isCompleted: true)
        
        tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)

        TodoUtility.saveData(self.todoStore.tasks)
        tableView.reloadData()

    }
}
