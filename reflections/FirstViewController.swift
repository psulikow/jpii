//
//  FirstViewController.swift
//  reflections
//
//  Created by Paul Sulikowski on 3/6/20.
//  Copyright © 2020 Paul Sulikowski. All rights reserved.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: DesiredDate.shared.stringGlobalDate_)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: DesiredDate.shared.stringGlobalDate_)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}

class FirstViewController: UIViewController {
        
    @IBOutlet weak var dateLabel: UILabel!
        
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    public static func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    private var observer: NSObjectProtocol?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [unowned self] notification in
            self.performWhenLoadFirstTime()
        }
        
        daysOfTheYear["Days"] = [
            "10-07" : Days(title: "Pope John Paul II tells us, \"Prayer gives us strength for great ideals, for keeping up our faith, charity, purity, generosity; prayer gives us strength to rise up from indifference and guilt, if we have had the misfortune to give in to temptation and weakness. Prayer gives us light by which to see and to judge from God's perspective and from eternity. That is why you must not give up on praying!\"", url: "75", saints: [["Saint Veronica Giuliani : 07/10", "196s", "10-07", "Veronica Giuliani (27 December 1660 – 9 July 1727) was an Italian Capuchin Poor Clares nun and mystic. She was canonized by Pope Gregory XVI in 1839.\n\nAfter Giuliani's death a figure of the Cross was supposedly found impressed upon her heart, and her body has been noted as being incorrupt. She was beatified by Pope Pius VII on 17 June 1804 and was canonized by Pope Gregory XVI on 26 May 1839. She is usually represented in art crowned with thorns and embracing the Cross."]]),


            "11-07" : Days(title: "Pope John Paul II once said, \"We Christians joyfully recognize the religious values we have in common with Islam. I would like to repeat what I said to young Muslims some years ago in Casablanca: 'We believe in the same God, the one God, the living God, the God who created the world and brings his creatures to their perfection.\"", url: "76", saints: [["Saint Benedict : 07/11", "197s", "11-07", "Benedict of Nursia (c. 2 March 480 – c. 21 March 543 AD) is a Christian saint venerated in the Catholic Church, the Eastern Orthodox Church, the Oriental Orthodox Churches, the Anglican Communion and Old Catholic Churches. He is a patron saint of Europe.\n\nBenedict founded twelve communities for monks at Subiaco, Lazio, Italy (about 65 kilometres to the east of Rome), before moving to Monte Cassino in the mountains of southern Italy. The Order of Saint Benedict is of later origin and, moreover, not an \"order\" as commonly understood but merely a confederation of autonomous congregations.\n\nBenedict's main achievement, his \"Rule of Saint Benedict\", contains a set of rules for his monks to follow. Heavily influenced by the writings of John Cassian, it shows strong affinity with the Rule of the Master, but it also has a unique spirit of balance, moderation and reasonableness which persuaded most Christian religious communities founded throughout the Middle Ages to adopt it. As a result, his Rule became one of the most influential religious rules in Western Christendom. For this reason, Giuseppe Carletti regarded Benedict as the founder of Western Christian monasticism."],["Saint test : 07/11", "198s", "11-07", "Benedict of Nursia (c. 2 March 480 – c. 21 March 543 AD) is a Christian saint venerated in the Catholic Church, the Eastern Orthodox Church, the Oriental Orthodox Churches, the Anglican Communion and Old Catholic Churches. He is a patron saint of Europe.\n\nBenedict founded twelve communities for monks at Subiaco, Lazio, Italy (about 65 kilometres to the east of Rome), before moving to Monte Cassino in the mountains of southern Italy. The Order of Saint Benedict is of later origin and, moreover, not an \"order\" as commonly understood but merely a confederation of autonomous congregations.\n\nBenedict's main achievement, his \"Rule of Saint Benedict\", contains a set of rules for his monks to follow. Heavily influenced by the writings of John Cassian, it shows strong affinity with the Rule of the Master, but it also has a unique spirit of balance, moderation and reasonableness which persuaded most Christian religious communities founded throughout the Middle Ages to adopt it. As a result, his Rule became one of the most influential religious rules in Western Christendom. For this reason, Giuseppe Carletti regarded Benedict as the founder of Western Christian monasticism."]]),
        ]

        performWhenLoadFirstTime()
    }
    
    @IBAction func todayAction(_ sender: UIButton) {
        DesiredDate.shared.stringGlobalDate_ = Date()
        let currentGlobal = DesiredDate.shared.globalDate
        if(currentGlobal != formatDate(date: Date())){
            print("not equal")
            DesiredDate.shared.globalDate = formatDate(date: Date())
        }
        let newDate = DesiredDate.shared.globalDate
        mainImage.image = UIImage(named: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[newDate]?.title
        dateLabel.text = formatDate2(date: DesiredDate.shared.stringGlobalDate_)
    }
    
    @IBAction func previousDayAction(_ sender: UIButton) {
        DesiredDate.shared.globalDate = formatDate(date: Date.yesterday)
        DesiredDate.shared.globalDate2 = formatDate2(date: Date.yesterday)

        dateLabel.text = DesiredDate.shared.globalDate2
        let newDate = DesiredDate.shared.globalDate
        mainImage.image = UIImage(named: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[newDate]?.title
        DesiredDate.shared.stringGlobalDate_ = Calendar.current.date(byAdding: .day, value: -1, to: DesiredDate.shared.stringGlobalDate_)!
    }
    
    @IBAction func nextDayAction(_ sender: UIButton) {
        DesiredDate.shared.globalDate = formatDate(date: Date.tomorrow)
        DesiredDate.shared.globalDate2 = formatDate2(date: Date.tomorrow)
        
        dateLabel.text = DesiredDate.shared.globalDate2
        let newDate = DesiredDate.shared.globalDate
        mainImage.image = UIImage(named: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[newDate]?.title
        DesiredDate.shared.stringGlobalDate_ = Calendar.current.date(byAdding: .day, value: 1, to: DesiredDate.shared.stringGlobalDate_)!
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func performWhenLoadFirstTime(){
        DesiredDate.shared.stringGlobalDate_ = Date()
        print(formatDate(date: DesiredDate.shared.stringGlobalDate_) + " is current string global date")
        mainImage.image = UIImage(named: daysOfTheYear["Days"]?[formatDate(date: Date())]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[formatDate(date: Date())]?.title
        dateLabel.sizeToFit()
        dateLabel.text = formatDate2(date: DesiredDate.shared.stringGlobalDate_)
    }
    
//    func formatDate(date: Date) -> String {
//        let formatter = DateFormatter()
//        // initially set the format based on your datepicker date / server String
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//
//        let myString = formatter.string(from: date) // string purpose I add here
//        // convert your string to date
//        let yourDate = formatter.date(from: myString)
//        //then again set the date format whhich type of output you need
//        formatter.dateFormat = "dd-MMM-yyyy"
//        // again convert your date to string
//        return formatter.string(from: yourDate!)
//    }
    
    
}

