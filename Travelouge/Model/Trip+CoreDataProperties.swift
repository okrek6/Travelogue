//
//  Trip+CoreDataProperties.swift
//  Travelouge
//
//  Created by Brendan Krekeler on 12/5/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var title: String?
    @NSManaged public var rawEntries: NSOrderedSet?
    
}
    
    extension Trip {
        
        @objc(insertObject:inRawEntriesAtIndex:)
        @NSManaged public func insertIntoRawEntries(_ value: Entry, at idx: Int)
        
        @objc(removeObjectFromRawEntriesAtIndex:)
        @NSManaged public func removeFromRawEntries(at idx: Int)
        
        @objc(insertRawEntries:atIndexes:)
        @NSManaged public func insertIntoRawEntries(_ values: [Entry], at indexes: NSIndexSet)
        
        @objc(removeRawEntriesAtIndexes:)
        @NSManaged public func removeFromRawEntries(at indexes: NSIndexSet)
        
        @objc(replaceObjectInRawEntriesAtIndex:withObject:)
        @NSManaged public func replaceRawEntries(at idx: Int, with value: Entry)
        
        @objc(replaceRawEntriesAtIndexes:withRawEntries:)
        @NSManaged public func replaceRawEntries(at indexes: NSIndexSet, with values: [Entry])
        
        @objc(addRawEntriesObject:)
        @NSManaged public func addToRawEntries(_ value: Entry)
        
        @objc(removeRawEntriesObject:)
        @NSManaged public func removeFromRawEntries(_ value: Entry)
        
        @objc(addRawEntries:)
        @NSManaged public func addToRawEntries(_ values: NSOrderedSet)
        
        @objc(removeRawEntries:)
        @NSManaged public func removeFromRawEntries(_ values: NSOrderedSet)

}
