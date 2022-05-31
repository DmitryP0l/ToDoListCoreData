//
//  TableViewController.swift
//  ToDoListCoreData
//
//  Created by lion on 31.05.22.
//

import UIKit
import CoreData

final class TableViewController: UITableViewController {
    
    private var tasks: [Task] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTask()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   cleanTask()
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task", message: "Please add new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields?.first
            if let newTaskTitle = textField?.text {
                self.saveTask(withTitle: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField { _ in }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    //сохраняем данные в кордате
    private func saveTask(withTitle title: String) {
        let context = getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        //обязательно сохраняем контекст после любых действий с данными
        do {
            try context.save()
            tasks.insert(taskObject, at: 0)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //получаем контекст, чтобы из него получить объекты хранящиеся по нашей сущности Task
    private func getTask() {
        let context = getContext()
        //создаем запрос для получения объектов хранящиеся по entity Task
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        //порядок вывода, сортировка по возр/убыв (ascending)
        let sortDeskriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDeskriptor]
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func cleanTask() {
        let context = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        //получаем все результаты по fetchRequest и через цикл затираем все данные
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        //обязательно сохраняем контекст после любых действий с данными
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
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
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
}
