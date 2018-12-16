//
//  NewEntriesViewController.swift
//  Travelouge
//
//  Created by Brendan Krekeler on 12/5/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.


import UIKit
import CoreData

class NewEntriesViewController: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var trip: Trip?
    var newEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.delegate = self
        descriptionText.delegate = self as? UITextViewDelegate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleText.resignFirstResponder()
        descriptionText.resignFirstResponder()
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        guard let name = titleText.text else {
            return
        }
        guard let desc = descriptionText.text else {
            return
        }
        let date = Date()

        var entry: Entry?
            
        if let existingEntry = newEntry {
            entry = existingEntry
            entry?.name = name
            entry?.desc = desc
            entry?.date = date
        } else {
            entry = Entry(name: name, desc: desc, rawDate: date)
        }
        
        if let entry = entry {
            do {
                let managedObjectContext = entry.managedObjectContext
                try managedObjectContext?.save()
            } catch {
                print("Entry could not be saved")
                return
            }
        }
        
       _ = navigationController?.popViewController(animated: true)
    }
}

extension NewEntriesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
