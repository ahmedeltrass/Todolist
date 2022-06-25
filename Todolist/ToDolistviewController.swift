//
//  ViewController.swift
//  Todolist
//
//  Created by Ahmed Eltrass on 25/06/2022.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var listArray = ["first" , "second" ,"third"]
    let defult = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let item = defult.array(forKey: "todolist")as? [String]{
            listArray = item
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = listArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(listArray[indexPath.row])
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
            
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "add item", style: .default) { action in
          
            self.listArray.append(textField.text!)
            self.defult.set(self.listArray, forKey: "todolist")
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "create new item "
             textField = alertTextField
            
            print("now")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
  

    
}
