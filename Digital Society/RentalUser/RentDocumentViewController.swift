//
//  RentDocumentViewController.swift
//  Digital Society
//
//  Created by jainish on 08/03/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit
import TextFieldEffects
import TransitionButton

class RentDocumentViewController: UIViewController {

    @IBOutlet var aadharid: HoshiTextField!
    @IBOutlet var panid: HoshiTextField!
    @IBOutlet var licenceid: HoshiTextField!
    @IBOutlet var votingcardid: HoshiTextField!
    @IBOutlet var passportid: HoshiTextField!
    @IBOutlet var incomeid: HoshiTextField!
    @IBOutlet var verabillid: HoshiTextField!
    @IBOutlet var btn: TransitionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
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
