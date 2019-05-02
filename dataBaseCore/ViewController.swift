//
//  ViewController.swift
//  dataBaseCore
//
//  Created by oneteam on 30/04/19.
//  Copyright © 2019 oneteam. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var idTxt: UITextField!
    @IBOutlet weak var saveUpdateBtn: UIButton!
    
    var studDetail : NSManagedObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        if studDetail != nil{
            
            saveUpdateBtn.setTitle("Edit", for: .normal)
            cofigEdit()
        }
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func cancellButtonClicked(_ sender: UIButton) {
        
       dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        if studDetail != nil{
            editData()
        }else{
            guard let userID = idTxt.text , !userID.isEmpty else {return}
            guard let name = nameTxt.text , !name.isEmpty else {return}
            guard let age = ageTxt.text , !age.isEmpty else {return}
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appdelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
            
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(userID, forKey: "stud_id")
            newUser.setValue(name, forKey: "stud_name")
            newUser.setValue(age, forKey: "stud_age")
            
            do{
                try context.save()
                navigationController?.popViewController(animated: true)
                
            }catch let error{
                print(error.localizedDescription)
                
            }
            
            
        }
    
  
    }
    
    
    
    func editData(){
    
        guard let userID = idTxt.text , !userID.isEmpty else {return}
        guard let name = nameTxt.text , !name.isEmpty else {return}
        guard let age = ageTxt.text , !age.isEmpty else {return}
        
        
    let delegate =  UIApplication.shared.delegate as? AppDelegate
        let context = delegate?.persistentContainer.viewContext
        
        
        let editObject = studDetail
        
        editObject?.setValue(name, forKey: "stud_name")
        editObject?.setValue(age, forKey: "stud_age")
        editObject?.setValue(userID, forKey: "stud_id")
       
        
        do {
            
            try context?.save()
            print("sucess saved")
            navigationController?.popViewController(animated: true)
            
        }catch{
            
            print("error edit")
            
        }
    
        
    }
    func cofigEdit(){
        
        let age = studDetail?.value(forKey: "stud_age") as? String
        let name = studDetail?.value(forKey: "stud_name") as? String
        let studId = studDetail?.value(forKey: "stud_id") as?  String
        
        ageTxt.text = age
        idTxt.text = studId
        nameTxt.text = name
        
      
        
    }
}

