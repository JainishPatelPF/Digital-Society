//
//  memdetails.swift
//  Digital Society
//
//  Created by jainish on 12/12/18.
//  Copyright © 2018 jainish. All rights reserved.
//

import UIKit
import TextFieldEffects
import TransitionButton

class homeownerdetails: UIViewController {
    @IBOutlet weak var button: TransitionButton!
    @IBOutlet weak var txtaddress: HoshiTextField!
    @IBOutlet weak var Noofmember: HoshiTextField!
    @IBOutlet weak var occupation: HoshiTextField!
    @IBOutlet weak var phoneno: HoshiTextField!
    @IBOutlet weak var segmentedstatus: UISegmentedControl!
    @IBOutlet weak var gender: HoshiTextField!
    @IBOutlet var house_no: HoshiTextField!
    @IBOutlet var memsoc: UISegmentedControl!
    @IBOutlet var status: HoshiTextField!
    @IBOutlet var nohouseavail: HoshiTextField!
    @IBOutlet var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollview.contentSize = scrollview.bounds.size
        view.addSubview(scrollview)
        
        // Do any additional setup after loading the view.
    }
    @objc func dismisskeyboard()  {
        
        view.endEditing(true)
    }

    @IBAction func createacc(_ sender: Any) {
        insertData()
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(2) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                self.button.stopAnimation(animationStyle: .expand, completion: {
                    let next4 = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginviewcontroller
                    self.navigationController?.pushViewController(next4, animated: false)
                })
            })
        })
    }
    
    func insertData()  {
        
        let category = "Homeowner";
        
        //  let imgData = UIImagePNGRepresentation((btnProfileImgView.imageView?.image)!)
        //    let baseStr = imgData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
        var societymember = "";
        
        if memsoc.selectedSegmentIndex == 0 {
            
            societymember = "Yes";
        }else
        {
            societymember = "No";
        }
      
        let dif1 = UserDefaults.standard;
        
        let fullname = dif1.value(forKey: "name");
        let bdate = dif1.value(forKey: "dob")
        let username = dif1.value(forKey: "username")
        let password = dif1.value(forKey: "password")
        let email = dif1.value(forKey: "email")

        let str = "http://localhost:8080/DigitalSociety_Web/Insert_Owner_Profile.php"
        
        let disc :[String: Any] = ["email":email!,"house_no":house_no.text!,"contact_no":phoneno.text!,"member_soc":societymember,"name":fullname!,"no_house_available":nohouseavail.text!,"no_member":Noofmember.text!,"occupation":occupation.text!,"status":status.text!,"password":password!,"DOB":bdate!,"username":username!]
       // let disc : [String : Any] = ["name":fullname!,"DOB":bdate!,"username":username!,"password":password!,"email":email,"address":txtaddress.text!,"nomember":Noofmember.text!,"occupation":occupation.text!,"phonenumber":phoneno.text!,"gender":gender.text!];
        do {
            let body = try JSONSerialization.data(withJSONObject: disc, options: [])
            let url = URL(string: str)
            var request = URLRequest(url: url!)
            
            request.addValue(String(body.count), forHTTPHeaderField: "Content-Length")
            request.httpBody = body
            request.httpMethod = "POST"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data1, resp1, err) in
                
                let result = String(data: data1!, encoding: String.Encoding.utf8)
                print(result!)
                
            })
            dataTask.resume()
            
        } catch  {
            
        }
    }

    @IBAction func genderopt(_ sender: Any) {
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
    @IBAction func status(_ sender: Any) {
        self.dismisskeyboard()
        let alert = UIAlertController(title: "Select any one", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            print("Male")
            self.gender.text="Male"
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
