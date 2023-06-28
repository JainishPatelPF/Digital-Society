//
//  secshowprofile.swift
//  Digital Society
//
//  Created by jainish on 25/01/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit
import TextFieldEffects

var arrData1 : [[String:Any]] = []
var finalData1  :[[String:Any]] = []

var alert1 = SweetAlert()

class secshowprofile: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var btnSelectGallery: UIButton!
    @IBOutlet weak var name: HoshiTextField!
    @IBOutlet weak var dob: HoshiTextField!
    @IBOutlet weak var contact_no: HoshiTextField!
    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var username: HoshiTextField!
    var ownerID : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        getLoginData()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnUpdate(_ sender: Any) {
        
        updateData()
    }
    @objc func dismisskeyboard()  {
        view.endEditing(true)
        
    }
    func updateData()  {
        
        
        let imgData = (btnSelectGallery.imageView?.image)!.pngData()
        let baseStr = imgData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        let str = "http://localhost:8080/DigitalSociety_Web/Update_Owner_Profile.php"
        let disc : [String : Any] = ["owner_id":ownerID!,"email":email.text!,"name":name.text!,"DOB":dob.text!,"username":username.text!,"contact_no":contact_no.text!,"image":baseStr!];
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
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data1!, options: []) as! [[String:Any]]
                    DispatchQueue.main.async {
                        if jsonData.count == 1 {
                            
                            finalData1 = jsonData
                            self.setLoginData()
                        }
                    }
                }catch{
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
                ownerID = (getDisc["owner_id"] as? NSString)?.integerValue
                name.text = getDisc["name"] as? String
                dob.text  = getDisc["DOB"] as? String
                email.text = getDisc["email"]as? String
                username.text = getDisc["username"]as? String
                contact_no.text = getDisc["contact_no"]as? String
                let imgName = getDisc["image"] as? String
                let url = "http://localhost:8080/DigitalSociety_Web/"
                let urlStr = url + imgName!
                let finalUrl = URL(string: urlStr)
                do{
                    let imgData = try Data.init(contentsOf: finalUrl!)
                    let image = UIImage(data: imgData)
                    btnSelectGallery.setImage(image, for: .normal)
                }catch{
                    
                }
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
