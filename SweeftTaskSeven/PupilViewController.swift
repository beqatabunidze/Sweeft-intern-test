//
//  ViewController.swift
//  SweeftTaskSeven
//
//  Created by Beqa Tabunidze on 13.09.21.
//

import UIKit

class PupilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var pupilNameTextField: UITextField!
    @IBOutlet weak var pupilSurnameTextField: UITextField!
    @IBOutlet weak var pupilGenderTextField: UITextField!
    @IBOutlet weak var pupilClassTextfield: UITextField!
    
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var pupilLists:Array<Pupil>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Pupil.shared.fetchPupil(onComplete: { (response:[Pupil]?) -> Void in
            if let empList = response, empList.count > 0{
                self.pupilLists = empList
                self.tableView.reloadData()
            }
        })
    }

    
    //MARK: -ACTIONS
    
    @IBAction func btnSaveOnClick(_ sender: UIButton) {
        if let name = self.pupilNameTextField.text, name != "" {
            Pupil.shared.savePupil(name: name, surname: pupilSurnameTextField.text ?? "Unknown surname", gender: pupilGenderTextField.text ?? "none", className: pupilClassTextfield.text ?? "unspecified", OnSuccess: { (status:Bool) -> Void in
                
                if status {
                    
                    self.pupilNameTextField.text = ""
                    self.pupilSurnameTextField.text = ""
                    self.pupilGenderTextField.text = ""
                    self.pupilClassTextfield.text = ""
                    
                    Pupil.shared.fetchPupil(onComplete: { (response:[Pupil]?) -> Void in
                        if let empList = response, empList.count > 0{
                            self.pupilLists = empList
                            self.tableView.reloadData()
                        }
                    })
                }
                else {
                    
                    print("Name not saved!")
                }
            })
        }
    }
    
    //MARK: -UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pupList = self.pupilLists{
            return pupList.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if let pupList = self.pupilLists{
            cell.textLabel?.text = "\(pupList[indexPath.row].name!) " + "\(pupList[indexPath.row].surname ?? "unknown") • " + "\(pupList[indexPath.row].gender ?? "none") • " + "\(pupList[indexPath.row].classNum ?? "unknown")"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let pupil = self.pupilLists?[indexPath.row]{
            if let teacherList = pupil.teachers{
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
                    vc.flag = 1
                    vc.teacherList = Array(teacherList) as? [Teacher]
                    vc.title = "Teachers"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
}

