//
//  SegueOneViewController.swift
//  reflections
//
//  Created by Paul Sulikowski on 3/8/20.
//  Copyright © 2020 Paul Sulikowski. All rights reserved.
//

import UIKit
import WebKit

class SegueOneViewController: UIViewController {

    @IBOutlet weak private var webView: WKWebView!
    
    @IBOutlet weak var saintImage: UIImageView!
    
    @IBOutlet weak var saintText: UITextView!
    
    var urlString: String?
    var saintImageUrl: String?
    var saintInfo: String?
    var timerForShowScrollIndicator: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        saintImage.image = UIImage(named: saintImageUrl ?? " ")
        saintText.text = saintInfo
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //the below will leave the scroll indicator on
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startTimerForShowScrollIndicator()
    }
    
    @objc func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 0.00001) {
            self.saintText.flashScrollIndicators()
        }
    }
    
    func startTimerForShowScrollIndicator() {
        self.timerForShowScrollIndicator = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    }
}
