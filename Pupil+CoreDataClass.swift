//
//  Pupil+CoreDataClass.swift
//  Pupil
//
//  Created by Beqa Tabunidze on 13.09.21.
//
//

import Foundation
import CoreData
import UIKit

@objc(Pupil)
public class Pupil: NSManagedObject {
    
    static let shared = Pupil()
    
    func getContext() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func savePupil(name: String, surname: String, gender: String, className: String, OnSuccess:(Bool) -> Void)
    {
        let context = self.getContext()
        let pupilEntity = NSEntityDescription.entity(forEntityName: "Pupil", in: context)
        let newPupil = Pupil(entity: pupilEntity!, insertInto: context)
        newPupil.name = name
        newPupil.surname = surname
        newPupil.gender = gender
        newPupil.classNum = className
        do
        {
            try context.save()
            print("pupil saved")
            OnSuccess(true)
        }
        catch
        {
            OnSuccess(false)
        }
    }
    
    
    func fetchPupil(onComplete:([Pupil]?) -> Void)
    {
        let context = self.getContext()
        context.shouldDeleteInaccessibleFaults = false
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName:  "Pupil")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request) as! [Pupil]
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
