//
//  Teacher+CoreDataProperties.swift
//  Teacher
//
//  Created by Beqa Tabunidze on 13.09.21.
//
//

import Foundation
import CoreData


extension Teacher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teacher> {
        return NSFetchRequest<Teacher>(entityName: "Teacher");
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var gender: String?
    @NSManaged public var subject: String?
    @NSManaged public var pupils: NSSet?

}

extension Teacher {

    @objc(addPupilsObject:)
    @NSManaged public func addToPupils(_ value: Pupil)

    @objc(removePupilsObject:)
    @NSManaged public func removeFromPupils(_ value: Pupil)

    @objc(addPupils:)
    @NSManaged public func addToPupils(_ values: NSSet)

    @objc(removePupils:)
    @NSManaged public func removeFromPupils(_ values: NSSet)

}
