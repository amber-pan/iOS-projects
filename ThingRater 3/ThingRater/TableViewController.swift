//
//  TableViewController.swift
//  ThingRater
//
//  Created by Amber  Pan on 6/28/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var things:[RatedThing] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self                 //point to data source
        tableView.delegate = self
        loadData()
        
     things = [
            RatedThing(name:"first thing", rating: 1, image: UIImage(named:"kittens")),
            RatedThing(name:"second thing", rating: 1, image: UIImage(named:"fruit")),
            RatedThing(name:"third thing", rating: 1, image: UIImage(named:"boots")),
            RatedThing(name:"puppy", rating: 1, image: UIImage(named:"puppy")),
            RatedThing(name:"daffodil", rating: 1, image: UIImage(named:"daffodil")),
            RatedThing(name:"jacket", rating: 1, image: UIImage(named:"jacket")),
            RatedThing(name:"concert", rating: 1, image: UIImage(named:"concert")),
            RatedThing(name:"last", rating: 1, image: UIImage(named:"stone")),
        ]
    }
    
    func fileLocation() -> String {
        let basePath = FileManager.default.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first?.relativePath.appending("/file.json")
        return basePath ?? "no path"
    }

    
    func loadData(){
        if let base = FileManager.default.contents(atPath: fileLocation()) {
            if let newThings = try? JSONDecoder().decode([RatedThing].self, from: base) {
                things = newThings
            }
            
        }
        
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(self.things) {
            if FileManager.default.fileExists(atPath: self.fileLocation()) {
                try? FileManager.default.removeItem(atPath: self.fileLocation())
            }
            FileManager.default.createFile(atPath: self.fileLocation(), contents: data, attributes: [:])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {   //changes on second screen will appear on first one
        super.viewWillAppear(animated)
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newThing))
        saveData()
    }
    
    @objc func newThing() {
        let thing = RatedThing(name:"", rating: 0, image: nil)
        things.append(thing)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController{
            vc.ratedThing = thing
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard let cell = sender as? RatedThingCell else {return}
        
        guard let detail = segue.destination as? ViewController else {return}
        guard let indexPath = tableView.indexPath(for:cell) else{return}
        let thing = things[indexPath.row]
        detail.ratedThing = thing
    
    }
    
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatedThingCell", for: indexPath)
        
        if let cell = cell as? RatedThingCell {
            cell.configure(thing: things[indexPath.row])
        }
        
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            DispatchQueue.main.async {
                self.things.remove(at: indexPath.row)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
                self.saveData()
            }
            completion(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

