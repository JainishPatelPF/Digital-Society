//
//  SocietyRegistrationViewController.swift
//  Digital Society
//
//  Created by jainish on 02/02/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit
import TextFieldEffects

//var arrData1 : [[String:Any]] = []
//var finalData1  :[[String:Any]] = []

//var alert1 = SweetAlert()

class SocietyRegistrationViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var btnSelectGallery: UIButton!
    @IBOutlet var socname: HoshiTextField!
    @IBOutlet var socaddress: HoshiTextField!
    @IBOutlet var socownername: HoshiTextField!
    @IBOutlet var noofhouses: HoshiTextField!
    @IBOutlet var socstatus: HoshiTextField!
    var manager_id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        getLoginData()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    @objc func dismisskeyboard()  {
        view.endEditing(true)
    }
    
    
    @IBAction func insertsocietydata(_ sender: Any) {
        
        insert()
    }
    func insert()  {
        
        let imgData = (btnSelectGallery.imageView?.image)!.pngData()
        let baseStr = imgData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        let str = "http://localhost:8080/DigitalSociety_Web/Update_society_Profile.php"
        let disc : [String : Any] = ["manager_id":manager_id!,"soc_name":socname.text!,"soc_address":socaddress.text!,"soc_ownername":socownername.text!,"noofhouses":noofhouses.text!,"soc_status":socstatus.text!,"soc_bannerimage":baseStr!];
        
        
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
                DispatchQueue.main.async {
                    if result == "Inserted"{
                        let next2 = self.storyboard?.instantiateViewController(withIdentifier: "secsettings") as! Secretarysettings
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            })
            dataTask.resume()
            
        } catch  {
            
        }
    }
    func selectdata()  {
        let imgData = (btnSelectGallery.imageView?.image)!.pngData()
        let baseStr = imgData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
         let str = "http://localhost:8080/DigitalSociety_Web/Select.php"
         let disc : [String : Any] = ["manager_id":manager_id!];
        socname.text = disc["soc_name"] as! String;
        socaddress.text = disc["soc_address"] as! String;
        socownername.text = disc["soc_ownername"] as! String;
        noofhouses.text = disc["noofhouses"] as! String;
        socstatus.text = disc["soc_status"] as! String;
        
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
                DispatchQueue.main.async {
                    if result == "selected"{
                        /*let next2 = self.storyboard?.instantiateViewController(withIdentifier: "secsettings") as! Secretarysettings
                        self.navigationController?.popViewController(animated: true)*/
                    }
                }
            })
            dataTask.resume()
            
        } catch  {
            
        }
        
    }
    @IBAction func btnOpenGallery(_ sender: Any) {
        let alert1 = UIAlertController(title: "Select any one", message: "", preferredStyle: .actionSheet)
        alert1.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (action) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alert1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            
            let imagePicker = UIImagePickerController()
            //imagePicker.sourceType = .camera
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alert1.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert1, animated: true, completion: nil)
      
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        btnSelectGallery.setImage(img, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    func setLoginData() {
        
        let flm = FileManager()
        if flm.fileExists(atPath: getUserPath()) {
            
            var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
            var arr = disc["userRecord"] as! [[String:Any]]
            if arr.count == 1{
                arr =  finalData1
                disc["userRecord"] = arr
                let finalDisc = NSDictionary(dictionary: disc)
                finalDisc.write(toFile: getUserPath(), atomically: true)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func getLoginData() {
        
        let flm = FileManager()
        if flm.fileExists(atPath: getUserPath()) {
            
            var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
            var arr = disc["userRecord"] as! [[String:Any]]
            if arr.count == 1{
                var getDisc : [String:Any] = [:]
                //
                //print(ownerID!)
                getDisc = arr[0]
                manager_id = (getDisc["manager_id"] as? NSString)?.integerValue
                socname.text = getDisc["soc_name"] as? String
                socaddress.text = getDisc["soc_address"] as? String
                socownername.text  = getDisc["soc_ownername"] as? String
                noofhouses.text = getDisc["noofhouses"]as? String
                socstatus.text = getDisc["soc_status"]as? String
                /*let imgName = getDisc["soc_bannerimage"] as? String
                let url = "http://localhost:8080/DigitalSociety_Web/"
                let urlStr = url + imgName
                 !
                let finalUrl = URL(string: urlStr)
                do{
                    let imgData = try Data.init(contentsOf: finalUrl!)
                    let image = UIImage(data: imgData)
                    btnSelectGallery.setImage(image, for: .normal)
                }catch{
                    
                }*/
            }
        }
    }
    
    func getUserPath() -> String {
        
        let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = arr[0]
        let finalPath = path.appending("/userLogin.plist")
        print(finalPath)
        return finalPath
    }

}
