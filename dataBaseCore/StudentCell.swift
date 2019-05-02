//
//  StudentCell.swift
//  dataBaseCore
//
//  Created by oneteam on 30/04/19.
//  Copyright © 2019 oneteam. All rights reserved.
//

import UIKit
import CoreData

class StudentCell: UITableViewCell {

    @IBOutlet weak var lblStudAge: UILabel!
    @IBOutlet weak var lblStudName: UILabel!
    @IBOutlet weak var lblStudId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellConfig(student : NSManagedObject){
        
        let name = student.value(forKey: "stud_name") as? String
        let age = student.value(forKey: "stud_age") as? String
        let id = student.value(forKey: "stud_id") as? String
        
        lblStudId.text = id
        lblStudName.text = name
        lblStudAge.text = age
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
