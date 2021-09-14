//
//  TeachersViewController.swift
//  SweeftTaskSeven
//
//  Created by Beqa Tabunidze on 13.09.21.
//

import UIKit
import CoreData


class TeachersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tacherNameTextField: UITextField!
    @IBOutlet weak var teacherSurnameTextField: UITextField!
    @IBOutlet weak var teacherGenderTextField: UITextField!
    @IBOutlet weak var teacherSubjectTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var teachers_tableView: UITableView!
    
    var pupilsList: [Pupil]?
    var selectedPupilList:Array<Pupil>? = Array<Pupil>()
    
    var teacherList: [Teacher]?
    
    var filteredData: Array<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        filteredData = teacherList
        
        Pupil.shared.fetchPupil(onComplete: { (response:[Pupil]?) -> Void in
            if let pupList = response, pupList.count > 0{
                self.pupilsList = pupList
                self.tableView.reloadData()
            }
        })
        
        Teacher.shared.fetchTeacher { (response:[Teacher]?) -> Void in
            if let teachers = response, teachers.count > 0{
                self.teacherList = teachers
                self.teachers_tableView.reloadData()
            }
        }
    }
    

    
    @IBAction func btnSaveOnClick(_ sender: UIButton) {
        
        if let teacherName = self.tacherNameTextField.text, teacherName != "", (self.selectedPupilList!.count) > 0 {
            Teacher.shared.saveTeacher(teacherName: teacherName, teacherSurname: teacherSurnameTextField.text ?? "No last name", gender: teacherGenderTextField.text ?? "Unknown gender", subject: teacherSubjectTextField.text ?? "No subject specified",  pupilList: self.selectedPupilList!, OnSuccess: { (status:Bool) -> Void in
                self.tacherNameTextField.text = ""
                self.teacherSurnameTextField.text = ""
                self.teacherGenderTextField.text = ""
                self.teacherSubjectTextField.text = ""
                Teacher.shared.fetchTeacher { (response:[Teacher]?) -> Void in
                    if let teachers = response, teachers.count > 0 {
                        self.teacherList = teachers
                        self.teachers_tableView.reloadData()
                        self.selectedPupilList?.removeAll()
                        self.tableView.reloadData()
                    }
                }
            })

        }
        
    }
    
    //MARK: -UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 0 {
            
            if let pupList = self.pupilsList {
                
                return pupList.count
                
            } else { return 0 }
            
        } else {
            
            if let filteredTeachers = self.filteredData {
                

                return filteredTeachers.count


            } else { return 0 }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if tableView.tag == 0 {
            
            if let pupList = self.pupilsList {
                
                cell.textLabel?.text = pupList[indexPath.row].name!
            }
            
            cell.accessoryType = .none
            
        } else {
            
            if let pupils = self.teacherList {
                
                cell.textLabel?.text = "\(pupils[indexPath.row].name!) " + "\(pupils[indexPath.row].surname ?? "unknown surname") • " + "\(pupils[indexPath.row].gender ?? "none") • " + "\(pupils[indexPath.row].subject ?? "unknown")"
            }
            
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    //MARK: -UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.selectedPupilList?.append(self.pupilsList![indexPath.row])
        }
        else{
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
                if let teamList = self.teacherList, let empList = teamList[indexPath.row].pupils{
                    vc.flag = 0
                    vc.pupilList = Array(empList) as? Array<Pupil>
                    vc.title = "\(teamList[indexPath.row].name!)" + "'s pupil"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.tag == 0{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if let selectedEmp = self.pupilsList?[indexPath.row]{
                self.selectedPupilList = self.selectedPupilList?.filter { $0.name != selectedEmp.name }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        

        if searchText == "" {
            
            filteredData = self.teacherList
 
        }

        for pupil in pupilsList! {

            if pupil.name!.lowercased().contains(searchText.lowercased()) {
                

                filteredData.append(pupil)
                self.teachers_tableView.reloadData()

            }

            self.teachers_tableView.reloadData()
        }
        
    }

}
