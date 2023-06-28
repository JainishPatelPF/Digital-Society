//
//  ViewRentViewController.swift
//  Digital Society
//
//  Created by jainish on 04/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit

class ViewRentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var manager_id = "";
    
    var jsondata:[Any] = [];
    
    @IBOutlet var backbtn: UIBarButtonItem!
    
    @IBOutlet var tbl: UITableView!
    var arrData : [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLoginData()
        
        getinfodata();
        
        // Do any additional setup after loading the view.
    }
    
    func getinfodata()  {
        
        print(manager_id)
        let str = "http://localhost:8080/DigitalSociety_Web/selectrentbyowner.php?owner_id=\(manager_id)";
        
        let url = URL(string: str);
        
        let requet = URLRequest(url: url!);
        
        let session = URLSession.shared;
        
        let task = session.dataTask(with: requet) { (data, responce, err) in
            
            //let result = String(data: data!, encoding: String.Encoding.utf8);
            DispatchQueue.main.async {
                
                do{
                    try self.jsondata = JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                    self.tbl.reloadData()
                }catch{
                    
                }
                
            }
            //print(result!);
        }
        
        task.resume();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsondata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustCell", for: indexPath) as! viewrentTableViewCell
        //cell.addrentimage.image = UIImage(cgImage: "fund.png" as! CGImage)
        
        let arr = jsondata[indexPath.row]  as![String: String];
        
        cell.lblname.text = arr["rent_personname"];
        
      //  cell.imageview.image = UIImageView(image: disc["image"])
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
        
 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let next = self.storyboard?.instantiateViewController(withIdentifier: "profileview") as! rentprofileviewViewController
          next.dic = jsondata[indexPath.row]  as![String: String];
    
        
     //    let arr = jsondata[indexPath.row]  as![String: String];
        
            self.navigationController?.pushViewController(next, animated: true)


    }
    @IBAction func backbtnaction(_ sender: Any) {
        let next4 = self.storyboard?.instantiateViewController(withIdentifier: "rent") as! RentViewController
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func checkLoginData() {
        
        let flm = FileManager()
        if flm.fileExists(atPath: getUserPath()) {
            
            var disc = NSDictionary(contentsOfFile: getUserPath()) as! [String:Any]
            var arr = disc["userRecord"] as! [[String:Any]]
            if arr.count == 1{
                arrData = arr
                
                let disc = arr[0]
                
                manager_id = disc["manager_id"] as! String
                
                //     tblProfileView.reloadData()
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
    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }

}
