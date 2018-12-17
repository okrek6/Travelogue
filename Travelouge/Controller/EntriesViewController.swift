//
//  EntriesViewController.swift
//  Travelouge
//
//  Created by Brendan Krekeler on 12/5/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class EntriesViewController: UIViewController {
    
    @IBOutlet weak var entriesTableView: UITableView!
    
    var entries: [Entry] = []
    
    let dateFormatter = DateFormatter()
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entries"
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        var fetchedEntries: [Entry] = []
        do {
            fetchedEntries = try managedContext.fetch(fetchRequest)
        } catch {
            print("Could not fetch")
        }
        
        entries.removeAll()
        entries = fetchedEntries
        entriesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SingleEntriesViewController,
            let segueIdentifier = segue.identifier, segueIdentifier == "viewEntry",
            let row = entriesTableView.indexPathForSelectedRow?.row {
            destination.entry = entries[row]
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteEntry(at: indexPath)
        }
    }
    
    func deleteEntry(at indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        guard let managedContext = entry.managedObjectContext else {
            return
        }
        
        managedContext.delete(entry)
        
        do {
            try managedContext.save()
            
            entries.remove(at: indexPath.row)
            entriesTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete entry")
            
            entriesTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension EntriesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        if let cell = cell as? EntriesTableViewCell {
            let entry = entries[indexPath.row]
            cell.nameLabel.text = entry.name
            
            if let date = entry.date {
                cell.dateLabel.text = dateFormatter.string(from: date)
            }
            
        }
        
        return cell
    }
}

