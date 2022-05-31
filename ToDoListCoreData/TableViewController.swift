//
//  TableViewController.swift
//  ToDoListCoreData
//
//  Created by lion on 31.05.22.
//

import UIKit

final class TableViewController: UITableViewController {
    
    private var tasks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task", message: "Please add new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields?.first
            if let newTask = textField?.text {
                self.tasks.insert(newTask, at: 0)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField { _ in }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
