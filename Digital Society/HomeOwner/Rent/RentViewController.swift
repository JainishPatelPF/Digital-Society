//
//  RentViewController.swift
//  Digital Society
//
//  Created by jainish on 04/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit

class RentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
             return 70.0
        }else {
            return 70.0
        }
        
        
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "addrent") as! addrentViewController
            self.navigationController?.pushViewController(next, animated: true)
        }else{
            let next = self.storyboard?.instantiateViewController(withIdentifier: "viewrent") as! ViewRentViewController
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustCell", for: indexPath) as! rentTableViewCell
            cell.addrent.text = "Add Rent"
            //cell.addrentimage.image = UIImage(cgImage: "fund.png" as! CGImage)
            cell.accessoryType = .disclosureIndicator
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustCell", for: indexPath) as! rentTableViewCell
        cell.addrent.text = "View Rent"
         //cell.addrentimage.image = UIImage(cgImage: "fund.png" as! CGImage)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
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
