//
//  m1ViewController.swift
//  Digital Society
//
//  Created by jainish on 03/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit
import TextFieldEffects

class m1ViewController: UIViewController { //m1ViewController

    @IBOutlet var ownerid: HoshiTextField!
    @IBOutlet var maintainancedate: HoshiTextField!
    @IBOutlet var totalamt: HoshiTextField!
    @IBOutlet var paiddate: HoshiTextField!
    @IBOutlet var paymode: HoshiTextField!
    @IBOutlet var penalty: HoshiTextField!
    @IBOutlet var totalamtwithpenalty: HoshiTextField!
    @IBOutlet var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollview.contentSize = scrollview.bounds.size
        view.addSubview(scrollview)
        //self.navigationController?.navigationBar.backItem = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func savebtn(_ sender: Any) {
     self.storyboard?.instantiateViewController(withIdentifier: "mainmaintenance") as! MaintainanceViewController
        self.navigationController?.popViewController(animated: true)
        
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
