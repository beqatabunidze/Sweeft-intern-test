//
//  Pupil+CoreDataProperties.swift
//  Pupil
//
//  Created by Beqa Tabunidze on 13.09.21.
//
//

import Foundation
import CoreData


extension Pupil {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pupil> {
        return NSFetchRequest<Pupil>(entityName: "Pupil");
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var gender: String?
    @NSManaged public var classNum: String?
    @NSManaged public var teachers: NSSet?    
}

extension Pupil {

    @objc(addTeacherObject:)
    @NSManaged public func addToTeacher(_ value: Teacher)

    @objc(removeTeacherObject:)
    @NSManaged public func removeFromTeacher(_ value: Teacher)

    @objc(addTeacher:)
    @NSManaged public func addToTeacher(_ values: NSSet)

    @objc(removeTeacher:)
    @NSManaged public func removeFromTeacher(_ values: NSSet)

}
