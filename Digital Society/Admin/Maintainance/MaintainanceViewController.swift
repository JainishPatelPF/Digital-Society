//
//  MaintainanceViewController.swift
//  Digital Society
//
//  Created by jainish on 02/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit


class MaintainanceViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustCell", for: indexPath) as! MaintainanceTableViewCell
        cell.lbl.text = "Maintenance"
           // cell.img.image = UIImage(cgImage: "fund.png" as! CGImage)
        cell.accessoryType = .disclosureIndicator
        return cell
        }else if indexPath.section == 1{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "CustCell", for: indexPath) as! MaintainanceTableViewCell
            cell1.lbl.text = "Society Expense"
            //cell1.img.image = UIImage(cgImage: "manage.png" as! CGImage)
            cell1.accessoryType = .disclosureIndicator
            return cell1
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustCell", for: indexPath) as! MaintainanceTableViewCell
            cell.lbl.text = "Fund"
            //cell.img.image = UIImage(cgImage: "fund.png" as! CGImage)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            
        return 70.0
        }else{
            return 70.0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
        let next = self.storyboard?.instantiateViewController(withIdentifier: "maintainance") as! m1ViewController
            self.navigationController?.pushViewController(next, animated: true)
        }else if indexPath.section == 1{
            let next1 = self.storyboard?.instantiateViewController(withIdentifier: "expense") as! ExpenseViewController
            self.navigationController?.pushViewController(next1, animated: true)
        }
        else{
            let next1 = self.storyboard?.instantiateViewController(withIdentifier: "fund") as! FundViewController
            self.navigationController?.pushViewController(next1, animated: true)
        }
    }
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    //    let disc : [String:Any] = arrData[0]
        

            let cell = tableView.dequeueReusableCell(withIdentifier: "CustCell", for: indexPath)
           // cell.lblName.text = disc["name"] as? String
          //  let imgName = disc["image"] as? String
           // let url = "http://localhost:8080/DigitalSociety_Web/"
          //  let urlStr = url + imgName!
           // let finalUrl = URL(string: urlStr)
            do{
               // let imgData = try Data.init(contentsOf: finalUrl!)
               // cell.uiimage.image = UIImage(data: imgData)
               cell.accessoryType = .disclosureIndicator
            }catch{
                
            }
            return cell
        }*/
    
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
