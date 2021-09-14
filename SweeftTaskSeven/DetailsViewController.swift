//
//  DetailsViewController.swift
//  SweeftTaskSeven
//
//  Created by Beqa Tabunidze on 13.09.21.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource {

    var pupilList:Array<Pupil>?
    var teacherList: Array<Teacher>?
    
    var flag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if flag == 0{
            if let pupList = self.pupilList{
                return pupList.count
            }
            else{
                return 0
            }
        }
        else
        {
            if let teachList = self.teacherList{
                return teachList.count
            }
            else {
                
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if flag == 0 {
            if let pupList = self.pupilList {
                
                cell.textLabel?.text = pupList[indexPath.row].name!
            }
        } else {
            
            if let teachList = self.teacherList {
                
                cell.textLabel?.text = "\(teachList[indexPath.row].name!)"
            }
        }
        
        return cell
    }
    

}
