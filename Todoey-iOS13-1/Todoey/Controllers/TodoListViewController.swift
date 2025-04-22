//
//  ViewController.swift
//  Todoey
//
//  Created by Amber Pan on 02/12/2019.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    //    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //        print(dataFilePath)
        // Do any additional setup after loading the view.
        
        let lineItem1 = Item()
        lineItem1.title="Find David"
        itemArray.append(lineItem1)
        
        let lineItem2 = Item()
        lineItem2.title="Buy Mini Wheat"
        itemArray.append(lineItem2)
        
        let lineItem3 = Item()
        lineItem3.title="Destroy Demogorgon"
        itemArray.append(lineItem3)
        
        
        let lineItem4 = Item()
        lineItem4.title="Destroy Demogorgon"
        itemArray.append(lineItem4)
        
        let lineItem5 = Item()
        lineItem5.title="Destroy Demogorgon2"
        itemArray.append(lineItem5)
        
        let lineItem6 = Item()
        lineItem6.title="Destroy Demogorgon3"
        itemArray.append(lineItem6)
        
        
        //        if let items = defaults.array(forKey: "TodoListArray")as? [Item] {
        //                 itemArray = items
        //             }
        
    }
    
    //Mark - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //Ternary operator
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark: .none
        //        if itemArray[indexPath.row].done == true{
        //            cell.accessoryType = .checkmark}
        //        else {
        //            cell.accessoryType = .none
        //        }
        
        return cell
    }
    
    //Mark - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(indexPath.row)
        //        print(itemArray[indexPath.row])
        //        print (tableView.cellForRow(at: indexPath)?.textLabel?.text! ?? "")
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //        self.defaults.set(self.itemArray, forKey: "TodoListArray")
        
        tableView.reloadData()
        
        //animate item select/deselect
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks thew Add Item button on UIAlert
            
            let lineItem = Item()
            lineItem.title = textField.text!
            self.itemArray.append(lineItem)
            
            //            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            let encoder = PropertyListEncoder()
            do{
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            }catch{
                print ("Error emcoding item array, \(error)")
            }
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
                            }
        
        //this alert.addAction must be outside of the inclosure of the UIAlertAction, otherwise it will inside of what needs to happen after the user clicks the add item button on UIAlert and will not have chance to execute since that button can only be pressed after th UIAlert presents
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
