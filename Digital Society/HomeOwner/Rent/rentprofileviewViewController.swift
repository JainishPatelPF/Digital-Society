//
//  rentprofileviewViewController.swift
//  Digital Society
//
//  Created by jainish on 05/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit

class rentprofileviewViewController: UIViewController {

    @IBOutlet var rentpersonname: UILabel!
    @IBOutlet var birthdate: UILabel!
    @IBOutlet var phoneno: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var document: UILabel!
    @IBOutlet var occupation: UILabel!
    @IBOutlet var noofchild: UILabel!
    @IBOutlet var gender: UILabel!
    @IBOutlet var maritalstatus: UILabel!
    @IBOutlet var cancelbtn: UIBarButtonItem!
    
    var dic: [String: String] = [:];
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print(dic);
       
        
        
        rentpersonname.text = dic["rent_personname"]
        birthdate.text = dic["rent_personDOB"]
        phoneno.text = dic["rent_personcontact"]
          email.text = dic["rent_personemail"]
          document.text = dic["rent_persondocument"]
        occupation.text = dic["occupation"]
        noofchild.text = dic["rent_person_no_child"]
        gender.text = dic["rent_persongender"]
        maritalstatus.text = dic["rent_person_marital_status"]

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
   
    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
