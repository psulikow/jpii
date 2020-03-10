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
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
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
    
    
    @IBOutlet weak var reflectonLabel: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    public static func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
                    daysOfTheYear["Days"] = [
                            "01-01" : Days(title: "", reflection: "", url: "", saint: "Mary, Mother of God : 01/01", saintURL: "https://www.franciscanmedia.org/mary-mother-of-god/", saintDate: "01-01"),


                            "02-01" : Days(title: "", reflection: "", url: "", saint: "Saint Basil the Great : 01/02", saintURL: "https://www.franciscanmedia.org/saint-basil-the-great/", saintDate: "02-01"),


                            "03-01" : Days(title: "", reflection: "", url: "", saint: "Most Holy Name of Jesus : 01/03", saintURL: "https://www.franciscanmedia.org/mosaint-holy-name-of-jesus/", saintDate: "03-01"),


                            "04-01" : Days(title: "", reflection: "", url: "", saint: "Saint Elizabeth Ann Seton : 01/04", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-ann-seton/", saintDate: "04-01"),


                            "05-01" : Days(title: "", reflection: "", url: "", saint: "Saint John Neumann : 01/05", saintURL: "https://www.franciscanmedia.org/saint-john-neumann/", saintDate: "05-01"),


                            "06-01" : Days(title: "", reflection: "", url: "", saint: "Saint André Bessette : 01/06", saintURL: "https://www.franciscanmedia.org/saint-andr-eacute-bessette/", saintDate: "06-01"),


                            "07-01" : Days(title: "", reflection: "", url: "", saint: "Saint Raymond of Peñafort : 01/07", saintURL: "https://www.franciscanmedia.org/saint-raymond-of-pe-afort/", saintDate: "07-01"),


                            "08-01" : Days(title: "", reflection: "", url: "", saint: "Saint Angela of Foligno : 01/08", saintURL: "https://www.franciscanmedia.org/saint-angela-of-foligno/", saintDate: "08-01"),


                            "09-01" : Days(title: "", reflection: "", url: "", saint: "Saint Adrian of Canterbury : 01/09", saintURL: "https://www.franciscanmedia.org/saint-adrian-of-canterbury/", saintDate: "09-01"),


                            "10-01" : Days(title: "", reflection: "", url: "", saint: "Saint Gregory of Nyssa : 01/10", saintURL: "https://www.franciscanmedia.org/saint-gregory-of-nyssa/", saintDate: "10-01"),


                            "11-01" : Days(title: "", reflection: "", url: "", saint: "Blessed William Carter : 01/11", saintURL: "https://www.franciscanmedia.org/blessed-william-carter/", saintDate: "11-01"),


                            "12-01" : Days(title: "", reflection: "", url: "", saint: "Saint Marguerite Bourgeoys : 01/12", saintURL: "https://www.franciscanmedia.org/saint-marguerite-bourgeoys/", saintDate: "12-01"),


                            "13-01" : Days(title: "", reflection: "", url: "", saint: "Saint Hilary of Poitiers : 01/13", saintURL: "https://www.franciscanmedia.org/saint-hilary/", saintDate: "13-01"),


                            "14-01" : Days(title: "", reflection: "", url: "", saint: "Saint Gregory Nazianzen : 01/14", saintURL: "https://www.franciscanmedia.org/saint-gregory-nazianzen/", saintDate: "14-01"),


                            "15-01" : Days(title: "", reflection: "", url: "", saint: "Saint Paul the Hermit : 01/15", saintURL: "https://www.franciscanmedia.org/saint-paul-the-hermit/", saintDate: "15-01"),


                            "16-01" : Days(title: "", reflection: "", url: "", saint: "Saint Berard and Companions : 01/16", saintURL: "https://www.franciscanmedia.org/saint-berard-and-companions/", saintDate: "16-01"),


                            "17-01" : Days(title: "", reflection: "", url: "", saint: "Saint Anthony of Egypt : 01/17", saintURL: "https://www.franciscanmedia.org/saint-anthony-of-egypt/", saintDate: "17-01"),


                            "18-01" : Days(title: "", reflection: "", url: "", saint: "Saint Charles of Sezze : 01/18", saintURL: "https://www.franciscanmedia.org/saint-charles-of-sezze/", saintDate: "18-01"),


                            "19-01" : Days(title: "", reflection: "", url: "", saint: "Saint Fabian : 01/19", saintURL: "https://www.franciscanmedia.org/saint-fabian/", saintDate: "19-01"),


                            "20-01" : Days(title: "", reflection: "", url: "", saint: "Saint Sebastian : 01/20", saintURL: "https://www.franciscanmedia.org/saint-sebastian/", saintDate: "20-01"),


                            "21-01" : Days(title: "", reflection: "", url: "", saint: "Saint Agnes : 01/21", saintURL: "https://www.franciscanmedia.org/saint-agnes/", saintDate: "21-01"),


                            "22-01" : Days(title: "", reflection: "", url: "", saint: "Saint Vincent of Zaragossa : 01/22", saintURL: "https://www.franciscanmedia.org/saint-vincent-of-zaragossa/", saintDate: "22-01"),


                            "23-01" : Days(title: "", reflection: "", url: "", saint: "Saint Marianne Cope : 01/23", saintURL: "https://www.franciscanmedia.org/saint-marianne-cope/", saintDate: "23-01"),


                            "24-01" : Days(title: "", reflection: "", url: "", saint: "Saint Francis de Sales : 01/24", saintURL: "https://www.franciscanmedia.org/saint-francis-de-sales/", saintDate: "24-01"),


                            "25-01" : Days(title: "", reflection: "", url: "", saint: "Conversion of Saint Paul : 01/25", saintURL: "https://www.franciscanmedia.org/conversion-of-saint-paul/", saintDate: "25-01"),


                            "26-01" : Days(title: "", reflection: "", url: "", saint: "Saints Timothy and Titus : 01/26", saintURL: "https://www.franciscanmedia.org/saints-timothy-and-titus/", saintDate: "26-01"),


                            "27-01" : Days(title: "", reflection: "", url: "", saint: "Saint Angela Merici : 01/27", saintURL: "https://www.franciscanmedia.org/saint-angela-merici/", saintDate: "27-01"),


                            "28-01" : Days(title: "", reflection: "", url: "", saint: "Saint Thomas Aquinas : 01/28", saintURL: "https://www.franciscanmedia.org/saint-thomas-aquinas/", saintDate: "28-01"),


                            "29-01" : Days(title: "", reflection: "", url: "", saint: "Servant of God Brother Juniper : 01/29", saintURL: "https://www.franciscanmedia.org/servant-of-god-brother-juniper/", saintDate: "29-01"),


                            "30-01" : Days(title: "", reflection: "", url: "", saint: "Blessed Mary Angela Truszkowska : 01/30", saintURL: "https://www.franciscanmedia.org/blessed-mary-angela-truszkowska/", saintDate: "30-01"),


                            "31-01" : Days(title: "", reflection: "", url: "", saint: "Saint John Bosco : 01/31", saintURL: "https://www.franciscanmedia.org/saint-john-bosco/", saintDate: "31-01"),
                            





                            "01-02" : Days(title: "", reflection: "", url: "", saint: "Saint Ansgar : 02/01", saintURL: "https://www.franciscanmedia.org/saint-ansgar/", saintDate: "01-02"),


                            "02-02" : Days(title: "", reflection: "", url: "", saint: "Presentation of the Lord : 02/02", saintURL: "https://www.franciscanmedia.org/presentation-of-the-lord/", saintDate: "02-02"),


                            "03-02" : Days(title: "", reflection: "", url: "", saint: "Saint Blaise : 02/03", saintURL: "https://www.franciscanmedia.org/saint-blaise/", saintDate: "03-02"),


                            "04-02" : Days(title: "", reflection: "", url: "", saint: "Saint Joseph of Leonissa : 02/04", saintURL: "https://www.franciscanmedia.org/saint-joseph-of-leonissa/", saintDate: "04-02"),


                            "05-02" : Days(title: "", reflection: "", url: "", saint: "Saint Agatha : 02/05", saintURL: "https://www.franciscanmedia.org/saint-agatha/", saintDate: "05-02"),


                            "06-02" : Days(title: "", reflection: "", url: "", saint: "Saint Paul Miki and Companions : 02/06", saintURL: "https://www.franciscanmedia.org/saint-paul-miki-and-companions/", saintDate: "06-02"),


                            "07-02" : Days(title: "", reflection: "", url: "", saint: "Saint Colette : 02/07", saintURL: "https://www.franciscanmedia.org/saint-colette/", saintDate: "07-02"),


                            "08-02" : Days(title: "", reflection: "", url: "", saint: "Saint Josephine Bakhita : 02/08", saintURL: "https://www.franciscanmedia.org/saint-josephine-bakhita/", saintDate: "08-02"),


                            "09-02" : Days(title: "", reflection: "", url: "", saint: "Saint Jerome Emiliani : 02/09", saintURL: "https://www.franciscanmedia.org/saint-jerome-emiliani/", saintDate: "09-02"),


                            "10-02" : Days(title: "", reflection: "", url: "", saint: "Saint Scholastica : 02/10", saintURL: "https://www.franciscanmedia.org/saint-scholastica/", saintDate: "10-02"),


                            "11-02" : Days(title: "", reflection: "", url: "", saint: "Our Lady of Lourdes : 02/11", saintURL: "https://www.franciscanmedia.org/our-lady-of-lourdes/", saintDate: "11-02"),


                            "12-02" : Days(title: "", reflection: "", url: "", saint: "Saint Apollonia : 02/12", saintURL: "https://www.franciscanmedia.org/saint-apollonia/", saintDate: "12-02"),


                            "13-02" : Days(title: "", reflection: "", url: "", saint: "Saint Giles Mary of Saint Joseph : 02/13", saintURL: "https://www.franciscanmedia.org/saint-giles-mary-of-saint-joseph/", saintDate: "13-02"),


                            "14-02" : Days(title: "", reflection: "", url: "", saint: "Saints Cyril and Methodius : 02/14", saintURL: "https://www.franciscanmedia.org/saints-cyril-and-methodius/", saintDate: "14-02"),


                            "15-02" : Days(title: "", reflection: "", url: "", saint: "Saint Claude de la Colombière : 02/15", saintURL: "https://www.franciscanmedia.org/saint-claude-de-la-colombi-egrave-re/", saintDate: "15-02"),


                            "16-02" : Days(title: "", reflection: "", url: "", saint: "Saint Gilbert of Sempringham : 02/16", saintURL: "https://www.franciscanmedia.org/saint-gilbert-of-sempringham/", saintDate: "16-02"),


                            "17-02" : Days(title: "", reflection: "", url: "", saint: "Seven Founders of the Servite Order : 02/17", saintURL: "https://www.franciscanmedia.org/seven-founders-of-the-servite-order/", saintDate: "17-02"),


                            "18-02" : Days(title: "", reflection: "", url: "", saint: "Blessed John of Fiesole : 02/18", saintURL: "https://www.franciscanmedia.org/blessed-john-of-fiesole/", saintDate: "18-02"),


                            "19-02" : Days(title: "", reflection: "", url: "", saint: "Saint Conrad of Piacenza : 02/19", saintURL: "https://www.franciscanmedia.org/saint-conrad-of-piacenza/", saintDate: "19-02"),


                            "20-02" : Days(title: "", reflection: "", url: "", saint: "Saints Jacinta and Francisco Marto : 02/20", saintURL: "https://www.franciscanmedia.org/saints-jacinta-and-francisco-marto/", saintDate: "20-02"),


                            "21-02" : Days(title: "", reflection: "", url: "", saint: "Saint Peter Damian : 02/21", saintURL: "https://www.franciscanmedia.org/saint-peter-damian/", saintDate: "21-02"),


                            "22-02" : Days(title: "", reflection: "", url: "", saint: "Chair of Saint Peter : 02/22", saintURL: "https://www.franciscanmedia.org/chair-of-saint-peter/", saintDate: "22-02"),


                            "23-02" : Days(title: "", reflection: "", url: "", saint: "Saint Polycarp : 02/23", saintURL: "https://www.franciscanmedia.org/saint-polycarp/", saintDate: "23-02"),


                            "24-02" : Days(title: "", reflection: "", url: "", saint: "Blessed Luke Belludi : 02/24", saintURL: "https://www.franciscanmedia.org/blessed-luke-belludi/", saintDate: "24-02"),


                            "25-02" : Days(title: "", reflection: "", url: "", saint: "Blessed Sebastian of Aparicio : 02/25", saintURL: "https://www.franciscanmedia.org/blessed-sebastian-of-aparicio/", saintDate: "25-02"),


                            "26-02" : Days(title: "", reflection: "", url: "", saint: "Saint Maria Bertilla Boscardin : 02/26", saintURL: "https://www.franciscanmedia.org/saint-maria-bertilla-boscardin/", saintDate: "26-02"),


                            "27-02" : Days(title: "", reflection: "", url: "", saint: "Saint Gabriel of Our Lady of Sorrows : 02/27", saintURL: "https://www.franciscanmedia.org/saint-gabriel-of-our-lady-of-sorrows/", saintDate: "27-02"),


                            "28-02" : Days(title: "", reflection: "", url: "", saint: "Blessed Daniel Brottier : 02/28", saintURL: "https://www.franciscanmedia.org/blessed-daniel-brottier/", saintDate: "28-02"),


                            "29-02" : Days(title: "", reflection: "", url: "", saint: "Saint Oswald : 02/29", saintURL: "https://www.franciscanmedia.org/saint-oswald/", saintDate: "29-02"),


                            "30-02" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-02"),


                            "31-02" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-02"),






                            "01-03" : Days(title: "", reflection: "", url: "", saint: "Saint David of Wales: 03/01", saintURL: "https://www.franciscanmedia.org/saint-david-of-wales/", saintDate: "01-03"),


                            "02-03" : Days(title: "", reflection: "", url: "", saint: "Saint Agnes of Bohemia : 03/02", saintURL: "https://www.franciscanmedia.org/saint-agnes-of-bohemia/", saintDate: "02-03"),


                            "03-03" : Days(title: "", reflection: "", url: "", saint: "Saint Katharine Drexel : 03/03", saintURL: "https://www.franciscanmedia.org/saint-katharine-drexel/", saintDate: "03-03"),


                            "04-03" : Days(title: "", reflection: "", url: "", saint: "Saint Casimir : 03/04", saintURL: "https://www.franciscanmedia.org/saint-casimir/", saintDate: "04-03"),


                            "05-03" : Days(title: "", reflection: "", url: "", saint: "Saint John Joseph of the Cross : 03/05", saintURL: "https://www.franciscanmedia.org/saint-john-joseph-of-the-cross/", saintDate: "05-03"),


                            "06-03" : Days(title: "Pope John Paul and Sister Lucia", reflection: "The institution of nuns and sisters, who devote themselves in various religious orders to the practice of a life of perfection, dates from the first ages of the Church, and women may claim with a certain pride that they were the first to embrace the religious state for its own sake, without regard to missionary work and ecclesiastical functions proper to men.\n\nTake a moment to reflect upon any experiences you may have had with a sister or nun.  Maybe you have at one time discerned the vocation of sisterhood. Take a moment to pray, pray for your own vocation and that of others, God is always listening.", url: "https://i.pinimg.com/564x/aa/21/4e/aa214e73d98232cb14581205a4bcb16d.jpg", saint: "Saint Mary Ann of Jesus of Paredes : 03/06", saintURL: "https://www.franciscanmedia.org/saint-mary-ann-of-jesus-of-paredes/", saintDate: "06-03"),


                            "07-03" : Days(title: "Our Lady of Fatima Pope John Paul II pictured here thanking the virgin for her intervention when he was shot (the bullet was added to her crown.", reflection: "Saint Pope John Paul II had a very close relationship with the Blessed Mother. He was convinced that Mary, in the form of Our Lady of Fatima, had personally redirected the bullet that hit him, saving his life. \n\nTake a moment to reflect upon what impact the Blessed Mother has had in your life and pray on what you can do to become closer to her.", url: "https://i.pinimg.com/564x/22/5d/50/225d506c3294ed968859637d03a7ad8b.jpg", saint: "Saints Perpetua and Felicity : 03/07", saintURL: "https://www.franciscanmedia.org/saints-perpetua-and-felicity/", saintDate: "07-03"),


                            "08-03" : Days(title: "Pope John Paul II and Cardinal Ratzinger.", reflection: "Pope Emeritus Benedict XVI, then Cardinal Joseph Ratzinger, was John Paul’s chief doctrinal officer for nearly a quarter of a century, and presided at John Paul’s funeral in 2005.\n\nPope Emeritus Benedict once said, \"True friends challenge us and help us to be faithful on our journey.\"\n\nTake a moment and reflect on a good friend of yours who has challenged you and lifted you toward Jesus.  Maybe take some time to pray for him or her and give thanks to God for putting them in your life.", url: "https://i.pinimg.com/564x/e3/85/4c/e3854ce4df621f80d25123d945784c0d.jpg", saint: "Saint John of God : 03/08", saintURL: "https://www.franciscanmedia.org/saint-john-of-god/", saintDate: "08-03"),


                            "09-03" : Days(title: "Pope John Paul Second of II coat of arms", reflection: "Saint Pope John Paul II once said, \"The future starts today, not tomorrow.\" Take some time and think about that for a moment.  Reflect on any times you have put things off.  Maybe it is making amends with a friend or even going to mass or confession.  Let us take an example from Pope John Paul II and look at what we can do today.", url: "https://i.pinimg.com/564x/c2/21/d4/c221d424e61b00198f0f94a974ab3baa.jpg", saint: "Saint Frances of Rome : 03/09", saintURL: "https://www.franciscanmedia.org/saint-frances-of-rome/", saintDate: "09-03"),


                            "10-03" : Days(title: "Pope John Paul II and the rosary.", reflection: "St. John Paul II’s new way of praying the Rosary was based on the teachings of St. Theresa of Avila and has become known as the Contemplative Rosary because it more perfectly unites vocal prayer and meditation, transforming the prayers of the Rosary into a contemplative meeting with God.\n\nPope John Paul II, in his apostolic letter Rosarium Virginis Mariae (October 2002), recommended an additional set of mysteries called the Luminous Mysteries (or the \"Mysteries of Light\").", url: "https://i.pinimg.com/236x/9d/0d/9c/9d0d9c9257346441f71d550e1457efa7.jpg", saint: "Saint Dominic Savio : 03/10", saintURL: "https://www.franciscanmedia.org/saint-dominic-savio/", saintDate: "10-03"),


                            "11-03" : Days(title: "The official portrait of Pope John Paul II", reflection: "He was elected pope by the second papal conclave of 1978, which was called after Pope John Paul I, who had been elected in August to succeed Pope Paul VI, died after 33 days. Cardinal Wojtyła was elected on the third day of the conclave and adopted the name of his predecessor in tribute to him. His papacy began on 16 October 1978.\n\nWere you alive when Pope John Paul II was elected?  Take a moment to reflect on that day and what it and his life has meant to you.  ", url: "https://i.pinimg.com/564x/23/7c/bc/237cbcdbf1ee94acbdc59d4949a10dad.jpg", saint: "Saint John Ogilvie : 03/11", saintURL: "https://www.franciscanmedia.org/saint-john-ogilvie/", saintDate: "11-03"),


                            "12-03" : Days(title: "Pope John Paul II wearing sombrero.", reflection: "Saint Pope John Paul II once said, \"Do not abandon yourselves to despair. We are the Easter people and hallelujah is our song.\"\n\nTake a moment to reflect on a time when you felt alone, poor or oppressed.  What did you find comfort in?  Could it have been a call from God, an opportunity to show your faith?", url: "https://i.pinimg.com/564x/e6/9e/ce/e69ece0620cdc3cc6f278f5d11039b61.jpg", saint: "Blessed Angela Salawa : 03/12", saintURL: "https://www.franciscanmedia.org/blessed-angela-salawa/", saintDate: "12-03"),


                            "13-03" : Days(title: "", reflection: "", url: "", saint: "Saint Leander of Seville : 03/13", saintURL: "https://www.franciscanmedia.org/saint-leander-of-seville/", saintDate: "13-03"),


                            "14-03" : Days(title: "", reflection: "", url: "", saint: "Saint Maximilian : 03/14", saintURL: "https://www.franciscanmedia.org/saint-maximilian/", saintDate: "14-03"),


                            "15-03" : Days(title: "", reflection: "", url: "", saint: "Saint Louise de Marillac : 03/15", saintURL: "https://www.franciscanmedia.org/saint-louise-de-marillac/", saintDate: "15-03"),


                            "16-03" : Days(title: "", reflection: "", url: "", saint: "Saint Clement Mary Hofbauer : 03/16", saintURL: "https://www.franciscanmedia.org/saint-clement-mary-hofbauer/", saintDate: "16-03"),


                            "17-03" : Days(title: "", reflection: "", url: "", saint: "Saint Patrick : 03/17", saintURL: "https://www.franciscanmedia.org/saint-patrick/", saintDate: "17-03"),


                            "18-03" : Days(title: "", reflection: "", url: "", saint: "Saint Cyril of Jerusalem : 03/18", saintURL: "https://www.franciscanmedia.org/saint-cyril-of-jerusalem/", saintDate: "18-03"),


                            "19-03" : Days(title: "", reflection: "", url: "", saint: "Saint Joseph, Husband of Mary : 03/19", saintURL: "https://www.franciscanmedia.org/saint-joseph-husband-of-mary/", saintDate: "19-03"),


                            "20-03" : Days(title: "", reflection: "", url: "", saint: "Saint Salvator of Horta : 03/20", saintURL: "https://www.franciscanmedia.org/saint-salvator-of-horta/", saintDate: "20-03"),


                            "21-03" : Days(title: "", reflection: "", url: "", saint: "Blessed John of Parma : 03/21", saintURL: "https://www.franciscanmedia.org/blessed-john-of-parma/", saintDate: "21-03"),


                            "22-03" : Days(title: "", reflection: "", url: "", saint: "Saint Nicholas Owen : 03/22", saintURL: "https://www.franciscanmedia.org/saint-nicholas-owen/", saintDate: "22-03"),


                            "23-03" : Days(title: "", reflection: "", url: "", saint: "Saint Turibius of Mogrovejo : 03/23", saintURL: "https://www.franciscanmedia.org/saint-turibius-of-mogrovejo/", saintDate: "23-03"),


                            "24-03" : Days(title: "", reflection: "", url: "", saint: "Saint Oscar Arnulfo Romero : 03/24", saintURL: "https://www.franciscanmedia.org/saint-oscar-arnulfo-romero/", saintDate: "24-03"),


                            "25-03" : Days(title: "", reflection: "", url: "", saint: "Annunciation of the Lord : 03/25", saintURL: "https://www.franciscanmedia.org/annunciation-of-the-lord/", saintDate: "25-03"),


                            "26-03" : Days(title: "", reflection: "", url: "", saint: "Saint Catherine of Genoa : 03/26", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-genoa/", saintDate: "26-03"),


                            "27-03" : Days(title: "", reflection: "", url: "", saint: "Lazarus : 03/27", saintURL: "https://www.franciscanmedia.org/lazarus/", saintDate: "27-03"),


                            "28-03" : Days(title: "", reflection: "", url: "", saint: "Saint Catharine of Bologna : 03/28", saintURL: "https://www.franciscanmedia.org/saint-catharine-of-bologna/", saintDate: "28-03"),


                            "29-03" : Days(title: "", reflection: "", url: "", saint: "Saint Ludovico of Casoria : 03/29", saintURL: "https://www.franciscanmedia.org/saint-ludovico-of-casoria/", saintDate: "29-03"),


                            "30-03" : Days(title: "", reflection: "", url: "", saint: "Saint Peter Regalado : 03/30", saintURL: "https://www.franciscanmedia.org/saint-peter-regalado/", saintDate: "30-03"),


                            "31-03" : Days(title: "", reflection: "", url: "", saint: "Saint Stephen of Mar Saba : 03/31", saintURL: "https://www.franciscanmedia.org/saint-stephen-of-mar-saba/", saintDate: "31-03"),






                            "01-04" : Days(title: "", reflection: "", url: "", saint: "Saint Hugh of Grenoble : 04/01", saintURL: "https://www.franciscanmedia.org/saint-hugh-of-grenoble/", saintDate: "01-04"),


                            "02-04" : Days(title: "", reflection: "", url: "", saint: "Saint Francis of Paola : 04/02", saintURL: "https://www.franciscanmedia.org/saint-francis-of-paola/", saintDate: "02-04"),


                            "03-04" : Days(title: "", reflection: "", url: "", saint: "Saint Benedict the African : 04/03", saintURL: "https://www.franciscanmedia.org/saint-benedict-the-african/", saintDate: "03-04"),


                            "04-04" : Days(title: "", reflection: "", url: "", saint: "Saint Isidore of Seville : 04/04", saintURL: "https://www.franciscanmedia.org/saint-isidore-of-seville/", saintDate: "04-04"),


                            "05-04" : Days(title: "", reflection: "", url: "", saint: "Saint Vincent Ferrer : 04/05", saintURL: "https://www.franciscanmedia.org/saint-vincent-ferrer/", saintDate: "05-04"),


                            "06-04" : Days(title: "", reflection: "", url: "", saint: "Saint Crescentia Hoess : 04/06", saintURL: "https://www.franciscanmedia.org/saint-crescentia-hoess/", saintDate: "06-04"),


                            "07-04" : Days(title: "", reflection: "", url: "", saint: "Saint John Baptist de La Salle : 04/07", saintURL: "https://www.franciscanmedia.org/saint-john-baptist-de-la-salle/", saintDate: "07-04"),


                            "08-04" : Days(title: "", reflection: "", url: "", saint: "Saint Julie Billiart : 04/08", saintURL: "https://www.franciscanmedia.org/saint-julie-billiart/", saintDate: "08-04"),


                            "09-04" : Days(title: "", reflection: "", url: "", saint: "Saint Casilda : 04/09", saintURL: "https://www.franciscanmedia.org/saint-casilda/", saintDate: "09-04"),


                            "10-04" : Days(title: "", reflection: "", url: "", saint: "Saint Magdalen of Canossa : 04/10", saintURL: "https://www.franciscanmedia.org/saint-magdalen-of-canossa/", saintDate: "10-04"),


                            "11-04" : Days(title: "", reflection: "", url: "", saint: "Saint Stanislaus : 04/11", saintURL: "https://www.franciscanmedia.org/saint-stanislaus/", saintDate: "11-04"),


                            "12-04" : Days(title: "", reflection: "", url: "", saint: "Saint Teresa of Los Andes : 04/12", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-los-andes/", saintDate: "12-04"),


                            "13-04" : Days(title: "", reflection: "", url: "", saint: "Saint Martin I : 04/13", saintURL: "https://www.franciscanmedia.org/saint-martin-i/", saintDate: "13-04"),


                            "14-04" : Days(title: "", reflection: "", url: "", saint: "Blessed Peter Gonzalez : 04/14", saintURL: "https://www.franciscanmedia.org/blessed-peter-gonzalez/", saintDate: "14-04"),


                            "15-04" : Days(title: "", reflection: "", url: "", saint: "Blessed Caesar de Bus : 04/15", saintURL: "https://www.franciscanmedia.org/blessed-caesar-de-bus/", saintDate: "15-04"),


                            "16-04" : Days(title: "", reflection: "", url: "", saint: "Saint Bernadette Soubirous : 04/16", saintURL: "https://www.franciscanmedia.org/saint-bernadette-soubirous/", saintDate: "16-04"),


                            "17-04" : Days(title: "", reflection: "", url: "", saint: "Saint Benedict Joseph Labre : 04/17", saintURL: "https://www.franciscanmedia.org/saint-benedict-joseph-labre/", saintDate: "17-04"),


                            "18-04" : Days(title: "", reflection: "", url: "", saint: "Blessed James Oldo : 04/18", saintURL: "https://www.franciscanmedia.org/blessed-james-oldo/", saintDate: "18-04"),


                            "19-04" : Days(title: "", reflection: "", url: "", saint: "Saint Gianna Beretta Molla : 04/19", saintURL: "https://www.franciscanmedia.org/saint-gianna-beretta-molla/", saintDate: "19-04"),


                            "20-04" : Days(title: "", reflection: "", url: "", saint: "Saint Conrad of Parzham : 04/20", saintURL: "https://www.franciscanmedia.org/saint-conrad-of-parzham/", saintDate: "20-04"),


                            "21-04" : Days(title: "", reflection: "", url: "", saint: "Saint Anselm : 04/21", saintURL: "https://www.franciscanmedia.org/saint-anselm/", saintDate: "21-04"),


                            "22-04" : Days(title: "", reflection: "", url: "", saint: "Saint Adalbert of Prague : 04/22", saintURL: "https://www.franciscanmedia.org/saint-adalbert-of-prague/", saintDate: "22-04"),


                            "23-04" : Days(title: "", reflection: "", url: "", saint: "Saint George : 04/23", saintURL: "https://www.franciscanmedia.org/saint-george/", saintDate: "23-04"),


                            "24-04" : Days(title: "", reflection: "", url: "", saint: "https://www.franciscanmedia.org/saint-fidelis-of-sigmaringen/", saintURL: "Saint Fidelis of Sigmaringen", saintDate: "24-04"),


                            "25-04" : Days(title: "", reflection: "", url: "", saint: "Saint Mark : 04/25", saintURL: "https://www.franciscanmedia.org/saint-mark/", saintDate: "25-04"),


                            "26-04" : Days(title: "", reflection: "", url: "", saint: "Saint Pedro de San José Betancur : 04/26", saintURL: "https://www.franciscanmedia.org/saint-pedro-de-san-jos-eacute-betancur/", saintDate: "26-04"),


                            "27-04" : Days(title: "", reflection: "", url: "", saint: "Saint Louis Mary Grignion de Montfort : 04/27", saintURL: "https://www.franciscanmedia.org/saint-louis-mary-grignion-de-montfort/", saintDate: "27-04"),


                            "28-04" : Days(title: "", reflection: "", url: "", saint: "Saint Peter Chanel : 04/28", saintURL: "https://www.franciscanmedia.org/saint-peter-chanel/", saintDate: "28-04"),


                            "29-04" : Days(title: "", reflection: "", url: "", saint: "Saint Catherine of Siena : 04/29", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-siena/", saintDate: "29-04"),


                            "30-04" : Days(title: "", reflection: "", url: "", saint: "Saint Pius V : 04/31", saintURL: "https://www.franciscanmedia.org/saint-pius-v/", saintDate: "30-04"),


                            "31-04" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-04"),






                            "01-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "01-05"),


                            "02-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "02-05"),


                            "03-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "03-05"),


                            "04-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "04-05"),


                            "05-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "05-05"),


                            "06-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "06-05"),


                            "07-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "07-05"),


                            "08-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "08-05"),


                            "09-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "09-05"),


                            "10-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "10-05"),


                            "11-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "11-05"),


                            "12-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "12-05"),


                            "13-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "13-05"),


                            "14-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "14-05"),


                            "15-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "15-05"),


                            "16-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "16-05"),


                            "17-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "17-05"),


                            "18-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "18-05"),


                            "19-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "19-05"),


                            "20-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "20-05"),


                            "21-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "21-05"),


                            "22-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "22-05"),


                            "23-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "23-05"),


                            "24-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "24-05"),


                            "25-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "25-05"),


                            "26-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "26-05"),


                            "27-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "27-05"),


                            "28-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "28-05"),


                            "29-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "29-05"),


                            "30-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-05"),


                            "31-05" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-05"),






                            "01-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "01-06"),


                            "02-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "02-06"),


                            "03-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "03-06"),


                            "04-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "04-06"),


                            "05-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "05-06"),


                            "06-06" : Days(title: "Pope John Paul and Sister Lucia", reflection: "The institution of nuns and sisters, who devote themselves in various religious orders to the practice of a life of perfection, dates from the first ages of the Church, and women may claim with a certain pride that they were the first to embrace the religious state for its own sake, without regard to missionary work and ecclesiastical functions proper to men.\n\nTake a moment to reflect upon any experiences you may have had with a sister or nun.  Maybe you have at one time discerned the vocation of sisterhood. Take a moment to pray, pray for your own vocation and that of others, God is always listening.", url: "https://i.pinimg.com/564x/aa/21/4e/aa214e73d98232cb14581205a4bcb16d.jpg", saint: "", saintURL: "", saintDate: "06-06"),


                            "07-06" : Days(title: "Our Lady of Fatima Pope John Paul II pictured here thanking the virgin for her intervention when he was shot (the bullet was added to her crown.", reflection: "Saint Pope John Paul II had a very close relationship with the Blessed Mother. He was convinced that Mary, in the form of Our Lady of Fatima, had personally redirected the bullet that hit him, saving his life. \n\nTake a moment to reflect upon what impact the Blessed Mother has had in your life and pray on what you can do to become closer to her.", url: "https://i.pinimg.com/564x/22/5d/50/225d506c3294ed968859637d03a7ad8b.jpg", saint: "", saintURL: "", saintDate: "07-06"),


                            "08-06" : Days(title: "Pope John Paul II and Cardinal Ratzinger.", reflection: "Pope Emeritus Benedict XVI, then Cardinal Joseph Ratzinger, was John Paul’s chief doctrinal officer for nearly a quarter of a century, and presided at John Paul’s funeral in 2005.\n\nPope Emeritus Benedict once said, \"True friends challenge us and help us to be faithful on our journey.\"\n\nTake a moment and reflect on a good friend of yours who has challenged you and lifted you toward Jesus.  Maybe take some time to pray for him or her and give thanks to God for putting them in your life.", url: "https://i.pinimg.com/564x/e3/85/4c/e3854ce4df621f80d25123d945784c0d.jpg", saint: "", saintURL: "", saintDate: "08-06"),


                            "09-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "09-06"),


                            "10-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "10-06"),


                            "11-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "11-06"),


                            "12-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "12-06"),


                            "13-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "13-06"),


                            "14-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "14-06"),


                            "15-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "15-06"),


                            "16-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "16-06"),


                            "17-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "17-06"),


                            "18-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "18-06"),


                            "19-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "19-06"),


                            "20-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "20-06"),


                            "21-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "21-06"),


                            "22-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "22-06"),


                            "23-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "23-06"),


                            "24-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "24-06"),


                            "25-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "25-06"),


                            "26-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "26-06"),


                            "27-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "27-06"),


                            "28-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "28-06"),


                            "29-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "29-06"),


                            "30-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-06"),


                            "31-06" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-06"),






                            "01-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "01-07"),


                            "02-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "02-07"),


                            "03-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "03-07"),


                            "04-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "04-07"),


                            "05-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "05-07"),


                            "06-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "06-07"),


                            "07-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "07-07"),


                            "08-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "08-07"),


                            "09-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "09-07"),


                            "10-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "10-07"),


                            "11-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "11-07"),


                            "12-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "12-07"),


                            "13-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "13-07"),


                            "14-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "14-07"),


                            "15-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "15-07"),


                            "16-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "16-07"),


                            "17-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "17-07"),


                            "18-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "18-07"),


                            "19-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "19-07"),


                            "20-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "20-07"),


                            "21-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "21-07"),


                            "22-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "22-07"),


                            "23-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "23-07"),


                            "24-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "24-07"),


                            "25-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "25-07"),


                            "26-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "26-07"),


                            "27-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "27-07"),


                            "28-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "28-07"),


                            "29-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "29-07"),


                            "30-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-07"),


                            "31-07" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-07"),





                            "01-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "01-08"),


                            "02-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "02-08"),


                            "03-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "03-08"),


                            "04-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "04-08"),


                            "05-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "05-08"),


                            "06-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "06-08"),


                            "07-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "07-08"),


                            "08-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "08-08"),


                            "09-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "09-08"),


                            "10-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "10-08"),


                            "11-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "11-08"),


                            "12-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "12-08"),


                            "13-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "13-08"),


                            "14-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "14-08"),


                            "15-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "15-08"),


                            "16-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "16-08"),


                            "17-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "17-08"),


                            "18-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "18-08"),


                            "19-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "19-08"),


                            "20-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "20-08"),


                            "21-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "21-08"),


                            "22-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "22-08"),


                            "23-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "23-08"),


                            "24-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "24-08"),


                            "25-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "25-08"),


                            "26-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "26-08"),


                            "27-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "27-08"),


                            "28-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "28-08"),


                            "29-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "29-08"),


                            "30-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-08"),


                            "31-08" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-08"),




                            "01-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "01-09"),


                            "02-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "02-09"),


                            "03-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "03-09"),


                            "04-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "04-09"),


                            "05-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "05-09"),


                            "06-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "06-09"),


                            "07-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "07-09"),


                            "08-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "08-09"),


                            "09-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "09-09"),


                            "10-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "10-09"),


                            "11-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "11-09"),


                            "12-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "12-09"),


                            "13-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "13-09"),


                            "14-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "14-09"),


                            "15-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "15-09"),


                            "16-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "16-09"),


                            "17-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "17-09"),


                            "18-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "18-09"),


                            "19-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "19-09"),


                            "20-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "20-09"),


                            "21-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "21-09"),


                            "22-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "22-09"),


                            "23-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "23-09"),


                            "24-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "24-09"),


                            "25-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "25-09"),


                            "26-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "26-09"),


                            "27-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "27-09"),


                            "28-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "28-09"),


                            "29-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "29-09"),


                            "30-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-09"),


                            "31-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-09"),





                            "01-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "01-10"),


                            "02-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "02-10"),


                            "03-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "03-10"),


                            "04-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "04-10"),


                            "05-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "05-10"),


                            "06-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "06-10"),


                            "07-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "07-10"),


                            "08-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "08-10"),


                            "09-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "09-10"),


                            "10-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "10-10"),


                            "11-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "11-10"),


                            "12-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "12-10"),


                            "13-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "13-10"),


                            "14-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "14-10"),


                            "15-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "15-10"),


                            "16-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "16-10"),


                            "17-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "17-10"),


                            "18-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "18-10"),


                            "19-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "19-10"),


                            "20-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "20-10"),


                            "21-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "21-10"),


                            "22-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "22-10"),


                            "23-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "23-10"),


                            "24-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "24-10"),


                            "25-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "25-10"),


                            "26-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "26-10"),


                            "27-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "27-10"),


                            "28-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "28-10"),


                            "29-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "29-10"),


                            "30-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-10"),


                            "31-10" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-10"),





                            "01-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "01-11"),


                            "02-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "02-11"),


                            "03-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "03-11"),


                            "04-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "04-11"),


                            "05-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "05-11"),


                            "06-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "06-11"),


                            "07-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "07-11"),


                            "08-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "08-11"),


                            "09-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "09-11"),


                            "10-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "10-11"),


                            "11-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "11-11"),


                            "12-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "12-11"),


                            "13-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "13-11"),


                            "14-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "14-11"),


                            "15-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "15-11"),


                            "16-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "16-11"),


                            "17-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "17-11"),


                            "18-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "18-11"),


                            "19-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "19-11"),


                            "20-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "20-11"),


                            "21-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "21-11"),


                            "22-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "22-11"),


                            "23-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "23-11"),


                            "24-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "24-11"),


                            "25-11" : Days(title: "BRISBANE, AUSTRALIA - NOVEMBER 25: Pope John Paul II holds a koala in his arms during his official visit to Oceania on November 25, 1986 in Brisbane, Australia.", reflection: "Saint Pope John Paul II once said, \"Freedom consists not in doing what we like, but in having the right to do what we ought.\"\n\nThis is a powerful statement that I am sure many of us struggle with.  Let us reflect for a moment on the things we have done in the last week.  How many of these things have been for the benefit of ourselves as opposed to others?", url: "https://i.pinimg.com/564x/bc/4e/cf/bc4ecf6149fd85f5ac3ddf0e87f20cf6.jpg", saint: "", saintURL: "", saintDate: "25-11"),


                            "26-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "26-11"),


                            "27-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "27-11"),


                            "28-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "28-11"),


                            "29-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "29-11"),


                            "30-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-11"),


                            "31-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-11"),





                            "01-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "01-12"),


                            "02-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "02-12"),


                            "03-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "03-12"),


                            "04-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "04-12"),


                            "05-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "05-12"),


                            "06-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "06-12"),


                            "07-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "07-12"),


                            "08-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "08-12"),


                            "09-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "09-12"),


                            "10-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "10-12"),


                            "11-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "11-12"),


                            "12-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "12-12"),


                            "13-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "13-12"),


                            "14-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "14-12"),


                            "15-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "15-12"),


                            "16-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "16-12"),


                            "17-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "17-12"),


                            "18-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "18-12"),


                            "19-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "19-12"),


                            "20-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "20-12"),


                            "21-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "21-12"),


                            "22-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "22-12"),


                            "23-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "23-12"),


                            "24-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "24-12"),


                            "25-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "25-12"),


                            "26-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "26-12"),


                            "27-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "27-12"),


                            "28-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "28-12"),


                            "29-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "29-12"),


                            "30-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "30-12"),


                            "31-12" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-12"),

                    ]
        
        mainImage.loadImageUsingCache(withUrl: daysOfTheYear["Days"]?[formatDate(date: Date())]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[formatDate(date: Date())]?.title
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[formatDate(date: Date())]?.reflection
    }
    
    
    @IBAction func todayAction(_ sender: UIButton) {
        let currentGlobal = DesiredDate.shared.globalDate
        if(currentGlobal != formatDate(date: Date())){
            print("not equal")
            DesiredDate.shared.globalDate = formatDate(date: Date())
        }
        let newDate = DesiredDate.shared.globalDate
        mainImage.loadImageUsingCache(withUrl: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[newDate]?.title
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[newDate]?.reflection
    }
    
    @IBAction func previousDayAction(_ sender: UIButton) {
        DesiredDate.shared.globalDate = formatDate(date: Date.yesterday)
        let newDate = DesiredDate.shared.globalDate
        mainImage.loadImageUsingCache(withUrl: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[newDate]?.title
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[newDate]?.reflection
    }
    
    @IBAction func nextDayAction(_ sender: UIButton) {
        DesiredDate.shared.globalDate = formatDate(date: Date.tomorrow)
        let newDate = DesiredDate.shared.globalDate
        mainImage.loadImageUsingCache(withUrl: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[newDate]?.title
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[newDate]?.reflection
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

