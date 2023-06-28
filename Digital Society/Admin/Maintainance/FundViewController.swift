//
//  FundViewController.swift
//  Digital Society
//
//  Created by jainish on 03/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit

class FundViewController: UIViewController {

    @IBOutlet var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollview.contentSize = scrollview.bounds.size
        view.addSubview(scrollview)
        
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
