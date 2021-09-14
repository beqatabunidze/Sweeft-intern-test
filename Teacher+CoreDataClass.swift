//
//  Teacher+CoreDataClass.swift
//  Teacher
//
//  Created by Beqa Tabunidze on 13.09.21.
//
//

import Foundation
import CoreData
import UIKit

@objc(Teacher)
public class Teacher: NSManagedObject {

    static let shared = Teacher()
    
    func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveTeacher(teacherName: String, teacherSurname: String, gender: String, subject: String, pupilList:Array<Pupil>, OnSuccess:(Bool) -> Void)
    {
        let context = self.getContext()
        let teacherEntity = NSEntityDescription.entity(forEntityName: "Teacher", in: context)
        let newTeacher = Teacher(entity: teacherEntity!, insertInto: context)
        newTeacher.name = teacherName
        newTeacher.surname = teacherSurname
        newTeacher.gender = gender
        newTeacher.subject = subject
        newTeacher.pupils = NSSet(array: pupilList)
        do
        {
            try context.save()
            print("teacher saved")
            OnSuccess(true)
        } catch { OnSuccess(false) }
    }
    
    func fetchTeacher(onComplete:([Teacher]?) -> Void)
    {
        let context = self.getContext()
        let request = NSFetchRequest<NSFetchRequestResult> (entityName:  "Teacher")
        request.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(request) as! [Teacher]
            
            if results.count > 0
            {
                onComplete(results)
            }
            else
            {
                onComplete(nil)
            }
        }
        catch
        {
            //PROCESS ERROR
        }
    }
    
}
