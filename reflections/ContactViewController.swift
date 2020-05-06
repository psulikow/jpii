//
//  ContactViewController.swift
//  reflections
//
//  Created by Paul Sulikowski on 3/7/20.
//  Copyright © 2020 Paul Sulikowski. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func contactAction(_ sender: UIButton) {
        
        let supportEmail = "sularize@gmail.com"
        if let emailURL = URL(string: "mailto:\(supportEmail)"), UIApplication.shared.canOpenURL(emailURL)
        {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
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
