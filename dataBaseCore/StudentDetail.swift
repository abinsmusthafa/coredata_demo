//
//  StudentDetail.swift
//  dataBaseCore
//
//  Created by oneteam on 30/04/19.
//  Copyright © 2019 oneteam. All rights reserved.
//

import UIKit
import CoreData

class StudentDetail: UITableViewController {
    var studentArray :[NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
 fetchstudents()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchstudents()
    }

  
    func fetchstudents() {
        studentArray.removeAll()
        
        let delegate = UIApplication.shared.delegate  as? AppDelegate
        let context = delegate?.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        request.returnsObjectsAsFaults = false
        do {
            studentArray = try  context?.fetch(request) as! [NSManagedObject]
            tableView.reloadData()
            studentArray.forEach { (studnet) in
                print(studnet.value(forKey: "stud_name") as! String)
                
            }
            
        }catch{
    
        }
    
    }
    
    func editStudent(indexpath : IndexPath){
        print(indexpath.row)
        
        let storboard  = UIStoryboard(name: "Main", bundle: nil)
        
        let EditVC = storboard.instantiateViewController(withIdentifier: "addStudent") as? ViewController
    EditVC?.studDetail = studentArray[indexpath.row]
        navigationController?.pushViewController(EditVC!, animated: true)
        
        
    }
    
    @IBAction func deleteClicked(_ sender: UIBarButtonItem) {
    }
    
    func deleteStudent(indexpath : IndexPath){
        let delegate = UIApplication.shared.delegate  as? AppDelegate
        let context = delegate?.persistentContainer.viewContext
        
        let deleteObj = studentArray[indexpath.row]
        context?.delete(deleteObj)
        
        do {
            
            try context?.save()
            fetchstudents()
        }catch{
          print("error deleting")
        }
        
    }
}



extension StudentDetail{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as? StudentCell{
            
            cell.cellConfig(student: studentArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    

    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit  = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
        
            self.editStudent(indexpath : indexPath )
            
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            self.deleteStudent(indexpath: indexPath)
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return UISwipeActionsConfiguration(actions: [delete,edit])
    }
}
