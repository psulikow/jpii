//
//  SecondViewController.swift
//  reflections
//
//  Created by Paul Sulikowski on 3/6/20.
//  Copyright © 2020 Paul Sulikowski. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var timerForShowScrollIndicator: Timer?

    @IBOutlet weak var bioText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //the below will leave the scroll indicator on
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startTimerForShowScrollIndicator()
    }
    
    @objc func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 0.00001) {
            self.bioText.flashScrollIndicators()
        }
    }
    
    func startTimerForShowScrollIndicator() {
        self.timerForShowScrollIndicator = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    }
}

