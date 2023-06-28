//
//  ExpenseViewController.swift
//  Digital Society
//
//  Created by jainish on 03/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {

    @IBOutlet var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollview.contentSize = scrollview.bounds.size
        view.addSubview(scrollview)
        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: Any) {
        self.storyboard?.instantiateViewController(withIdentifier: "mainmaintenance") as! MaintainanceViewController
        self.navigationController?.popViewController(animated: true)
    }
    

}
