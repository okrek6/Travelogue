//
//  Trip+CoreDataClass.swift
//  Travelouge
//
//  Created by Brendan Krekeler on 1/4/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    var trips: [Trip]? {
        return self.rawEntries?.array as? [Trip]
    }
    
    convenience init?(title: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Trip.entity(), insertInto: context)
        
        self.title = title
    }
    
}
