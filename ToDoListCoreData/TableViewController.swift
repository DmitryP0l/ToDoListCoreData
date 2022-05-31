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

    @IBAction func safeTask(_ sender: UIBarButtonItem) {
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
