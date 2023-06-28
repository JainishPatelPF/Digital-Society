//
//  secretaryviewcontroller.swift
//  Digital Society
//
//  Created by jainish on 08/10/18.
//  Copyright © 2018 jainish. All rights reserved.
//

import UIKit
import TextFieldEffects
import TransitionButton
class secretaryviewcontroller: UIViewController {

 

    @IBOutlet weak var button: TransitionButton!
    @IBOutlet weak var txtpwd: UITextField!
    @IBOutlet weak var confpass: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var bdate: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        bdate.inputView = datepicker
        datepicker.addTarget(self, action: #selector(self.datechanged(datepicker:)), for: .valueChanged)
        password.isSecureTextEntry = true
        
        confpass.isSecureTextEntry = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func dismisskeyboard()  {
        view.endEditing(true)
    }
    
    @IBAction func passtext(_ sender: Any) {
        if isValidPassword(pwd: txtpwd.text!) {
            
            txtpwd.rightViewMode = .never
            txtpwd.clipsToBounds = true
            txtpwd.layer.borderWidth = 1
            txtpwd.layer.borderColor = UIColor.green.cgColor
        }
        else {
            
            txtpwd.rightViewMode = .whileEditing
            let imgview = UIImageView(image: UIImage(named: "if_Help_mark_query_question_support_talk_271504.png"))
            txtpwd.rightView = imgview
            txtpwd.clipsToBounds = true
            txtpwd.layer.borderWidth = 1
            txtpwd.layer.borderColor = UIColor.red.cgColor
        }
    }
    @IBAction func passtextchanged(_ sender: Any) {
        if isValidPassword(pwd: confpass.text!) {
            
            confpass.rightViewMode = .never
            confpass.clipsToBounds = true
            confpass.layer.borderWidth = 1
            confpass.layer.borderColor = UIColor.green.cgColor
        }
        else {
            
            confpass.rightViewMode = .whileEditing
            let imgview = UIImageView(image: UIImage(named: "if_Help_mark_query_question_support_talk_271504.png"))
            confpass.rightView = imgview
            confpass.clipsToBounds = true
            confpass.layer.borderWidth = 1
            confpass.layer.borderColor = UIColor.red.cgColor
        }
    }
    func isValidPassword(pwd: String) -> Bool {
        
        //Minimum 6 Max 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
        let PHONE_REGEX = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: pwd)
        return result
    }
    @objc func datechanged(datepicker: UIDatePicker)  {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy"
        bdate.text = dateformatter.string(from: datepicker.date)
        view.endEditing(true)
    }
   
    
    @IBAction func createaccbtn(_ sender: Any) {
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
                    let next4 = self.storyboard?.instantiateViewController(withIdentifier: "secdet") as! secdetails
                    self.navigationController?.pushViewController(next4, animated: false)
                })
            })
        })
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
