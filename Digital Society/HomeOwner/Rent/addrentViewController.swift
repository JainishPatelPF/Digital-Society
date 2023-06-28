//  addrentViewController.swift
//  Digital Society
//
//  Created by jainish on 04/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit
import TextFieldEffects
import TransitionButton

class addrentViewController: UIViewController {

    @IBOutlet var personname: HoshiTextField!
    @IBOutlet var bdate: HoshiTextField!
    @IBOutlet var phoneno: HoshiTextField!
    @IBOutlet var email: HoshiTextField!
    @IBOutlet var document: UISegmentedControl!
    @IBOutlet var occupation: HoshiTextField!
    @IBOutlet var noofchild: HoshiTextField!
    @IBOutlet var gender: HoshiTextField!
    @IBOutlet var maritalstatus: UISegmentedControl!
    @IBOutlet var btn: TransitionButton!
    @IBOutlet var lblemail: UILabel!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var password: HoshiTextField!
    @IBOutlet var lblpassword: UILabel!
    
    var docans = " "
    var marstatus = " "
    var manager_id  : String = ""
    var category = "Rental"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getLoginData()
        
        scrollview.contentSize = scrollview.bounds.size
        view.addSubview(scrollview)
        
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        bdate.inputView = datepicker
        datepicker.addTarget(self, action: #selector(self.datechanged(datepicker:)), for: .valueChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismisskeyboard()  {
        view.endEditing(true)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func datechanged(datepicker: UIDatePicker)  {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        bdate.text = dateformatter.string(from: datepicker.date)
        //datepicker.isHidden = false
        //view.endEditing(true)
    }
    @IBAction func birthdate(_ sender: Any) {
    }
    
    
    func insertData()  {
       
        if document.selectedSegmentIndex == 0 {
            
            docans = "Yes";
        }else
        {
            docans = "No";
        }
        if maritalstatus.selectedSegmentIndex == 0 {
            marstatus = "Yes"
        }else{
            marstatus = "No"
        }
        
        let str = "http://localhost:8080/DigitalSociety_Web/insert_rentalinfo.php"
        
        let disc :[String: Any] = ["owner_id":manager_id,"rent_personname":personname.text!,"rent_personDOB":bdate.text!,"rent_personcontact":phoneno.text!,"rent_personemail":email.text!,"rent_persondocument":docans,"occupation":occupation.text!,"rent_person_no_child":noofchild.text!,"rent_persongender":gender.text!
            ,"rent_person_marital_status":marstatus, "rent_password":password.text!,"category":category]
        let url = URL(string: str)
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        do {
            let strBody = try JSONSerialization.data(withJSONObject: disc, options: [])
            request.addValue(String(strBody.count), forHTTPHeaderField: "Content-Length")
            request.httpBody = strBody
            request.httpMethod = "POST"
            
            let dataTask = session.dataTask(with: request) { (dat1, resp1, err) in
                
                let result = String(data: dat1!, encoding: String.Encoding.utf8)
                print(result!)
            }
            dataTask.resume()
        } catch  {
            
        }
    }
   
    func getLoginData() {
        
        let flm = FileManager()
        if flm.fileExists(atPath: getUserPath()) {
            
            var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
            var arr = disc["userRecord"] as! [[String:Any]]
            if arr.count == 1{
                let disc = arr[0]
                manager_id = disc["manager_id"] as! String
            }
        }
    }
    @IBAction func passwordaction(_ sender: Any) {
        if isValidPassword(pwd: password.text!) {
            
            password.rightViewMode = .never
            lblpassword.isHidden = true
        }else{
            
            password.rightViewMode = .whileEditing
            let imgview = UIImageView(image: UIImage(named: "rsz_alert-512.png"))
            password.rightView = imgview
            lblpassword.isHidden = false
            lblpassword.text = "Enter atleast 8 Character Containing 1 Uppercase,Number and Special Character"
        }
    }
    func isValidPassword(pwd: String) -> Bool {
        
        //Minimum 6 Max 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
        let PHONE_REGEX = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: pwd)
        return result
    }
    
    
    
    func getUserPath() -> String {
        
        let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = arr[0]
        let finalPath = path.appending("/userLogin.plist")
        print(finalPath)
        return finalPath
    }
    @IBAction func gender(_ sender: Any) {
        self.dismisskeyboard()
        let alert = UIAlertController(title: "Select any one", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Male", style: .default, handler: { (action) in
            print("Male")
            self.gender.text="Male"
        }))
        alert.addAction(UIAlertAction(title: "Female", style: .default, handler: { (action) in
            print("Female")
            self.gender.text="Female"
        }))
        alert.addAction(UIAlertAction(title: "Others", style: .default, handler: { (action) in
            print("Others")
            self.gender.text="Others"
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func emailidvalidation(_ sender: Any) {
        if isValidEmail(email: email.text!) {
            
            email.rightViewMode = .never
            email.clipsToBounds = true
            // txtemail.layer.borderWidth = 1
            // txtemail.layer.borderColor = UIColor.green.cgColor
            lblemail.isHidden = true
        }
        else {
            
            email.rightViewMode = .whileEditing
            let imgview = UIImageView(image: UIImage(named: "rsz_alert-512.png"))
            email.rightView = imgview
            email.clipsToBounds = true
            //  txtemail.layer.borderWidth = 1
            // txtemail.layer.borderColor = UIColor.red.cgColor
            lblemail.isHidden = false
            lblemail.text = "Enter Email in sense of: Firstpart@secondPart.domainname"
        }
    }
    
    func isValidEmail(email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    @IBAction func savebtn(_ sender: Any) {
        insertData()
        btn.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(2)
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.btn.stopAnimation(animationStyle: .expand, completion: {
                    let next4 = self.storyboard?.instantiateViewController(withIdentifier: "rent") as! RentViewController
                    self.navigationController?.popViewController(animated: true)
                })
            })
        })
    }
    
  

}
