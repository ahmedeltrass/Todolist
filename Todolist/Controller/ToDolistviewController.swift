//
//  ViewController.swift
//  Todolist
//
//  Created by Ahmed Eltrass on 25/06/2022.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var listArray =  [Item]()
    
    let defult = UserDefaults.standard
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let newitem  = Item()
        newitem.title = "first name"
       // newitem.done = true
        listArray.append(newitem)
        let newitem2  = Item()
        newitem2.title = "second name"
        listArray.append(newitem2)
        let newitem3  = Item()
        newitem3.title = "third name"
        listArray.append(newitem3)
 
        if  let item = defult.array(forKey: "todolist")as? [Item]{
            listArray = item
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        let item = listArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listArray[indexPath.row].done = !listArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "add item", style: .default) { action in
        let newitem = Item()
        newitem.title = textField.text!
            self.listArray.append(newitem)
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
