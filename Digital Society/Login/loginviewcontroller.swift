import UIKit
import TextFieldEffects
import TransitionButton

class loginviewcontroller: UIViewController {

  
    @IBOutlet var txtemail: HoshiTextField!
    @IBOutlet weak var button: TransitionButton!
    @IBOutlet weak var txtpwd: UITextField!
    @IBOutlet weak var lblPwdInst: UILabel!
    //@IBOutlet weak var txtpwd: HoshiTextField!
    var finalData : [[String:Any]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        createStructure()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func dismisskeyboard()  {
        view.endEditing(true)

    }
    
    @IBAction func login(_ sender: Any) {
    
        //checkLogin()
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                self.button.stopAnimation(animationStyle: .expand, completion: {
                    if self.txtemail.text == "admin@gmail.com" && self.txtpwd.text == "admin"{
                        let next2 = self.storyboard?.instantiateViewController(withIdentifier: "Sectab")
                         self.navigationController?.pushViewController(next2!, animated: false)
                        }else{
                             self.checkLoginforHomeOwner()
                        }
                    //let next2 = self.storyboard?.instantiateViewController(withIdentifier: "usertab")
                   // self.navigationController?.pushViewController(next2!, animated: false)
                })
            })
        })
    }
    func checkLoginforHomeOwner()  {
        
        let str = "http://localhost:8080/DigitalSociety_Web/LoginHomeOwner.php"
        let disc : [String : Any] = ["email":txtemail.text!,"password":txtpwd.text!];
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
                        
                        if jsonData.count > 0 {
                            self.finalData = jsonData
                            //print(self.finalData)
                            storeLoginData(arrDisc: self.finalData)
                            let stb = self.storyboard?.instantiateViewController(withIdentifier: "HomeOwnertab");
                            
                            self.navigationController?.pushViewController(stb!, animated: true);
                            
                        }else{
                            self.checkLoginforRental()
                        }
                    }
                }catch{
                    
                }
            })
            dataTask.resume()
            
        } catch  {
            
        }
    }
    func checkLoginforRental()  {
        
        let str = "http://localhost:8080/DigitalSociety_Web/LoginRental.php"
        let disc : [String : Any] = ["email":txtemail.text!,"password":txtpwd.text!];
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
                        
                        if jsonData.count > 0 {
                            self.finalData = jsonData
                            //print(self.finalData)
                            storeLoginData(arrDisc: self.finalData)
                            let stb = self.storyboard?.instantiateViewController(withIdentifier: "Rentaltab");
                            
                            self.navigationController?.pushViewController(stb!, animated: true);
                        }else{
                            
                        }
                    }
                }catch{
                    
                }
            })
            dataTask.resume()
            
        } catch  {
            
        }
    }
    /*func storeLoginData() {
        
        let flm = FileManager()
        if flm.fileExists(atPath: getUserPath()) {
            
            var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
            var arr = disc["userRecord"] as! [[String:Any]]
            arr = finalData
            disc["userRecord"] = arr
            let finalDisc = NSDictionary(dictionary: disc)
            finalDisc.write(toFile: getUserPath(), atomically: true)
        }
    }
    func createFormat() {
        
        let flm = FileManager()
        if !flm.fileExists(atPath: getUserPath()) {
            
            let arr : [[String:Any]] = []
            let disc : [String:Any] = ["userRecord":arr]
            let finalDisc = NSDictionary(dictionary: disc)
            finalDisc.write(toFile: getUserPath(), atomically: true)
        }
    }
    func getUserPath() -> String {
        
        let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = arr[0]
        let finalPath = path.appending("/userLogin.plist")
        print(finalPath)
        return finalPath
    }*/
        
    @IBAction func signupbutton(_ sender: Any) {
        UIView.animate(withDuration: 0.6) {
            
            /*_ = SweetAlert().showAlert("Select Any One", subTitle: "Choose Appropriate Option", style: AlertStyle.none, buttonTitle:"HomeOwner", buttonColor:UIColor.gray , otherButtonTitle:  "Secretary", otherButtonColor: UIColor.gray) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    
                    let next1 = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! signupviewcontroller
                    self.navigationController?.pushViewController(next1, animated: false)
                }
                else {
                    let next1 = self.storyboard?.instantiateViewController(withIdentifier: "secretary") as! secretaryviewcontroller
                    self.navigationController?.pushViewController(next1, animated: false)
                }
            }*/
            let next1 = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! signupviewcontroller
            self.navigationController?.pushViewController(next1, animated: false)
    }
    
    }
    
    @IBAction func PasswordTextChange(_ sender: Any) {
    
        if isValidPassword(pwd: txtpwd.text!) {
            
            txtpwd.rightViewMode = .never
            lblPwdInst.isHidden = true
        }else{
            
            txtpwd.rightViewMode = .whileEditing
            let imgview = UIImageView(image: UIImage(named: "rsz_alert-512.png"))
            txtpwd.rightView = imgview
            lblPwdInst.isHidden = false
            lblPwdInst.text = "Enter atleast 8 Character Containing 1 Uppercase,Number and Special Character"
        }
    }
    func isValidPassword(pwd: String) -> Bool {
        
        //Minimum 6 Max 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
        let PHONE_REGEX = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,15}$"

        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: pwd)
        return result
    }
    func PassTextChange(_ sender: Any) {
        
    
     /*   if isValidPassword(pwd: txtpwd.text!) {
            
            txtpwd.rightViewMode = .never
            txtpwd.clipsToBounds = true
            txtpwd.layer.borderWidth = 1
            txtpwd.layer.borderColor = UIColor.green.cgColor
        }
        else {
            
            txtpwd.rightViewMode = .whileEditing
           // let imgview = UIImageView(image: UIImage(named: "if_Help_mark_query_question_support_talk_271504.png"))
        //    txtpwd.rightView = imgview
            txtpwd.clipsToBounds = true
            txtpwd.layer.borderWidth = 1
            txtpwd.layer.borderColor = UIColor.red.cgColor
        }*/
    }

    
//    @objc func tapped(){
//        let time = Double(timePeriod.text != "" ? timePeriod.text! : "1")!
//        let padding = Double(timePadding.text != "" ? timePadding.text! : "0.5")!
       // picker.selectedRow(inComponent: 0) == 0 ? self.progressButton.startIndeterminate(withTimePeriod: time, andTimePadding: padding) : self.loadDeterminate()
//    }
}
