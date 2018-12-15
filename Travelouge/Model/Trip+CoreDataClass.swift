//
//  Trip+CoreDataClass.swift
//  Travelouge
//
//  Created by Brendan Krekeler on 12/4/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
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
