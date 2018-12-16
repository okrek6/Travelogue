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
        
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
        entriesTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        var fetchedEntries: [Entry] = []
        do {
            fetchedEntries = try managedContext.fetch(fetchRequest)
            entriesTableView.reloadData()
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
    
    @IBAction func addNewEntry(_ sender: Any) {
        performSegue(withIdentifier: "showEntry", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewEntriesViewController else {
            return
        }
        
        destination.trip = trip
    }
    
    func deleteDocument(at indexPath: IndexPath) {
        guard let trip = trip?.trips?[indexPath.row], let managedContext = trip.managedObjectContext else {
            return
        }
        
        managedContext.delete(trip)
        
        do {
            try managedContext.save()
            
            entriesTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete entry")
            
            entriesTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

extension EntriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
}

extension EntriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewEntry", sender: self)
    }
}
