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
                             "01-01" : Days(title: "", reflection: "", url: "1", saint: "Mary, Mother of God : 01/01", saintURL: "https://www.franciscanmedia.org/mary-mother-of-god/", saintDate: "01-01"),


                             "02-01" : Days(title: "", reflection: "", url: "2", saint: "Saint Basil the Great : 01/02", saintURL: "https://www.franciscanmedia.org/saint-basil-the-great/", saintDate: "02-01"),


                             "03-01" : Days(title: "", reflection: "", url: "3", saint: "Most Holy Name of Jesus : 01/03", saintURL: "https://www.franciscanmedia.org/mosaint-holy-name-of-jesus/", saintDate: "03-01"),


                             "04-01" : Days(title: "", reflection: "", url: "4", saint: "Saint Elizabeth Ann Seton : 01/04", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-ann-seton/", saintDate: "04-01"),


                             "05-01" : Days(title: "", reflection: "", url: "5", saint: "Saint John Neumann : 01/05", saintURL: "https://www.franciscanmedia.org/saint-john-neumann/", saintDate: "05-01"),


                             "06-01" : Days(title: "", reflection: "", url: "6", saint: "Saint André Bessette : 01/06", saintURL: "https://www.franciscanmedia.org/saint-andr-eacute-bessette/", saintDate: "06-01"),


                             "07-01" : Days(title: "", reflection: "", url: "7", saint: "Saint Raymond of Peñafort : 01/07", saintURL: "https://www.franciscanmedia.org/saint-raymond-of-pe-afort/", saintDate: "07-01"),


                             "08-01" : Days(title: "", reflection: "", url: "8", saint: "Saint Angela of Foligno : 01/08", saintURL: "https://www.franciscanmedia.org/saint-angela-of-foligno/", saintDate: "08-01"),


                             "09-01" : Days(title: "", reflection: "", url: "9", saint: "Saint Adrian of Canterbury : 01/09", saintURL: "https://www.franciscanmedia.org/saint-adrian-of-canterbury/", saintDate: "09-01"),


                             "10-01" : Days(title: "", reflection: "", url: "10", saint: "Saint Gregory of Nyssa : 01/10", saintURL: "https://www.franciscanmedia.org/saint-gregory-of-nyssa/", saintDate: "10-01"),


                             "11-01" : Days(title: "", reflection: "", url: "11", saint: "Blessed William Carter : 01/11", saintURL: "https://www.franciscanmedia.org/blessed-william-carter/", saintDate: "11-01"),


                             "12-01" : Days(title: "", reflection: "", url: "12", saint: "Saint Marguerite Bourgeoys : 01/12", saintURL: "https://www.franciscanmedia.org/saint-marguerite-bourgeoys/", saintDate: "12-01"),


                             "13-01" : Days(title: "", reflection: "", url: "13", saint: "Saint Hilary of Poitiers : 01/13", saintURL: "https://www.franciscanmedia.org/saint-hilary/", saintDate: "13-01"),


                             "14-01" : Days(title: "", reflection: "", url: "14", saint: "Saint Gregory Nazianzen : 01/14", saintURL: "https://www.franciscanmedia.org/saint-gregory-nazianzen/", saintDate: "14-01"),


                             "15-01" : Days(title: "", reflection: "", url: "15", saint: "Saint Paul the Hermit : 01/15", saintURL: "https://www.franciscanmedia.org/saint-paul-the-hermit/", saintDate: "15-01"),


                             "16-01" : Days(title: "", reflection: "", url: "16", saint: "Saint Berard and Companions : 01/16", saintURL: "https://www.franciscanmedia.org/saint-berard-and-companions/", saintDate: "16-01"),


                             "17-01" : Days(title: "", reflection: "", url: "17", saint: "Saint Anthony of Egypt : 01/17", saintURL: "https://www.franciscanmedia.org/saint-anthony-of-egypt/", saintDate: "17-01"),


                             "18-01" : Days(title: "", reflection: "", url: "18", saint: "Saint Charles of Sezze : 01/18", saintURL: "https://www.franciscanmedia.org/saint-charles-of-sezze/", saintDate: "18-01"),


                             "19-01" : Days(title: "", reflection: "", url: "19", saint: "Saint Fabian : 01/19", saintURL: "https://www.franciscanmedia.org/saint-fabian/", saintDate: "19-01"),


                             "20-01" : Days(title: "", reflection: "", url: "20", saint: "Saint Sebastian : 01/20", saintURL: "https://www.franciscanmedia.org/saint-sebastian/", saintDate: "20-01"),


                             "21-01" : Days(title: "", reflection: "", url: "21", saint: "Saint Agnes : 01/21", saintURL: "https://www.franciscanmedia.org/saint-agnes/", saintDate: "21-01"),


                             "22-01" : Days(title: "", reflection: "", url: "22", saint: "Saint Vincent of Zaragossa : 01/22", saintURL: "https://www.franciscanmedia.org/saint-vincent-of-zaragossa/", saintDate: "22-01"),


                             "23-01" : Days(title: "", reflection: "", url: "23", saint: "Saint Marianne Cope : 01/23", saintURL: "https://www.franciscanmedia.org/saint-marianne-cope/", saintDate: "23-01"),


                             "24-01" : Days(title: "", reflection: "", url: "24", saint: "Saint Francis de Sales : 01/24", saintURL: "https://www.franciscanmedia.org/saint-francis-de-sales/", saintDate: "24-01"),


                             "25-01" : Days(title: "", reflection: "", url: "25", saint: "Conversion of Saint Paul : 01/25", saintURL: "https://www.franciscanmedia.org/conversion-of-saint-paul/", saintDate: "25-01"),


                             "26-01" : Days(title: "", reflection: "", url: "26", saint: "Saints Timothy and Titus : 01/26", saintURL: "https://www.franciscanmedia.org/saints-timothy-and-titus/", saintDate: "26-01"),


                             "27-01" : Days(title: "", reflection: "", url: "27", saint: "Saint Angela Merici : 01/27", saintURL: "https://www.franciscanmedia.org/saint-angela-merici/", saintDate: "27-01"),


                             "28-01" : Days(title: "", reflection: "", url: "28", saint: "Saint Thomas Aquinas : 01/28", saintURL: "https://www.franciscanmedia.org/saint-thomas-aquinas/", saintDate: "28-01"),


                             "29-01" : Days(title: "", reflection: "", url: "29", saint: "Servant of God Brother Juniper : 01/29", saintURL: "https://www.franciscanmedia.org/servant-of-god-brother-juniper/", saintDate: "29-01"),


                             "30-01" : Days(title: "", reflection: "", url: "30", saint: "Blessed Mary Angela Truszkowska : 01/30", saintURL: "https://www.franciscanmedia.org/blessed-mary-angela-truszkowska/", saintDate: "30-01"),


                             "31-01" : Days(title: "", reflection: "", url: "31", saint: "Saint John Bosco : 01/31", saintURL: "https://www.franciscanmedia.org/saint-john-bosco/", saintDate: "31-01"),
                             





                             "01-02" : Days(title: "", reflection: "", url: "32", saint: "Saint Ansgar : 02/01", saintURL: "https://www.franciscanmedia.org/saint-ansgar/", saintDate: "01-02"),


                             "02-02" : Days(title: "", reflection: "", url: "33", saint: "Presentation of the Lord : 02/02", saintURL: "https://www.franciscanmedia.org/presentation-of-the-lord/", saintDate: "02-02"),


                             "03-02" : Days(title: "", reflection: "", url: "34", saint: "Saint Blaise : 02/03", saintURL: "https://www.franciscanmedia.org/saint-blaise/", saintDate: "03-02"),


                             "04-02" : Days(title: "", reflection: "", url: "35", saint: "Saint Joseph of Leonissa : 02/04", saintURL: "https://www.franciscanmedia.org/saint-joseph-of-leonissa/", saintDate: "04-02"),


                             "05-02" : Days(title: "", reflection: "", url: "36", saint: "Saint Agatha : 02/05", saintURL: "https://www.franciscanmedia.org/saint-agatha/", saintDate: "05-02"),


                             "06-02" : Days(title: "", reflection: "", url: "37", saint: "Saint Paul Miki and Companions : 02/06", saintURL: "https://www.franciscanmedia.org/saint-paul-miki-and-companions/", saintDate: "06-02"),


                             "07-02" : Days(title: "", reflection: "", url: "38", saint: "Saint Colette : 02/07", saintURL: "https://www.franciscanmedia.org/saint-colette/", saintDate: "07-02"),


                             "08-02" : Days(title: "", reflection: "", url: "39", saint: "Saint Josephine Bakhita : 02/08", saintURL: "https://www.franciscanmedia.org/saint-josephine-bakhita/", saintDate: "08-02"),


                             "09-02" : Days(title: "", reflection: "", url: "40", saint: "Saint Jerome Emiliani : 02/09", saintURL: "https://www.franciscanmedia.org/saint-jerome-emiliani/", saintDate: "09-02"),


                             "10-02" : Days(title: "", reflection: "", url: "41", saint: "Saint Scholastica : 02/10", saintURL: "https://www.franciscanmedia.org/saint-scholastica/", saintDate: "10-02"),


                             "11-02" : Days(title: "", reflection: "", url: "42", saint: "Our Lady of Lourdes : 02/11", saintURL: "https://www.franciscanmedia.org/our-lady-of-lourdes/", saintDate: "11-02"),


                             "12-02" : Days(title: "", reflection: "", url: "43", saint: "Saint Apollonia : 02/12", saintURL: "https://www.franciscanmedia.org/saint-apollonia/", saintDate: "12-02"),


                             "13-02" : Days(title: "", reflection: "", url: "44", saint: "Saint Giles Mary of Saint Joseph : 02/13", saintURL: "https://www.franciscanmedia.org/saint-giles-mary-of-saint-joseph/", saintDate: "13-02"),


                             "14-02" : Days(title: "", reflection: "", url: "45", saint: "Saints Cyril and Methodius : 02/14", saintURL: "https://www.franciscanmedia.org/saints-cyril-and-methodius/", saintDate: "14-02"),


                             "15-02" : Days(title: "", reflection: "", url: "46", saint: "Saint Claude de la Colombière : 02/15", saintURL: "https://www.franciscanmedia.org/saint-claude-de-la-colombi-egrave-re/", saintDate: "15-02"),


                             "16-02" : Days(title: "", reflection: "", url: "47", saint: "Saint Gilbert of Sempringham : 02/16", saintURL: "https://www.franciscanmedia.org/saint-gilbert-of-sempringham/", saintDate: "16-02"),


                             "17-02" : Days(title: "", reflection: "", url: "48", saint: "Seven Founders of the Servite Order : 02/17", saintURL: "https://www.franciscanmedia.org/seven-founders-of-the-servite-order/", saintDate: "17-02"),


                             "18-02" : Days(title: "", reflection: "", url: "49", saint: "Blessed John of Fiesole : 02/18", saintURL: "https://www.franciscanmedia.org/blessed-john-of-fiesole/", saintDate: "18-02"),


                             "19-02" : Days(title: "", reflection: "", url: "50", saint: "Saint Conrad of Piacenza : 02/19", saintURL: "https://www.franciscanmedia.org/saint-conrad-of-piacenza/", saintDate: "19-02"),


                             "20-02" : Days(title: "", reflection: "", url: "51", saint: "Saints Jacinta and Francisco Marto : 02/20", saintURL: "https://www.franciscanmedia.org/saints-jacinta-and-francisco-marto/", saintDate: "20-02"),


                             "21-02" : Days(title: "", reflection: "", url: "52", saint: "Saint Peter Damian : 02/21", saintURL: "https://www.franciscanmedia.org/saint-peter-damian/", saintDate: "21-02"),


                             "22-02" : Days(title: "", reflection: "", url: "53", saint: "Chair of Saint Peter : 02/22", saintURL: "https://www.franciscanmedia.org/chair-of-saint-peter/", saintDate: "22-02"),


                             "23-02" : Days(title: "", reflection: "", url: "54", saint: "Saint Polycarp : 02/23", saintURL: "https://www.franciscanmedia.org/saint-polycarp/", saintDate: "23-02"),


                             "24-02" : Days(title: "", reflection: "", url: "55", saint: "Blessed Luke Belludi : 02/24", saintURL: "https://www.franciscanmedia.org/blessed-luke-belludi/", saintDate: "24-02"),


                             "25-02" : Days(title: "", reflection: "", url: "56", saint: "Blessed Sebastian of Aparicio : 02/25", saintURL: "https://www.franciscanmedia.org/blessed-sebastian-of-aparicio/", saintDate: "25-02"),


                             "26-02" : Days(title: "", reflection: "", url: "57", saint: "Saint Maria Bertilla Boscardin : 02/26", saintURL: "https://www.franciscanmedia.org/saint-maria-bertilla-boscardin/", saintDate: "26-02"),


                             "27-02" : Days(title: "", reflection: "", url: "58", saint: "Saint Gabriel of Our Lady of Sorrows : 02/27", saintURL: "https://www.franciscanmedia.org/saint-gabriel-of-our-lady-of-sorrows/", saintDate: "27-02"),


                             "28-02" : Days(title: "", reflection: "", url: "59", saint: "Blessed Daniel Brottier : 02/28", saintURL: "https://www.franciscanmedia.org/blessed-daniel-brottier/", saintDate: "28-02"),


                             "29-02" : Days(title: "", reflection: "", url: "60", saint: "Saint Oswald : 02/29", saintURL: "https://www.franciscanmedia.org/saint-oswald/", saintDate: "29-02"),


                             "30-02" : Days(title: "", reflection: "", url: "61", saint: "", saintURL: "", saintDate: "30-02"),


                             "31-02" : Days(title: "", reflection: "", url: "62", saint: "", saintURL: "", saintDate: "31-02"),






                             "01-03" : Days(title: "", reflection: "", url: "63", saint: "Saint David of Wales: 03/01", saintURL: "https://www.franciscanmedia.org/saint-david-of-wales/", saintDate: "01-03"),


                             "02-03" : Days(title: "", reflection: "", url: "64", saint: "Saint Agnes of Bohemia : 03/02", saintURL: "https://www.franciscanmedia.org/saint-agnes-of-bohemia/", saintDate: "02-03"),


                             "03-03" : Days(title: "", reflection: "", url: "65", saint: "Saint Katharine Drexel : 03/03", saintURL: "https://www.franciscanmedia.org/saint-katharine-drexel/", saintDate: "03-03"),


                             "04-03" : Days(title: "", reflection: "", url: "66", saint: "Saint Casimir : 03/04", saintURL: "https://www.franciscanmedia.org/saint-casimir/", saintDate: "04-03"),


                             "05-03" : Days(title: "", reflection: "", url: "67", saint: "Saint John Joseph of the Cross : 03/05", saintURL: "https://www.franciscanmedia.org/saint-john-joseph-of-the-cross/", saintDate: "05-03"),


                             "06-03" : Days(title: "Pope John Paul and Sister Lucia", reflection: "The institution of nuns and sisters, who devote themselves in various religious orders to the practice of a life of perfection, dates from the first ages of the Church, and women may claim with a certain pride that they were the first to embrace the religious state for its own sake, without regard to missionary work and ecclesiastical functions proper to men.\n\nTake a moment to reflect upon any experiences you may have had with a sister or nun.  Maybe you have at one time discerned the vocation of sisterhood. Take a moment to pray, pray for your own vocation and that of others, God is always listening.", url:"68", saint: "Saint Mary Ann of Jesus of Paredes : 03/06", saintURL: "https://www.franciscanmedia.org/saint-mary-ann-of-jesus-of-paredes/", saintDate: "06-03"),


                             "07-03" : Days(title: "Our Lady of Fatima Pope John Paul II pictured here thanking the virgin for her intervention when he was shot (the bullet was added to her crown.", reflection: "Saint Pope John Paul II had a very close relationship with the Blessed Mother. He was convinced that Mary, in the form of Our Lady of Fatima, had personally redirected the bullet that hit him, saving his life. \n\nTake a moment to reflect upon what impact the Blessed Mother has had in your life and pray on what you can do to become closer to her.", url: "69", saint: "Saints Perpetua and Felicity : 03/07", saintURL: "https://www.franciscanmedia.org/saints-perpetua-and-felicity/", saintDate: "07-03"),


                             "08-03" : Days(title: "Pope John Paul II and Cardinal Ratzinger.", reflection: "Pope Emeritus Benedict XVI, then Cardinal Joseph Ratzinger, was John Paul’s chief doctrinal officer for nearly a quarter of a century, and presided at John Paul’s funeral in 2005.\n\nPope Emeritus Benedict once said, \"True friends challenge us and help us to be faithful on our journey.\"\n\nTake a moment and reflect on a good friend of yours who has challenged you and lifted you toward Jesus.  Maybe take some time to pray for him or her and give thanks to God for putting them in your life.", url: "70", saint: "Saint John of God : 03/08", saintURL: "https://www.franciscanmedia.org/saint-john-of-god/", saintDate: "08-03"),


                             "09-03" : Days(title: "Pope John Paul Second of II coat of arms", reflection: "Saint Pope John Paul II once said, \"The future starts today, not tomorrow.\" Take some time and think about that for a moment.  Reflect on any times you have put things off.  Maybe it is making amends with a friend or even going to mass or confession.  Let us take an example from Pope John Paul II and look at what we can do today.", url: "71", saint: "Saint Frances of Rome : 03/09", saintURL: "https://www.franciscanmedia.org/saint-frances-of-rome/", saintDate: "09-03"),


                             "10-03" : Days(title: "Pope John Paul II and the rosary.", reflection: "St. John Paul II’s new way of praying the Rosary was based on the teachings of St. Theresa of Avila and has become known as the Contemplative Rosary because it more perfectly unites vocal prayer and meditation, transforming the prayers of the Rosary into a contemplative meeting with God.\n\nPope John Paul II, in his apostolic letter Rosarium Virginis Mariae (October 2002), recommended an additional set of mysteries called the Luminous Mysteries (or the \"Mysteries of Light\").", url: "72", saint: "Saint Dominic Savio : 03/10", saintURL: "https://www.franciscanmedia.org/saint-dominic-savio/", saintDate: "10-03"),


                             "11-03" : Days(title: "The official portrait of Pope John Paul II", reflection: "He was elected pope by the second papal conclave of 1978, which was called after Pope John Paul I, who had been elected in August to succeed Pope Paul VI, died after 33 days. Cardinal Wojtyła was elected on the third day of the conclave and adopted the name of his predecessor in tribute to him. His papacy began on 16 October 1978.\n\nWere you alive when Pope John Paul II was elected?  Take a moment to reflect on that day and what it and his life has meant to you.  ", url: "73", saint: "Saint John Ogilvie : 03/11", saintURL: "https://www.franciscanmedia.org/saint-john-ogilvie/", saintDate: "11-03"),


                             "12-03" : Days(title: "Pope John Paul II wearing sombrero.", reflection: "Saint Pope John Paul II once said, \"Do not abandon yourselves to despair. We are the Easter people and hallelujah is our song.\"\n\nTake a moment to reflect on a time when you felt alone, poor or oppressed.  What did you find comfort in?  Could it have been a call from God, an opportunity to show your faith?", url: "74", saint: "Blessed Angela Salawa : 03/12", saintURL: "https://www.franciscanmedia.org/blessed-angela-salawa/", saintDate: "12-03"),


                             "13-03" : Days(title: "Pope John Paul II and the rosary.", reflection: "St. John Paul II’s new way of praying the Rosary was based on the teachings of St. Theresa of Avila and has become known as the Contemplative Rosary because it more perfectly unites vocal prayer and meditation, transforming the prayers of the Rosary into a contemplative meeting with God.\n\nPope John Paul II, in his apostolic letter Rosarium Virginis Mariae (October 2002), recommended an additional set of mysteries called the Luminous Mysteries (or the \"Mysteries of Light\").", url: "75", saint: "Saint Dominic Savio : 03/10", saintURL: "https://www.franciscanmedia.org/saint-dominic-savio/", saintDate: "10-03"),


                             "14-03" : Days(title: "Pope John Paul II and Cardinal Ratzinger.", reflection: "Pope Emeritus Benedict XVI, then Cardinal Joseph Ratzinger, was John Paul’s chief doctrinal officer for nearly a quarter of a century, and presided at John Paul’s funeral in 2005.\n\nPope Emeritus Benedict once said, \"True friends challenge us and help us to be faithful on our journey.\"\n\nTake a moment and reflect on a good friend of yours who has challenged you and lifted you toward Jesus.  Maybe take some time to pray for him or her and give thanks to God for putting them in your life.", url: "76", saint: "Saint John of God : 03/08", saintURL: "https://www.franciscanmedia.org/saint-john-of-god/", saintDate: "08-03"),


                             "15-03" : Days(title: "", reflection: "", url: "77", saint: "Saint Louise de Marillac : 03/15", saintURL: "https://www.franciscanmedia.org/saint-louise-de-marillac/", saintDate: "15-03"),


                             "16-03" : Days(title: "", reflection: "", url: "78", saint: "Saint Clement Mary Hofbauer : 03/16", saintURL: "https://www.franciscanmedia.org/saint-clement-mary-hofbauer/", saintDate: "16-03"),


                             "17-03" : Days(title: "", reflection: "", url: "79", saint: "Saint Patrick : 03/17", saintURL: "https://www.franciscanmedia.org/saint-patrick/", saintDate: "17-03"),


                             "18-03" : Days(title: "", reflection: "", url: "80", saint: "Saint Cyril of Jerusalem : 03/18", saintURL: "https://www.franciscanmedia.org/saint-cyril-of-jerusalem/", saintDate: "18-03"),


                             "19-03" : Days(title: "", reflection: "", url: "81", saint: "Saint Joseph, Husband of Mary : 03/19", saintURL: "https://www.franciscanmedia.org/saint-joseph-husband-of-mary/", saintDate: "19-03"),


                             "20-03" : Days(title: "", reflection: "", url: "82", saint: "Saint Salvator of Horta : 03/20", saintURL: "https://www.franciscanmedia.org/saint-salvator-of-horta/", saintDate: "20-03"),


                             "21-03" : Days(title: "", reflection: "", url: "83", saint: "Blessed John of Parma : 03/21", saintURL: "https://www.franciscanmedia.org/blessed-john-of-parma/", saintDate: "21-03"),


                             "22-03" : Days(title: "", reflection: "", url: "84", saint: "Saint Nicholas Owen : 03/22", saintURL: "https://www.franciscanmedia.org/saint-nicholas-owen/", saintDate: "22-03"),


                             "23-03" : Days(title: "", reflection: "", url: "85", saint: "Saint Turibius of Mogrovejo : 03/23", saintURL: "https://www.franciscanmedia.org/saint-turibius-of-mogrovejo/", saintDate: "23-03"),


                             "24-03" : Days(title: "", reflection: "", url: "86", saint: "Saint Oscar Arnulfo Romero : 03/24", saintURL: "https://www.franciscanmedia.org/saint-oscar-arnulfo-romero/", saintDate: "24-03"),


                             "25-03" : Days(title: "", reflection: "", url: "87", saint: "Annunciation of the Lord : 03/25", saintURL: "https://www.franciscanmedia.org/annunciation-of-the-lord/", saintDate: "25-03"),


                             "26-03" : Days(title: "", reflection: "", url: "88", saint: "Saint Catherine of Genoa : 03/26", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-genoa/", saintDate: "26-03"),


                             "27-03" : Days(title: "", reflection: "", url: "89", saint: "Lazarus : 03/27", saintURL: "https://www.franciscanmedia.org/lazarus/", saintDate: "27-03"),


                             "28-03" : Days(title: "", reflection: "", url: "90", saint: "Saint Catharine of Bologna : 03/28", saintURL: "https://www.franciscanmedia.org/saint-catharine-of-bologna/", saintDate: "28-03"),


                             "29-03" : Days(title: "", reflection: "", url: "91", saint: "Saint Ludovico of Casoria : 03/29", saintURL: "https://www.franciscanmedia.org/saint-ludovico-of-casoria/", saintDate: "29-03"),


                             "30-03" : Days(title: "", reflection: "", url: "92", saint: "Saint Peter Regalado : 03/30", saintURL: "https://www.franciscanmedia.org/saint-peter-regalado/", saintDate: "30-03"),


                             "31-03" : Days(title: "", reflection: "", url: "93", saint: "Saint Stephen of Mar Saba : 03/31", saintURL: "https://www.franciscanmedia.org/saint-stephen-of-mar-saba/", saintDate: "31-03"),






                             "01-04" : Days(title: "", reflection: "", url: "94", saint: "Saint Hugh of Grenoble : 04/01", saintURL: "https://www.franciscanmedia.org/saint-hugh-of-grenoble/", saintDate: "01-04"),


                             "02-04" : Days(title: "", reflection: "", url: "95", saint: "Saint Francis of Paola : 04/02", saintURL: "https://www.franciscanmedia.org/saint-francis-of-paola/", saintDate: "02-04"),


                             "03-04" : Days(title: "", reflection: "", url: "96", saint: "Saint Benedict the African : 04/03", saintURL: "https://www.franciscanmedia.org/saint-benedict-the-african/", saintDate: "03-04"),


                             "04-04" : Days(title: "", reflection: "", url: "97", saint: "Saint Isidore of Seville : 04/04", saintURL: "https://www.franciscanmedia.org/saint-isidore-of-seville/", saintDate: "04-04"),


                             "05-04" : Days(title: "", reflection: "", url: "98", saint: "Saint Vincent Ferrer : 04/05", saintURL: "https://www.franciscanmedia.org/saint-vincent-ferrer/", saintDate: "05-04"),


                             "06-04" : Days(title: "", reflection: "", url: "99", saint: "Saint Crescentia Hoess : 04/06", saintURL: "https://www.franciscanmedia.org/saint-crescentia-hoess/", saintDate: "06-04"),


                             "07-04" : Days(title: "", reflection: "", url: "100", saint: "Saint John Baptist de La Salle : 04/07", saintURL: "https://www.franciscanmedia.org/saint-john-baptist-de-la-salle/", saintDate: "07-04"),


                             "08-04" : Days(title: "", reflection: "", url: "101", saint: "Saint Julie Billiart : 04/08", saintURL: "https://www.franciscanmedia.org/saint-julie-billiart/", saintDate: "08-04"),


                             "09-04" : Days(title: "", reflection: "", url: "102", saint: "Saint Casilda : 04/09", saintURL: "https://www.franciscanmedia.org/saint-casilda/", saintDate: "09-04"),


                             "10-04" : Days(title: "", reflection: "", url: "103", saint: "Saint Magdalen of Canossa : 04/10", saintURL: "https://www.franciscanmedia.org/saint-magdalen-of-canossa/", saintDate: "10-04"),


                             "11-04" : Days(title: "", reflection: "", url: "104", saint: "Saint Stanislaus : 04/11", saintURL: "https://www.franciscanmedia.org/saint-stanislaus/", saintDate: "11-04"),


                             "12-04" : Days(title: "", reflection: "", url: "105", saint: "Saint Teresa of Los Andes : 04/12", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-los-andes/", saintDate: "12-04"),


                             "13-04" : Days(title: "", reflection: "", url: "106", saint: "Saint Martin I : 04/13", saintURL: "https://www.franciscanmedia.org/saint-martin-i/", saintDate: "13-04"),


                             "14-04" : Days(title: "", reflection: "", url: "107", saint: "Blessed Peter Gonzalez : 04/14", saintURL: "https://www.franciscanmedia.org/blessed-peter-gonzalez/", saintDate: "14-04"),


                             "15-04" : Days(title: "", reflection: "", url: "108", saint: "Blessed Caesar de Bus : 04/15", saintURL: "https://www.franciscanmedia.org/blessed-caesar-de-bus/", saintDate: "15-04"),


                             "16-04" : Days(title: "", reflection: "", url: "109", saint: "Saint Bernadette Soubirous : 04/16", saintURL: "https://www.franciscanmedia.org/saint-bernadette-soubirous/", saintDate: "16-04"),


                             "17-04" : Days(title: "", reflection: "", url: "110", saint: "Saint Benedict Joseph Labre : 04/17", saintURL: "https://www.franciscanmedia.org/saint-benedict-joseph-labre/", saintDate: "17-04"),


                             "18-04" : Days(title: "", reflection: "", url: "111", saint: "Blessed James Oldo : 04/18", saintURL: "https://www.franciscanmedia.org/blessed-james-oldo/", saintDate: "18-04"),


                             "19-04" : Days(title: "", reflection: "", url: "112", saint: "Saint Gianna Beretta Molla : 04/19", saintURL: "https://www.franciscanmedia.org/saint-gianna-beretta-molla/", saintDate: "19-04"),


                             "20-04" : Days(title: "", reflection: "", url: "113", saint: "Saint Conrad of Parzham : 04/20", saintURL: "https://www.franciscanmedia.org/saint-conrad-of-parzham/", saintDate: "20-04"),


                             "21-04" : Days(title: "", reflection: "", url: "114", saint: "Saint Anselm : 04/21", saintURL: "https://www.franciscanmedia.org/saint-anselm/", saintDate: "21-04"),


                             "22-04" : Days(title: "", reflection: "", url: "115", saint: "Saint Adalbert of Prague : 04/22", saintURL: "https://www.franciscanmedia.org/saint-adalbert-of-prague/", saintDate: "22-04"),


                             "23-04" : Days(title: "", reflection: "", url: "116", saint: "Saint George : 04/23", saintURL: "https://www.franciscanmedia.org/saint-george/", saintDate: "23-04"),


                             "24-04" : Days(title: "", reflection: "", url: "117", saint: "Saint Fidelis of Sigmaringen : 04/24", saintURL: "https://www.franciscanmedia.org/saint-fidelis-of-sigmaringen/", saintDate: "24-04"),


                             "25-04" : Days(title: "", reflection: "", url: "118", saint: "Saint Mark : 04/25", saintURL: "https://www.franciscanmedia.org/saint-mark/", saintDate: "25-04"),


                             "26-04" : Days(title: "", reflection: "", url: "119", saint: "Saint Pedro de San José Betancur : 04/26", saintURL: "https://www.franciscanmedia.org/saint-pedro-de-san-jos-eacute-betancur/", saintDate: "26-04"),


                             "27-04" : Days(title: "", reflection: "", url: "120", saint: "Saint Louis Mary Grignion de Montfort : 04/27", saintURL: "https://www.franciscanmedia.org/saint-louis-mary-grignion-de-montfort/", saintDate: "27-04"),


                             "28-04" : Days(title: "", reflection: "", url: "121", saint: "Saint Peter Chanel : 04/28", saintURL: "https://www.franciscanmedia.org/saint-peter-chanel/", saintDate: "28-04"),


                             "29-04" : Days(title: "", reflection: "", url: "1", saint: "Saint Catherine of Siena : 04/29", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-siena/", saintDate: "29-04"),


                             "30-04" : Days(title: "", reflection: "", url: "2", saint: "Saint Pius V : 04/30", saintURL: "https://www.franciscanmedia.org/saint-pius-v/", saintDate: "30-04"),


                             "31-04" : Days(title: "", reflection: "", url: "3", saint: "", saintURL: "", saintDate: "31-04"),






                             "01-05" : Days(title: "", reflection: "", url: "4", saint: "Saint Joseph the Worker : 05/01", saintURL: "https://www.franciscanmedia.org/saint-joseph-the-worker/", saintDate: "01-05"),


                             "02-05" : Days(title: "", reflection: "", url: "5", saint: "Saint Athanasius : 05/02", saintURL: "https://www.franciscanmedia.org/saint-athanasius/", saintDate: "02-05"),


                             "03-05" : Days(title: "", reflection: "", url: "6", saint: "Saints Philip and James : 05/03", saintURL: "https://www.franciscanmedia.org/saints-philip-and-james/", saintDate: "03-05"),


                             "04-05" : Days(title: "", reflection: "", url: "7", saint: "Blessed Michael Giedroyc : 05/04", saintURL: "https://www.franciscanmedia.org/blessed-michael-giedroyc/", saintDate: "04-05"),


                             "05-05" : Days(title: "", reflection: "", url: "8", saint: "Saint Hilary of Arles : 05/05", saintURL: "https://www.franciscanmedia.org/saint-hilary-of-arles/", saintDate: "05-05"),


                             "06-05" : Days(title: "", reflection: "", url: "9", saint: "Saints Marian and James : 05/06", saintURL: "https://www.franciscanmedia.org/saints-marian-and-james/", saintDate: "06-05"),


                             "07-05" : Days(title: "", reflection: "", url: "10", saint: "Saint Rose Venerini : 05/07", saintURL: "https://www.franciscanmedia.org/saint-rose-venerini/", saintDate: "07-05"),


                             "08-05" : Days(title: "", reflection: "", url: "11", saint: "Saint Peter of Tarentaise : 05/08", saintURL: "https://www.franciscanmedia.org/saint-peter-of-tarentaise/", saintDate: "08-05"),


                             "09-05" : Days(title: "", reflection: "", url: "12", saint: "Saint John of Avila : 05/09", saintURL: "https://www.franciscanmedia.org/saint-john-of-avila/", saintDate: "09-05"),


                             "10-05" : Days(title: "", reflection: "", url: "13", saint: "Saint Damien de Veuster of Moloka’i : 05/10", saintURL: "https://www.franciscanmedia.org/saint-damien-de-veuster-of-moloka-i/", saintDate: "10-05"),


                             "11-05" : Days(title: "", reflection: "", url: "14", saint: "Saint Ignatius of Laconi : 05/11", saintURL: "https://www.franciscanmedia.org/saint-ignatius-of-laconi/", saintDate: "11-05"),


                             "12-05" : Days(title: "", reflection: "", url: "15", saint: "Saint Leopold Mandic : 05/12", saintURL: "https://www.franciscanmedia.org/saint-leopold-mandic/", saintDate: "12-05"),


                             "13-05" : Days(title: "", reflection: "", url: "16", saint: "Our Lady of Fatima : 05/13", saintURL: "https://www.franciscanmedia.org/our-lady-of-fatima/", saintDate: "13-05"),


                             "14-05" : Days(title: "", reflection: "", url: "17", saint: "Saint Matthias : 05/14", saintURL: "https://www.franciscanmedia.org/saint-matthias/", saintDate: "14-05"),


                             "15-05" : Days(title: "", reflection: "", url: "18", saint: "Saint Isidore the Farmer : 05/15", saintURL: "https://www.franciscanmedia.org/saint-isidore-the-farmer/", saintDate: "15-05"),


                             "16-05" : Days(title: "", reflection: "", url: "19", saint: "Saint Margaret of Cortona : 05/16", saintURL: "https://www.franciscanmedia.org/saint-margaret-of-cortona/", saintDate: "16-05"),


                             "17-05" : Days(title: "", reflection: "", url: "20", saint: "Saint Paschal Baylon : 05/17", saintURL: "https://www.franciscanmedia.org/saint-paschal-baylon/", saintDate: "17-05"),


                             "18-05" : Days(title: "", reflection: "", url: "21", saint: "Saint John I : 05/18", saintURL: "https://www.franciscanmedia.org/saint-john-i/", saintDate: "18-05"),


                             "19-05" : Days(title: "", reflection: "", url: "22", saint: "Saint Theophilus of Corte : 05/19", saintURL: "https://www.franciscanmedia.org/saint-theophilus-of-corte/", saintDate: "19-05"),


                             "20-05" : Days(title: "", reflection: "", url: "23", saint: "Saint Bernardine of Siena : 05/20", saintURL: "https://www.franciscanmedia.org/saint-bernardine-of-siena/", saintDate: "20-05"),


                             "21-05" : Days(title: "", reflection: "", url: "24", saint: "Saint Cristóbal Magallanes and Companions : 05/21", saintURL: "https://www.franciscanmedia.org/saint-crisaint-oacute-bal-magallanes-and-companions/", saintDate: "21-05"),


                             "22-05" : Days(title: "", reflection: "", url: "25", saint: "Saint Rita of Cascia : 05/22", saintURL: "https://www.franciscanmedia.org/saint-rita-of-cascia/", saintDate: "22-05"),


                             "23-05" : Days(title: "", reflection: "", url: "26", saint: "Saint Gregory VII : 05/23", saintURL: "https://www.franciscanmedia.org/saint-gregory-vii/", saintDate: "23-05"),


                             "24-05" : Days(title: "", reflection: "", url: "27", saint: "Saint Mary Magdalene de’ Pazzi : 05/24", saintURL: "https://www.franciscanmedia.org/saint-mary-magdalene-de-pazzi/", saintDate: "24-05"),


                             "25-05" : Days(title: "", reflection: "", url: "28", saint: "Saint Bede the Venerable : 05/25", saintURL: "https://www.franciscanmedia.org/saint-bede-the-venerable/", saintDate: "25-05"),


                             "26-05" : Days(title: "", reflection: "", url: "29", saint: "Saint Philip Neri : 05/26", saintURL: "https://www.franciscanmedia.org/saint-philip-neri/", saintDate: "26-05"),


                             "27-05" : Days(title: "", reflection: "", url: "30", saint: "Saint Augustine of Canterbury : 05/27", saintURL: "https://www.franciscanmedia.org/saint-augustine-of-canterbury/", saintDate: "27-05"),


                             "28-05" : Days(title: "", reflection: "", url: "31", saint: "Venerable Pierre Toussaint : 05/28", saintURL: "https://www.franciscanmedia.org/venerable-pierre-toussaint/", saintDate: "28-05"),


                             "29-05" : Days(title: "", reflection: "", url: "32", saint: "Saint Madeleine Sophie Barat : 05/29", saintURL: "https://www.franciscanmedia.org/saint-madeleine-sophie-barat/", saintDate: "29-05"),


                             "30-05" : Days(title: "", reflection: "", url: "33", saint: "Saint Joan of Arc : 05/30", saintURL: "https://www.franciscanmedia.org/saint-joan-of-arc/", saintDate: "30-05"),


                             "31-05" : Days(title: "", reflection: "", url: "34", saint: "Visitation of the Blessed Virgin Mary : 05/31", saintURL: "https://www.franciscanmedia.org/visitation/", saintDate: "31-05"),






                             "01-06" : Days(title: "", reflection: "", url: "35", saint: "Saint Justin Martyr : 06/01", saintURL: "https://www.franciscanmedia.org/saint-justin/", saintDate: "01-06"),


                             "02-06" : Days(title: "", reflection: "", url: "36", saint: "Saints Marcellinus and Peter : 06/02", saintURL: "https://www.franciscanmedia.org/saints-marcellinus-and-peter/", saintDate: "02-06"),


                             "03-06" : Days(title: "", reflection: "", url: "37", saint: "Saint Charles Lwanga and Companions : 06/03", saintURL: "https://www.franciscanmedia.org/saints-charles-lwanga-and-companions/", saintDate: "03-06"),


                             "04-06" : Days(title: "", reflection: "", url: "38", saint: "Blessed Angeline of Marsciano : 06/04", saintURL: "https://www.franciscanmedia.org/blessed-angeline-of-marsciano/", saintDate: "04-06"),


                             "05-06" : Days(title: "", reflection: "", url: "39", saint: "Saint Boniface : 06/05", saintURL: "https://www.franciscanmedia.org/saint-boniface/", saintDate: "05-06"),


                             "06-06" : Days(title: "Pope John Paul and Sister Lucia", reflection: "The institution of nuns and sisters, who devote themselves in various religious orders to the practice of a life of perfection, dates from the first ages of the Church, and women may claim with a certain pride that they were the first to embrace the religious state for its own sake, without regard to missionary work and ecclesiastical functions proper to men.\n\nTake a moment to reflect upon any experiences you may have had with a sister or nun.  Maybe you have at one time discerned the vocation of sisterhood. Take a moment to pray, pray for your own vocation and that of others, God is always listening.", url: "40", saint: "Saint Norbert : 06/06", saintURL: "https://www.franciscanmedia.org/saint-norbert/", saintDate: "06-06"),


                             "07-06" : Days(title: "Our Lady of Fatima Pope John Paul II pictured here thanking the virgin for her intervention when he was shot (the bullet was added to her crown.", reflection: "Saint Pope John Paul II had a very close relationship with the Blessed Mother. He was convinced that Mary, in the form of Our Lady of Fatima, had personally redirected the bullet that hit him, saving his life. \n\nTake a moment to reflect upon what impact the Blessed Mother has had in your life and pray on what you can do to become closer to her.", url: "41", saint: "Blessed Franz Jägerstätter : 06/07", saintURL: "https://www.franciscanmedia.org/blessed-franz-jagerstatter/", saintDate: "07-06"),


                             "08-06" : Days(title: "Pope John Paul II and Cardinal Ratzinger.", reflection: "Pope Emeritus Benedict XVI, then Cardinal Joseph Ratzinger, was John Paul’s chief doctrinal officer for nearly a quarter of a century, and presided at John Paul’s funeral in 2005.\n\nPope Emeritus Benedict once said, \"True friends challenge us and help us to be faithful on our journey.\"\n\nTake a moment and reflect on a good friend of yours who has challenged you and lifted you toward Jesus.  Maybe take some time to pray for him or her and give thanks to God for putting them in your life.", url: "42", saint: "Saint William of York : 06/08", saintURL: "https://www.franciscanmedia.org/saint-william-of-york/", saintDate: "08-06"),


                             "09-06" : Days(title: "", reflection: "", url: "43", saint: "Saint Ephrem : 06/09", saintURL: "https://www.franciscanmedia.org/saint-ephrem/", saintDate: "09-06"),


                             "10-06" : Days(title: "", reflection: "", url: "44", saint: "Blessed Joachima : 06/10", saintURL: "https://www.franciscanmedia.org/blessed-joachima/", saintDate: "10-06"),


                             "11-06" : Days(title: "", reflection: "", url: "45", saint: "Saint Barnabas : 06/11", saintURL: "https://www.franciscanmedia.org/saint-barnabas/", saintDate: "11-06"),


                             "12-06" : Days(title: "", reflection: "", url: "46", saint: "Blessed Jolenta (Yolanda) of Poland : 06/12", saintURL: "https://www.franciscanmedia.org/blessed-jolenta-yolanda-of-poland/", saintDate: "12-06"),


                             "13-06" : Days(title: "", reflection: "", url: "47", saint: "Saint Anthony of Padua : 06/13", saintURL: "https://www.franciscanmedia.org/saint-anthony-of-padua/", saintDate: "13-06"),


                             "14-06" : Days(title: "", reflection: "", url: "48", saint: "Saint Albert Chmielowski : 06/14", saintURL: "https://www.franciscanmedia.org/saint-albert-chmielowski/", saintDate: "14-06"),


                             "15-06" : Days(title: "", reflection: "", url: "49", saint: "Saint Marguerite d’Youville : 06/15", saintURL: "https://www.franciscanmedia.org/saint-marguerite-d-youville/", saintDate: "15-06"),


                             "16-06" : Days(title: "", reflection: "", url: "50", saint: "Saint John Francis Regis : 06/16", saintURL: "https://www.franciscanmedia.org/saint-john-francis-regis/", saintDate: "16-06"),


                             "17-06" : Days(title: "", reflection: "", url: "51", saint: "Saint Joseph Cafasso : 06/17", saintURL: "https://www.franciscanmedia.org/saint-joseph-cafasso/", saintDate: "17-06"),


                             "18-06" : Days(title: "", reflection: "", url: "52", saint: "Venerable Matt Talbot : 06/18", saintURL: "https://www.franciscanmedia.org/venerable-matt-talbot/", saintDate: "18-06"),


                             "19-06" : Days(title: "", reflection: "", url: "53", saint: "Saint Romuald : 06/19", saintURL: "https://www.franciscanmedia.org/saint-romuald/", saintDate: "19-06"),


                             "20-06" : Days(title: "", reflection: "", url: "54", saint: "Saint Paulinus of Nola : 06/20", saintURL: "https://www.franciscanmedia.org/saint-paulinus-of-nola/", saintDate: "20-06"),


                             "21-06" : Days(title: "", reflection: "", url: "55", saint: "Saint Aloysius Gonzaga : 06/21", saintURL: "https://www.franciscanmedia.org/saint-aloysius-gonzaga/", saintDate: "21-06"),


                             "22-06" : Days(title: "", reflection: "", url: "56", saint: "Saint Thomas More : 06/22", saintURL: "https://www.franciscanmedia.org/saint-thomas-more/", saintDate: "22-06"),


                             "23-06" : Days(title: "", reflection: "", url: "57", saint: "Saint John Fisher : 06/23", saintURL: "https://www.franciscanmedia.org/saint-john-fisher/", saintDate: "23-06"),


                             "24-06" : Days(title: "", reflection: "", url: "58", saint: "Nativity of Saint John the Baptist : 06/24", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-nativity-of-saint-john-the-baptist/", saintDate: "24-06"),


                             "25-06" : Days(title: "", reflection: "", url: "59", saint: "Blessed Jutta of Thuringia : 06/25", saintURL: "https://www.franciscanmedia.org/blessed-jutta-of-thuringia/", saintDate: "25-06"),


                             "26-06" : Days(title: "", reflection: "", url: "60", saint: "Blessed Raymond Lull : 06/26", saintURL: "https://www.franciscanmedia.org/blessed-raymond-lull/", saintDate: "26-06"),


                             "27-06" : Days(title: "", reflection: "", url: "61", saint: "Saint Cyril of Alexandria : 06/27", saintURL: "https://www.franciscanmedia.org/saint-cyril-of-alexandria/", saintDate: "27-06"),


                             "28-06" : Days(title: "", reflection: "", url: "62", saint: "Saint Irenaeus : 06/28", saintURL: "https://www.franciscanmedia.org/saint-irenaeus/", saintDate: "28-06"),


                             "29-06" : Days(title: "", reflection: "", url: "63", saint: "Solemnity of Saints Peter and Paul : 06/29", saintURL: "https://www.franciscanmedia.org/solemnity-of-saints-peter-and-paul/", saintDate: "29-06"),


                             "30-06" : Days(title: "", reflection: "", url: "64", saint: "First Martyrs of the Church of Rome : 06/30", saintURL: "https://www.franciscanmedia.org/firsaint-martyrs-of-the-church-of-rome/", saintDate: "30-06"),


                             "31-06" : Days(title: "", reflection: "", url: "65", saint: "", saintURL: "", saintDate: "31-06"),






                             "01-07" : Days(title: "", reflection: "", url: "", saint: "Saint Junipero Serra : 07/01", saintURL: "https://www.franciscanmedia.org/saint-junipero-serra/", saintDate: "01-07"),


                             "02-07" : Days(title: "", reflection: "", url: "", saint: "Saint Oliver Plunkett : 07/02", saintURL: "https://www.franciscanmedia.org/saint-oliver-plunkett/", saintDate: "02-07"),


                             "03-07" : Days(title: "", reflection: "", url: "", saint: "Saint Thomas the Apostle : 07/03", saintURL: "https://www.franciscanmedia.org/saint-thomas-the-apostle/", saintDate: "03-07"),


                             "04-07" : Days(title: "", reflection: "", url: "", saint: "Saint Elizabeth of Portugal : 07/04", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-of-portugal/", saintDate: "04-07"),


                             "05-07" : Days(title: "", reflection: "", url: "", saint: "Saint Anthony Zaccaria : 07/05", saintURL: "https://www.franciscanmedia.org/saint-anthony-zaccaria/", saintDate: "05-07"),


                             "06-07" : Days(title: "", reflection: "", url: "", saint: "Saint Maria Goretti : 07/06", saintURL: "https://www.franciscanmedia.org/saint-maria-goretti/", saintDate: "06-07"),


                             "07-07" : Days(title: "", reflection: "", url: "", saint: "Blessed Emmanuel Ruiz and Companions : 07/07", saintURL: "https://www.franciscanmedia.org/blessed-emmanuel-ruiz-and-companions/", saintDate: "07-07"),


                             "08-07" : Days(title: "", reflection: "", url: "", saint: "Saint Gregory Grassi and Companions : 07/08", saintURL: "https://www.franciscanmedia.org/saint-gregory-grassi-and-companions/", saintDate: "08-07"),


                             "09-07" : Days(title: "", reflection: "", url: "", saint: "Saint Augustine Zhao Rong and Companions : 07/09", saintURL: "https://www.franciscanmedia.org/saint-augustine-zhao-rong-and-companions/", saintDate: "09-07"),


                             "10-07" : Days(title: "", reflection: "", url: "", saint: "Saint Veronica Giuliani : 07/10", saintURL: "https://www.franciscanmedia.org/saint-veronica-giuliani/", saintDate: "10-07"),


                             "11-07" : Days(title: "", reflection: "", url: "", saint: "Saint Benedict : 07/11", saintURL: "https://www.franciscanmedia.org/saint-benedict/", saintDate: "11-07"),


                             "12-07" : Days(title: "", reflection: "", url: "", saint: "Saints John Jones and John Wall : 07/12", saintURL: "https://www.franciscanmedia.org/saints-john-jones-and-john-wall/", saintDate: "12-07"),


                             "13-07" : Days(title: "", reflection: "", url: "", saint: "Saint Henry : 07/13", saintURL: "https://www.franciscanmedia.org/saint-henry/", saintDate: "13-07"),


                             "14-07" : Days(title: "", reflection: "", url: "", saint: "Saint Kateri Tekakwitha : 07/14", saintURL: "https://www.franciscanmedia.org/saint-kateri-tekakwitha/", saintDate: "14-07"),


                             "15-07" : Days(title: "", reflection: "", url: "", saint: "Saint Bonaventure : 07/15", saintURL: "https://www.franciscanmedia.org/saint-bonaventure/", saintDate: "15-07"),


                             "16-07" : Days(title: "", reflection: "", url: "", saint: "Our Lady of Mount Carmel : 07/16", saintURL: "https://www.franciscanmedia.org/our-lady-of-mount-carmel/", saintDate: "16-07"),


                             "17-07" : Days(title: "", reflection: "", url: "", saint: "Saint Francis Solano : 07/17", saintURL: "https://www.franciscanmedia.org/saint-francis-solano/", saintDate: "17-07"),


                             "18-07" : Days(title: "", reflection: "", url: "", saint: "Saint Camillus de Lellis : 07/18", saintURL: "https://www.franciscanmedia.org/saint-camillus-de-lellis/", saintDate: "18-07"),


                             "19-07" : Days(title: "", reflection: "", url: "", saint: "Saint Mary MacKillop : 07/19", saintURL: "https://www.franciscanmedia.org/saint-mary-mackillop/", saintDate: "19-07"),


                             "20-07" : Days(title: "", reflection: "", url: "", saint: "Saint Apollinaris : 07/20", saintURL: "https://www.franciscanmedia.org/saint-apollinaris/", saintDate: "20-07"),


                             "21-07" : Days(title: "", reflection: "", url: "", saint: "Saint Lawrence of Brindisi : 07/21", saintURL: "https://www.franciscanmedia.org/saint-lawrence-of-brindisi/", saintDate: "21-07"),


                             "22-07" : Days(title: "", reflection: "", url: "", saint: "Saint Mary Magdalene : 07/22", saintURL: "https://www.franciscanmedia.org/saint-mary-magdalene/", saintDate: "22-07"),


                             "23-07" : Days(title: "", reflection: "", url: "", saint: "Saint Bridget of Sweden : 07/23", saintURL: "https://www.franciscanmedia.org/saint-bridget/", saintDate: "23-07"),


                             "24-07" : Days(title: "", reflection: "", url: "", saint: "Saint Sharbel Makhluf : 07/24", saintURL: "https://www.franciscanmedia.org/saint-sharbel-makhluf/", saintDate: "24-07"),


                             "25-07" : Days(title: "", reflection: "", url: "", saint: "Saint James the Apostle : 07/25", saintURL: "https://www.franciscanmedia.org/saint-james/", saintDate: "25-07"),


                             "26-07" : Days(title: "", reflection: "", url: "", saint: "Saints Joachim and Anne : 07/26", saintURL: "https://www.franciscanmedia.org/saints-joachim-and-anne/", saintDate: "26-07"),


                             "27-07" : Days(title: "", reflection: "", url: "", saint: "Blessed Antonio Lucci : 07/27", saintURL: "https://www.franciscanmedia.org/blessed-antonio-lucci/", saintDate: "27-07"),


                             "28-07" : Days(title: "", reflection: "", url: "", saint: "Blessed Stanley Rother : 07/28", saintURL: "https://www.franciscanmedia.org/blessed-stanley-rother/", saintDate: "28-07"),


                             "29-07" : Days(title: "", reflection: "", url: "", saint: "Saint Martha : 07/29", saintURL: "https://www.franciscanmedia.org/saint-martha/", saintDate: "29-07"),


                             "30-07" : Days(title: "", reflection: "", url: "", saint: "Blessed Solanus Casey : 07/30", saintURL: "https://www.franciscanmedia.org/venerable-solanus-casey/", saintDate: "30-07"),


                             "31-07" : Days(title: "", reflection: "", url: "", saint: "Saint Ignatius of Loyola : 07/31", saintURL: "https://www.franciscanmedia.org/saint-ignatius-of-loyola/", saintDate: "31-07"),





                             "01-08" : Days(title: "", reflection: "", url: "", saint: "Saint Alphonsus Liguori : 08/01", saintURL: "https://www.franciscanmedia.org/saint-alphonsus-liguori/", saintDate: "01-08"),


                             "02-08" : Days(title: "", reflection: "", url: "", saint: "Saint Eusebius of Vercelli : 08/02", saintURL: "https://www.franciscanmedia.org/saint-eusebius-of-vercelli/", saintDate: "02-08"),


                             "03-08" : Days(title: "", reflection: "", url: "", saint: "Saint Peter Julian Eymard : 08/03", saintURL: "https://www.franciscanmedia.org/saint-peter-julian-eymard/", saintDate: "03-08"),


                             "04-08" : Days(title: "", reflection: "", url: "", saint: "Saint John Vianney : 08/04", saintURL: "https://www.franciscanmedia.org/saint-john-vianney/", saintDate: "04-08"),


                             "05-08" : Days(title: "", reflection: "", url: "", saint: "Dedication of Saint Mary Major Basilica : 08/05", saintURL: "https://www.franciscanmedia.org/dedication-of-saint-mary-major-basilica/", saintDate: "05-08"),


                             "06-08" : Days(title: "", reflection: "", url: "", saint: "Transfiguration of the Lord : 08/06", saintURL: "https://www.franciscanmedia.org/transfiguration-of-the-lord/", saintDate: "06-08"),


                             "07-08" : Days(title: "", reflection: "", url: "", saint: "Saint Cajetan : 08/07", saintURL: "https://www.franciscanmedia.org/saint-cajetan/", saintDate: "07-08"),


                             "08-08" : Days(title: "", reflection: "", url: "", saint: "Saint Dominic : 08/08", saintURL: "https://www.franciscanmedia.org/saint-dominic/", saintDate: "08-08"),


                             "09-08" : Days(title: "", reflection: "", url: "", saint: "Saint Teresa Benedicta of the Cross : 08/09", saintURL: "https://www.franciscanmedia.org/saint-teresa-benedicta-of-the-cross-edith-stein/", saintDate: "09-08"),


                             "10-08" : Days(title: "", reflection: "", url: "", saint: "Saint Lawrence : 08/10", saintURL: "https://www.franciscanmedia.org/saint-lawrence/", saintDate: "10-08"),


                             "11-08" : Days(title: "", reflection: "", url: "", saint: "Saint Clare of Assisi : 08/11", saintURL: "https://www.franciscanmedia.org/saint-clare-of-assisi/", saintDate: "11-08"),


                             "12-08" : Days(title: "", reflection: "", url: "", saint: "Saint Jane Frances de Chantal : 08/12", saintURL: "https://www.franciscanmedia.org/saint-jane-frances-de-chantal/", saintDate: "12-08"),


                             "13-08" : Days(title: "", reflection: "", url: "", saint: "Saints Pontian and Hippolytus : 08/13", saintURL: "https://www.franciscanmedia.org/saints-pontian-and-hippolytus/", saintDate: "13-08"),


                             "14-08" : Days(title: "", reflection: "", url: "", saint: "Saint Maximilian Mary Kolbe : 08/14", saintURL: "https://www.franciscanmedia.org/saint-maximilian-mary-kolbe/", saintDate: "14-08"),


                             "15-08" : Days(title: "", reflection: "", url: "", saint: "Solemnity of the Assumption of Mary : 08/15", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-assumption-of-mary/", saintDate: "15-08"),


                             "16-08" : Days(title: "", reflection: "", url: "", saint: "Saint Stephen of Hungary : 08/16", saintURL: "https://www.franciscanmedia.org/saint-stephen-of-hungary/", saintDate: "16-08"),


                             "17-08" : Days(title: "", reflection: "", url: "", saint: "Saint Joan of the Cross : 08/17", saintURL: "https://www.franciscanmedia.org/saint-joan-of-the-cross/", saintDate: "17-08"),


                             "18-08" : Days(title: "", reflection: "", url: "", saint: "Saint Louis of Toulouse : 08/18", saintURL: "https://www.franciscanmedia.org/saint-louis-of-toulouse/", saintDate: "18-08"),


                             "19-08" : Days(title: "", reflection: "", url: "", saint: "Saint John Eudes : 08/19", saintURL: "https://www.franciscanmedia.org/saint-john-eudes/", saintDate: "19-08"),


                             "20-08" : Days(title: "", reflection: "", url: "", saint: "Saint Bernard of Clairvaux : 08/20", saintURL: "https://www.franciscanmedia.org/saint-bernard-of-clairvaux/", saintDate: "20-08"),


                             "21-08" : Days(title: "", reflection: "", url: "", saint: "Saint Pius X : 08/21", saintURL: "https://www.franciscanmedia.org/saint-pius-x/", saintDate: "21-08"),


                             "22-08" : Days(title: "", reflection: "", url: "", saint: "Queenship of Mary : 08/22", saintURL: "https://www.franciscanmedia.org/queenship-of-mary/", saintDate: "22-08"),


                             "23-08" : Days(title: "", reflection: "", url: "", saint: "Saint Rose of Lima : 08/23", saintURL: "https://www.franciscanmedia.org/saint-rose-of-lima/", saintDate: "23-08"),


                             "24-08" : Days(title: "", reflection: "", url: "", saint: "Saint Bartholomew : 08/24", saintURL: "https://www.franciscanmedia.org/saint-bartholomew/", saintDate: "24-08"),


                             "25-08" : Days(title: "", reflection: "", url: "", saint: "Saint Louis of France : 08/25", saintURL: "https://www.franciscanmedia.org/saint-louis-of-france/", saintDate: "25-08"),


                             "26-08" : Days(title: "", reflection: "", url: "", saint: "Saint Joseph Calasanz : 08/26", saintURL: "https://www.franciscanmedia.org/saint-joseph-calasanz/", saintDate: "26-08"),


                             "27-08" : Days(title: "", reflection: "", url: "", saint: "Saint Monica : 08/27", saintURL: "https://www.franciscanmedia.org/saint-monica/", saintDate: "27-08"),


                             "28-08" : Days(title: "", reflection: "", url: "", saint: "Saint Augustine of Hippo : 08/28", saintURL: "https://www.franciscanmedia.org/saint-augustine-of-hippo/", saintDate: "28-08"),


                             "29-08" : Days(title: "", reflection: "", url: "", saint: "Martyrdom of John the Baptist : 08/29", saintURL: "https://www.franciscanmedia.org/martyrdom-of-john-the-baptist/", saintDate: "29-08"),


                             "30-08" : Days(title: "", reflection: "", url: "", saint: "Saint Jeanne Jugan : 08/30", saintURL: "https://www.franciscanmedia.org/saint-jeanne-jugan/", saintDate: "30-08"),


                             "31-08" : Days(title: "", reflection: "", url: "", saint: "Saints Joseph of Arimathea and Nicodemus : 08/31", saintURL: "https://www.franciscanmedia.org/saints-joseph-of-arimathea-and-nicodemus/", saintDate: "31-08"),




                             "01-09" : Days(title: "", reflection: "", url: "", saint: "Saint Giles: 09/01", saintURL: "https://www.franciscanmedia.org/saint-giles/", saintDate: "01-09"),


                             "02-09" : Days(title: "", reflection: "", url: "", saint: "Blessed John Francis Burté and Companions: 09/02", saintURL: "https://www.franciscanmedia.org/blessed-john-francis-burt-eacute-and-companions/", saintDate: "02-09"),


                             "03-09" : Days(title: "", reflection: "", url: "", saint: "Saint Gregory the Great: 09/03", saintURL: "https://www.franciscanmedia.org/saint-gregory-the-great/", saintDate: "03-09"),


                             "04-09" : Days(title: "", reflection: "", url: "", saint: "Saint Rose of Viterbo: 09/04", saintURL: "https://www.franciscanmedia.org/saint-rose-of-viterbo/", saintDate: "04-09"),


                             "05-09" : Days(title: "", reflection: "", url: "", saint: "Saint Teresa of Calcutta: 09/05", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-calcutta/", saintDate: "05-09"),


                             "06-09" : Days(title: "", reflection: "", url: "", saint: "Blessed Claudio Granzotto: 09/06", saintURL: "https://www.franciscanmedia.org/blessed-claudio-granzotto/", saintDate: "06-09"),


                             "07-09" : Days(title: "", reflection: "", url: "", saint: "Blessed Frédéric Ozanam: 09/07", saintURL: "https://www.franciscanmedia.org/blessed-fr-d-ric-ozanam/", saintDate: "07-09"),


                             "08-09" : Days(title: "", reflection: "", url: "", saint: "Nativity of the Blessed Virgin Mary: 09/08", saintURL: "https://www.franciscanmedia.org/nativity-of-the-blessed-virgin-mary/", saintDate: "08-09"),


                             "09-09" : Days(title: "", reflection: "", url: "", saint: "Saint Peter Claver: 09/09", saintURL: "https://www.franciscanmedia.org/saint-peter-claver/", saintDate: "09-09"),


                             "10-09" : Days(title: "", reflection: "", url: "", saint: "Saint Thomas of Villanova: 09/10", saintURL: "https://www.franciscanmedia.org/saint-thomas-of-villanova/", saintDate: "10-09"),


                             "11-09" : Days(title: "", reflection: "", url: "", saint: "Saint Cyprian: 09/11", saintURL: "https://www.franciscanmedia.org/saint-cyprian/", saintDate: "11-09"),


                             "12-09" : Days(title: "", reflection: "", url: "", saint: "Most Holy Name of the Blessed Virgin Mary: 09/12", saintURL: "https://www.franciscanmedia.org/mosaint-holy-name-of-the-blessed-virgin-mary/", saintDate: "12-09"),


                             "13-09" : Days(title: "", reflection: "", url: "", saint: "Saint John Chrysostom: 09/13", saintURL: "https://www.franciscanmedia.org/saint-john-chrysostom/", saintDate: "13-09"),


                             "14-09" : Days(title: "", reflection: "", url: "", saint: "Exaltation of the Holy Cross: 09/14", saintURL: "https://www.franciscanmedia.org/exaltation-of-the-holy-cross/", saintDate: "14-09"),


                             "15-09" : Days(title: "", reflection: "", url: "", saint: "Our Lady of Sorrows: 09/15", saintURL: "https://www.franciscanmedia.org/our-lady-of-sorrows/", saintDate: "15-09"),


                             "16-09" : Days(title: "", reflection: "", url: "", saint: "Saint Cornelius: 09/16", saintURL: "https://www.franciscanmedia.org/saint-cornelius/", saintDate: "16-09"),


                             "17-09" : Days(title: "", reflection: "", url: "", saint: "Saint Robert Bellarmine: 09/17", saintURL: "https://www.franciscanmedia.org/saint-robert-bellarmine/", saintDate: "17-09"),


                             "18-09" : Days(title: "", reflection: "", url: "", saint: "Saint Joseph of Cupertino: 09/18", saintURL: "https://www.franciscanmedia.org/saint-joseph-of-cupertino/", saintDate: "18-09"),


                             "19-09" : Days(title: "", reflection: "", url: "", saint: "Saint Januarius: 09/19", saintURL: "https://www.franciscanmedia.org/saint-januarius/", saintDate: "19-09"),


                             "20-09" : Days(title: "", reflection: "", url: "", saint: "Saints Andrew Kim Taegon, Paul Chong Hasang, and Companions: 09/20", saintURL: "https://www.franciscanmedia.org/saints-andrew-kim-taegon-paul-chong-hasang-and-companions/", saintDate: "20-09"),


                             "21-09" : Days(title: "", reflection: "", url: "", saint: "Saint Matthew: 09/21", saintURL: "https://www.franciscanmedia.org/saint-matthew/", saintDate: "21-09"),


                             "22-09" : Days(title: "", reflection: "", url: "", saint: "Saint Lorenzo Ruiz and Companions: 09/22", saintURL: "https://www.franciscanmedia.org/saint-lorenzo-ruiz-and-companions/", saintDate: "22-09"),


                             "23-09" : Days(title: "", reflection: "", url: "", saint: "Saint Pio of Pietrelcina: 09/23", saintURL: "https://www.franciscanmedia.org/saint-pio-of-pietrelcina/", saintDate: "23-09"),


                             "24-09" : Days(title: "", reflection: "", url: "", saint: "Saint John Henry Newman: 09/24", saintURL: "https://www.franciscanmedia.org/blessed-john-henry-newman/", saintDate: "24-09"),


                             "25-09" : Days(title: "", reflection: "", url: "", saint: "Saints Louis Martin and Zélie Guerin: 09/25", saintURL: "https://www.franciscanmedia.org/blesseds-louis-martin-and-zelie-guerin/", saintDate: "25-09"),


                             "26-09" : Days(title: "", reflection: "", url: "", saint: "Saint Paul VIL 09/26", saintURL: "https://www.franciscanmedia.org/saint-paul-vi/", saintDate: "26-09"),


                             "27-09" : Days(title: "", reflection: "", url: "", saint: "Saint Vincent de Paul: 09/27", saintURL: "https://www.franciscanmedia.org/saint-vincent-de-paul/", saintDate: "27-09"),


                             "28-09" : Days(title: "", reflection: "", url: "", saint: "Saint Wenceslaus: 09/28", saintURL: "https://www.franciscanmedia.org/saint-wenceslaus/", saintDate: "28-09"),


                             "29-09" : Days(title: "", reflection: "", url: "", saint: "Saints Michael, Gabriel, and Raphael: 09/29", saintURL: "https://www.franciscanmedia.org/saints-michael-gabriel-and-raphael/", saintDate: "29-09"),


                             "30-09" : Days(title: "", reflection: "", url: "", saint: "Saint Jerome: 09/30", saintURL: "https://www.franciscanmedia.org/saint-jerome/", saintDate: "30-09"),


                             "31-09" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-09"),





                             "01-10" : Days(title: "", reflection: "", url: "", saint: "Saint Thérèse of Lisieux: 10/01", saintURL: "https://www.franciscanmedia.org/saint-theresa-of-the-child-jesus/", saintDate: "01-10"),


                             "02-10" : Days(title: "", reflection: "", url: "", saint: "Feast of the Guardian Angels: 10/02", saintURL: "https://www.franciscanmedia.org/feasaint-of-the-guardian-angels/", saintDate: "02-10"),


                             "03-10" : Days(title: "", reflection: "", url: "", saint: "Saint Theodora Guérin: 10/03", saintURL: "https://www.franciscanmedia.org/saint-theodora-gu-eacute-rin/", saintDate: "03-10"),


                             "04-10" : Days(title: "", reflection: "", url: "", saint: "Saint Francis of Assisi: 10/04", saintURL: "https://www.franciscanmedia.org/saint-francis-of-assisi/", saintDate: "04-10"),


                             "05-10" : Days(title: "", reflection: "", url: "", saint: "Saint Maria Faustina Kowalska: 10/05", saintURL: "https://www.franciscanmedia.org/saint-maria-faustina-kowalska/", saintDate: "05-10"),


                             "06-10" : Days(title: "", reflection: "", url: "", saint: "Saint Bruno: 10/06", saintURL: "https://www.franciscanmedia.org/saint-bruno/", saintDate: "06-10"),


                             "07-10" : Days(title: "", reflection: "", url: "", saint: "Our Lady of the Rosary: 10/07", saintURL: "https://www.franciscanmedia.org/our-lady-of-the-rosary/", saintDate: "07-10"),


                             "08-10" : Days(title: "", reflection: "", url: "", saint: "Saint John Leonardi: 10/08", saintURL: "https://www.franciscanmedia.org/saint-john-leonardi/", saintDate: "08-10"),


                             "09-10" : Days(title: "", reflection: "", url: "", saint: "Saint Denis and Companions: 10/09", saintURL: "https://www.franciscanmedia.org/saint-denis-and-companions/", saintDate: "09-10"),


                             "10-10" : Days(title: "", reflection: "", url: "", saint: "Saint Francis Borgia: 10/10", saintURL: "https://www.franciscanmedia.org/saint-francis-borgia/", saintDate: "10-10"),


                             "11-10" : Days(title: "", reflection: "", url: "", saint: "Saint John XXIII: 10/11", saintURL: "https://www.franciscanmedia.org/saint-john-xxiii/", saintDate: "11-10"),


                             "12-10" : Days(title: "", reflection: "", url: "", saint: "Blessed Francis Xavier Seelos: 10/12", saintURL: "https://www.franciscanmedia.org/blessed-francis-xavier-seelos/", saintDate: "12-10"),


                             "13-10" : Days(title: "", reflection: "", url: "", saint: "Blessed Marie-Rose Durocher: 10/13", saintURL: "https://www.franciscanmedia.org/blessed-marie-rose-durocher/", saintDate: "13-10"),


                             "14-10" : Days(title: "", reflection: "", url: "", saint: "Saint Callistus I: 10/14", saintURL: "https://www.franciscanmedia.org/saint-callistus-i/", saintDate: "14-10"),


                             "15-10" : Days(title: "", reflection: "", url: "", saint: "Saint Teresa of Avila: 10/15", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-avila/", saintDate: "15-10"),


                             "16-10" : Days(title: "", reflection: "", url: "", saint: "Saint Margaret Mary Alacoque: 10/16", saintURL: "https://www.franciscanmedia.org/saint-margaret-mary-alacoque/", saintDate: "16-10"),


                             "17-10" : Days(title: "", reflection: "", url: "", saint: "Saint Ignatius of Antioch: 10/17", saintURL: "https://www.franciscanmedia.org/saint-ignatius-of-antioch/", saintDate: "17-10"),


                             "18-10" : Days(title: "", reflection: "", url: "", saint: "Saint Luke: 10/18", saintURL: "https://www.franciscanmedia.org/saint-luke/", saintDate: "18-10"),


                             "19-10" : Days(title: "", reflection: "", url: "", saint: "Saints Isaac Jogues, Jean de Brébeuf, and Companions: 10/19", saintURL: "https://www.franciscanmedia.org/saint-isaac-jogues-jean-de-br-eacute-beuf-and-companions/", saintDate: "19-10"),


                             "20-10" : Days(title: "", reflection: "", url: "", saint: "Saint Paul of the Cross: 10/20", saintURL: "https://www.franciscanmedia.org/saint-paul-of-the-cross/", saintDate: "20-10"),


                             "21-10" : Days(title: "", reflection: "", url: "", saint: "Saint Hilarion: 10/21", saintURL: "https://www.franciscanmedia.org/saint-hilarion/", saintDate: "21-10"),


                             "22-10" : Days(title: "", reflection: "", url: "", saint: "Saint John Paul II: 10/22", saintURL: "https://www.franciscanmedia.org/saint-john-paul-ii/", saintDate: "22-10"),


                             "23-10" : Days(title: "", reflection: "", url: "", saint: "Saint John of Capistrano: 10/23", saintURL: "https://www.franciscanmedia.org/saint-john-of-capistrano/", saintDate: "23-10"),


                             "24-10" : Days(title: "", reflection: "", url: "", saint: "Saint Anthony Mary Claret: 10/24", saintURL: "https://www.franciscanmedia.org/saint-anthony-claret/", saintDate: "24-10"),


                             "25-10" : Days(title: "", reflection: "", url: "", saint: "Saint Antônio de Sant’Anna Galvão: 10/25", saintURL: "https://www.franciscanmedia.org/saint-ant-ocirc-nio-de-sant-146-anna-galv-atilde-o/", saintDate: "25-10"),


                             "26-10" : Days(title: "", reflection: "", url: "", saint: "Saint Peter of Alcantara: 10/26", saintURL: "https://www.franciscanmedia.org/saint-peter-of-alcantara/", saintDate: "26-10"),


                             "27-10" : Days(title: "", reflection: "", url: "", saint: "Blessed Bartholomew of Vicenza: 10/27", saintURL: "https://www.franciscanmedia.org/blessed-bartholomew-of-vicenza/", saintDate: "27-10"),


                             "28-10" : Days(title: "", reflection: "", url: "", saint: "Saints Simon and Jude: 10/28", saintURL: "https://www.franciscanmedia.org/saints-simon-and-jude/", saintDate: "28-10"),


                             "29-10" : Days(title: "", reflection: "", url: "", saint: "Saint Narcissus of Jerusalem: 10/29", saintURL: "https://www.franciscanmedia.org/saint-narcissus-of-jerusalem/", saintDate: "29-10"),


                             "30-10" : Days(title: "", reflection: "", url: "", saint: "Saint Alphonsus Rodriguez: 10/30", saintURL: "https://www.franciscanmedia.org/saint-alphonsus-rodriguez/", saintDate: "30-10"),


                             "31-10" : Days(title: "", reflection: "", url: "", saint: "Saint Wolfgang of Regensburg: 10/31", saintURL: "https://www.franciscanmedia.org/saint-wolfgang-of-regensburg/", saintDate: "31-10"),





                             "01-11" : Days(title: "", reflection: "", url: "", saint: "Solemnity of All Saints: 11/01", saintURL: "https://www.franciscanmedia.org/solemnity-of-all-saints/", saintDate: "01-11"),


                             "02-11" : Days(title: "", reflection: "", url: "", saint: "Commemoration of All the Faithful Departed: 11/02", saintURL: "https://www.franciscanmedia.org/commemoration-of-all-the-faithful-departed/", saintDate: "02-11"),


                             "03-11" : Days(title: "", reflection: "", url: "", saint: "Saint Martin de Porres: 11/03", saintURL: "https://www.franciscanmedia.org/saint-martin-de-porres/", saintDate: "03-11"),


                             "04-11" : Days(title: "", reflection: "", url: "", saint: "Saint Charles Borromeo: 11/04", saintURL: "https://www.franciscanmedia.org/saint-charles-borromeo/", saintDate: "04-11"),


                             "05-11" : Days(title: "", reflection: "", url: "", saint: "Saint Peter Chrysologus: 11/05", saintURL: "https://www.franciscanmedia.org/saint-peter-chrysologus/", saintDate: "05-11"),


                             "06-11" : Days(title: "", reflection: "", url: "", saint: "Saint Nicholas Tavelic and Companions: 11/06", saintURL: "https://www.franciscanmedia.org/saint-nicholas-tavelic-and-companions/", saintDate: "06-11"),


                             "07-11" : Days(title: "", reflection: "", url: "", saint: "Saint Didacus: 11/07", saintURL: "https://www.franciscanmedia.org/saint-didacus/", saintDate: "07-11"),


                             "08-11" : Days(title: "", reflection: "", url: "", saint: "Blessed John Duns Scotus: 11/08", saintURL: "https://www.franciscanmedia.org/blessed-john-duns-scotus/", saintDate: "08-11"),


                             "09-11" : Days(title: "", reflection: "", url: "", saint: "Dedication of St. John Lateran: 11/09", saintURL: "https://www.franciscanmedia.org/dedication-of-saint-john-lateran/", saintDate: "09-11"),


                             "10-11" : Days(title: "", reflection: "", url: "", saint: "Saint Leo the Great: 11/10", saintURL: "https://www.franciscanmedia.org/saint-leo-the-great/", saintDate: "10-11"),


                             "11-11" : Days(title: "", reflection: "", url: "", saint: "Saint Martin of Tours: 11/11", saintURL: "https://www.franciscanmedia.org/saint-martin-of-tours/", saintDate: "11-11"),


                             "12-11" : Days(title: "", reflection: "", url: "", saint: "Saint Josaphat: 11/12", saintURL: "https://www.franciscanmedia.org/saint-josaphat/", saintDate: "12-11"),


                             "13-11" : Days(title: "", reflection: "", url: "", saint: "Saint Frances Xavier Cabrini: 11/13", saintURL: "https://www.franciscanmedia.org/saint-frances-xavier-cabrini/", saintDate: "13-11"),


                             "14-11" : Days(title: "", reflection: "", url: "", saint: "Saint Gertrude the Great: 11/14", saintURL: "https://www.franciscanmedia.org/saint-gertrude-the-great/", saintDate: "14-11"),


                             "15-11" : Days(title: "", reflection: "", url: "", saint: "Saint Albert the Great: 11/15", saintURL: "https://www.franciscanmedia.org/saint-albert-the-great/", saintDate: "15-11"),


                             "16-11" : Days(title: "", reflection: "", url: "", saint: "Saint Margaret of Scotland: 11/16", saintURL: "https://www.franciscanmedia.org/saint-margaret-of-scotland/", saintDate: "16-11"),


                             "17-11" : Days(title: "", reflection: "", url: "", saint: "Saint Elizabeth of Hungary: 11/17", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-of-hungary/", saintDate: "17-11"),


                             "18-11" : Days(title: "", reflection: "", url: "", saint: "Dedication of Churches of Saints Peter and Paul: 11/18", saintURL: "https://www.franciscanmedia.org/dedication-of-churches-of-saints-peter-and-paul/", saintDate: "18-11"),


                             "19-11" : Days(title: "", reflection: "", url: "", saint: "Saint Agnes of Assisi: 11/19", saintURL: "https://www.franciscanmedia.org/saint-agnes-of-assisi/", saintDate: "19-11"),


                             "20-11" : Days(title: "", reflection: "", url: "", saint: "Saint Rose Philippine Duchesne: 11/20", saintURL: "https://www.franciscanmedia.org/saint-rose-philippine-duchesne/", saintDate: "20-11"),


                             "21-11" : Days(title: "", reflection: "", url: "", saint: "Presentation of the Blessed Virgin Mary: 11/21", saintURL: "https://www.franciscanmedia.org/presentation-of-mary/", saintDate: "21-11"),


                             "22-11" : Days(title: "", reflection: "", url: "", saint: "Saint Cecilia: 11/22", saintURL: "https://www.franciscanmedia.org/saint-cecilia/", saintDate: "22-11"),


                             "23-11" : Days(title: "", reflection: "", url: "", saint: "Blessed Miguel Agustín Pro: 11/23", saintURL: "https://www.franciscanmedia.org/blessed-miguel-agusaint-iacute-n-pro/", saintDate: "23-11"),


                             "24-11" : Days(title: "", reflection: "", url: "", saint: "Saint Andrew Dung-Lac and Companions: 11/24", saintURL: "https://www.franciscanmedia.org/saint-andrew-dung-lac-and-companions/", saintDate: "24-11"),


                             "25-11" : Days(title: "BRISBANE, AUSTRALIA - NOVEMBER 25: Pope John Paul II holds a koala in his arms during his official visit to Oceania on November 25, 1986 in Brisbane, Australia.", reflection: "Saint Pope John Paul II once said, \"Freedom consists not in doing what we like, but in having the right to do what we ought.\"\n\nThis is a powerful statement that I am sure many of us struggle with.  Let us reflect for a moment on the things we have done in the last week.  How many of these things have been for the benefit of ourselves as opposed to others?", url: "https://i.pinimg.com/564x/bc/4e/cf/bc4ecf6149fd85f5ac3ddf0e87f20cf6.jpg", saint: "Saint Catherine of Alexandria: 11/25", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-alexandria/", saintDate: "25-11"),


                             "26-11" : Days(title: "", reflection: "", url: "", saint: "Saint Columban: 11/26", saintURL: "https://www.franciscanmedia.org/saint-columban/", saintDate: "26-11"),


                             "27-11" : Days(title: "", reflection: "", url: "", saint: "Saint Francesco Antonio Fasani: 11/27", saintURL: "https://www.franciscanmedia.org/saint-francesco-antonio-fasani/", saintDate: "27-11"),


                             "28-11" : Days(title: "", reflection: "", url: "", saint: "Saint James of the Marche: 11/28", saintURL: "https://www.franciscanmedia.org/saint-james-of-the-marche/", saintDate: "28-11"),


                             "29-11" : Days(title: "", reflection: "", url: "", saint: "Saint Clement: 11/29", saintURL: "https://www.franciscanmedia.org/saint-clement/", saintDate: "29-11"),


                             "30-11" : Days(title: "", reflection: "", url: "", saint: "Saint Andrew: 11/30", saintURL: "https://www.franciscanmedia.org/saint-andrew/", saintDate: "30-11"),


                             "31-11" : Days(title: "", reflection: "", url: "", saint: "", saintURL: "", saintDate: "31-11"),





                             "01-12" : Days(title: "", reflection: "", url: "", saint: "Blessed Charles de Foucauld: 12/01", saintURL: "https://www.franciscanmedia.org/blessed-charles-de-foucauld/", saintDate: "01-12"),


                             "02-12" : Days(title: "", reflection: "", url: "", saint: "Blessed Rafal Chylinski: 12/02", saintURL: "https://www.franciscanmedia.org/blessed-rafal-chylinski/", saintDate: "02-12"),


                             "03-12" : Days(title: "", reflection: "", url: "", saint: "Saint Francis Xavier: 12/03", saintURL: "https://www.franciscanmedia.org/saint-francis-xavier/", saintDate: "03-12"),


                             "04-12" : Days(title: "", reflection: "", url: "", saint: "Saint John Damascene: 12/04", saintURL: "https://www.franciscanmedia.org/saint-john-damascene/", saintDate: "04-12"),


                             "05-12" : Days(title: "", reflection: "", url: "", saint: "Saint Sabas: 12/05", saintURL: "https://www.franciscanmedia.org/saint-sabas/", saintDate: "05-12"),


                             "06-12" : Days(title: "", reflection: "", url: "", saint: "Saint Nicholas:12/06", saintURL: "https://www.franciscanmedia.org/saint-nicholas/", saintDate: "06-12"),


                             "07-12" : Days(title: "", reflection: "", url: "", saint: "Saint Ambrose: 12/07", saintURL: "https://www.franciscanmedia.org/saint-ambrose/", saintDate: "07-12"),


                             "08-12" : Days(title: "", reflection: "", url: "", saint: "Immaculate Conception of the Blessed Virgin Mary: 12/08", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-immaculate-conception/", saintDate: "08-12"),


                             "09-12" : Days(title: "", reflection: "", url: "", saint: "Saint Juan Diego: 12/09", saintURL: "https://www.franciscanmedia.org/saint-juan-diego/", saintDate: "09-12"),


                             "10-12" : Days(title: "", reflection: "", url: "", saint: "Blessed Adolph Kolping: 12/10", saintURL: "https://www.franciscanmedia.org/blessed-adolph-kolping/", saintDate: "10-12"),


                             "11-12" : Days(title: "", reflection: "", url: "", saint: "Saint Damasus I: 12/11", saintURL: "https://www.franciscanmedia.org/saint-damasus-i/", saintDate: "11-12"),


                             "12-12" : Days(title: "", reflection: "", url: "", saint: "Our Lady of Guadalupe: 12/12", saintURL: "https://www.franciscanmedia.org/our-lady-of-guadalupe/", saintDate: "12-12"),


                             "13-12" : Days(title: "", reflection: "", url: "", saint: "Saint Lucy: 12/13", saintURL: "https://www.franciscanmedia.org/saint-lucy/", saintDate: "13-12"),


                             "14-12" : Days(title: "", reflection: "", url: "", saint: "Saint John of the Cross: 12/14", saintURL: "https://www.franciscanmedia.org/saint-john-of-the-cross/", saintDate: "14-12"),


                             "15-12" : Days(title: "", reflection: "", url: "", saint: "Blessed Mary Frances Schervier: 12/15", saintURL: "https://www.franciscanmedia.org/blessed-mary-frances-schervier/", saintDate: "15-12"),


                             "16-12" : Days(title: "", reflection: "", url: "", saint: "Blessed Honoratus Kozminski: 12/16", saintURL: "https://www.franciscanmedia.org/blessed-honoratus-kozminski/", saintDate: "16-12"),


                             "17-12" : Days(title: "", reflection: "", url: "", saint: "Saint Hildegard of Bingen: 12/17", saintURL: "https://www.franciscanmedia.org/saint-hildegard-of-bingen/", saintDate: "17-12"),


                             "18-12" : Days(title: "", reflection: "", url: "", saint: "Blessed Anthony Grassi: 12/18", saintURL: "https://www.franciscanmedia.org/blessed-anthony-grassi/", saintDate: "18-12"),


                             "19-12" : Days(title: "", reflection: "", url: "", saint: "Blessed Pope Urban V: 12/19", saintURL: "https://www.franciscanmedia.org/blessed-pope-urban-v/", saintDate: "19-12"),


                             "20-12" : Days(title: "", reflection: "", url: "", saint: "Saint Dominic of Silos: 12/20", saintURL: "https://www.franciscanmedia.org/saint-dominic-of-silos/", saintDate: "20-12"),


                             "21-12" : Days(title: "", reflection: "", url: "", saint: "Saint Peter Canisius: 12/21", saintURL: "https://www.franciscanmedia.org/saint-peter-canisius/", saintDate: "21-12"),


                             "22-12" : Days(title: "", reflection: "", url: "", saint: "Blessed Jacopone da Todi: 12/22", saintURL: "https://www.franciscanmedia.org/blessed-jacopone-da-todi/", saintDate: "22-12"),


                             "23-12" : Days(title: "", reflection: "", url: "", saint: "Saint John of Kanty: 12/23", saintURL: "https://www.franciscanmedia.org/saint-john-kanty/", saintDate: "23-12"),


                             "24-12" : Days(title: "", reflection: "", url: "", saint: "Christmas at Greccio: 12/24", saintURL: "https://www.franciscanmedia.org/christmas-at-greccio/", saintDate: "24-12"),


                             "25-12" : Days(title: "", reflection: "", url: "", saint: "Nativity of the Lord: 12/25", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-nativity-of-the-lord/", saintDate: "25-12"),


                             "26-12" : Days(title: "", reflection: "", url: "", saint: "Saint Stephen: 12/26", saintURL: "https://www.franciscanmedia.org/saint-stephen/", saintDate: "26-12"),


                             "27-12" : Days(title: "", reflection: "", url: "", saint: "Saint John the Apostle: 12/27", saintURL: "https://www.franciscanmedia.org/saint-john-the-apostle/", saintDate: "27-12"),


                             "28-12" : Days(title: "", reflection: "", url: "", saint: "Holy Innocents: 12/28", saintURL: "https://www.franciscanmedia.org/holy-innocents/", saintDate: "28-12"),


                             "29-12" : Days(title: "", reflection: "", url: "", saint: "Saint Thomas Becket: 12/29", saintURL: "https://www.franciscanmedia.org/saint-thomas-becket/", saintDate: "29-12"),


                             "30-12" : Days(title: "", reflection: "", url: "", saint: "Saint Egwin: 12/30", saintURL: "https://www.franciscanmedia.org/saint-egwin/", saintDate: "30-12"),


                             "31-12" : Days(title: "", reflection: "", url: "", saint: "Saint Sylvester I: 12/31", saintURL: "https://www.franciscanmedia.org/saint-sylvester-i/", saintDate: "31-12"),

                     ]
        
        mainImage.image = UIImage(named: daysOfTheYear["Days"]?[formatDate(date: Date())]?.url ?? " ")
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
        mainImage.image = UIImage(named: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[newDate]?.title
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[newDate]?.reflection
    }
    
    @IBAction func previousDayAction(_ sender: UIButton) {
        DesiredDate.shared.globalDate = formatDate(date: Date.yesterday)
        let newDate = DesiredDate.shared.globalDate
        mainImage.image = UIImage(named: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
        quoteLabel.sizeToFit()
        quoteLabel.text = daysOfTheYear["Days"]?[newDate]?.title
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[newDate]?.reflection
    }
    
    @IBAction func nextDayAction(_ sender: UIButton) {
        DesiredDate.shared.globalDate = formatDate(date: Date.tomorrow)
        let newDate = DesiredDate.shared.globalDate
        mainImage.image = UIImage(named: daysOfTheYear["Days"]?[newDate]?.url ?? " ")
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

