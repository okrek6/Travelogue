//
//  Entry+CoreDataClass.swift
//  Travelouge
//
//  Created by Brendan Krekeler on 12/4/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Entry)
public class Entry: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        } set {
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(name: String?, desc: String?, rawDate: Date?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Entry.entity(), insertInto: context)
        
        self.name = name
        self.desc = desc
        self.date = rawDate
    }
}
