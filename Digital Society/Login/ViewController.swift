//
//  ViewController.swift
//  Digital Society
//
//  Created by jainish on 07/10/18.
//  Copyright © 2018 jainish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var alert = SweetAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let arr = getLoginData()
        if arr.count == 1{
            
            let getDisc = arr[0]
            let cat : String = getDisc["category"] as! String
            if cat == "Rental"{
                let next1 = self.storyboard?.instantiateViewController(withIdentifier: "Rentaltab")
                self.navigationController?.pushViewController(next1!, animated: false)
            }else {
                let next1 = self.storyboard?.instantiateViewController(withIdentifier: "HomeOwnertab")
                self.navigationController?.pushViewController(next1!, animated: false)
            }
        }
    }
    @IBAction func loginbtn(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginviewcontroller
        self.navigationController?.pushViewController(next, animated: false)
    }
   /* func checkLoginData() {
        
        let flm = FileManager()
        if flm.fileExists(atPath: getUserPath()) {
            
            var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
            var arr = disc["userRecord"] as! [[String:Any]]
            if arr.count == 1{
                
                let getDisc = arr[0]
                let cat : String = getDisc["category"] as! String
                if cat == "Rental"{
                    let next1 = self.storyboard?.instantiateViewController(withIdentifier: "Rentaltab")
                    self.navigationController?.pushViewController(next1!, animated: false)
                }else {
                    let next1 = self.storyboard?.instantiateViewController(withIdentifier: "HomeOwnertab")
                    self.navigationController?.pushViewController(next1!, animated: false)
                }
            }
        }
    }*/
    /*func getUserPath() -> String {
        
        let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = arr[0]
        let finalPath = path.appending("/userLogin.plist")
        print(finalPath)
        return finalPath
    }*/
    @IBAction func signupbtn(_ sender: Any) {
        
        UIView.animate(withDuration: 0.6) {
            
            /*self.alert.showAlert("Select Any One", subTitle: "Choose Appropriate Option", style: AlertStyle.none, buttonTitle:"HomeOwner", buttonColor:UIColor.gray , otherButtonTitle:  "Secretary", otherButtonColor: UIColor.gray) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    
                    let next1 = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! signupviewcontroller
                    self.navigationController?.pushViewController(next1, animated: false)
                }
                else {
                    let next1 = self.storyboard?.instantiateViewController(withIdentifier: "secretary") as! secretaryviewcontroller
                    self.navigationController?.pushViewController(next1, animated: false)
                }
                self.alert.view.superview?.isUserInteractionEnabled = true
                self.alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            }*/
            
        }
 let next1 = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! signupviewcontroller
            self.navigationController?.pushViewController(next1, animated: false)
    }
    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
}
