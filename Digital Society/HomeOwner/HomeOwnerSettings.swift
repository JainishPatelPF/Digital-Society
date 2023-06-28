import UIKit

class secsettings: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblProfileView: UITableView!
    var arrData : [[String:Any]] = []
    var alert = SweetAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // tblProfileView.layer.cornerRadius = tblProfileView.layer.frame.width / 2
       // tblProfileView.clipsToBounds = true
        self.navigationController?.navigationBar.isHidden = false

    }
    override func viewWillAppear(_ animated: Bool) {
        let arr = getLoginData()
        if arr.count == 1{
            arrData = arr
            tblProfileView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "showprofileowner") as! showprofile
        self.navigationController?.pushViewController(next, animated: true)
    }
    @IBAction func logoutbtn(_ sender: Any) {
        let alert = UIAlertController(title: "Logout?", message: "Are You Sure", preferredStyle: .alert)
        let next = UIAlertAction(title: "Logout", style: .default) { (act) in
            logout()
            let next = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginviewcontroller
            self.navigationController?.pushViewController(next, animated: false)
        }
        let next1 = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(next)
        alert.addAction(next1)
        self.present(alert, animated: true, completion: nil)
        
        //destroyLoginData()
    }
    
    
    
    /*func destroyLoginData() {
        let flm  = FileManager()
        if flm.fileExists(atPath: getUserPath()){
            var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
            var arr = disc["userRecord"] as! [[String:Any]]
            arr.removeAll()
            disc["userRecord"] = arr
            let finaldisc = NSDictionary(dictionary: disc)
            finaldisc.write(toFile: getUserPath(), atomically: true)
            let alert = UIAlertController(title: "Logout?", message: "Are You Sure", preferredStyle: .alert)
            let next = UIAlertAction(title: "Logout", style: .default) { (act) in
                let next = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginviewcontroller
                self.navigationController?.pushViewController(next, animated: false)
                
                
            }
            let next1 = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(next)
            alert.addAction(next1)
            self.present(alert, animated: true, completion: nil)
        }
    }*/
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let disc : [String:Any] = arrData[0]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustCell", for: indexPath) as! ownersettingstab
        if indexPath.row == 0 {
            cell.lblName.text = disc["name"] as? String
            let imgName = disc["image"] as? String
            let url = "http://localhost:8080/DigitalSociety_Web/"
            let urlStr = url + imgName!
            let finalUrl = URL(string: urlStr)
            do{
                let imgData = try Data.init(contentsOf: finalUrl!)
                cell.imageview.image = UIImage(data: imgData)
            }catch{
                
            }
        }
        return cell
    }
    /*func checkLoginData() {
        
        let flm = FileManager()
        if flm.fileExists(atPath: getUserPath()) {
            
            var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
            var arr = disc["userRecord"] as! [[String:Any]]
            if arr.count == 1{
                arrData = arr
                tblProfileView.reloadData()
                }
            }
        }
    func getUserPath() -> String {
        
        let arr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = arr[0]
        let finalPath = path.appending("/userLogin.plist")
        print(finalPath)
        return finalPath
    }*/
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
