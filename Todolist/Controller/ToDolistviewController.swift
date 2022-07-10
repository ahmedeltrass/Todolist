//
//  ViewController.swift
//  Todolist
//
//  Created by Ahmed Eltrass on 25/06/2022.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var listArray =  [Item]()
    
    let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
   
    override func viewDidLoad() {

        
        super.viewDidLoad()
    
        
        loudItem()
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
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "add item", style: .default) { action in
        let newitem = Item()
        newitem.title = textField.text!
            self.listArray.append(newitem)
        self.saveItem()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "create new item "
             textField = alertTextField
            
            print("now")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    func saveItem()  {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(listArray)
            try data.write(to: dataPath!)
        }
        catch{
            print("some error\(error)")
        }
           tableView.reloadData()
    }
    func loudItem()  {
        if let data = try? Data(contentsOf: dataPath!){
        let decoder = PropertyListDecoder()
            do{
            listArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print(error)
            }
        
        }
        }

    
}
