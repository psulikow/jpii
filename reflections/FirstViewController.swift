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
    
    @IBOutlet weak var reflectonLabel: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    public static func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    private var observer: NSObjectProtocol?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [unowned self] notification in
            self.performWhenLoadFirstTime()
        }
        
        daysOfTheYear["Days"] = [
                 "01-01" : Days(title: "On this day in 1990 Pope John Paul II told us, \"When man turns his back on the Creator's plan, he provokes a disorder which has inevitable repercussions on the rest of the created order. If man is not at peace with God, then earth itself cannot be at peace.\"", reflection: "This was part of the MESSAGE OF HIS HOLINESS POPE JOHN PAUL II FOR THE CELEBRATION OF THE WORLD DAY OF PEACE", url: "1", saint: "Mary, Mother of God : 01/01", saintURL: "https://www.franciscanmedia.org/mary-mother-of-god/", saintDate: "01-01"),


                 "02-01" : Days(title: "Pope John Paul II once said, \"Have no fear of moving into the unknown. Simply step out fearlessly knowing that I am with you, therefore no harm can befall you; all is very, very well. Do this in complete faith and confidence.\"", reflection: "When you are feeling alone or afraid, do you remind yourself that Jesus is with us? Ask Saint Pope John Paul II to pray and interceed for someone you know that is feeling alone or afraid.", url: "2", saint: "Saint Basil the Great : 01/02", saintURL: "https://www.franciscanmedia.org/saint-basil-the-great/", saintDate: "02-01"),


                 "03-01" : Days(title: "Pope John Paul II reminds us, \"Marriage is an act of will that signifies and involves a mutual gift, which unites the spouses and binds them to their eventual souls, with whom they make up a sole family - a domestic church.\"", reflection: "", url: "3", saint: "Most Holy Name of Jesus : 01/03", saintURL: "https://www.franciscanmedia.org/mosaint-holy-name-of-jesus/", saintDate: "03-01"),


                 "04-01" : Days(title: "Pope John Paul II once said, \"Wars generally do not resolve the problems for which they are fought and therefore... prove ultimately futile.\"", reflection: "", url: "4", saint: "Saint Elizabeth Ann Seton : 01/04", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-ann-seton/", saintDate: "04-01"),


                 "05-01" : Days(title: "Pope John Paul II once said, \"Young people are threatened... by the evil use of advertising techniques that stimulate the natural inclination to avoid hard work by promising the immediate satisfaction of every desire.\"", reflection: "Do we let ourselves become influenced by society and what we see and read? These days we are surrounded by evil and if you want, take a moment to pray for our youth and ask that they may be protected.", url: "5", saint: "Saint John Neumann : 01/05", saintURL: "https://www.franciscanmedia.org/saint-john-neumann/", saintDate: "05-01"),


                 "06-01" : Days(title: "Pope John Paul II reminds us, \"The historical experience of socialist countries has sadly demonstrated that collectivism does not do away with alienation but rather increases it, adding to it a lack of basic necessities and economic inefficiency.\"", reflection: "", url: "6", saint: "Saint André Bessette : 01/06", saintURL: "https://www.franciscanmedia.org/saint-andr-eacute-bessette/", saintDate: "06-01"),


                 "07-01" : Days(title: "Pope John Paul II once said, \"Humanity should question itself, once more, about the absurd and always unfair phenomenon of war...\"", reflection: "On this day, if you wish, let us pray for peace.", url: "7", saint: "Saint Raymond of Peñafort : 01/07", saintURL: "https://www.franciscanmedia.org/saint-raymond-of-pe-afort/", saintDate: "07-01"),


                 "08-01" : Days(title: "Pope John Paul II tells us, \"As the family goes, so goes the nation and so goes the whole world in which we live.\"", reflection: "If you wish, take a moment to pray not only for the strength of your family but especially for any other families that may or may not be struggling.", url: "8", saint: "Saint Angela of Foligno : 01/08", saintURL: "https://www.franciscanmedia.org/saint-angela-of-foligno/", saintDate: "08-01"),


                 "09-01" : Days(title: "Pope John Paul II tells us, \"Love is never defeated, and I could add, the history of Ireland proves it.\"", reflection: "Ireland, quite the breathtaking country, let us take a moment if you wish to pray for the great people of this wonderful nation.", url: "9", saint: "Saint Adrian of Canterbury : 01/09", saintURL: "https://www.franciscanmedia.org/saint-adrian-of-canterbury/", saintDate: "09-01"),


                 "10-01" : Days(title: "Pope John Paul II once said, \"Do not abandon yourselves to despair. We are the Easter people and hallelujah is our song.\"", reflection: "", url: "10", saint: "Saint Gregory of Nyssa : 01/10", saintURL: "https://www.franciscanmedia.org/saint-gregory-of-nyssa/", saintDate: "10-01"),


                 "11-01" : Days(title: "Pope John Paul II once said, \"I kiss the soil as if I placed a kiss on the hands of a mother, for the homeland is our earthly mother. I consider it my duty to be with my compatriots in this sublime and difficult moment.\"", reflection: "", url: "11", saint: "Blessed William Carter : 01/11", saintURL: "https://www.franciscanmedia.org/blessed-william-carter/", saintDate: "11-01"),


                 "12-01" : Days(title: "Pope John Paul II reminds us, \"When freedom does not have a purpose, when it does not wish to know anything about the rule of law engraved in the hearts of men and women, when it does not listen to the voice of conscience, it turns against humanity and society.\"", reflection: "", url: "12", saint: "Saint Marguerite Bourgeoys : 01/12", saintURL: "https://www.franciscanmedia.org/saint-marguerite-bourgeoys/", saintDate: "12-01"),


                 "13-01" : Days(title: "Pope John Paul II once said, \"I hope to have communion with the people, that is the most important thing.\"", reflection: "", url: "13", saint: "Saint Hilary of Poitiers : 01/13", saintURL: "https://www.franciscanmedia.org/saint-hilary/", saintDate: "13-01"),


                 "14-01" : Days(title: "Pope John Paul II once said, \"The vow of celibacy is a matter of keeping one's word to Christ and the Church. a duty and a proof of the priest's inner maturity; it is the expression of his personal dignity.\"", reflection: "", url: "14", saint: "Saint Gregory Nazianzen : 01/14", saintURL: "https://www.franciscanmedia.org/saint-gregory-nazianzen/", saintDate: "14-01"),


                 "15-01" : Days(title: "Pope John Paul II reminds us, \"The question confronting the Church today is not any longer whether the man in the street can grasp a religious message, but how to employ the communications media so as to let him have the full impact of the Gospel message.\"", reflection: "", url: "15", saint: "Saint Paul the Hermit : 01/15", saintURL: "https://www.franciscanmedia.org/saint-paul-the-hermit/", saintDate: "15-01"),


                 "16-01" : Days(title: "Pope John Paul II once said, \"I have a sweet tooth for song and music. This is my Polish sin.\"", reflection: "", url: "16", saint: "Saint Berard and Companions : 01/16", saintURL: "https://www.franciscanmedia.org/saint-berard-and-companions/", saintDate: "16-01"),


                 "17-01" : Days(title: "Pope John Paul II tells us, \"From now on it is only through a conscious choice and through a deliberate policy that humanity can survive.\"", reflection: "", url: "17", saint: "Saint Anthony of Egypt : 01/17", saintURL: "https://www.franciscanmedia.org/saint-anthony-of-egypt/", saintDate: "17-01"),


                 "18-01" : Days(title: "Pope John Paul II once said, \"To maintain a joyful family requires much from both the parents and the children. Each member of the family has to become, in a special way, the servant of the others.\"", reflection: "", url: "18", saint: "Saint Charles of Sezze : 01/18", saintURL: "https://www.franciscanmedia.org/saint-charles-of-sezze/", saintDate: "18-01"),


                 "19-01" : Days(title: "Pope John Paul II reminds us, \"Social justice cannot be attained by violence. Violence kills what it intends to create.\"", reflection: "", url: "19", saint: "Saint Fabian : 01/19", saintURL: "https://www.franciscanmedia.org/saint-fabian/", saintDate: "19-01"),


                 "20-01" : Days(title: "Pope John Paul II once said, \"There are people and nations, Mother, that I would like to say to you by name. I entrust them to you in silence, I entrust them to you in the way that you know best.\"", reflection: "", url: "20", saint: "Saint Sebastian : 01/20", saintURL: "https://www.franciscanmedia.org/saint-sebastian/", saintDate: "20-01"),


                 "21-01" : Days(title: "Pope John Paul II reminds us, \"Stupidity is also a gift of God, but one mustn't misuse it.\"", reflection: "", url: "21", saint: "Saint Agnes : 01/21", saintURL: "https://www.franciscanmedia.org/saint-agnes/", saintDate: "21-01"),


                 "22-01" : Days(title: "On this day in 1973 the supreme court ruled on Roe v. Wade. On the 25th anniversary of the decision, at a prayer vigil at the Basilica of the National Shrine of the Immaculate Conception in Washington, Pope John Paul II said, \"The 25th anniversary of the decision ... is a call to people of good will to reflect. Now is the time for recommitment to the building of a culture of absolute respect for life.\"", reflection: "", url: "22", saint: "Saint Vincent of Zaragossa : 01/22", saintURL: "https://www.franciscanmedia.org/saint-vincent-of-zaragossa/", saintDate: "22-01"),


                 "23-01" : Days(title: "Pope John Paul II once said, \"The great danger for family life, in the midst of any society whose idols are pleasure, comfort and independence, lies in the fact that people close their hearts and become selfish.\"", reflection: "", url: "23", saint: "Saint Marianne Cope : 01/23", saintURL: "https://www.franciscanmedia.org/saint-marianne-cope/", saintDate: "23-01"),


                 "24-01" : Days(title: "Pope John Paul II tells us, \"Science can purify religion from error and superstition. Religion can purify science from idolatry and false absolutes.\"", reflection: "", url: "24", saint: "Saint Francis de Sales : 01/24", saintURL: "https://www.franciscanmedia.org/saint-francis-de-sales/", saintDate: "24-01"),


                 "25-01" : Days(title: "Pope John Paul II once said, \"Violence and arms can never resolve the problems of men.\"", reflection: "", url: "25", saint: "Conversion of Saint Paul : 01/25", saintURL: "https://www.franciscanmedia.org/conversion-of-saint-paul/", saintDate: "25-01"),


                 "26-01" : Days(title: "Pope John Paul II once said, \"You will reciprocally promise love, loyalty and matrimonial honesty. We only want for you this day that these words constitute the principle of your entire life and that with the help of divine grace you will observe these solemn vows that today, before God, you formulate.\"", reflection: "", url: "26", saint: "Saints Timothy and Titus : 01/26", saintURL: "https://www.franciscanmedia.org/saints-timothy-and-titus/", saintDate: "26-01"),


                 "27-01" : Days(title: "Pope John Paul II reminds us, \"Radical changes in world politics leave America with a heightened responsibility to be, for the world, an example of a genuinely free, democratic, just and humane society.\"", reflection: "", url: "27", saint: "Saint Angela Merici : 01/27", saintURL: "https://www.franciscanmedia.org/saint-angela-merici/", saintDate: "27-01"),


                 "28-01" : Days(title: "Pope John Paul II once said, \"You are our dearly beloved brothers, and in a certain way, it could be said that you are our elder brothers.\"", reflection: "", url: "28", saint: "Saint Thomas Aquinas : 01/28", saintURL: "https://www.franciscanmedia.org/saint-thomas-aquinas/", saintDate: "28-01"),


                 "29-01" : Days(title: "Pope John Paul II tells us, \"The unworthy successor of Peter who desires to benefit from the immeasurable wealth of Christ feels the great need of your assistance, your prayers, your sacrifice, and he most humbly asks this of you.\"", reflection: "", url: "100", saint: "Servant of God Brother Juniper : 01/29", saintURL: "https://www.franciscanmedia.org/servant-of-god-brother-juniper/", saintDate: "29-01"),


                 "30-01" : Days(title: "Pope John Paul II once said, \"You are priests, not social or political leaders. Let us not be under the illusion that we are serving the Gospel through an exaggerated interest in the wide field of temporal problems.\"", reflection: "", url: "30", saint: "Blessed Mary Angela Truszkowska : 01/30", saintURL: "https://www.franciscanmedia.org/blessed-mary-angela-truszkowska/", saintDate: "30-01"),


                 "31-01" : Days(title: "Pope John Paul II reminds us, \"The cemetery of the victims of human cruelty in our century is extended to include yet another vast cemetery, that of the unborn.\"", reflection: "", url: "31", saint: "Saint John Bosco : 01/31", saintURL: "https://www.franciscanmedia.org/saint-john-bosco/", saintDate: "31-01"),
                 





                 "01-02" : Days(title: "Pope John Paul II once said, \"Today, for the first time in history, a Bishop of Rome sets foot on English soil. This fair land, once a distant outpost of the pagan world, has become, through the preaching of the Gospel, a beloved and gifted portion of Christ's vineyard.\"", reflection: "", url: "32", saint: "Saint Ansgar : 02/01", saintURL: "https://www.franciscanmedia.org/saint-ansgar/", saintDate: "01-02"),


                 "02-02" : Days(title: "Pope John Paul II once said, \"In the depths of the human soul... the desire to give meaning to one's own life is joined by the fleeting vision of beauty and of the mysterious unity of things.\"", reflection: "", url: "33", saint: "Presentation of the Lord : 02/02", saintURL: "https://www.franciscanmedia.org/presentation-of-the-lord/", saintDate: "02-02"),


                 "03-02" : Days(title: "Pope John Paul II once said, \"Consequently, theories of evolution which, in accordance with the philosophies inspiring them, consider the mind as emerging from the forces of living matter, or as a mere epiphenomenon of this matter, are incompatible with the truth about man. Nor are they able to ground the dignity of the person.\"", reflection: "", url: "34", saint: "Saint Blaise : 02/03", saintURL: "https://www.franciscanmedia.org/saint-blaise/", saintDate: "03-02"),


                 "04-02" : Days(title: "Pope John Paul II once said, \"The world designed by God cannot be a world in which some hoard immoderate wealth in their hands, while others suffer from destitution and poverty, and die of hunger. Love must inspire justice and the struggle for justice\"", reflection: "", url: "35", saint: "Saint Joseph of Leonissa : 02/04", saintURL: "https://www.franciscanmedia.org/saint-joseph-of-leonissa/", saintDate: "04-02"),


                 "05-02" : Days(title: "Pope John Paul II once said, \"People must not attempt to impose their own 'truth' on others. The right to profess the truth must always be upheld, but not in a way that involves contempt for those who may think differently. Truth imposes itself solely by the force of its own truth.\"", reflection: "", url: "36", saint: "Saint Agatha : 02/05", saintURL: "https://www.franciscanmedia.org/saint-agatha/", saintDate: "05-02"),


                 "06-02" : Days(title: "Pope John Paul II once said, \"A society will be judged on the basis of how it treats its weakest members; and among the most vulnerable are surely the unborn and the dying.\"", reflection: "", url: "37", saint: "Saint Paul Miki and Companions : 02/06", saintURL: "https://www.franciscanmedia.org/saint-paul-miki-and-companions/", saintDate: "06-02"),


                 "07-02" : Days(title: "Pope John Paul II once said, \"Every scientist, through personal study and research, completes himself and his own humanity. ... Scientific research constitutes for you, as it does for many, the way for the personal encounter with truth, and perhaps the privileged place for the encounter itself with God, the Creator of heaven and earth. Science shines forth in all its value as a good capable of motivating our existence, as a great experience of freedom for truth, as a fundamental work of service. Through research each scientist grows as a human being and helps others to do likewise.\"", reflection: "", url: "38", saint: "Saint Colette : 02/07", saintURL: "https://www.franciscanmedia.org/saint-colette/", saintDate: "07-02"),


                 "08-02" : Days(title: "Pope John Paul II once said, \"Only faith in Christ gives rise to a culture contrary to egotism and death.\"", reflection: "How are you building your faith today?", url: "39", saint: "Saint Josephine Bakhita : 02/08", saintURL: "https://www.franciscanmedia.org/saint-josephine-bakhita/", saintDate: "08-02"),


                 "09-02" : Days(title: "Pope John Paul II once said, \"The mystery of the Holy Night, which historically happened two thousand years ago, must be lived as a spiritual event in the 'today' of the Liturgy.  The Word who found a dwelling in Mary's womb comes to knock on the heart of every person with singular intensity this Christmas.\"", reflection: "", url: "40", saint: "Saint Jerome Emiliani : 02/09", saintURL: "https://www.franciscanmedia.org/saint-jerome-emiliani/", saintDate: "09-02"),


                 "10-02" : Days(title: "Pope John Paul II once said, \"The obligation to earn one's bread presumes the right to do so. A society that denies this right cannot be justified, nor can it attain social peace.\"", reflection: "", url: "41", saint: "Saint Scholastica : 02/10", saintURL: "https://www.franciscanmedia.org/saint-scholastica/", saintDate: "10-02"),


                 "11-02" : Days(title: "Pope John Paul II once said, \"To recite the Rosary is nothing other than to contemplate the face of Christ with Mary.\"", reflection: "Pope John Paul had a strong relationship with the Blessed Mother. We can all become closer not only to her but also to Christ through the rosary.", url: "42", saint: "Our Lady of Lourdes : 02/11", saintURL: "https://www.franciscanmedia.org/our-lady-of-lourdes/", saintDate: "11-02"),


                 "12-02" : Days(title: "Pope John Paul II once said, \"Today, the scale and horror of modern warfare - whether nuclear or not - makes it totally unacceptable as a means of settling differences between nations. War should belong to the tragic past, to history; it should find no place on humanity's agenda for the future.\"", reflection: "", url: "43", saint: "Saint Apollonia : 02/12", saintURL: "https://www.franciscanmedia.org/saint-apollonia/", saintDate: "12-02"),


                 "13-02" : Days(title: "Pope John Paul II once said, \"We emphasize the transcendent worth of the human person. We insist that the human person must never be treated as an object; he must always be considered the subject. That is the basis for our teaching, the absolute standard.\"", reflection: "", url: "44", saint: "Saint Giles Mary of Saint Joseph : 02/13", saintURL: "https://www.franciscanmedia.org/saint-giles-mary-of-saint-joseph/", saintDate: "13-02"),


                 "14-02" : Days(title: "Pope John Paul II once said, \"For by his incarnation the Son of God united himself in a certain way with every man. He labored with human hands... and loved with a human heart. Born of Mary the Virgin, he truly became one of us...\"", reflection: "", url: "45", saint: "Saints Cyril and Methodius : 02/14", saintURL: "https://www.franciscanmedia.org/saints-cyril-and-methodius/", saintDate: "14-02"),


                 "15-02" : Days(title: "Pope John Paul II once said, \"Love is a constant challenge, thrown to us by God.\"", reflection: "Love is never easy, JPII often spoke of this. Whom do you love, if you would like, pray for them.", url: "46", saint: "Saint Claude de la Colombière : 02/15", saintURL: "https://www.franciscanmedia.org/saint-claude-de-la-colombi-egrave-re/", saintDate: "15-02"),


                 "16-02" : Days(title: "Pope John Paul II once said, \"The Internet causes billions of images to appear on millions of computer monitors around the planet. From this galaxy of sight and sound will the face of Christ emerge and the voice of Christ be heard? For it is only when his face is seen and his voice heard that the world will know the glad tidings of our redemption. This is the purpose of evangelization. And this is what will make the Internet a genuinely human space, for if there is no room for Christ, there is no room for man.\"", reflection: "", url: "47", saint: "Saint Gilbert of Sempringham : 02/16", saintURL: "https://www.franciscanmedia.org/saint-gilbert-of-sempringham/", saintDate: "16-02"),


                 "17-02" : Days(title: "Pope John Paul II once said, \"Pervading nationalism imposes its dominion on man today in many different forms and with an aggressiveness that spares no one. The challenge that is already with us is the temptation to accept as true freedom what in reality is only a new form of slavery.\"", reflection: "", url: "48", saint: "Seven Founders of the Servite Order : 02/17", saintURL: "https://www.franciscanmedia.org/seven-founders-of-the-servite-order/", saintDate: "17-02"),


                 "18-02" : Days(title: "Pope John Paul II once said, \"The Church must persist in the teaching transmitted to her by Christ.\"", reflection: "What teaching of Christ means the most to you?", url: "49", saint: "Blessed John of Fiesole : 02/18", saintURL: "https://www.franciscanmedia.org/blessed-john-of-fiesole/", saintDate: "18-02"),


                 "19-02" : Days(title: "Pope John Paul II once said, \"If development is the new name for peace, war and preparations for war are the major enemy of the healthy development of peoples. If we take the common good of all humanity as our norm, instead of individual greed, peace would be possible.\"", reflection: "", url: "50", saint: "Saint Conrad of Piacenza : 02/19", saintURL: "https://www.franciscanmedia.org/saint-conrad-of-piacenza/", saintDate: "19-02"),


                 "20-02" : Days(title: "Pope John Paul II once said, \"Sensitivity to the immense needs of humanity brings with it a spontaneous rejection of the arms race, which is incompatible with the all out struggle against hunger, sickness, under-development and illiteracy.\"", reflection: "", url: "51", saint: "Saints Jacinta and Francisco Marto : 02/20", saintURL: "https://www.franciscanmedia.org/saints-jacinta-and-francisco-marto/", saintDate: "20-02"),


                 "21-02" : Days(title: "Pope John Paul II once said, \"...Be holy men and women! Do not forget that the fruits of the apostolate depend on the depth of the spiritual life, on the intensity of prayer, of continual formation and sincere adhesion to the directives of the Church.\"", reflection: "", url: "52", saint: "Saint Peter Damian : 02/21", saintURL: "https://www.franciscanmedia.org/saint-peter-damian/", saintDate: "21-02"),


                 "22-02" : Days(title: "Pope John Paul II once said, \"Love the family! Defend and promote it as the basic cell of human society; nurture it as the prime sanctuary of life. Give great care to the preparation of engaged couples and be close to young married couples, so that they will be for their children and the whole community an eloquent testimony of God's love.\"", reflection: "", url: "53", saint: "Chair of Saint Peter : 02/22", saintURL: "https://www.franciscanmedia.org/chair-of-saint-peter/", saintDate: "22-02"),


                 "23-02" : Days(title: "Pope John Paul II once said, \"None are so poor that they have nothing to give...and none are so rich that they have nothing to receive.\"", reflection: "We can all make this world a better place!", url: "54", saint: "Saint Polycarp : 02/23", saintURL: "https://www.franciscanmedia.org/saint-polycarp/", saintDate: "23-02"),


                 "24-02" : Days(title: "Pope John Paul II once said, \"Condemning class struggle does not mean condemning every possible form of social conflict. Such conflicts inevitably arise and Christians must often take a position in the \"struggle for social justice.\" What is condemned is \"total war,\" which has no respect for the dignity of others (and consequently of oneself). It excludes reasonable compromise, does not pursue the common good but the good of a group, and sets out to destroy whatever stands in its way.\"", reflection: "", url: "55", saint: "Blessed Luke Belludi : 02/24", saintURL: "https://www.franciscanmedia.org/blessed-luke-belludi/", saintDate: "24-02"),


                 "25-02" : Days(title: "Pope John Paul II once said, \"It is not enough to long for a person as a good for oneself, one must also, and above all, long for that person's good.\"", reflection: "", url: "56", saint: "Blessed Sebastian of Aparicio : 02/25", saintURL: "https://www.franciscanmedia.org/blessed-sebastian-of-aparicio/", saintDate: "25-02"),


                 "26-02" : Days(title: "Pope John Paul II once said, \"With supernatural intuition Blessed Josemaria untiringly preached the universal call to holiness and apostolate. Christ calls everyone to become holy in the realities of everyday life. Hence work too is a means of personal holiness and apostolate when it is done in union with Jesus Christ", reflection: "Josemaría Escrivá de Balaguer y Albás was a Spanish Roman Catholic priest who founded Opus Dei.", url: "57", saint: "Saint Maria Bertilla Boscardin : 02/26", saintURL: "https://www.franciscanmedia.org/saint-maria-bertilla-boscardin/", saintDate: "26-02"),


                 "27-02" : Days(title: "Pope John Paul II once said, \"Interdependence must be transformed into solidarity based upon the principle that the goods of creation are meant for all. That which human industry produces through the processing of raw materials with the contribution of work must serve equally for the good of all.\"", reflection: "", url: "58", saint: "Saint Gabriel of Our Lady of Sorrows : 02/27", saintURL: "https://www.franciscanmedia.org/saint-gabriel-of-our-lady-of-sorrows/", saintDate: "27-02"),


                 "28-02" : Days(title: "Pope John Paul II once said, \"Man must reconcile himself to his natural greatness.... he must not forget that he is a person.\"", reflection: "We are all people, but we are people created in the image of God.", url: "59", saint: "Blessed Daniel Brottier : 02/28", saintURL: "https://www.franciscanmedia.org/blessed-daniel-brottier/", saintDate: "28-02"),


                 "29-02" : Days(title: "Pope John Paul II once said, \"There is no need to be dismayed if love sometimes follows torturous ways. Grace has the power to make straight the paths of human love.\"", reflection: "", url: "60", saint: "Saint Oswald : 02/29", saintURL: "https://www.franciscanmedia.org/saint-oswald/", saintDate: "29-02"),


                 "30-02" : Days(title: "", reflection: "", url: "61", saint: "", saintURL: "", saintDate: "30-02"),


                 "31-02" : Days(title: "", reflection: "", url: "62", saint: "", saintURL: "", saintDate: "31-02"),






                 "01-03" : Days(title: "Pope John Paul II once said, \"The heart is our hidden center, beyond the grasp of our reason and of others; only the Spirit of God can fathom the human heart and know it fully. The heart is the place of decision, deeper than our psychic drives. It is the place of truth, where we choose life or death. It is the place of encounter...\"", reflection: "", url: "63", saint: "Saint David of Wales: 03/01", saintURL: "https://www.franciscanmedia.org/saint-david-of-wales/", saintDate: "01-03"),


                 "02-03" : Days(title: "Pope John Paul II once said, \"To the family is entrusted the task of striving, first and foremost, to unleash the forces of good...\"", reflection: "If you would like, pray for the strenght of your family.", url: "64", saint: "Saint Agnes of Bohemia : 03/02", saintURL: "https://www.franciscanmedia.org/saint-agnes-of-bohemia/", saintDate: "02-03"),


                 "03-03" : Days(title: "Pope John Paul II once said, \"Creating the human race in His own image and continually keeping it in being, God inscribed in the humanity of man and woman the vocation... of love and communion. Love is therefore the fundamental and innate vocation of every human being.\"", reflection: "", url: "65", saint: "Saint Katharine Drexel : 03/03", saintURL: "https://www.franciscanmedia.org/saint-katharine-drexel/", saintDate: "03-03"),


                 "04-03" : Days(title: "On this day in 1979, in Redemptor hominis, Pope John Paul II wrote that man cannot live without love. He remains a being that is incomprehensible for himself, his life is senseless, if love is not revealed to him, if he does not encounter love, if he does not experience it and make it his own, if he does not participate intimately in it.", reflection: "Redemptor hominis is the name of the first encyclical written by Pope John Paul II.", url: "66", saint: "Saint Casimir : 03/04", saintURL: "https://www.franciscanmedia.org/saint-casimir/", saintDate: "04-03"),


                 "05-03" : Days(title: "On this day in 2000, Pope John Paul said, \"Young friends, do not hesitate to follow the example of Pedro, who 'pleased God and was loved by him' and who, having come to perfection in so short a time, lived a full life.\"", reflection: "Pope John Paul II was refering to Pedro Calungsod: A 17-year-old Filipino catechist who was killed for his faith.", url: "67", saint: "Saint John Joseph of the Cross : 03/05", saintURL: "https://www.franciscanmedia.org/saint-john-joseph-of-the-cross/", saintDate: "05-03"),


                 "06-03" : Days(title: "Pope John Paul II once said, \"But sometimes it is necessary to do that which is too much.\"", reflection: "Have you ever felt something you did was too much but for good reason?", url:"68", saint: "Saint Mary Ann of Jesus of Paredes : 03/06", saintURL: "https://www.franciscanmedia.org/saint-mary-ann-of-jesus-of-paredes/", saintDate: "06-03"),


                 "07-03" : Days(title: "Pope John Paul II once said, \"The modern world, a world which has experienced marvelous achievements but which seems to have lost its sense of ultimate realities and of existence itself.\"", reflection: "", url: "69", saint: "Saints Perpetua and Felicity : 03/07", saintURL: "https://www.franciscanmedia.org/saints-perpetua-and-felicity/", saintDate: "07-03"),


                 "08-03" : Days(title: "Pope John Paul II once said, \"The vocation and mission of the faithful can only be understood in light of a renewed awareness of the Church as sacrament or sign and instrument of intimate union with God, of the unity of the whole of mankind, and of the personal duty to adhere more closely to her.\"", reflection: "", url: "1", saint: "Saint John of God : 03/08", saintURL: "https://www.franciscanmedia.org/saint-john-of-god/", saintDate: "08-03"),


                 "09-03" : Days(title: "Pope John Paul II once said, \"Yes, the civilization of love is possible; it is not a utopia. But it is only possible by a constant and ready reference to the \"Father from whom all fatherhood and motherhood on earth is named,\" from whom every human family comes.\"", reflection: "", url: "71", saint: "Saint Frances of Rome : 03/09", saintURL: "https://www.franciscanmedia.org/saint-frances-of-rome/", saintDate: "09-03"),


                 "10-03" : Days(title: "Pope John Paul II once said, \"Only a socially just country has the right to exist.\"", reflection: "If you would like, think and pray on something you would like to see more just.", url: "72", saint: "Saint Dominic Savio : 03/10", saintURL: "https://www.franciscanmedia.org/saint-dominic-savio/", saintDate: "10-03"),


                 "11-03" : Days(title: "Pope John Paul II once said, \"In the life of husband and wife together, fatherhood and motherhood represent such a sublime \"novelty\" and richness as can only be approached \"on one's knees\".\"", reflection: "", url: "73", saint: "Saint John Ogilvie : 03/11", saintURL: "https://www.franciscanmedia.org/saint-john-ogilvie/", saintDate: "11-03"),


                 "12-03" : Days(title: "Pope John Paul II once said, \"Man matures through work which inspires him to difficult good.\"", reflection: "The words difficult and good are usually not synominous. What way can you bring these two words together?", url: "74", saint: "Blessed Angela Salawa : 03/12", saintURL: "https://www.franciscanmedia.org/blessed-angela-salawa/", saintDate: "12-03"),


                 "13-03" : Days(title: "Pope John Paul II once said, \"The true Christian can nurture a trustful optimism, because he is certain of not walking alone. In sending us Jesus, the eternal Son made man, God has drawn near to each of us. In Christ he has become our travelling companion.\"", reflection: "", url: "75", saint: "Saint Dominic Savio : 03/10", saintURL: "https://www.franciscanmedia.org/saint-dominic-savio/", saintDate: "10-03"),


                 "14-03" : Days(title: "Pope John Paul II once said, \"Learning to think rigorously, so as to act rightly and to serve humanity better.\"", reflection: "What are some ways we can serve our fellow man and woman?", url: "76", saint: "Saint John of God : 03/08", saintURL: "https://www.franciscanmedia.org/saint-john-of-god/", saintDate: "08-03"),


                 "15-03" : Days(title: "Pope John Paul II once said, \"The challenge is to make the church's yes to life concrete and effective. The struggle will be long, and it needs each one of you. Place your intelligence, your talents, your enthusiasm, your compassion and your fortitude at the service of life!\"", reflection: "", url: "77", saint: "Saint Louise de Marillac : 03/15", saintURL: "https://www.franciscanmedia.org/saint-louise-de-marillac/", saintDate: "15-03"),


                 "16-03" : Days(title: "Pope John Paul II once said, \"All are called to holiness, and holy people alone can renew humanity.\"", reflection: "How are you being called to holiness?", url: "78", saint: "Saint Clement Mary Hofbauer : 03/16", saintURL: "https://www.franciscanmedia.org/saint-clement-mary-hofbauer/", saintDate: "16-03"),


                 "17-03" : Days(title: "Pope John Paul II once said, \"Never again war. Never again hatred and intolerance.\"", reflection: "If you would like, take a moment, say a prayer for peace.", url: "79", saint: "Saint Patrick : 03/17", saintURL: "https://www.franciscanmedia.org/saint-patrick/", saintDate: "17-03"),


                 "18-03" : Days(title: "Pope John Paul II once said, \"Christ called as his Apostles only men. He did this in a totally free and sovereign way.\"", reflection: "", url: "80", saint: "Saint Cyril of Jerusalem : 03/18", saintURL: "https://www.franciscanmedia.org/saint-cyril-of-jerusalem/", saintDate: "18-03"),


                 "19-03" : Days(title: "Pope John Paul II once said, \"Faced with today's problems and disappointments , many people will try to escape from their responsibility. Escape in selfishness, escape in sexual pleasure, escape in drugs, escape in violence, escape in indifference and cynical attitudes. I propose to you the option of love, which is the opposite of escape.\"", reflection: "", url: "81", saint: "Saint Joseph, Husband of Mary : 03/19", saintURL: "https://www.franciscanmedia.org/saint-joseph-husband-of-mary/", saintDate: "19-03"),


                 "20-03" : Days(title: "Pope John Paul II once said, Without wonder, men and women would lapse into deadening routine and little by little would become incapable of a life which is genuinely personal.", reflection: "What routines have you fallen into? Good or bad....", url: "82", saint: "Saint Salvator of Horta : 03/20", saintURL: "https://www.franciscanmedia.org/saint-salvator-of-horta/", saintDate: "20-03"),


                 "21-03" : Days(title: "Pope John Paul II once said, \"But responsibility likewise falls on the legislators who have promoted and approved abortion laws, and, to the extent that they have a say in the matter, on the administrators of the health-care centers where abortions are performed. In this sense abortion goes beyond the responsibility of individuals and beyond the harm done to them, and takes on a distinctly social dimension. It is a most serious wound inflicted on society and its culture by the very people who ought to be societys promoters and defenders.\"", reflection: "", url: "83", saint: "Blessed John of Parma : 03/21", saintURL: "https://www.franciscanmedia.org/blessed-john-of-parma/", saintDate: "21-03"),


                 "22-03" : Days(title: "Pope John Paul II once said, \"Mary's role is to make Her Son Shine\"", reflection: "What role does the Blessed Mother play in your life?", url: "84", saint: "Saint Nicholas Owen : 03/22", saintURL: "https://www.franciscanmedia.org/saint-nicholas-owen/", saintDate: "22-03"),


                 "23-03" : Days(title: "Pope John Paul II once said, \"An effective proclamation of the Gospel in contemporary Western society will need to confront directly the widespread spirit of agnosticism and relativism which has cast doubt on reason's ability to know the truth, which alone satisfies the human heart's restless quest for meaning.\"", reflection: "", url: "85", saint: "Saint Turibius of Mogrovejo : 03/23", saintURL: "https://www.franciscanmedia.org/saint-turibius-of-mogrovejo/", saintDate: "23-03"),


                 "24-03" : Days(title: "Pope John Paul II once said, \"The seriousness of ecological degradation lays bare the depth of man's moral crisis... Simplicity, moderation, and discipline as well as the spirit of sacrifice must become a part of everyday life.\"", reflection: "", url: "86", saint: "Saint Oscar Arnulfo Romero : 03/24", saintURL: "https://www.franciscanmedia.org/saint-oscar-arnulfo-romero/", saintDate: "24-03"),


                 "25-03" : Days(title: "On this day in 1995, Pope John Paul wrote, \"Humanity, its dignity and its balance, will depend at every moment and on every place on the globe,on who man is for woman and who woman is for man.\"", reflection: "EVANGELIUM VITAE: To the Bishops, Priests and Deacons, Men and Women religious lay Faithful and all People of Good Will on the Value and Inviolability of Human Life", url: "87", saint: "Annunciation of the Lord : 03/25", saintURL: "https://www.franciscanmedia.org/annunciation-of-the-lord/", saintDate: "25-03"),


                 "26-03" : Days(title: "Pope John Paul II once said, \"Freedom consists not in doing what we like, but in having the right to do what we ought.\"", reflection: "", url: "88", saint: "Saint Catherine of Genoa : 03/26", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-genoa/", saintDate: "26-03"),


                 "27-03" : Days(title: "Pope John Paul II once said, \"I encourage Christians regularly to visit Christ present in the Blessed Sacrament, for we are all called to abide in the presence of God.\"", reflection: "In the above photo, Pope John Paul II is hugging the Archbishop Fulton J. Sheen. I invite you to research also this great man.", url: "89", saint: "Lazarus : 03/27", saintURL: "https://www.franciscanmedia.org/lazarus/", saintDate: "27-03"),


                 "28-03" : Days(title: "Pope John Paul II once told us, \"The Eucharist is not only a particularly intense expression of the reality of the Church's life, but also in a sense its fountainhead. The Eucharist feeds and forms the Church: 'Because there is one bread, we who are many are one body, for we all partake of the one bread' (1 Cor 10:17, RSV). Because of this vital link with the sacrament of the Body and Blood of the Lord, the mystery of the Church is savored, proclaimed, and lived supremely in the Eucharist.\"", reflection: "", url: "90", saint: "Saint Catharine of Bologna : 03/28", saintURL: "https://www.franciscanmedia.org/saint-catharine-of-bologna/", saintDate: "28-03"),


                 "29-03" : Days(title: "Pope John Paul II tells us, \"The essential commitment and, above all, the visible grace and source of supernatural strength for the Church as the People of God is to persevere and advance constantly in Eucharistic life and Eucharistic piety and to develop spiritually in the climate of the Eucharist.\"", reflection: "", url: "91", saint: "Saint Ludovico of Casoria : 03/29", saintURL: "https://www.franciscanmedia.org/saint-ludovico-of-casoria/", saintDate: "29-03"),


                 "30-03" : Days(title: "Pope John Paul II once said, \"The legal toleration of abortion or of euthanasia can in no way claim to be based on respect for the conscience of others, precisely because society has the right and the duty to protect itself against the abuses which can occur in the name of conscience and under the pretext of freedom.\"", reflection: "", url: "92", saint: "Saint Peter Regalado : 03/30", saintURL: "https://www.franciscanmedia.org/saint-peter-regalado/", saintDate: "30-03"),


                 "31-03" : Days(title: "Pope John Paul II tells us, \"The Rosary mystically transports us to Mary's side as she is busy watching over the human growth of Christ in the home of Nazareth. This enables her to train us and to mold us with the same care, until Christ is \"fully formed\" in us... Why should we not once more have recourse to the Rosary, with the same faith as those who have gone before us?\"", reflection: "", url: "93", saint: "Saint Stephen of Mar Saba : 03/31", saintURL: "https://www.franciscanmedia.org/saint-stephen-of-mar-saba/", saintDate: "31-03"),






                 "01-04" : Days(title: "Pope John Paul II once told us, \"In suffocating the voice of conscience, passion carries with itself a restlessness of the body and the senses: it is the restlessness of the \"external man.\" When the internal man has been reduced to silence, then passion, once it has been given freedom of action, so to speak, exhibits itself as an insistent tendency to satisfy the senses and the body.\"", reflection: "", url: "94", saint: "Saint Hugh of Grenoble : 04/01", saintURL: "https://www.franciscanmedia.org/saint-hugh-of-grenoble/", saintDate: "01-04"),


                 "02-04" : Days(title: "On this day in 2005, Pope John Paul II passes away at 9:37 PM. He served 26 years, 5 months and 17 days.", reflection: "Can you think of an impact this Saint has made in your life? Let us take a moment and say a prayer for Pope John Paul II and thank God for bringing him into our lives.", url: "119", saint: "Saint Francis of Paola : 04/02", saintURL: "https://www.franciscanmedia.org/saint-francis-of-paola/", saintDate: "02-04"),


                 "03-04" : Days(title: "Pope John Paul II once said, \"It is manifestly unjust that a privileged few should continue to accumulate excess goods, squandering available resources, while masses of people are living in conditions of misery at the very lowest level of subsistence.\"", reflection: "", url: "96", saint: "Saint Benedict the African : 04/03", saintURL: "https://www.franciscanmedia.org/saint-benedict-the-african/", saintDate: "03-04"),


                 "04-04" : Days(title: "Pope John Paul II once said, \"Truth can prevail only in virtue of truth itself.\"", reflection: "", url: "97", saint: "Saint Isidore of Seville : 04/04", saintURL: "https://www.franciscanmedia.org/saint-isidore-of-seville/", saintDate: "04-04"),


                 "05-04" : Days(title: "Pope John Paul II once told us, \"We are all one family in the world. Building a community that empowers everyone to attain their full potential through each of us respecting each other's dignity, rights and responsibilities makes the world a better place to live.\"", reflection: "", url: "98", saint: "Saint Vincent Ferrer : 04/05", saintURL: "https://www.franciscanmedia.org/saint-vincent-ferrer/", saintDate: "05-04"),


                 "06-04" : Days(title: "Pope John Paul II tells us, \"Learning to think rigorously, so as to act rightly and to serve humanity better.\"", reflection: "", url: "99", saint: "Saint Crescentia Hoess : 04/06", saintURL: "https://www.franciscanmedia.org/saint-crescentia-hoess/", saintDate: "06-04"),


                 "07-04" : Days(title: "Pope John Paul II once said, \"When we go before Jesus in the Blessed Sacrament we represent the one in the world who is in most need of God's Mercy.\" We \"Stand in behalf of the one in the world who does not know Christ and who is farthest away from God and we bring down upon their soul the Precious Blood of The Lamb.\"", reflection: "", url: "100", saint: "Saint John Baptist de La Salle : 04/07", saintURL: "https://www.franciscanmedia.org/saint-john-baptist-de-la-salle/", saintDate: "07-04"),


                 "08-04" : Days(title: "Pope John Paul II once said, \"The encouragement and the deepening of Eucharistic worship are proofs of the authentic renewal which the Council set itself as an aim and of which they are the central point.\"", reflection: "", url: "101", saint: "Saint Julie Billiart : 04/08", saintURL: "https://www.franciscanmedia.org/saint-julie-billiart/", saintDate: "08-04"),


                 "09-04" : Days(title: "Pope John Paul II once said, \"Every act of reverence, every genuflection that you make before the Blessed Sacrament is important because it is an act of faith in Christ, and act of love for Christ. And every sign of the cross and gesture of respect made each time you pass a church is also an act of faith.\"", reflection: "", url: "21", saint: "Saint Casilda : 04/09", saintURL: "https://www.franciscanmedia.org/saint-casilda/", saintDate: "09-04"),


                 "10-04" : Days(title: "Pope John Paul II tells us that \"Eucharistic worship is not so much worship of the inaccessible transcendence as worship of the divine condescension, and it is also the merciful and redeeming transformation of the world in the human heart\"", reflection: "", url: "103", saint: "Saint Magdalen of Canossa : 04/10", saintURL: "https://www.franciscanmedia.org/saint-magdalen-of-canossa/", saintDate: "10-04"),


                 "11-04" : Days(title: "On this day in 2000, Easter Sunday Pope John Paul II, in URBI ET ORBI, related to us the following. \"May the temptation to seek revenge give way to the courage to forgive; may the culture of life and love render vain the logic of death; may trust once more give breath to the lives of peoples.\"", reflection: "", url: "104", saint: "Saint Stanislaus : 04/11", saintURL: "https://www.franciscanmedia.org/saint-stanislaus/", saintDate: "11-04"),


                 "12-04" : Days(title: "Pope John Paul II once said, \"Original sin is not only the violation of a positive command … but … attempts … to abolish fatherhood, destroying its rays which permeate the created world, placing in doubt the truth about God who is Love and leaving man with only a sense of the master-slave relationship.\"", reflection: "", url: "105", saint: "Saint Teresa of Los Andes : 04/12", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-los-andes/", saintDate: "12-04"),


                 "13-04" : Days(title: "Pope John Paul II told us, \"When our whole life is one faith, hope, love, prayer and silence, a consecrated life always bound up in the Eucharist, then the 'urge' towards God springs...\"", reflection: "", url: "106", saint: "Saint Martin I : 04/13", saintURL: "https://www.franciscanmedia.org/saint-martin-i/", saintDate: "13-04"),


                 "14-04" : Days(title: "Pope John Paul II reminds us, \"...if desire is predominant it can deform love between man and woman and rob them both of it.\"", reflection: "", url: "107", saint: "Blessed Peter Gonzalez : 04/14", saintURL: "https://www.franciscanmedia.org/blessed-peter-gonzalez/", saintDate: "14-04"),


                 "15-04" : Days(title: "Pope John Paul II tells us, \"Friendship, as has been said, consists in a full commitment of the will to another person with a view to that person's good.\"", reflection: "", url: "108", saint: "Blessed Caesar de Bus : 04/15", saintURL: "https://www.franciscanmedia.org/blessed-caesar-de-bus/", saintDate: "15-04"),


                 "16-04" : Days(title: "Pope John Paul II once told us, \"Take away from love the fullness of self surrender, the completeness of personal commitment, and what remains will be a total denial and negation of it.\"", reflection: "", url: "109", saint: "Saint Bernadette Soubirous : 04/16", saintURL: "https://www.franciscanmedia.org/saint-bernadette-soubirous/", saintDate: "16-04"),


                 "17-04" : Days(title: "Pope John Paul II once said, \"And so, like Moses (cf Ex 3, 5), in spirit we remove the shoes from our feet, on the threshold of the inner sanctuary that each of us must become as we meet the Lord.\"", reflection: "", url: "110", saint: "Saint Benedict Joseph Labre : 04/17", saintURL: "https://www.franciscanmedia.org/saint-benedict-joseph-labre/", saintDate: "17-04"),


                 "18-04" : Days(title: "Pope John Paul II once told us, \"The dramatic threat of ecological breakdown is teaching us the extent to which greed and selfishness are contrary to the order of creation. ...A given culture reveals its understanding of life through the choices it makes in production and consumption... a great deal of educational and cultural work is urgently needed, including the education of consumers in the responsible use of their power of choice...\"", reflection: "", url: "11", saint: "Blessed James Oldo : 04/18", saintURL: "https://www.franciscanmedia.org/blessed-james-oldo/", saintDate: "18-04"),


                 "19-04" : Days(title: "Pope John Paul II once said, \"Limitation of one's freedom might seem to be something negative and unpleasant, but love makes it a positive, joyful and creative thing. Freedom exists for the sake of love.\"", reflection: "", url: "21", saint: "Saint Gianna Beretta Molla : 04/19", saintURL: "https://www.franciscanmedia.org/saint-gianna-beretta-molla/", saintDate: "19-04"),


                 "20-04" : Days(title: "Pope John Paul II reminds us, \"The dignity of the human person is a transcendent value, always recognized as such by those who sincerely search for the truth. Indeed, the whole of human history should be interpreted in the light of this certainty. Every person, created in the image and likeness of God (cf. Gn 1:26 28), is therefore radically oriented towards the Creator, and is constantly in relationship with those possessed of the same dignity.\"", reflection: "", url: "113", saint: "Saint Conrad of Parzham : 04/20", saintURL: "https://www.franciscanmedia.org/saint-conrad-of-parzham/", saintDate: "20-04"),


                 "21-04" : Days(title: "Pope John Paul II tells us, \"Our communal worship at Mass must go together with our personal worship of Jesus in Eucharistic adoration in order that our love may be complete\"", reflection: "Can you think back to when you starting going to adoration, how has it changed your life?", url: "114", saint: "Saint Anselm : 04/21", saintURL: "https://www.franciscanmedia.org/saint-anselm/", saintDate: "21-04"),


                 "22-04" : Days(title: "Pope John Paul II once said, \"Love consists of a commitment which limits one's freedom - it is a giving of the self, and to give oneself means just that: to limit one's freedom on behalf of another.\"", reflection: "", url: "115", saint: "Saint Adalbert of Prague : 04/22", saintURL: "https://www.franciscanmedia.org/saint-adalbert-of-prague/", saintDate: "22-04"),


                 "23-04" : Days(title: "Pope John Paul II tells us, \"Reason and faith cannot be separated without diminishing the capacity of men and women to know themselves, the world and God in an appropriate way.\"", reflection: "", url: "116", saint: "Saint George : 04/23", saintURL: "https://www.franciscanmedia.org/saint-george/", saintDate: "23-04"),


                 "24-04" : Days(title: "Pope John Paul II once said, \"The family, as the fundamental and essential educating community, is the privileged means for transmitting the religious and cultural values which help the person to acquire his or her own identity. Founded on love and open to the gift of life, the family contains in itself the very future of society; its most special task is to contribute effectively to a future of peace.\"", reflection: "", url: "117", saint: "Saint Fidelis of Sigmaringen : 04/24", saintURL: "https://www.franciscanmedia.org/saint-fidelis-of-sigmaringen/", saintDate: "24-04"),


                 "25-04" : Days(title: "Pope John Paul II told us, \"The obligation to earn one's bread by the sweat of one's brow also presumes the right to do so. A society in which this right is systematically denied, in which economic policies do not allow workers to reach satisfactory levels of employment, cannot be justified from an ethical point of view, nor can that society attain social peace.\"", reflection: "", url: "118", saint: "Saint Mark : 04/25", saintURL: "https://www.franciscanmedia.org/saint-mark/", saintDate: "25-04"),


                 "26-04" : Days(title: "Pope John Paul said, \"Amongst all unimportant subjects, football is by far the most important.\"", reflection: "Being that football (soccer) is a popular sport in Europe it is no surprise that Pope John Paul II was a fan. This is a nice humorous quote but also a good chance for us to be thankful for the little things in life that we take for granted that sometimes bring us together with friends and family.", url: "95", saint: "Saint Pedro de San José Betancur : 04/26", saintURL: "https://www.franciscanmedia.org/saint-pedro-de-san-jos-eacute-betancur/", saintDate: "26-04"),


                 "27-04" : Days(title: "Pope John Paul II once said, \"In the Eucharistic Sacrifice the Church venerates the memory of Mary the ever Virgin Mother of God and the memory of Saint Joseph, because he fed Him whom the faithful must eat as the Bread of Life.\"", reflection: "", url: "120", saint: "Saint Louis Mary Grignion de Montfort : 04/27", saintURL: "https://www.franciscanmedia.org/saint-louis-mary-grignion-de-montfort/", saintDate: "27-04"),


                 "28-04" : Days(title: "Pope John Paul II reminds us, \"To believe in Jesus is to accept what he says, even when it runs contrary to what others are saying. It means rejecting the lure of sin, however attractive it may be, in order to set out on the difficult path of the Gospel virtues.\"", reflection: "", url: "121", saint: "Saint Peter Chanel : 04/28", saintURL: "https://www.franciscanmedia.org/saint-peter-chanel/", saintDate: "28-04"),


                 "29-04" : Days(title: "Pope John Paul II reminds us, \"The inviolability of the person which is a reflection of the absolute inviolability of God, finds its primary and fundamental expression in the inviolability of human life. Above all, the common outcry, which is justly made on behalf of human rights-for example, the right to health, to home, to work, to family, to culture- is false and illusory if the right to life, the most basic and fundamental right and the condition for all other personal rights, is not defended with maximum determination.\"", reflection: "", url: "1", saint: "Saint Catherine of Siena : 04/29", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-siena/", saintDate: "29-04"),


                 "30-04" : Days(title: "Pope John Paul II once said, \"All human life-from the moment of conception and through all subsequent stages-is sacred, because human life is created in the image and likeness of God. Nothing surpasses the greatness or dignity of a human person...If a person's right to life is violated at the moment in which he is first conceived in his mother's womb, an indirect blow is struck also at the whole moral order.\"", reflection: "", url: "2", saint: "Saint Pius V : 04/30", saintURL: "https://www.franciscanmedia.org/saint-pius-v/", saintDate: "30-04"),


                 "31-04" : Days(title: "", reflection: "", url: "3", saint: "", saintURL: "", saintDate: "31-04"),






                 "01-05" : Days(title: "Pope John Paul II once said, \"Every Mass is a memorial of that one sacrifice and that passover which restored life to the world. Every Mass puts us into intimate communion with her, the mother, whose sacrifice 'becomes present' just as the sacrifice of her Son 'becomes present' at the words of consecration..... At the root of the Eucharist is the virginal and maternal life of Mary\"", reflection: "", url: "4", saint: "Saint Joseph the Worker : 05/01", saintURL: "https://www.franciscanmedia.org/saint-joseph-the-worker/", saintDate: "01-05"),


                 "02-05" : Days(title: "Pope John Paul II tells us, \"Freedom consists not in doing what we like, but in having the right to do what we ought.\"", reflection: "Take a moment and try and really get to the bottom of what it means not only to your life but what you do for others.", url: "5", saint: "Saint Athanasius : 05/02", saintURL: "https://www.franciscanmedia.org/saint-athanasius/", saintDate: "02-05"),


                 "03-05" : Days(title: "Pope John Paul II once said, \"Christ assigns as a duty to every man the dignity of every woman: and simultaneously... He also assigns to every woman the dignity of every man.\"", reflection: "", url: "6", saint: "Saints Philip and James : 05/03", saintURL: "https://www.franciscanmedia.org/saints-philip-and-james/", saintDate: "03-05"),


                 "04-05" : Days(title: "Pope John Paul once said, \"Those in society who are in charge of schools must never forget that the parents have been appointed by God himself as the first and principal educators of their children and that their right is completely inalienable.\"", reflection: "", url: "7", saint: "Blessed Michael Giedroyc : 05/04", saintURL: "https://www.franciscanmedia.org/blessed-michael-giedroyc/", saintDate: "04-05"),


                 "05-05" : Days(title: "Pope John Paul II once said, \"In this oasis of quiet, before the wonderful spectacle of nature, one easily experiences how profitable silence is, a good that today is ever more rare... In reality, only in silence does man succeed in hearing in the depth of his conscience the voice of God, which really makes him free. And vacations can help to rediscover and cultivate this indispensable interior dimension of human life.\"", reflection: "", url: "8", saint: "Saint Hilary of Arles : 05/05", saintURL: "https://www.franciscanmedia.org/saint-hilary-of-arles/", saintDate: "05-05"),


                 "06-05" : Days(title: "Pope John Paul II reminds us, \"The best, the surest and the most effective way of establishing PEACE on the face of the earth is through the great power of Perpetual Adoration of the Blessed Sacrament.\"", reflection: "", url: "9", saint: "Saints Marian and James : 05/06", saintURL: "https://www.franciscanmedia.org/saints-marian-and-james/", saintDate: "06-05"),


                 "07-05" : Days(title: "Pope John Paul II once said, \"Peoples of the entire world need to hear these words. Their conscience needs to grow in the certainty that Someone exists who holds in His Hands the destiny of this passing world... And this Someone is Love- Love that became Man, Love crucified and risen, Love unceasingly present among men. It is Eucharistic Love.\"", reflection: "", url: "10", saint: "Saint Rose Venerini : 05/07", saintURL: "https://www.franciscanmedia.org/saint-rose-venerini/", saintDate: "07-05"),


                 "08-05" : Days(title: "Pope John Paul II reminds us that \"The Family that prays together, stays together.\"", reflection: "", url: "11", saint: "Saint Peter of Tarentaise : 05/08", saintURL: "https://www.franciscanmedia.org/saint-peter-of-tarentaise/", saintDate: "08-05"),


                 "09-05" : Days(title: "Pope John Paul II once said, \"For 2,000 years, the Church has been the cradle in which Mary places Jesus and entrusts Him to the adoration and contemplation of all peoples. May the humility of the Bride cause to shine forth still more brightly the glory and power of the Eucharist, which she celebrates and treasures in her heart. In the sign of the consecrated Bread and Wine, Christ Jesus risen and glorified, the light of the nations, reveals the enduring reality of His Incarnation. He remains living and real in our midst in order to nourish the faithful with His Body and Blood.\"", reflection: "", url: "12", saint: "Saint John of Avila : 05/09", saintURL: "https://www.franciscanmedia.org/saint-john-of-avila/", saintDate: "09-05"),


                 "10-05" : Days(title: "Pope John Paul II once said, \"I cannot fail to note once again that the poor constitute the modern challenge, especially for the well-off of our planet, where millions of people live in inhuman conditions and many are literally dying of hunger. It is not possible to announce God the Father to these brothers and sisters without taking on the responsibility of building a more just society in the name of Christ.\"", reflection: "", url: "13", saint: "Saint Damien de Veuster of Moloka’i : 05/10", saintURL: "https://www.franciscanmedia.org/saint-damien-de-veuster-of-moloka-i/", saintDate: "10-05"),


                 "11-05" : Days(title: "Pope John Paul II tells us, \"Precisely in an age when the inviolable rights of the person are solemnly proclaimed and the value of life is publicly affirmed, the very right to life is being denied or trampled upon, especially at the more significant moments of existence: the moment of birth and the moment of death.\"", reflection: "", url: "14", saint: "Saint Ignatius of Laconi : 05/11", saintURL: "https://www.franciscanmedia.org/saint-ignatius-of-laconi/", saintDate: "11-05"),


                 "12-05" : Days(title: "Pope John Paul II once said, \"In the fulfillment of your duties, let your intentions be so pure that you reject from your actions any other motive than the glory of God and the salvation of souls.\"", reflection: "", url: "15", saint: "Saint Leopold Mandic : 05/12", saintURL: "https://www.franciscanmedia.org/saint-leopold-mandic/", saintDate: "12-05"),


                 "13-05" : Days(title: "On this day in 1981 Pope John Paul II is shot by Turkish terrorist Mehmet Ali Agca. Pope John Paul II tells us, \"Dear young people of every language and culture, a high and exhilarating task awaits you: that of becoming men and women capable of solidarity, peace and love of life, with respect for everyone. Become craftsmen of a new humanity, where brothers and sisters - members all of the same family - are able at last to live in peace.\"", reflection: "", url: "111", saint: "Our Lady of Fatima : 05/13", saintURL: "https://www.franciscanmedia.org/our-lady-of-fatima/", saintDate: "13-05"),


                 "14-05" : Days(title: "Pope John Paul II once told us, \"Since Christ is the only way to the Father, in order to highlight His living and saving presence in the Church and the world, the International Eucharistic Congress will take place in Rome, on the occasion of the Great Jubilee. The Year 2000 will be intensely Eucharistic: in the Sacrament of the Eucharist the Savior, who took flesh in Mary's womb twenty centuries ago, continues to offer Himself to humanity as the source of Divine Life\"", reflection: "", url: "17", saint: "Saint Matthias : 05/14", saintURL: "https://www.franciscanmedia.org/saint-matthias/", saintDate: "14-05"),


                 "15-05" : Days(title: "Pope John Paul II once said, \"This worship, given therefore to the Trinity of the Father and of the Son and of the Holy Spirit, above all accompanies and permeates the celebration of the Eucharistic liturgy. But it must fill our churches also outside the timetable of Masses. Indeed, since the Eucharistic mystery was instituted out of love, and makes Christ sacramentally present, it is worthy of thanksgiving and worship.\"", reflection: "", url: "18", saint: "Saint Isidore the Farmer : 05/15", saintURL: "https://www.franciscanmedia.org/saint-isidore-the-farmer/", saintDate: "15-05"),


                 "16-05" : Days(title: "Pope John Paul II once said, \"The Church has a special duty to safeguard and strengthen the sacredness of the Eucharist. In our pluralistic and often deliberately secularized society, the living faith of the Christian community - a faith always aware of its rights vis-a-vis those who do not share the faith - ensures respect for this sacredness\"", reflection: "", url: "19", saint: "Saint Margaret of Cortona : 05/16", saintURL: "https://www.franciscanmedia.org/saint-margaret-of-cortona/", saintDate: "16-05"),


                 "17-05" : Days(title: "Pope John Paul II once told us, \"Attention is riveted on what is tangible, useful, instantly available; the stimulus for deeper thought and reflection may be lacking. Yet human beings have a vital need for time and inner quiet to ponder and examine life and its mysteries... Understanding and wisdom are the fruit of a contemplative eye upon the world, and do not come from a mere accumulation of facts, no matter how interesting.\"", reflection: "", url: "20", saint: "Saint Paschal Baylon : 05/17", saintURL: "https://www.franciscanmedia.org/saint-paschal-baylon/", saintDate: "17-05"),


                 "18-05" : Days(title: "On this day in 1920, Karol Wojtyla, Jr. is born. Pope John Paul II once said, \"The Rosary is my favorite prayer.\"", reflection: "Have you ever prayed the Rosary? Have you meditated the mysteries why praying the rosary? Let us try and take some inspiration not only in the birth of this great man but also, ask the Blessed Mother to interceed and draw us closer to Christ Jesus.", url: "102", saint: "Saint John I : 05/18", saintURL: "https://www.franciscanmedia.org/saint-john-i/", saintDate: "18-05"),


                 "19-05" : Days(title: "Pope John Paul II once said, \"There must be a cooperation of all who believe in God, knowing that authentic religiousness - far from placing individuals and peoples in conflict with one another - rather pushes them together to build a world of peace.\"", reflection: "", url: "22", saint: "Saint Theophilus of Corte : 05/19", saintURL: "https://www.franciscanmedia.org/saint-theophilus-of-corte/", saintDate: "19-05"),


                 "20-05" : Days(title: "Pope John Paul II reminds us, \"There is no true peace without fairness , truth , justice and solidarity .\"", reflection: "Maybe we can take this day to examine how we have practiced these virtues in our daily life, seeing where we may be able to improve and possible reflect the light of God upon others.", url: "23", saint: "Saint Bernardine of Siena : 05/20", saintURL: "https://www.franciscanmedia.org/saint-bernardine-of-siena/", saintDate: "20-05"),


                 "21-05" : Days(title: "Pope John Paul II once said, \"True living is not found in one's self or in things. It is found in Someone else, in the One who created everything that is good, true, and beautiful in the world. True living is found in God and you discover God in the person of Jesus Christ.\"", reflection: "", url: "24", saint: "Saint Cristóbal Magallanes and Companions : 05/21", saintURL: "https://www.franciscanmedia.org/saint-crisaint-oacute-bal-magallanes-and-companions/", saintDate: "21-05"),


                 "22-05" : Days(title: "Pope John Paul II reminds us that, \"The greatness of work is inside man.\"", reflection: "Let us take a few moments to take a look inside, maybe an examination of our past day or week and try and give an account of the great things we have done, or, failed to do.", url: "25", saint: "Saint Rita of Cascia : 05/22", saintURL: "https://www.franciscanmedia.org/saint-rita-of-cascia/", saintDate: "22-05"),


                 "23-05" : Days(title: "Pope John Paul II once said, \"The Church counters the culture of death with the culture of love.\"", reflection: "Fyodor Dostoevsky said, \"Love in action is a harsh and dreadful thing compared to love in dreams.\" What does that mean to you?", url: "26", saint: "Saint Gregory VII : 05/23", saintURL: "https://www.franciscanmedia.org/saint-gregory-vii/", saintDate: "23-05"),


                 "24-05" : Days(title: "Pope John Paul II once told us, \"Humankind, which discovers its capacity to transform and in a certain sense create the world through its own work, forgets that this is always based on God's prior and original gift of things that are. People think that they can make arbitrary use of the earth, subjecting it without restraint to their wills, as though the earth did not have its own requisites and a prior God-given purpose, which human beings can indeed develop but must not betray.\"", reflection: "", url: "27", saint: "Saint Mary Magdalene de’ Pazzi : 05/24", saintURL: "https://www.franciscanmedia.org/saint-mary-magdalene-de-pazzi/", saintDate: "24-05"),


                 "25-05" : Days(title: "On this day in 1995, Ut unum sint, an encyclical by Pope John Paul II was published. In it, John Paul II wrote, \"The Church must breathe with her two lungs\". He was refering to the Western (Roman Catholic) and Eastern (Orthodox) churches, known as \"Sister Churches\".  One body two lungs.", reflection: "On this day, let us pray, along side Saint Pope John Paul II, that the holy spirit can unit these two lungs toward diversity and a sincere commitment to unity.", url: "28", saint: "Saint Bede the Venerable : 05/25", saintURL: "https://www.franciscanmedia.org/saint-bede-the-venerable/", saintDate: "25-05"),


                 "26-05" : Days(title: "Pope John Paul II reminds us, \"In Christ and through Christ man has acquired full awareness of his dignity.\"", reflection: "Dignity is the state or quality of being worthy of honor or respect.", url: "29", saint: "Saint Philip Neri : 05/26", saintURL: "https://www.franciscanmedia.org/saint-philip-neri/", saintDate: "26-05"),


                 "27-05" : Days(title: "Pope John Paul II once said, \"What will you do with your life? What are your plans? Have you ever thought of committing your existence totally to Christ? Do you think that there can be anything greater than to bring Jesus to people and people to Jesus?\"", reflection: "Have you ever considered the priesthood or deaconate? Take a moment to pray for your vocation and that of someone you know.", url: "30", saint: "Saint Augustine of Canterbury : 05/27", saintURL: "https://www.franciscanmedia.org/saint-augustine-of-canterbury/", saintDate: "27-05"),


                 "28-05" : Days(title: "Pope John Paul II tells us, \"If you really wish to follow Christ, if you want your love for him to grow and last, then you must be faithful to prayer. It is the key to the vitality of your life in Christ. Without prayer, your faith and love will die. If you are constant in daily prayer and in the Sunday celebration of Mass, your love for Jesus will increase. And your heart will know deep joy and peace, such as the world could never give.\"", reflection: "Let us not forget the simple things we can be doing to become a follower of Christ.", url: "31", saint: "Venerable Pierre Toussaint : 05/28", saintURL: "https://www.franciscanmedia.org/venerable-pierre-toussaint/", saintDate: "28-05"),


                 "29-05" : Days(title: "Pope John Paul II once said, \"The Gospel of life must be proclaimed and human life defended in all places and all times.\"", reflection: "How are you proclaiming the Gospel?", url: "32", saint: "Saint Madeleine Sophie Barat : 05/29", saintURL: "https://www.franciscanmedia.org/saint-madeleine-sophie-barat/", saintDate: "29-05"),


                 "30-05" : Days(title: "Pope John Paul II reminds us, \"Rediscover the Rosary in the light of scripture, in harmony with the Liturgy, and in the context of your daily lives.\"", reflection: "I often find myslef saying I don't have time to pray as much as I should but then I realize what a wonderful time it can be to say the rosary when I am driving to work or taking an evening walk.", url: "33", saint: "Saint Joan of Arc : 05/30", saintURL: "https://www.franciscanmedia.org/saint-joan-of-arc/", saintDate: "30-05"),


                 "31-05" : Days(title: "Pope John Paul II once said, \"Is not Jesus pointing to children even as models for grownups?\"", reflection: "In the Gospel of Matthew Jesus reminds us, \"Amen, I say to you, unless you turn and become like children, you will not enter the kingdom of heaven.\"", url: "34", saint: "Visitation of the Blessed Virgin Mary : 05/31", saintURL: "https://www.franciscanmedia.org/visitation/", saintDate: "31-05"),






                 "01-06" : Days(title: "Pope John Paul II once said, \"What does our generation owe to generations yet unborn? ...there is an order in the universe which must be respected, and... the human person, endowed with the capability of choosing freely, has a grave responsibility to preserve this order for the well-being of future generations.\"", reflection: "", url: "35", saint: "Saint Justin Martyr : 06/01", saintURL: "https://www.franciscanmedia.org/saint-justin/", saintDate: "01-06"),


                 "02-06" : Days(title: "Pope John Paul II once told us, \"Motherhood involves a special communion with the mystery of life, as it develops in the mother's womb. The mother is filled with wonder at this mystery of life, and 'understands' with unique intuition what is happening inside her. In the light of the 'beginning', the mother accepts and loves as a person the child she is carrying in her womb.\"", reflection: "", url: "36", saint: "Saints Marcellinus and Peter : 06/02", saintURL: "https://www.franciscanmedia.org/saints-marcellinus-and-peter/", saintDate: "02-06"),


                 "03-06" : Days(title: "Pope John Paul II shares with us, \"The Rosary is my favorite prayer. A prayer so simple and so rich; from deepest heart, I exhort all to recite it.\"", reflection: "Is the rosary your favorite prayer? Don't forget you can pray the Rosary anywhere, even if not in full, a decade can go a long way.", url: "37", saint: "Saint Charles Lwanga and Companions : 06/03", saintURL: "https://www.franciscanmedia.org/saints-charles-lwanga-and-companions/", saintDate: "03-06"),


                 "04-06" : Days(title: "Pope John Paul II once said, \"Once again, through myself, the Church, in the words of the well-known declaration Nostra Aetate, 'deplores the hatred, persecutions and displays of anti-Semitism directed against the Jews at any time and by anyone.' I repeat, 'By anyone.'\"", reflection: "If you wish, let us take a moment and pray for our brothers and sisters of Judaism.", url: "38", saint: "Blessed Angeline of Marsciano : 06/04", saintURL: "https://www.franciscanmedia.org/blessed-angeline-of-marsciano/", saintDate: "04-06"),


                 "05-06" : Days(title: "Pope John Paul II tells us that, \"Treating a person as a means to an end, and an end moreover which in this case is pleasure, the maximization of pleasure, will always stand in the way of love.\"", reflection: "Is there anything blocking love between us and our significant others?", url: "39", saint: "Saint Boniface : 06/05", saintURL: "https://www.franciscanmedia.org/saint-boniface/", saintDate: "05-06"),


                 "06-06" : Days(title: "Pope John Paul II once said, \"No one else can want for me. No one can substitute his act of will for mine. It does sometimes happen that someone very much wants me to want what he wants. This is the moment when the impassable frontier between him and me, which is drawn by free will, becomes most obvious. I may not want that which he wants me to want - and in this precisely I am incommunicabilis. I am, and I must be, independent in my actions. All human relationships are posited on this fact.\"", reflection: "", url: "40", saint: "Saint Norbert : 06/06", saintURL: "https://www.franciscanmedia.org/saint-norbert/", saintDate: "06-06"),


                 "07-06" : Days(title: "Pope John Paul II tells us, \"Motherhood implies from the beginning a special openness to the new person: and this is precisely the woman's 'part'. In this openness, in conceiving and giving birth to a child, the woman 'discovers herself through a sincere gift of self'.\"", reflection: "", url: "41", saint: "Blessed Franz Jägerstätter : 06/07", saintURL: "https://www.franciscanmedia.org/blessed-franz-jagerstatter/", saintDate: "07-06"),


                 "08-06" : Days(title: "Pope John Paul II once said, \"The greatest deception, and the deepest source of unhappiness, is the illusion of finding life by excluding God, of finding freedom by excluding moral truths and personal responsibility.\"", reflection: "", url: "42", saint: "Saint William of York : 06/08", saintURL: "https://www.franciscanmedia.org/saint-william-of-york/", saintDate: "08-06"),


                 "09-06" : Days(title: "Pope John Paul II reminds us, \"Euthanasia is a grave violation of the law of God, since it is the deliberate and morally unacceptable killing of a human person.\"", reflection: "", url: "43", saint: "Saint Ephrem : 06/09", saintURL: "https://www.franciscanmedia.org/saint-ephrem/", saintDate: "09-06"),


                 "10-06" : Days(title: "Pope John Paul II once said, \"In the sacrifice which Jesus Christ makes of Himself on the Cross for His bride, the Church... there is entirely revealed that plan which God has imprinted on the humanity of man and woman since their creation.\"", reflection: "", url: "44", saint: "Blessed Joachima : 06/10", saintURL: "https://www.franciscanmedia.org/blessed-joachima/", saintDate: "10-06"),


                 "11-06" : Days(title: "Pope John Paul II once said, \"It is the responsibility of Pastors to encourage, also by their personal witness, the practice of Eucharistic adoration, and exposition of the Blessed Sacrament in particular, as well as prayer of adoration before Christ present under the Eucharistic species.\"", reflection: "", url: "45", saint: "Saint Barnabas : 06/11", saintURL: "https://www.franciscanmedia.org/saint-barnabas/", saintDate: "11-06"),


                 "12-06" : Days(title: "Pope John Paul II once said, \"Prayer gives us light by which to see and to judge from God's perspective and from eternity. That is why you must not give up on praying!\"", reflection: "", url: "46", saint: "Blessed Jolenta (Yolanda) of Poland : 06/12", saintURL: "https://www.franciscanmedia.org/blessed-jolenta-yolanda-of-poland/", saintDate: "12-06"),


                 "13-06" : Days(title: "Pope John Paul II tells us, \"The new evangelization calls for followers of Christ who are unconditionally pro-life: who will proclaim, celebrate and serve the Gospel of life in every situation. A sign of hope is the increasing recognition that the dignity of human life must never be taken away, even in the case of someone who has done great evil. . . . I renew the appeal I made . . . for a consensus to end the death penalty, which is both cruel and unnecessary.\"", reflection: "", url: "47", saint: "Saint Anthony of Padua : 06/13", saintURL: "https://www.franciscanmedia.org/saint-anthony-of-padua/", saintDate: "13-06"),


                 "14-06" : Days(title: "Pope John Paul II once said, \"It is legitimate and necessary to ask oneself if this is not perhaps part of a new ideology of evil, perhaps more insidious and hidden, which attempts to pit human rights against the family and against man.\"", reflection: "", url: "48", saint: "Saint Albert Chmielowski : 06/14", saintURL: "https://www.franciscanmedia.org/saint-albert-chmielowski/", saintDate: "14-06"),


                 "15-06" : Days(title: "Pope John Paul II once said, \"The purpose of art is nothing less than the upliftment of the human spirit.\"", reflection: "If you would like, take a moment to research some Christian art. It can be very inspiring!", url: "49", saint: "Saint Marguerite d’Youville : 06/15", saintURL: "https://www.franciscanmedia.org/saint-marguerite-d-youville/", saintDate: "15-06"),


                 "16-06" : Days(title: "Pope John Paul II tells us, \"We cannot interfere in one area of the ecosystem without paying due attention to both the consequences of such interference in other areas and to the well-being of future generations.\"", reflection: "What are we doing to protect and invest in the future generations...", url: "50", saint: "Saint John Francis Regis : 06/16", saintURL: "https://www.franciscanmedia.org/saint-john-francis-regis/", saintDate: "16-06"),


                 "17-06" : Days(title: "Pope John Paul II told us, \"Deep within yourself, listen to your conscience which calls you to be pure...a home is not warmed by the fire of pleasure which burns quickly like a pile of withered grass. Passing encounters are only a caricature of love; they injure hearts and mock God's plan.\"", reflection: "", url: "51", saint: "Saint Joseph Cafasso : 06/17", saintURL: "https://www.franciscanmedia.org/saint-joseph-cafasso/", saintDate: "17-06"),


                 "18-06" : Days(title: "Pope John Paul reminds us, \"Like so many pilgrims before us, we kneel in wonder and adoration before the ineffable mystery which. was accomplished here... In This Child - the Son who is given to us - we find rest for our souls and the true bread that never fails - the Eucharistic Bread foreshadowed even in the name of this town: Bethlehem, the house of bread. God lies hidden in the Child; divinity lies hidden in the Bread of Life\"", reflection: "Let us not forget our calling, Jesus telling us to become \"child-like\"", url: "52", saint: "Venerable Matt Talbot : 06/18", saintURL: "https://www.franciscanmedia.org/venerable-matt-talbot/", saintDate: "18-06"),


                 "19-06" : Days(title: "Pope John Paul II once said, \"Deepen you knowledge of Jesus which ends loneliness, overcomes sadness and uncertainty, gives real meaning to life, curbs passions, exalts ideals, expands energies in charity, brings light into decisive choices. Let Christ be for you the Way, the Truth, and the Life.\"", reflection: "", url: "53", saint: "Saint Romuald : 06/19", saintURL: "https://www.franciscanmedia.org/saint-romuald/", saintDate: "19-06"),


                 "20-06" : Days(title: "On this day in 1920, Karol Wojtyla was baptized in the Church of teh Presentation of the Blessed Virgin Mary. Pope John Paul II once said, \"Art has a unique capacity to take one or other facet of the message and translate it into colors, shapes and sounds which nourish the intuition of those who look and listen.\"", reflection: "", url: "54", saint: "Saint Paulinus of Nola : 06/20", saintURL: "https://www.franciscanmedia.org/saint-paulinus-of-nola/", saintDate: "20-06"),


                 "21-06" : Days(title: "Pope John Paul II reminds us, \"The measure of your success will be the measure of your generosity.\"", reflection: "How are these two words, generosity and success, haromized in your life?", url: "55", saint: "Saint Aloysius Gonzaga : 06/21", saintURL: "https://www.franciscanmedia.org/saint-aloysius-gonzaga/", saintDate: "21-06"),


                 "22-06" : Days(title: "Pope John Paul II once said, \"The conviction which we must share and spread is that the call to holiness is directed to all Christians. This is not a question of privilege or of spiritual elitism. It is a question of a grace offered to all the baptized.\"", reflection: "", url: "56", saint: "Saint Thomas More : 06/22", saintURL: "https://www.franciscanmedia.org/saint-thomas-more/", saintDate: "22-06"),


                 "23-06" : Days(title: "Pope John Paul II once told us, \"I sense that the moment has come to commit all of the Church's energies to a new evangelization... No believer in Christ, no institution of the Church can avoid this supreme duty: to proclaim Christ to all peoples.\"", reflection: "", url: "57", saint: "Saint John Fisher : 06/23", saintURL: "https://www.franciscanmedia.org/saint-john-fisher/", saintDate: "23-06"),


                 "24-06" : Days(title: "Pope John Paul II once said, \"He has chosen you, in a mysterious but real way, to make you saviors with Him and like Him. Yes, Christ calls you, but He calls you in truth. His call is demanding, because He invites you to let yourselves be 'captured' by Him completely, so that your whole lives will be seen in a different light.\"", reflection: "", url: "58", saint: "Nativity of Saint John the Baptist : 06/24", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-nativity-of-saint-john-the-baptist/", saintDate: "24-06"),


                 "25-06" : Days(title: "Pope John Paul II once said, \"We are the people of life, because God, in His unconditional love, has given us the Gospel of Life, and we are called to act accordingly.\"", reflection: "", url: "59", saint: "Blessed Jutta of Thuringia : 06/25", saintURL: "https://www.franciscanmedia.org/blessed-jutta-of-thuringia/", saintDate: "25-06"),


                 "26-06" : Days(title: "On this day in 1967, Karol Wojtyla is elevated to Cardinal. Pope John Paul II once told us, \"The only struggle which religions can justify, the only struggle worthy of humans, is the moral struggle against humanity's own disordered passions, against every kind of selfishness, against attempts to oppress others, against every type of hatred and violence.\"", reflection: "Take a moment to reflect on any struggles you have had in your life and see how you can offer these up to God.", url: "60", saint: "Blessed Raymond Lull : 06/26", saintURL: "https://www.franciscanmedia.org/blessed-raymond-lull/", saintDate: "26-06"),


                 "27-06" : Days(title: "Pope John Paul II once said, \"And everything else will then turn out to be unimportant and inessential except this: father, child, and love. And then, looking at the simplest things, we will all say, Could we have not learned this long ago? Has this not always been embedded in everything that is?\"", reflection: "", url: "61", saint: "Saint Cyril of Alexandria : 06/27", saintURL: "https://www.franciscanmedia.org/saint-cyril-of-alexandria/", saintDate: "27-06"),


                 "28-06" : Days(title: "Pope John Paul II reminds us, \"Opting for peace does not mean a passive acquiescence to evil or compromise of principle. It demands an active struggle against hatred, oppression and disunity, but not by using methods of violence. Building peace requires creative and courageous action\"", reflection: "", url: "62", saint: "Saint Irenaeus : 06/28", saintURL: "https://www.franciscanmedia.org/saint-irenaeus/", saintDate: "28-06"),


                 "29-06" : Days(title: "Pope John Paul II once said, \"Beauty is the vocation bestowed on the artist by the Creator in the gift of artistic talent.\"", reflection: "I invite you to explore a painting called, The Calling of Saint Matthew. This is a masterpiece by Michelangelo Merisi da Caravaggio, depicting the moment at which Jesus Christ inspires Matthew to follow him.", url: "63", saint: "Solemnity of Saints Peter and Paul : 06/29", saintURL: "https://www.franciscanmedia.org/solemnity-of-saints-peter-and-paul/", saintDate: "29-06"),


                 "30-06" : Days(title: "Pope John Paul II reminds us, \"Take heed all of you who have at heart mankind's future! Take heed men and women of good will! May the temptation to seek revenge give way to the courage to forgive; may the culture of life and love render vain the logic of death; may trust once more give breath to the lives of peoples.\"", reflection: "", url: "64", saint: "First Martyrs of the Church of Rome : 06/30", saintURL: "https://www.franciscanmedia.org/firsaint-martyrs-of-the-church-of-rome/", saintDate: "30-06"),


                 "31-06" : Days(title: "", reflection: "", url: "65", saint: "", saintURL: "", saintDate: "31-06"),






                 "01-07" : Days(title: "Pope John Paul II once said, \"Sacred scripture wishes simply to declare that the world was created by God, and in order to teach this truth it expressed itself in terms of the cosmology in use at the time of the writer. Any other teaching about the origin and makeup of the universe is so alien to the intentions of the Bible, which does not wish to teach how heaven was made but how one goes to heaven.\"", reflection: "", url: "66", saint: "Saint Junipero Serra : 07/01", saintURL: "https://www.franciscanmedia.org/saint-junipero-serra/", saintDate: "01-07"),


                 "02-07" : Days(title: "Pope John Paul II once said, \"Believers know that the presence of evil is always accompanied by the presence of good, by grace... Where evil grows, there the hope for good also grows... In the love that pours forth from the heart of Christ, we find hope for the future of the world. Christ has redeemed the world: 'By his wounds we are healed.' (Isaiah 53:5)\"", reflection: "", url: "67", saint: "Saint Oliver Plunkett : 07/02", saintURL: "https://www.franciscanmedia.org/saint-oliver-plunkett/", saintDate: "02-07"),


                 "03-07" : Days(title: "Pope John Paul II tells us, \"Born and nurtured when the human being first asked questions about the reason for things and their purpose, philosophy shows in different modes and forms that the desire for truth is part of human nature itself.\"", reflection: "", url: "68", saint: "Saint Thomas the Apostle : 07/03", saintURL: "https://www.franciscanmedia.org/saint-thomas-the-apostle/", saintDate: "03-07"),


                 "04-07" : Days(title: "Pope John Paul II once said, \"When Sunday loses its fundamental meaning and becomes subordinate to a secular concept of weekend dominated by such things as entertainment and sport, people stay locked within a horizon so narrow that they can no longer see the heavens.\"", reflection: "", url: "69", saint: "Saint Elizabeth of Portugal : 07/04", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-of-portugal/", saintDate: "04-07"),


                 "05-07" : Days(title: "Pope John Paul II once told us, \"A good leader sees everything, overlooks a great deal, and corrects a little.\"", reflection: "", url: "70", saint: "Saint Anthony Zaccaria : 07/05", saintURL: "https://www.franciscanmedia.org/saint-anthony-zaccaria/", saintDate: "05-07"),


                 "06-07" : Days(title: "Pope John Paul II once said, \"On the basis of his work each person is fully entitled to consider himself a part owner of the great workbench at which he is working with everyone else. A way toward that goal could be found by associating labor with the ownership of capital joint ownership of the means of work, sharing by the workers in the management and/or profits of businesses, so-called shareholding by labor, etc.\"", reflection: "", url: "71", saint: "Saint Maria Goretti : 07/06", saintURL: "https://www.franciscanmedia.org/saint-maria-goretti/", saintDate: "06-07"),


                 "07-07" : Days(title: "Pope John Paul II once said, \"The greater the feeling of responsibility for the person the more true love there is.\"", reflection: "", url: "72", saint: "Blessed Emmanuel Ruiz and Companions : 07/07", saintURL: "https://www.franciscanmedia.org/blessed-emmanuel-ruiz-and-companions/", saintDate: "07-07"),


                 "08-07" : Days(title: "Pope John Paul II reminds us, \"There is no peace without justice, and no justice without forgiveness.\"", reflection: "", url: "73", saint: "Saint Gregory Grassi and Companions : 07/08", saintURL: "https://www.franciscanmedia.org/saint-gregory-grassi-and-companions/", saintDate: "08-07"),


                 "09-07" : Days(title: "Pope John Paul II once said, \"Evangelization through the Eucharist, in the Eucharist, and from the Eucharist - these are three inseparable aspects of how the Church lives the mystery of Christ and fulfills her mission of communicating it to all people.... In addition to the preaching of the message, the consummation of evangelization consists in the building up of the Church, which has no real existence without the sacramental life culminating in the Blessed Eucharist\"", reflection: "", url: "74", saint: "Saint Augustine Zhao Rong and Companions : 07/09", saintURL: "https://www.franciscanmedia.org/saint-augustine-zhao-rong-and-companions/", saintDate: "09-07"),


                 "10-07" : Days(title: "Pope John Paul II tells us, \"Prayer gives us strength for great ideals, for keeping up our faith, charity, purity, generosity; prayer gives us strength to rise up from indifference and guilt, if we have had the misfortune to give in to temptation and weakness. Prayer gives us light by which to see and to judge from God's perspective and from eternity. That is why you must not give up on praying!\"", reflection: "", url: "75", saint: "Saint Veronica Giuliani : 07/10", saintURL: "https://www.franciscanmedia.org/saint-veronica-giuliani/", saintDate: "10-07"),


                 "11-07" : Days(title: "Pope John Paul II once said, \"We Christians joyfully recognize the religious values we have in common with Islam. I would like to repeat what I said to young Muslims some years ago in Casablanca: 'We believe in the same God, the one God, the living God, the God who created the world and brings his creatures to their perfection.\"", reflection: "", url: "76", saint: "Saint Benedict : 07/11", saintURL: "https://www.franciscanmedia.org/saint-benedict/", saintDate: "11-07"),


                 "12-07" : Days(title: "Pope John Paul II reminds us, \"It is Jesus who stirs in you the desire to do something great with your lives, the will to follow an ideal, the refusal to allow yourselves to be ground down by mediocrity, the courage to commit yourselves humbly and patiently to improving yourselves and society, making the world more human and more fraternal.\"", reflection: "", url: "77", saint: "Saints John Jones and John Wall : 07/12", saintURL: "https://www.franciscanmedia.org/saints-john-jones-and-john-wall/", saintDate: "12-07"),


                 "13-07" : Days(title: "Pope John Paul tells us, \"The sacraments infuse holiness into the terrain of man's humanity: they penetrate the soul and body, the femininity and masculinity of the personal subject, with the power of holiness.\"", reflection: "", url: "78", saint: "Saint Henry : 07/13", saintURL: "https://www.franciscanmedia.org/saint-henry/", saintDate: "13-07"),


                 "14-07" : Days(title: "Pope John Paul II once said, \"The Gospel of Life is not for believers alone: it is for everyone. The issue of life and its defense and promotion is not a concern of the Christian alone. Although faith provides special light and strength, this question arises in every human conscience which seeks the truth and which cares about the future of humanity. Life certainly has a sacred and religious value, but in no way is that value a concern only of believers. The value at stake is one which every human being can grasp by the light of reason; thus it necessarily concerns everyone.\"", reflection: "", url: "79", saint: "Saint Kateri Tekakwitha : 07/14", saintURL: "https://www.franciscanmedia.org/saint-kateri-tekakwitha/", saintDate: "14-07"),


                 "15-07" : Days(title: "Pope John Paul II reminds us, \"The man who wishes to understand himself thoroughly must with his unrest, uncertainty, and even his weakness and sinfulness, with his life and death, draw near to Christ.\"", reflection: "", url: "80", saint: "Saint Bonaventure : 07/15", saintURL: "https://www.franciscanmedia.org/saint-bonaventure/", saintDate: "15-07"),


                 "16-07" : Days(title: "Pope John Paul II reminds us, \"The Eucharist is the full realization of the worship which humanity owes to God, and it cannot be compared to any other religious experience.... The risen Lord ... calls the faithful together to give them the light of His Word and the nourishment of His Body as the perennial sacramental wellspring of redemption. The grace flowing from this wellspring renews mankind, life, and history.\"", reflection: "", url: "81", saint: "Our Lady of Mount Carmel : 07/16", saintURL: "https://www.franciscanmedia.org/our-lady-of-mount-carmel/", saintDate: "16-07"),


                 "17-07" : Days(title: "Pope John Paul II once said, \"Those who perceive in themselves... the artistic vocation as poet, writer, sculptor, painter, musician, and actor feel at the same time an obligation not to waste this talent but to develop it, in order to put it to service of their neighbour and the humanity as a whole.\"", reflection: "", url: "82", saint: "Saint Francis Solano : 07/17", saintURL: "https://www.franciscanmedia.org/saint-francis-solano/", saintDate: "17-07"),


                 "18-07" : Days(title: "Pope John Paul II tells us, \"You are called to stand up for life! To respect and defend the mystery of life always and everywhere, including the lives of unborn babies, giving real help and encouragement to mothers in difficult situations. You are called to work and pray against abortion.\"", reflection: "", url: "83", saint: "Saint Camillus de Lellis : 07/18", saintURL: "https://www.franciscanmedia.org/saint-camillus-de-lellis/", saintDate: "18-07"),


                 "19-07" : Days(title: "Pope John Paul II reminds us, \"The human person is a unique composite - a unity of spirit and matter, soul and body, fashioned in the image of God and destined to live forever. Every human life is sacred, because every human person is sacred.\"", reflection: "", url: "84", saint: "Saint Mary MacKillop : 07/19", saintURL: "https://www.franciscanmedia.org/saint-mary-mackillop/", saintDate: "19-07"),


                 "20-07" : Days(title: "Pope John Paul II once said, \"It is pleasant to spend time with Him, to lie close to His breast like the Beloved Disciple and to feel the infinite love present in His Heart....how can we not feel a renewed need to spend time in spiritual converse, in silent adoration, in heartfelt love before Christ present in the Most Holy Sacrament?\"", reflection: "", url: "85", saint: "Saint Apollinaris : 07/20", saintURL: "https://www.franciscanmedia.org/saint-apollinaris/", saintDate: "20-07"),


                 "21-07" : Days(title: "Pope John Paul II tells us, \"Do not be afraid to be saints. Follow Jesus Christ who is the source of freedom and light. Be open to the Lord so that He may lighten all your ways.\"", reflection: "", url: "86", saint: "Saint Lawrence of Brindisi : 07/21", saintURL: "https://www.franciscanmedia.org/saint-lawrence-of-brindisi/", saintDate: "21-07"),


                 "22-07" : Days(title: "Pope John Paul II once said, \"Jesus Christ has taken the lead on the way of the cross. He has suffered first. He does not drive us toward suffering but shares it with us, wanting us to have life and to have it in abundance.\"", reflection: "", url: "87", saint: "Saint Mary Magdalene : 07/22", saintURL: "https://www.franciscanmedia.org/saint-mary-magdalene/", saintDate: "22-07"),


                 "23-07" : Days(title: "Pope John Paul II tells us, \"To reach peace, teach peace.\"", reflection: "", url: "88", saint: "Saint Bridget of Sweden : 07/23", saintURL: "https://www.franciscanmedia.org/saint-bridget/", saintDate: "23-07"),


                 "24-07" : Days(title: "Pope John Paul II once said, \"Although I have lived through much darkness, I have seen enough evidence to be unshakably convinced that no difficulty, no fear is so great that it can completely suffocate the hope that springs eternal in the hearts of the young... Do not let that hope die! Stake your lives on it! We are not the sum of our weaknesses and failures; we are the sum of the Father's love for us and our real capacity to become the image of his Son.\"", reflection: "", url: "89", saint: "Saint Sharbel Makhluf : 07/24", saintURL: "https://www.franciscanmedia.org/saint-sharbel-makhluf/", saintDate: "24-07"),


                 "25-07" : Days(title: "Pope John Paul II tells us, \"In Christ and through Christ man has acquired full awareness of his dignity, of the heights to which he is raised, of the surpassing worth of his own humanity, and of the meaning of his existence.\"", reflection: "", url: "90", saint: "Saint James the Apostle : 07/25", saintURL: "https://www.franciscanmedia.org/saint-james/", saintDate: "25-07"),


                 "26-07" : Days(title: "Pope John Paul II once said, \"[Speaking of marriage and family] In this entire world there is not a more perfect, more complete image of God, Unity and Community. There is no other human reality which corresponds more, humanly speaking, to that divine mystery.\"", reflection: "", url: "91", saint: "Saints Joachim and Anne : 07/26", saintURL: "https://www.franciscanmedia.org/saints-joachim-and-anne/", saintDate: "26-07"),


                 "27-07" : Days(title: "Pope John Paul II tells us, \"Chastity is a difficult long term matter, one must wait patiently for it to bear fruit for the happiness of loving kindness which it must bring. But at the same time chastity is the sure way to happiness.\"", reflection: "", url: "92", saint: "Blessed Antonio Lucci : 07/27", saintURL: "https://www.franciscanmedia.org/blessed-antonio-lucci/", saintDate: "27-07"),


                 "28-07" : Days(title: "Pope John Paul II once said, \"Man's life comes from God: it is his image and imprint, as sharing in his breath of life. God therefore is the sole Lord of this life: Man cannot do with it as he wills.\"", reflection: "", url: "93", saint: "Blessed Stanley Rother : 07/28", saintURL: "https://www.franciscanmedia.org/blessed-stanley-rother/", saintDate: "28-07"),


                 "29-07" : Days(title: "Pope John Paul II reminds us, \"In the Mass and in Eucharistic Adoration we meet the merciful love of God that passes through the Heart of Jesus Christ.\"", reflection: "", url: "94", saint: "Saint Martha : 07/29", saintURL: "https://www.franciscanmedia.org/saint-martha/", saintDate: "29-07"),


                 "30-07" : Days(title: "Pope John Paul II reminds us, \"The Eucharist is the source and summit of the Christian life\"", reflection: "", url: "95", saint: "Blessed Solanus Casey : 07/30", saintURL: "https://www.franciscanmedia.org/venerable-solanus-casey/", saintDate: "30-07"),


                 "31-07" : Days(title: "Pope John Paul II once said, \"United with the angels and saints of the heavenly Church, let us adore the most Holy Sacrament of the Eucharist. Prostrate, we adore this great mystery that contains God's new and definitive covenant with humankind in Christ.\"", reflection: "", url: "96", saint: "Saint Ignatius of Loyola : 07/31", saintURL: "https://www.franciscanmedia.org/saint-ignatius-of-loyola/", saintDate: "31-07"),





                 "01-08" : Days(title: "Pope John Paul II once said, \"Faith and Reason are like two wings of the human spirit by which is soars to the truth.\"", reflection: "", url: "97", saint: "Saint Alphonsus Liguori : 08/01", saintURL: "https://www.franciscanmedia.org/saint-alphonsus-liguori/", saintDate: "01-08"),


                 "02-08" : Days(title: "Pope John Paul II reminds us, \"Only through the Eucharist is it possible to live the heroic virtues of Christianity: charity, to the point of forgiving one's enemies; love for those who make us suffer; chastity in every age and situation of life; patience in suffering and when one is shocked by the silence of God in the tragedies of history or of one's own personal existence. You must always be Eucharistic souls in order to be authentic Christians\"", reflection: "", url: "98", saint: "Saint Eusebius of Vercelli : 08/02", saintURL: "https://www.franciscanmedia.org/saint-eusebius-of-vercelli/", saintDate: "02-08"),


                 "03-08" : Days(title: "Pope John Paul II once said, \"We are the sum of the Father's love for us\"", reflection: "", url: "99", saint: "Saint Peter Julian Eymard : 08/03", saintURL: "https://www.franciscanmedia.org/saint-peter-julian-eymard/", saintDate: "03-08"),


                 "04-08" : Days(title: "Pope John Paul II once said, \"Let us not accept violence as the way of peace. Let us instead begin by respecting true freedom: the resulting peace will be able to satisfy the world's expectations, for it will be a peace built on justice, a peace founded on the incomparable dignity of the free human being.\"", reflection: "", url: "100", saint: "Saint John Vianney : 08/04", saintURL: "https://www.franciscanmedia.org/saint-john-vianney/", saintDate: "04-08"),


                 "05-08" : Days(title: "Pope John Paul II once said, \"The lust of the flesh directs these desires [of personal union], however, to satisfaction of the body, often at the cost of a real and full communion of persons.\"", reflection: "", url: "101", saint: "Dedication of Saint Mary Major Basilica : 08/05", saintURL: "https://www.franciscanmedia.org/dedication-of-saint-mary-major-basilica/", saintDate: "05-08"),


                 "06-08" : Days(title: "Pope John Paul II reminds us, \"Do not be afraid. Open wide the doors to Christ.\"", reflection: "In times of despair, we can always call on Christ. Lord Jesus Christ, Son of God, have mercy on me, a sinner.", url: "102", saint: "Transfiguration of the Lord : 08/06", saintURL: "https://www.franciscanmedia.org/transfiguration-of-the-lord/", saintDate: "06-08"),


                 "07-08" : Days(title: "Pope John Paul II tells us, \"The fear of making permanent commitments can change the mutual love of husband and wife into two loves of self-two loves existing side by side, until they end in separation.\"", reflection: "", url: "103", saint: "Saint Cajetan : 08/07", saintURL: "https://www.franciscanmedia.org/saint-cajetan/", saintDate: "07-08"),


                 "08-08" : Days(title: "Pope John Paul II once said, \"The film industry has become a universal medium exercising a profound influence on the development of people's attitudes and choices, and possessing a remarkable ability to influence public opinion and culture across all social and political frontiers.\"", reflection: "", url: "104", saint: "Saint Dominic : 08/08", saintURL: "https://www.franciscanmedia.org/saint-dominic/", saintDate: "08-08"),


                 "09-08" : Days(title: "Pope John Paul II once said, \"The Church and the world have a great need of eucharistic worship. Jesus waits for us in this sacrament of love. Let us be generous with our time in going to meet Him in adoration and in contemplation that is full of faith and ready to make reparation for the great faults and crimes of the world. May our adoration never cease.\"", reflection: "", url: "105", saint: "Saint Teresa Benedicta of the Cross : 08/09", saintURL: "https://www.franciscanmedia.org/saint-teresa-benedicta-of-the-cross-edith-stein/", saintDate: "09-08"),


                 "10-08" : Days(title: "Pope John Paul II once said, \"That is the dignity of America, the reason she exists, the condition of her survival, yes, the ultimate test of her greatness: to respect every human person, especially the weak and most defenseless ones, those as yet unborn.\"", reflection: "", url: "106", saint: "Saint Lawrence : 08/10", saintURL: "https://www.franciscanmedia.org/saint-lawrence/", saintDate: "10-08"),


                 "11-08" : Days(title: "Pope John Paul II tells us, \"To predispose our mind to welcome the Lord who, as we say in the Creed, one day will come to judge the living and the dead, we must learn to recognize him as present in the events of daily life. Therefore, Advent is, so to speak, an intense training that directs us decisively toward him who already came, who will come, and who comes continuously.\"", reflection: "", url: "107", saint: "Saint Clare of Assisi : 08/11", saintURL: "https://www.franciscanmedia.org/saint-clare-of-assisi/", saintDate: "11-08"),


                 "12-08" : Days(title: "Pope John Paul II reminds us, \"It is the duty of every man to uphold the dignity of every woman.\"", reflection: "", url: "108", saint: "Saint Jane Frances de Chantal : 08/12", saintURL: "https://www.franciscanmedia.org/saint-jane-frances-de-chantal/", saintDate: "12-08"),


                 "13-08" : Days(title: "Pope John Paul II once said, \"Prayer finds its source in God's holiness and it is at the same time our response to this holiness.\"", reflection: "", url: "109", saint: "Saints Pontian and Hippolytus : 08/13", saintURL: "https://www.franciscanmedia.org/saints-pontian-and-hippolytus/", saintDate: "13-08"),


                 "14-08" : Days(title: "Pope John Paul II tells us, \"All of us experience the sad effects of blind submission to consumerism. In the first place it represents crass materialism. At the same time it represents a radical dissatisfaction because one quickly learns that the more one possesses, the more one wants, while deeper aspirations remain unsatisfied and perhaps even stifled.\"", reflection: "", url: "110", saint: "Saint Maximilian Mary Kolbe : 08/14", saintURL: "https://www.franciscanmedia.org/saint-maximilian-mary-kolbe/", saintDate: "14-08"),


                 "15-08" : Days(title: "On this day in 2000, Pope John Paul II reminded the youth, \"Do not be afraid to be the saints of the new mellineum!\"", reflection: "What does this mean to us? Maybe sainthood is attainable, do not give up and also, as Saint John Paul II told us, \"Be not afraid!\"", url: "111", saint: "Solemnity of the Assumption of Mary : 08/15", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-assumption-of-mary/", saintDate: "15-08"),


                 "16-08" : Days(title: "Pope John Paul II once told us, \"And Christ, through His own salvific suffering, is very much present in every human suffering, and can act from within that suffering by the powers of His Spirit of truth, His consoling spirit.\"", reflection: "Everyday, many of us suffer. We ask why, how, and we are dragged down by this. Let this quote, a beautiful reminder from this great saint lift us up in during our trials and tribulations.", url: "112", saint: "Saint Stephen of Hungary : 08/16", saintURL: "https://www.franciscanmedia.org/saint-stephen-of-hungary/", saintDate: "16-08"),


                 "17-08" : Days(title: "Pope John Paul II once told us, \"Faith and reason are like two wings on which the human spirit rises to the contemplation of truth; and God has placed in the human heart a desire to know the truth- in a word, to know himself- so that, by knowing and loving God, men and women may also come to the fullness of truth about themselves.\"", reflection: "", url: "113", saint: "Saint Joan of the Cross : 08/17", saintURL: "https://www.franciscanmedia.org/saint-joan-of-the-cross/", saintDate: "17-08"),


                 "18-08" : Days(title: "Pope John Paul once said, \"Dear young people, let yourselves be taken over by the light of Christ, and spread that light wherever you are.\"", reflection: "If you are young, take a moment to pray for your safety asking Jesus to watch over you. If you are old, take a moment to pray for the youth so they may be guided and protected by the light of Christ", url: "114", saint: "Saint Louis of Toulouse : 08/18", saintURL: "https://www.franciscanmedia.org/saint-louis-of-toulouse/", saintDate: "18-08"),


                 "19-08" : Days(title: "Pope John Paul II once said, \"Lord Jesus, Who in the Eucharist make your dwelling among us and become our traveling companion, sustain our Christian communities so that they may be ever more open to listening and accepting your Word. May they draw from the Eucharist a renewed commitment to spreading in society, by the proclamation of your Gospel, the signs and deeds of an attentive and active charity\"", reflection: "", url: "115", saint: "Saint John Eudes : 08/19", saintURL: "https://www.franciscanmedia.org/saint-john-eudes/", saintDate: "19-08"),


                 "20-08" : Days(title: "Pope John Paul II reminds us, \"Prayer joined to sacrifice constitutes the most powerful force in human history.\"", reflection: "", url: "116", saint: "Saint Bernard of Clairvaux : 08/20", saintURL: "https://www.franciscanmedia.org/saint-bernard-of-clairvaux/", saintDate: "20-08"),


                 "21-08" : Days(title: "Pope John Paul II tells us, \"Humanity looks to works of art to shed light upon its path and its destiny.\"", reflection: "Have you ever been to a Christian art exhibit? If not I would encourage you to experience the enlightment that may be found there.", url: "117", saint: "Saint Pius X : 08/21", saintURL: "https://www.franciscanmedia.org/saint-pius-x/", saintDate: "21-08"),


                 "22-08" : Days(title: "Pope John Paul II reminds us, \"Confidently open your most intimate aspirations to the Love of Christ who waits for you in the Eucharist. You will receive the answer to all your worries and you will see with joy that the consistency of your life which He asks of you is the door to fulfill the noblest dreams of your youth.\"", reflection: "", url: "118", saint: "Queenship of Mary : 08/22", saintURL: "https://www.franciscanmedia.org/queenship-of-mary/", saintDate: "22-08"),


                 "23-08" : Days(title: "Pope John Paul II once said, \"Truth must be the foundation stone, the cement to solidify the entire social edifice.\"", reflection: "", url: "95", saint: "Saint Rose of Lima : 08/23", saintURL: "https://www.franciscanmedia.org/saint-rose-of-lima/", saintDate: "23-08"),


                 "24-08" : Days(title: "Pope John Paul II reminds us, \"Through Mary, we come to her Son more easily.\"", reflection: "A great way would be to pray to our Blessed Mother, through the most holy mysteries of the Rosary.", url: "120", saint: "Saint Bartholomew : 08/24", saintURL: "https://www.franciscanmedia.org/saint-bartholomew/", saintDate: "24-08"),


                 "25-08" : Days(title: "Pope John Paul II reminds us, \"Faith leads us beyond ourselves. It leads us directly to God.\"", reflection: "In the end, it is not about us, it is as Bishop Barron says, the \"theo-drama\" not the \"ego-drama.\"", url: "121", saint: "Saint Louis of France : 08/25", saintURL: "https://www.franciscanmedia.org/saint-louis-of-france/", saintDate: "25-08"),


                 "26-08" : Days(title: "Pope John Paul II once said, \"Chess holds deep wisdoms of the people. It is truly an image of life, the reflection of human fate that has shown us the earthly way of suffering in darkness and permanent shortage of time. Like in chess, we encounter all kinds of traps, mistakes, settlements, sacrifices, kings, and queens, doubled pawns, and extraordinary moves while we are on the board ourselves.\"", reflection: "If you have ever played chess, you can relate to this. If not through a game of chess then most certainly through our daily life. Use times like those to ask Saint John Paul to interceed on our behalf, help us to persevere.", url: "1", saint: "Saint Joseph Calasanz : 08/26", saintURL: "https://www.franciscanmedia.org/saint-joseph-calasanz/", saintDate: "26-08"),


                 "27-08" : Days(title: "Pope John Paul II reminds us, \"Do not be afraid to be holy! Have the courage and humility to present yourselves to the world determined to be holy, since full, true freedom is born from holiness.\"", reflection: "", url: "2", saint: "Saint Monica : 08/27", saintURL: "https://www.franciscanmedia.org/saint-monica/", saintDate: "27-08"),


                 "28-08" : Days(title: "Pope John Paul II once said, \"Beauty is a key to the mystery and a call to transcendence. It is an invitation to savor life and to dream of the future. That is why the beauty of created things can never fully satisfy. It stirs that hidden nostalgia for God which a lover of beauty like Saint Augustine could express in incomparable terms: 'Late have I loved you, beauty so old and so new: late have I loved you!'.\"", reflection: "", url: "3", saint: "Saint Augustine of Hippo : 08/28", saintURL: "https://www.franciscanmedia.org/saint-augustine-of-hippo/", saintDate: "28-08"),


                 "29-08" : Days(title: "Pope John Paul II once told us, \"Forgiveness is above all a personal choice, a decision of the heart to go against the natural instinct to pay back evil with evil.\"", reflection: "", url: "4", saint: "Martyrdom of John the Baptist : 08/29", saintURL: "https://www.franciscanmedia.org/martyrdom-of-john-the-baptist/", saintDate: "29-08"),


                 "30-08" : Days(title: "Pope John Paul II once said, \"Darkness can only be scattered by light, hatred can only be conquered by love.\"", reflection: "", url: "5", saint: "Saint Jeanne Jugan : 08/30", saintURL: "https://www.franciscanmedia.org/saint-jeanne-jugan/", saintDate: "30-08"),


                 "31-08" : Days(title: "Pope John Paul II tells us, \"It's better to cry than be angry, because anger hurts others while tears flow silently through the soul and cleans the heart.\"", reflection: "", url: "6", saint: "Saints Joseph of Arimathea and Nicodemus : 08/31", saintURL: "https://www.franciscanmedia.org/saints-joseph-of-arimathea-and-nicodemus/", saintDate: "31-08"),




                 "01-09" : Days(title: "Pope John Paul II reminds us, \"The cross means there is no shipwreck without hope; there is no dark without dawn; nor storm without haven.\"", reflection: "", url: "7", saint: "Saint Giles: 09/01", saintURL: "https://www.franciscanmedia.org/saint-giles/", saintDate: "01-09"),


                 "02-09" : Days(title: "Pope John Paul II said once, \"God has, in fact, thought of us from eternity and has loved us as unique individuals. He has called every one of us by name, as the Good Shepherd 'calls His sheep by name.'\"", reflection: "", url: "8", saint: "Blessed John Francis Burté and Companions: 09/02", saintURL: "https://www.franciscanmedia.org/blessed-john-francis-burt-eacute-and-companions/", saintDate: "02-09"),


                 "03-09" : Days(title: "Pope John Paul II once said, \"The most faithful disciples of Christ have been builders of peace, to the point of forgiving their enemies, sometimes even to the point of giving their lives for them.\"", reflection: "", url: "9", saint: "Saint Gregory the Great: 09/03", saintURL: "https://www.franciscanmedia.org/saint-gregory-the-great/", saintDate: "03-09"),


                 "04-09" : Days(title: "Pope John Paul II tells us, \"Holiness is not reserved for a small number of exceptional persons. It is for everyone. It is the Lord who brings us to holiness when we are willing to collaborate in the salvation of the world for the glory of God, despite our sin and our sometimes rebellious temperament.\"", reflection: "", url: "10", saint: "Saint Rose of Viterbo: 09/04", saintURL: "https://www.franciscanmedia.org/saint-rose-of-viterbo/", saintDate: "04-09"),


                 "05-09" : Days(title: "Pope John II once said, \"Pray and learn to pray! Deepen your knowledge of the Word of the Living God by reading and meditating on the Scriptures.\"", reflection: "", url: "11", saint: "Saint Teresa of Calcutta: 09/05", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-calcutta/", saintDate: "05-09"),


                 "06-09" : Days(title: "Pope John Paul II once said, \"Mary is the sure path to our meeting with Christ. Devotion to the Mother of the Lord, when it is genuine, is always an impetus to a life guided by the spirit and values of the Gospel.\"", reflection: "", url: "12", saint: "Blessed Claudio Granzotto: 09/06", saintURL: "https://www.franciscanmedia.org/blessed-claudio-granzotto/", saintDate: "06-09"),


                 "07-09" : Days(title: "Pope John Paul said, \"'Lord you know that I love you...Lord, you know that I love you' (Jn 21:15-17). The Eucharist is, in a certain way, the culminating point of this answer. I wish to repeat it together with the whole Church to Him, who manifested His love by means of the Sacrament of His Body and Blood, remaining with us 'to the close of the age'\"", reflection: "", url: "13", saint: "Blessed Frédéric Ozanam: 09/07", saintURL: "https://www.franciscanmedia.org/blessed-fr-d-ric-ozanam/", saintDate: "07-09"),


                 "08-09" : Days(title: "Pope John Paul II once said' \"The Lord has given you a heart open to great horizons; do not be afraid to commit your life completely to the service of Christ and His Gospel! Listen to Him as He says again today: 'The harvest is abundant, but the laborers are few.\"", reflection: "", url: "14", saint: "Nativity of the Blessed Virgin Mary: 09/08", saintURL: "https://www.franciscanmedia.org/nativity-of-the-blessed-virgin-mary/", saintDate: "08-09"),


                 "09-09" : Days(title: "Pope John Paul II tells us, \"We must reflect the light of Christ through lives of prayer and joyful service to others.\"", reflection: "", url: "15", saint: "Saint Peter Claver: 09/09", saintURL: "https://www.franciscanmedia.org/saint-peter-claver/", saintDate: "09-09"),


                 "10-09" : Days(title: "Pope John Paul II once said, \"The Eucharist is the secret of my day. It gives strength and meaning to all my activities of service to the Church and to the whole world. . . . Let Jesus in the Blessed Sacrament speak to your hearts. It is he who is the true answer of life that you seek. He stays here with us: he is God with us. Seek him without tiring, welcome him without reserve, love him without interruption: today, tomorrow, forever.\"", reflection: "", url: "16", saint: "Saint Thomas of Villanova: 09/10", saintURL: "https://www.franciscanmedia.org/saint-thomas-of-villanova/", saintDate: "10-09"),


                 "11-09" : Days(title: "Pope John Paul II once said, \"War should belong to the tragic past, to history: it should find no place on humanity's agenda for the future.\"", reflection: "", url: "17", saint: "Saint Cyprian: 09/11", saintURL: "https://www.franciscanmedia.org/saint-cyprian/", saintDate: "11-09"),


                 "12-09" : Days(title: "Pope John Paul reminds us, \"From the Eucharist comes strength to live the Christian life and zeal to share that life with others\"", reflection: "", url: "18", saint: "Most Holy Name of the Blessed Virgin Mary: 09/12", saintURL: "https://www.franciscanmedia.org/mosaint-holy-name-of-the-blessed-virgin-mary/", saintDate: "12-09"),


                 "13-09" : Days(title: "Pope John Paul II tells us, \"May Mary, who in the freedom of her 'Fiat' and her presence at the foot of the cross, offered to the world, Jesus, the Liberator, help us to find him in the Sacrament of the altar\"", reflection: "", url: "19", saint: "Saint John Chrysostom: 09/13", saintURL: "https://www.franciscanmedia.org/saint-john-chrysostom/", saintDate: "13-09"),


                 "14-09" : Days(title: "Pope John Paul II reminds us, \"God passionately desires and ardently yearns for our salvation... Nothing is greater than this: that the blood of God was poured out for us.\"", reflection: "", url: "20", saint: "Exaltation of the Holy Cross: 09/14", saintURL: "https://www.franciscanmedia.org/exaltation-of-the-holy-cross/", saintDate: "14-09"),


                 "15-09" : Days(title: "Pope John Paul II once said, \"May you experience the truth that he, Christ, looks upon you with love.\"", reflection: "Take a moment to reflect on all of the great things you have done over the past week and if you would like, give thanks to God for allowing you to have such a great impact in the lives of others.", url: "21", saint: "Our Lady of Sorrows: 09/15", saintURL: "https://www.franciscanmedia.org/our-lady-of-sorrows/", saintDate: "15-09"),


                 "16-09" : Days(title: "Pope John Paul II reminds us, \"Physical condition or advancing of age are not obstacles to a perfect life. God does not look at external things but at the soul.\"", reflection: "Young or old, healty or sick we are all Gods children and may we take this time to remember that we are never alone.", url: "22", saint: "Saint Cornelius: 09/16", saintURL: "https://www.franciscanmedia.org/saint-cornelius/", saintDate: "16-09"),


                 "17-09" : Days(title: "Pope John Paul II tells us, \"Around the world, we can see the results of exploitation which destroys much without taking future generations into account. Today, all men have a duty to show themselves worthy of the mission given them by the Creator by ensuring the safekeeping of that creation.\"", reflection: "", url: "23", saint: "Saint Robert Bellarmine: 09/17", saintURL: "https://www.franciscanmedia.org/saint-robert-bellarmine/", saintDate: "17-09"),


                 "18-09" : Days(title: "Pope John Paul II once said, \"We can pray perfectly when we are out in the mountains or on a lake and we feel at one with nature. Nature speaks for us or rather speaks to us. We pray perfectly.\"", reflection: "Nature is one of Gods gifts to us. Even if we are not in the mountains or in a forest walkng along a path we can still pray and meditate becuase nature is always around us in many other ways.", url: "24", saint: "Saint Joseph of Cupertino: 09/18", saintURL: "https://www.franciscanmedia.org/saint-joseph-of-cupertino/", saintDate: "18-09"),


                 "19-09" : Days(title: "Pope John Paul II reminds us, \"Through the Rosary the faithful receive abundant grace, as though from the very hands of the Mother of the Redeemer.\"", reflection: "", url: "25", saint: "Saint Januarius: 09/19", saintURL: "https://www.franciscanmedia.org/saint-januarius/", saintDate: "19-09"),


                 "20-09" : Days(title: "Pope John Paul II once said, \"The Mother of Christ, who stands at the very center of this mystery...is given as mother to every single individual and all mankind.\"", reflection: "", url: "26", saint: "Saints Andrew Kim Taegon, Paul Chong Hasang, and Companions: 09/20", saintURL: "https://www.franciscanmedia.org/saints-andrew-kim-taegon-paul-chong-hasang-and-companions/", saintDate: "20-09"),


                 "21-09" : Days(title: "Pope John Paul II once said, \"God of our fathers, you chose Abraham and his descendants to bring your name to the nations: We are deeply saddened by the behaviour of those who in the course of history have caused these children of yours to suffer, and, asking your forgiveness, we wish to commit ourselves to genuine brotherhood with the people of the covenant.\"", reflection: "", url: "27", saint: "Saint Matthew: 09/21", saintURL: "https://www.franciscanmedia.org/saint-matthew/", saintDate: "21-09"),


                 "22-09" : Days(title: "On this day in 1999, Pope John Paul wrote a message to the young people of Israel and Palestine. One thing he said was, \"None of us is alone in this world; each of us is a vital piece of the great mosaic of humanity as a whole.\"", reflection: "", url: "28", saint: "Saint Lorenzo Ruiz and Companions: 09/22", saintURL: "https://www.franciscanmedia.org/saint-lorenzo-ruiz-and-companions/", saintDate: "22-09"),


                 "23-09" : Days(title: "Pope John Paul II reminds us, \"Only the chaste man and the chaste woman are capable of true love.\"", reflection: "Theology of the Body is the topic of a series of 129 lectures given by Pope John Paul II during his Wednesday audiences in St. Peter's Square and the Paul VI Audience Hall between September 5, 1979, and November 28, 1984. I invite everone to explore it.", url: "29", saint: "Saint Pio of Pietrelcina: 09/23", saintURL: "https://www.franciscanmedia.org/saint-pio-of-pietrelcina/", saintDate: "23-09"),


                 "24-09" : Days(title: "Pope John Paul II once said, \"There is nothing more man needs than Divine Mercy - that love which is benevolent, which is compassionate, which raises man above his weakness to the infinite heights to the holiness of God.\"", reflection: "", url: "30", saint: "Saint John Henry Newman: 09/24", saintURL: "https://www.franciscanmedia.org/blessed-john-henry-newman/", saintDate: "24-09"),


                 "25-09" : Days(title: "Pope John Paul II once said, \"You made us for yourself, Lord, and our heart is restless until it rests in you. In this creative restlessness beats and pulsates what is most deeply human - the search for truth, the insatiable need for the good, hunger for freedom, nostalgia for the beautiful, and the voice of conscience.\"", reflection: "", url: "31", saint: "Saints Louis Martin and Zélie Guerin: 09/25", saintURL: "https://www.franciscanmedia.org/blesseds-louis-martin-and-zelie-guerin/", saintDate: "25-09"),


                 "26-09" : Days(title: "Pope John Paul II tells us, \"Love of Christ does not distract us from interest in others, but rather invites us to responsibility for them, to the exclusion of no one...\"", reflection: "", url: "32", saint: "Saint Paul VIL 09/26", saintURL: "https://www.franciscanmedia.org/saint-paul-vi/", saintDate: "26-09"),


                 "27-09" : Days(title: "Pope John Paul II reminds us, \"Violence is a crime against humanity, for it destroys the very fabric of society.\"", reflection: "", url: "33", saint: "Saint Vincent de Paul: 09/27", saintURL: "https://www.franciscanmedia.org/saint-vincent-de-paul/", saintDate: "27-09"),


                 "28-09" : Days(title: "On this day in 1958, Karol Wojtyla is ordained auxiliary Bishop of Krakow. Pope John Paul II once said, \"Christ remains primary in your life only when he enjoys the first place in your mind and heart. Thus you must continuously unite yourself to him in prayer.... Without prayer there can be no joy, no hope, no peace. For prayer is what keeps us in touch with Christ.\"", reflection: "", url: "34", saint: "Saint Wenceslaus: 09/28", saintURL: "https://www.franciscanmedia.org/saint-wenceslaus/", saintDate: "28-09"),


                 "29-09" : Days(title: "Pope John Paul II reminds us, \"Open your minds and hearts to the beauty of all that God has made and to His special, personal love for each one of you.\"", reflection: "If you have a moment, think of one talent God has given to you and reflect on how you use it for the benefit of others.", url: "35", saint: "Saints Michael, Gabriel, and Raphael: 09/29", saintURL: "https://www.franciscanmedia.org/saints-michael-gabriel-and-raphael/", saintDate: "29-09"),


                 "30-09" : Days(title: "Pope John Paul II once said, \"With the Rosary, the Christian people sits at the school of Mary and is led to contemplate the beauty on the face of Christ and to experience the depths of his love.\"", reflection: "", url: "36", saint: "Saint Jerome: 09/30", saintURL: "https://www.franciscanmedia.org/saint-jerome/", saintDate: "30-09"),


                 "31-09" : Days(title: "Pope John Paul II reminds us, \"Beneath the Sacred Host, Christ is contained, the Redeemer of the world\"", reflection: "", url: "37", saint: "", saintURL: "", saintDate: "31-09"),





                 "01-10" : Days(title: "Pope John Paul II told us, \"Where, if not in the Divine Mercy, can the world find refuge and the light of hope?\"", reflection: "", url: "38", saint: "Saint Thérèse of Lisieux: 10/01", saintURL: "https://www.franciscanmedia.org/saint-theresa-of-the-child-jesus/", saintDate: "01-10"),


                 "02-10" : Days(title: "Pope John Paul II once said, \"The Gospel lives in conversation with culture, and if the Church holds back from the culture, the Gospel itself falls silent. Therefore, we must be fearless in crossing the threshold of the communication and information revolution now taking place.\"", reflection: "", url: "39", saint: "Feast of the Guardian Angels: 10/02", saintURL: "https://www.franciscanmedia.org/feasaint-of-the-guardian-angels/", saintDate: "02-10"),


                 "03-10" : Days(title: "Pope John Paul II reminds us, \"There is no place for selfishness-and no place for fear! Do not be afraid, then, when love makes demands. Do not be afraid when love requires sacrifice\"", reflection: "", url: "40", saint: "Saint Theodora Guérin: 10/03", saintURL: "https://www.franciscanmedia.org/saint-theodora-gu-eacute-rin/", saintDate: "03-10"),


                 "04-10" : Days(title: "Pope John Paul II says, \"the path of goodness had a name it is called Love in it we find the key to every hope and has it's root in God Himself\"", reflection: "", url: "41", saint: "Saint Francis of Assisi: 10/04", saintURL: "https://www.franciscanmedia.org/saint-francis-of-assisi/", saintDate: "04-10"),


                 "05-10" : Days(title: "", reflection: "", url: "42", saint: "Saint Maria Faustina Kowalska: 10/05", saintURL: "https://www.franciscanmedia.org/saint-maria-faustina-kowalska/", saintDate: "05-10"),


                 "06-10" : Days(title: "", reflection: "", url: "43", saint: "Saint Bruno: 10/06", saintURL: "https://www.franciscanmedia.org/saint-bruno/", saintDate: "06-10"),


                 "07-10" : Days(title: "", reflection: "", url: "44", saint: "Our Lady of the Rosary: 10/07", saintURL: "https://www.franciscanmedia.org/our-lady-of-the-rosary/", saintDate: "07-10"),


                 "08-10" : Days(title: "On this day in 1995 Pope John Paul gave a homily in Orioles Park at Camden Yards.  One thing he said that we can relfect on is, \"It is important for America that the moral truths which make freedom possible should be passed on to each new generation. Every generation of Americans needs to know that freedom consists not in doing what we like, but in having the right to do what we ought. ... Christ asks us to guard the truth because, as he promised us: 'You will know the truth and the truth will make you free.' Depositum custodi! We must guard the truth that is the condition of authentic freedom, the truth that allows freedoms to be fulfilled in goodness. We must guard the deposit of divine truth handed down to us.\"", reflection: "", url: "45", saint: "Saint John Leonardi: 10/08", saintURL: "https://www.franciscanmedia.org/saint-john-leonardi/", saintDate: "08-10"),


                 "09-10" : Days(title: "Pope John Paul II once said, \"The person who does not decide to love forever will find it very difficult to really love for even one day.\"", reflection: "", url: "46", saint: "Saint Denis and Companions: 10/09", saintURL: "https://www.franciscanmedia.org/saint-denis-and-companions/", saintDate: "09-10"),


                 "10-10" : Days(title: "Pope John Paul II reminds us, \"The future is in your hearts and in your hands. God is entrusting to you the task, at once difficult and uplifting, of working with Him in the building of the civilization of love.\"", reflection: "", url: "47", saint: "Saint Francis Borgia: 10/10", saintURL: "https://www.franciscanmedia.org/saint-francis-borgia/", saintDate: "10-10"),


                 "11-10" : Days(title: "Pope John Paul II reminds us, \"Christian holiness does not being sinless, but rather it means struggling not to give in and always getting up after every fall.\"", reflection: "", url: "48", saint: "Saint John XXIII: 10/11", saintURL: "https://www.franciscanmedia.org/saint-john-xxiii/", saintDate: "11-10"),


                 "12-10" : Days(title: "Pope John Paul II once said, \"A person's rightful due is to be treated as an object of love, not as an object for use.\"", reflection: "", url: "49", saint: "Blessed Francis Xavier Seelos: 10/12", saintURL: "https://www.franciscanmedia.org/blessed-francis-xavier-seelos/", saintDate: "12-10"),


                 "13-10" : Days(title: "Pope John Paul II reminds us, \"In order to see Jesus, we first need to let him look at us!\"", reflection: "", url: "50", saint: "Blessed Marie-Rose Durocher: 10/13", saintURL: "https://www.franciscanmedia.org/blessed-marie-rose-durocher/", saintDate: "13-10"),


                 "14-10" : Days(title: "Pope John Paul II once said, \"The Eucharist is a priceless treasure: by not only celebrating it but also by praying before it outside of Mass we are enabled to make contact with the very wellspring of grace.\"", reflection: "", url: "51", saint: "Saint Callistus I: 10/14", saintURL: "https://www.franciscanmedia.org/saint-callistus-i/", saintDate: "14-10"),


                 "15-10" : Days(title: "Pope John Paul II tells us, \"Faced with the sacredness of life and of the human person, and before the marvels of the universe, wonder is the only appropriate attitude.\"", reflection: "", url: "52", saint: "Saint Teresa of Avila: 10/15", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-avila/", saintDate: "15-10"),


                 "16-10" : Days(title: "On this day in 2002 Pope John Paul II released his apostolic letter Rosarium Virginis Mariae (“The Rosary of the Virgin Mary”), which introduced to the Church a new set of mysteries for the Rosary to complement the traditional 15. In addition to the Joyful, Sorrowful and Glorious Mysteries, Pope John Paul II recommended the Luminous Mysteries, which he said brought out fully \"the Christological depth of the Rosary\" by including \"the mysteries of Christ’s public ministry between his baptism and his passion\"", reflection: "", url: "53", saint: "Saint Margaret Mary Alacoque: 10/16", saintURL: "https://www.franciscanmedia.org/saint-margaret-mary-alacoque/", saintDate: "16-10"),


                 "17-10" : Days(title: "Pope John Paul II once said, \"We must open our eyes to admire God who hides and at the same time reveals himself in things and introduces us into the realms of mystery... we must be pure and simple like children, capable of admiring, being astonished, of marveling, and being enchanted by the divine gestures of love and closeness we witness.\"", reflection: "", url: "54", saint: "Saint Ignatius of Antioch: 10/17", saintURL: "https://www.franciscanmedia.org/saint-ignatius-of-antioch/", saintDate: "17-10"),


                 "18-10" : Days(title: "Pope John Paul II tells us, \"St. Joseph was a just man, a tireless worker, the upright guardian of those entrusted to his care. May he always guard, protect and enlighten families.\"", reflection: "", url: "55", saint: "Saint Luke: 10/18", saintURL: "https://www.franciscanmedia.org/saint-luke/", saintDate: "18-10"),


                 "19-10" : Days(title: "Pope John Paul II tells us, \"Do not be afraid. Do not be satisfied with mediocrity. Put out into the deep and let down your nets for a catch.\"", reflection: "", url: "56", saint: "Saints Isaac Jogues, Jean de Brébeuf, and Companions: 10/19", saintURL: "https://www.franciscanmedia.org/saint-isaac-jogues-jean-de-br-eacute-beuf-and-companions/", saintDate: "19-10"),


                 "20-10" : Days(title: "Pope John Paul II once said, \"This is the wonderful truth, my dear friends: the Word, which became flesh two thousand years ago, is present today in the Eucharist\"", reflection: "", url: "57", saint: "Saint Paul of the Cross: 10/20", saintURL: "https://www.franciscanmedia.org/saint-paul-of-the-cross/", saintDate: "20-10"),


                 "21-10" : Days(title: "Pope John Paul II tells us, \"Only in Christ can men and women find answers to the ultimate questions that trouble them. Only in Christ can they fully understand their dignity as persons created and loved by God.\"", reflection: "", url: "58", saint: "Saint Hilarion: 10/21", saintURL: "https://www.franciscanmedia.org/saint-hilarion/", saintDate: "21-10"),


                 "22-10" : Days(title: "Pope John Paul II once said, \"The frenetic pace of modern life can lead to an obscuring or even a loss of what is truly human... Perhaps more than in other periods of history, our time is in need of that genius which belongs to women, and which can ensure sensitivity for human beings in every circumstance.\"", reflection: "", url: "59", saint: "Saint John Paul II: 10/22", saintURL: "https://www.franciscanmedia.org/saint-john-paul-ii/", saintDate: "22-10"),


                 "23-10" : Days(title: "Pope John Paul II once said, \"The body in its masculinity and femininity has been called \"from the beginning\" to become the manifestation of the spirit. The body, in fact, and only the body, is capable of making visible what is invisible: the spiritual and the divine.\"", reflection: "", url: "60", saint: "Saint John of Capistrano: 10/23", saintURL: "https://www.franciscanmedia.org/saint-john-of-capistrano/", saintDate: "23-10"),


                 "24-10" : Days(title: "Pope John Paul II once said, \"Apart from the mercy of God, there is no other source of hope for mankind.\"", reflection: "", url: "61", saint: "Saint Anthony Mary Claret: 10/24", saintURL: "https://www.franciscanmedia.org/saint-anthony-claret/", saintDate: "24-10"),


                 "25-10" : Days(title: "Pope John Paul II reminds us, \"The battle against the Devil, which is the principal task of Saint Michael the Archangel, is still being fought today, because the Devil is still alive and active in the world.\"", reflection: "", url: "62", saint: "Saint Antônio de Sant’Anna Galvão: 10/25", saintURL: "https://www.franciscanmedia.org/saint-ant-ocirc-nio-de-sant-146-anna-galv-atilde-o/", saintDate: "25-10"),


                 "26-10" : Days(title: "Pope John Paul II tells us, \"When you wonder about the mystery of yourself, look to Christ, who gives you the meaning of life. When you wonder what it means to be a mature person, look to Christ, who is the fulfillness of humanity. And when you wonder about your role in the future of the world look to Christ.\"", reflection: "", url: "63", saint: "Saint Peter of Alcantara: 10/26", saintURL: "https://www.franciscanmedia.org/saint-peter-of-alcantara/", saintDate: "26-10"),


                 "27-10" : Days(title: "Pope John Paul II once said, \"Life is entrusted to man as a treasure which must not be squandered, as a talent which must be used well.\"", reflection: "", url: "64", saint: "Blessed Bartholomew of Vicenza: 10/27", saintURL: "https://www.franciscanmedia.org/blessed-bartholomew-of-vicenza/", saintDate: "27-10"),


                 "28-10" : Days(title: "Pope John Paul II reminds us, \"Love demands a personal commitment to the will of God.\"", reflection: "", url: "65", saint: "Saints Simon and Jude: 10/28", saintURL: "https://www.franciscanmedia.org/saints-simon-and-jude/", saintDate: "28-10"),


                 "29-10" : Days(title: "Pope John Paul II tells us, \"Each individual in fact has moral responsibility for the acts which he personally performs; no one can be exempted from this responsibility, and on the basis of it everyone will be judged by God himself.\"", reflection: "", url: "66", saint: "Saint Narcissus of Jerusalem: 10/29", saintURL: "https://www.franciscanmedia.org/saint-narcissus-of-jerusalem/", saintDate: "29-10"),


                 "30-10" : Days(title: "Pope John Paul II reminds us, \"From this moment on, live the Eucharist fully; be persons for whom the Holy Mass, Communion, and Eucharistic adoration are the center and summit of their whole life.\"", reflection: "", url: "67", saint: "Saint Alphonsus Rodriguez: 10/30", saintURL: "https://www.franciscanmedia.org/saint-alphonsus-rodriguez/", saintDate: "30-10"),


                 "31-10" : Days(title: "Pope John Paul II reminds us, \"Offer Christ your heart in meditation and personal prayer which is the foundation of the spiritual life.\"", reflection: "", url: "68", saint: "Saint Wolfgang of Regensburg: 10/31", saintURL: "https://www.franciscanmedia.org/saint-wolfgang-of-regensburg/", saintDate: "31-10"),





                 "01-11" : Days(title: "On this day in 1946, Karol Wojtyla is ordained a priest. Pope John Paul II reminds us, \"Real love is demanding. I would fail in my mission if I did not tell you so. Love demands a personal commitment to the will of God.\"", reflection: "Take a moment and pray for the ones you love and also for the ones we don't love, good and bad, everyone needs our prayers.", url: "69", saint: "Solemnity of All Saints: 11/01", saintURL: "https://www.franciscanmedia.org/solemnity-of-all-saints/", saintDate: "01-11"),


                 "02-11" : Days(title: "Pope John Paul II tells us, \"To humanity, which sometimes seems to be lost and dominated by the power of evil, selfishness and fear, the risen Lord gives the gift of His love which forgives, reconciles and reopens the soul to hope.\"", reflection: "", url: "70", saint: "Commemoration of All the Faithful Departed: 11/02", saintURL: "https://www.franciscanmedia.org/commemoration-of-all-the-faithful-departed/", saintDate: "02-11"),


                 "03-11" : Days(title: "Pope John Paul II asks us, \"What have I done with my baptism and confirmation? Is Christ really at the center of my life? Do I have time for prayer in my life? Do I live my life as a vocation and mission?\"", reflection: "", url: "71", saint: "Saint Martin de Porres: 11/03", saintURL: "https://www.franciscanmedia.org/saint-martin-de-porres/", saintDate: "03-11"),


                 "04-11" : Days(title: "Pope John Paul II once said, \"Even if the forces of darkness appear to prevail, those who believe in God know that evil and death do not have the final say.\"", reflection: "", url: "72", saint: "Saint Charles Borromeo: 11/04", saintURL: "https://www.franciscanmedia.org/saint-charles-borromeo/", saintDate: "04-11"),


                 "05-11" : Days(title: "Pope John Paul II tells us, \"People are made for happiness. Rightly, then, you thirst for happiness. Christ has the answer to this desire of yours. But he asks you to trust him.\"", reflection: "", url: "73", saint: "Saint Peter Chrysologus: 11/05", saintURL: "https://www.franciscanmedia.org/saint-peter-chrysologus/", saintDate: "05-11"),


                 "06-11" : Days(title: "Pope John Paul II tells us, \"The Eucharist is the heart of the Church. Where Eucharistic life flourishes, there the life of the church will blossom.\"", reflection: "", url: "74", saint: "Saint Nicholas Tavelic and Companions: 11/06", saintURL: "https://www.franciscanmedia.org/saint-nicholas-tavelic-and-companions/", saintDate: "06-11"),


                 "07-11" : Days(title: "Pope John Paul II once said, \"Confession is an act of honesty and courage - an act of entrusting ourselves, beyond sin, to the mercy of a loving and forgiving God.\"", reflection: "", url: "75", saint: "Saint Didacus: 11/07", saintURL: "https://www.franciscanmedia.org/saint-didacus/", saintDate: "07-11"),


                 "08-11" : Days(title: "Pope John Paul II tells us, \"Allow the light and the healing presence of Christ to shine brightly through your lives. In that way, all those who come in contact with you will discover the loving kindness of God.\"", reflection: "", url: "76", saint: "Blessed John Duns Scotus: 11/08", saintURL: "https://www.franciscanmedia.org/blessed-john-duns-scotus/", saintDate: "08-11"),


                 "09-11" : Days(title: "Pope John Paul II reminds us, \"Freedom is not the ability to do anything we want, whenever we want. Rather, FREEDOM is the ability to live responsibly the truth of our relationship with God and with one another.\"", reflection: "", url: "77", saint: "Dedication of St. John Lateran: 11/09", saintURL: "https://www.franciscanmedia.org/dedication-of-saint-john-lateran/", saintDate: "09-11"),


                 "10-11" : Days(title: "Pope John Paul II reminds us, \"The only way to peace is forgiveness.\"", reflection: "", url: "78", saint: "Saint Leo the Great: 11/10", saintURL: "https://www.franciscanmedia.org/saint-leo-the-great/", saintDate: "10-11"),


                 "11-11" : Days(title: "Pope John Paul II tells us, \"An important day in a young person's life is the day on which he becomes convinced that Christ is the only Friend who will not disappoint him, on which he can always count.\"", reflection: "", url: "79", saint: "Saint Martin of Tours: 11/11", saintURL: "https://www.franciscanmedia.org/saint-martin-of-tours/", saintDate: "11-11"),


                 "12-11" : Days(title: "Pope John Paul II once said, \"Your faith will help you realize that it is Jesus Himself Who is present in the Blessed Sacrament, waiting for you and calling you to spend one special specific hour with Him each week.\"", reflection: "", url: "80", saint: "Saint Josaphat: 11/12", saintURL: "https://www.franciscanmedia.org/saint-josaphat/", saintDate: "12-11"),


                 "13-11" : Days(title: "Pope John Paul II once said, \"The history of mankind, the history of salvation, passes by way of the family... The family is placed at the center of the great struggle between good and evil, between life and death, between love and all that is opposed to love.\"", reflection: "", url: "81", saint: "Saint Frances Xavier Cabrini: 11/13", saintURL: "https://www.franciscanmedia.org/saint-frances-xavier-cabrini/", saintDate: "13-11"),


                 "14-11" : Days(title: "Pope John Paul II tells us, \"Do not forget that true love sets no conditions; it does not calculate or complain, but simply loves.\"", reflection: "", url: "82", saint: "Saint Gertrude the Great: 11/14", saintURL: "https://www.franciscanmedia.org/saint-gertrude-the-great/", saintDate: "14-11"),


                 "15-11" : Days(title: "Pope John Paul II once said, \"What really matters in life is that we are loved by Christ and that we love Him in return. In comparison to the love of Jesus, everything else is secondary. And, without the love of Jesus, everything is useless.\"", reflection: "", url: "83", saint: "Saint Albert the Great: 11/15", saintURL: "https://www.franciscanmedia.org/saint-albert-the-great/", saintDate: "15-11"),


                 "16-11" : Days(title: "Pope John Paul II tells us, \"The world looks to the priest, because it looks to Jesus! No one can see Christ; but everyone sees the priest, and through him they wish to catch a glimpse of the Lord! Immense is the grandeur of the Lord! Immense is the grandeur and dignity of the priest!\"", reflection: "", url: "84", saint: "Saint Margaret of Scotland: 11/16", saintURL: "https://www.franciscanmedia.org/saint-margaret-of-scotland/", saintDate: "16-11"),


                 "17-11" : Days(title: "Pope John Paul II once said, \"Catholic education aims not only to communicate facts but also to transmit a coherent, comprehensive vision of life, in the conviction that the truths contained in that vision liberate students in the most profound meaning of human freedom.\"", reflection: "", url: "85", saint: "Saint Elizabeth of Hungary: 11/17", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-of-hungary/", saintDate: "17-11"),


                 "18-11" : Days(title: "Pope John Paul II reminds us, \"Life with Christ is a wonderful adventure.\"", reflection: "", url: "86", saint: "Dedication of Churches of Saints Peter and Paul: 11/18", saintURL: "https://www.franciscanmedia.org/dedication-of-churches-of-saints-peter-and-paul/", saintDate: "18-11"),


                 "19-11" : Days(title: "Pope John Paul II once said, \"Love between man and woman cannot be built without sacrifices and self-denial.\"", reflection: "", url: "87", saint: "Saint Agnes of Assisi: 11/19", saintURL: "https://www.franciscanmedia.org/saint-agnes-of-assisi/", saintDate: "19-11"),


                 "20-11" : Days(title: "Pope John Paul II once said, \"We are not the sum of our weaknesses and failures, we are the sum of the Father's love for us and our real capacity to become the image of His Son Jesus.\"", reflection: "", url: "88", saint: "Saint Rose Philippine Duchesne: 11/20", saintURL: "https://www.franciscanmedia.org/saint-rose-philippine-duchesne/", saintDate: "20-11"),


                 "21-11" : Days(title: "Pope John Paul II tells us, \"True holiness does not mean a flight from the world; rather, it lies in the effort to incarnate the Gospel in everyday life, in the family, at school and at work, and in social and political involvement.\"", reflection: "", url: "89", saint: "Presentation of the Blessed Virgin Mary: 11/21", saintURL: "https://www.franciscanmedia.org/presentation-of-mary/", saintDate: "21-11"),


                 "22-11" : Days(title: "Pope John Paul II reminds us, \"You must be strong, dear brothers and sisters. You must be strong with the strength that comes from faith.\"", reflection: "", url: "90", saint: "Saint Cecilia: 11/22", saintURL: "https://www.franciscanmedia.org/saint-cecilia/", saintDate: "22-11"),


                 "23-11" : Days(title: "Pope John Paul II once said, \"True holiness does not mean a flight from the world; rather, it lies in the effort to incarnate the Gospel in everyday life, in the family, at school and at work, and in social and political involvement.\"", reflection: "", url: "91", saint: "Blessed Miguel Agustín Pro: 11/23", saintURL: "https://www.franciscanmedia.org/blessed-miguel-agusaint-iacute-n-pro/", saintDate: "23-11"),


                 "24-11" : Days(title: "Pope John Paul II tells us, \"My desire is for the young people of the entire world to come closer to Mary. She is the bearer of an indelible youthfulness and beauty that never wanes. May young people have increasing confidence in her and may they entrust their lives to her.\"", reflection: "", url: "92", saint: "Saint Andrew Dung-Lac and Companions: 11/24", saintURL: "https://www.franciscanmedia.org/saint-andrew-dung-lac-and-companions/", saintDate: "24-11"),


                 "25-11" : Days(title: "Pope John Paul II once said, \"There is no evil to be faced that Christ does not face with us. There is no enemy that Christ has not already conquered. There is no cross to bear that Christ has not already borne for us, and does not now bear with us.\"", reflection: "", url: "93", saint: "Saint Catherine of Alexandria: 11/25", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-alexandria/", saintDate: "25-11"),


                 "26-11" : Days(title: "Pope John Paul II reminds us, \"Nobody is so poor he has nothing to give, and nobody is so rich he has nothing to receive.\"", reflection: "", url: "94", saint: "Saint Columban: 11/26", saintURL: "https://www.franciscanmedia.org/saint-columban/", saintDate: "26-11"),


                 "27-11" : Days(title: "Pope John Paul II tells us, \"I plead with you--never, ever give up on hope, never doubt, never tire, and never become discouraged. Be not afraid.\"", reflection: "", url: "95", saint: "Saint Francesco Antonio Fasani: 11/27", saintURL: "https://www.franciscanmedia.org/saint-francesco-antonio-fasani/", saintDate: "27-11"),


                 "28-11" : Days(title: "Pope John Paul II reminds us, \"Prayer can truly change your life. For it turns your attention away from yourself and directs your mind and your heart toward the Lord. If we look only at ourselves, with our own limitations and sins, we quickly give way to sadness and discouragement. But if we keep our eyes fixed on the Lord, then our hearts are filled with hope, our minds are washed n the light of truth, and we come to know the fullness of the Gospel with all is promise and life.\"", reflection: "", url: "96", saint: "Saint James of the Marche: 11/28", saintURL: "https://www.franciscanmedia.org/saint-james-of-the-marche/", saintDate: "28-11"),


                 "29-11" : Days(title: "Pope John Paul II once said, \"The way Jesus shows you is not easy. Rather, it is like a path winding up a mountain. Do not lose heart! The steeper the road, the faster it rises towards ever wider horizons.\"", reflection: "", url: "97", saint: "Saint Clement: 11/29", saintURL: "https://www.franciscanmedia.org/saint-clement/", saintDate: "29-11"),


                 "30-11" : Days(title: "Pope John Paul II reminds us, \"The sickness of a family member, friend or neighbor is a call to Christians to demonstrate true compassion, that gentle and persevering sharing in another's pain.\"", reflection: "", url: "98", saint: "Saint Andrew: 11/30", saintURL: "https://www.franciscanmedia.org/saint-andrew/", saintDate: "30-11"),


                 "31-11" : Days(title: "Pope John Paul II once said, \"The animals possess a soul and men must love and feel solidarity with our smaller brethren. All animals are fruit of the creative action of the Holy Spirit and merit respect and they are as near to God as men are.\"", reflection: "", url: "99", saint: "", saintURL: "", saintDate: "31-11"),





                 "01-12" : Days(title: "On this day in 1989, Pope John Paul II had an official visit from Mikhail Gorbachev. This was the first time a pope met with the head of the Soviet Union. Pope John Paul II once said, \"The ultimate test of your greatness is the way you treat every human being.\"", reflection: "Have you ever crossed lines to talk and interact with someone maybe we never felt comfortable with?", url: "29", saint: "Blessed Charles de Foucauld: 12/01", saintURL: "https://www.franciscanmedia.org/blessed-charles-de-foucauld/", saintDate: "01-12"),


                 "02-12" : Days(title: "Pope John Paul II reminds us, \"Let us remember the past with gratitude, live the present with enthusiasm, and look forward to the future with confidence.\"", reflection: "", url: "101", saint: "Blessed Rafal Chylinski: 12/02", saintURL: "https://www.franciscanmedia.org/blessed-rafal-chylinski/", saintDate: "02-12"),


                 "03-12" : Days(title: "Pope John Paul II reminds us, \"Jesus himself has shown us by his own example that prayer and fasting are the first and most effective weapons against the forces of evil.\"", reflection: "", url: "21", saint: "Saint Francis Xavier: 12/03", saintURL: "https://www.franciscanmedia.org/saint-francis-xavier/", saintDate: "03-12"),


                 "04-12" : Days(title: "Pope John Paul II once said, \"In my reading and in my studies I always tried to achieve a harmony between faith, reason, and the heart. These are not separate areas, but are profoundly interconnected, each giving life to the other.\"", reflection: "", url: "103", saint: "Saint John Damascene: 12/04", saintURL: "https://www.franciscanmedia.org/saint-john-damascene/", saintDate: "04-12"),


                 "05-12" : Days(title: "Pope John Paul II once said, \"The priest is not and must not be a civil servant of the Church. Above all the priest is a man who lives for the spirit for God. This being the case the Seminary is the place where he learns 'to be with Him.'\"", reflection: "", url: "104", saint: "Saint Sabas: 12/05", saintURL: "https://www.franciscanmedia.org/saint-sabas/", saintDate: "05-12"),


                 "06-12" : Days(title: "Pope John Paul II reminds us, \"The Rosary is a prayer both so humble and simple and a theologically rich in Biblical content. I beg you to pray it.\"", reflection: "", url: "105", saint: "Saint Nicholas:12/06", saintURL: "https://www.franciscanmedia.org/saint-nicholas/", saintDate: "06-12"),


                 "07-12" : Days(title: "Pope John Paul II once said, \"Love the family! Defend and promote it as the basic cell of human society; nurture it as the prime sanctuary of life. Give great care to the preparation of engaged couples and be close to young married couples, so that they will be for their children and the whole community an eloquent testimony of God's love.\"", reflection: "", url: "106", saint: "Saint Ambrose: 12/07", saintURL: "https://www.franciscanmedia.org/saint-ambrose/", saintDate: "07-12"),


                 "08-12" : Days(title: "Pope John Paul II tells us, \"On my knees, I beg of you to turn away from the paths of violence and to return to the path of peace. Those who resort to violence always claim that only violence brings about change. You must know there is a political, peaceful way to justice.\"", reflection: "", url: "107", saint: "Immaculate Conception of the Blessed Virgin Mary: 12/08", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-immaculate-conception/", saintDate: "08-12"),


                 "09-12" : Days(title: "Pope John Paul II tells us, \"The earth will not continue to offer its harvest, except with faithful stewardship. We cannot say we love the land and then take steps to destroy it for use by future generations.\"", reflection: "", url: "108", saint: "Saint Juan Diego: 12/09", saintURL: "https://www.franciscanmedia.org/saint-juan-diego/", saintDate: "09-12"),


                 "10-12" : Days(title: "Pope John Paul II once said, \"It is manifestly unjust that a privileged few should continue to accumulate excess goods, squandering available resources, while masses of people are living in conditions of misery at the very lowest level of subsistence.\"", reflection: "", url: "109", saint: "Blessed Adolph Kolping: 12/10", saintURL: "https://www.franciscanmedia.org/blessed-adolph-kolping/", saintDate: "10-12"),


                 "11-12" : Days(title: "Pope John Paul II reminds us, \"Never tire of firmly speaking out in defense of life from its conception and do not be deterred from the commitment to defend the dignity of every human person with courageous determination. Christ is with you: be not afraid!\"", reflection: "", url: "110", saint: "Saint Damasus I: 12/11", saintURL: "https://www.franciscanmedia.org/saint-damasus-i/", saintDate: "11-12"),


                 "12-12" : Days(title: "Pope John Paul II tells us, \"Friendship, as has been said, consists in a full commitment of the will to another person with a view to that person's good.\"", reflection: "", url: "16", saint: "Our Lady of Guadalupe: 12/12", saintURL: "https://www.franciscanmedia.org/our-lady-of-guadalupe/", saintDate: "12-12"),


                 "13-12" : Days(title: "Pope John Paul II once said, \"There is a growing threat to the environment, to the vegetation, animals, water and air. Sacred Scripture hands us the image of Cain who rejects his responsibility: 'Am I my brother's keeper?' The Bible shows the human person as his brother's keeper and the guardian of creation which has been entrusted to him.\"", reflection: "", url: "112", saint: "Saint Lucy: 12/13", saintURL: "https://www.franciscanmedia.org/saint-lucy/", saintDate: "13-12"),


                 "14-12" : Days(title: "Pope John Paul II reminds us, \"The essential commitment and, above all, the visible grace and source of supernatural strength for the Church as the People of God is to persevere and advance constantly in Eucharistic life and Eucharistic piety and to develop spiritually in the climate of the Eucharist.\"", reflection: "", url: "113", saint: "Saint John of the Cross: 12/14", saintURL: "https://www.franciscanmedia.org/saint-john-of-the-cross/", saintDate: "14-12"),


                 "15-12" : Days(title: "Pope John Paul II once said, \"In this silence of the white Host, carried in the Monstrance, are all His words; there is His whole life given in offering to the Father for each of us; there is also the glory of the glorified body, which started with the Resurrection, and still continues in Heavenly union.\"", reflection: "", url: "114", saint: "Blessed Mary Frances Schervier: 12/15", saintURL: "https://www.franciscanmedia.org/blessed-mary-frances-schervier/", saintDate: "15-12"),


                 "16-12" : Days(title: "Pope John Paul II tells us, \"The unworthy successor of Peter who desires to benefit from the immeasurable wealth of Christ feels the great need of your assistance, your prayers, your sacrifice, and he most humbly asks this of you.\"", reflection: "", url: "115", saint: "Blessed Honoratus Kozminski: 12/16", saintURL: "https://www.franciscanmedia.org/blessed-honoratus-kozminski/", saintDate: "16-12"),


                 "17-12" : Days(title: "Pope John Paul II once said, \"[St. Francis] looked upon creation with the eyes of one who could recognize in it the marvelous work of the hand of God. His solicitous care, not only towards men, but also towards animals is a faithful echo of the love with which God in the beginning pronounced his 'fiat' which brought them into existence. We too are called to a similar attitude.\"", reflection: "", url: "116", saint: "Saint Hildegard of Bingen: 12/17", saintURL: "https://www.franciscanmedia.org/saint-hildegard-of-bingen/", saintDate: "17-12"),


                 "18-12" : Days(title: "Pope John Paul II tells us, \"In the depths of the human soul... the desire to give meaning to one's own life is joined by the fleeting vision of beauty and of the mysterious unity of things.\"", reflection: "", url: "117", saint: "Blessed Anthony Grassi: 12/18", saintURL: "https://www.franciscanmedia.org/blessed-anthony-grassi/", saintDate: "18-12"),


                 "19-12" : Days(title: "Pope John Paul II reminds us, \"Marriage is an act of will that signifies and involves a mutual gift, which unites the spouses and binds them to their eventual souls, with whom they make up a sole family - a domestic church.\"", reflection: "", url: "118", saint: "Blessed Pope Urban V: 12/19", saintURL: "https://www.franciscanmedia.org/blessed-pope-urban-v/", saintDate: "19-12"),


                 "20-12" : Days(title: "Pope John Paul II tells us, \"But sometimes it is necessary to do that which is too much.\"", reflection: "", url: "119", saint: "Saint Dominic of Silos: 12/20", saintURL: "https://www.franciscanmedia.org/saint-dominic-of-silos/", saintDate: "20-12"),


                 "21-12" : Days(title: "Pope John Paul II once said, \"When man turns his back on the Creator's plan, he provokes a disorder which has inevitable repercussions on the rest of the created order. If man is not at peace with God, then earth itself cannot be at peace.\"", reflection: "", url: "120", saint: "Saint Peter Canisius: 12/21", saintURL: "https://www.franciscanmedia.org/saint-peter-canisius/", saintDate: "21-12"),


                 "22-12" : Days(title: "Pope John Paul II tells us, \"Euthanasia is a grave violation of the law of God, since it is the deliberate and morally unacceptable killing of a human person.\"", reflection: "", url: "121", saint: "Blessed Jacopone da Todi: 12/22", saintURL: "https://www.franciscanmedia.org/blessed-jacopone-da-todi/", saintDate: "22-12"),


                 "23-12" : Days(title: "On this day in 1983, Pope John Paul II visits Mehmet Ali Agca, the very man who attempted to assasinate him. ", reflection: "Pope John Paul II asked people to pray for Mehmet, he had forgiven him. Can you think of a time in your life where someone had wronged or hurt you. Could this be a day with the help of Saint Pope John Paul II, you also give forgiveness?", url: "70", saint: "Saint John of Kanty: 12/23", saintURL: "https://www.franciscanmedia.org/saint-john-kanty/", saintDate: "23-12"),


                 "24-12" : Days(title: "Pope John Paul II once said, \"For by his incarnation the Son of God united himself in a certain way with every man. He labored with human hands... and loved with a human heart. Born of Mary the Virgin, he truly became one of us...\"", reflection: "", url: "2", saint: "Christmas at Greccio: 12/24", saintURL: "https://www.franciscanmedia.org/christmas-at-greccio/", saintDate: "24-12"),


                 "25-12" : Days(title: "Pope John Paul II tells us, \"The mystery of the Holy Night, which historically happened two thousand years ago, must be lived as a spiritual event in the 'today' of the Liturgy,\" the Pope clarified. \"The Word who found a dwelling in Mary's womb comes to knock on the heart of every person with singular intensity this Christmas.\"", reflection: "", url: "3", saint: "Nativity of the Lord: 12/25", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-nativity-of-the-lord/", saintDate: "25-12"),


                 "26-12" : Days(title: "Pope John Paul II reminds us, \"The heart is our hidden center, beyond the grasp of our reason and of others; only the Spirit of God can fathom the human heart and know it fully. The heart is the place of decision, deeper than our psychic drives. It is the place of truth, where we choose life or death. It is the place of encounter...\"", reflection: "", url: "4", saint: "Saint Stephen: 12/26", saintURL: "https://www.franciscanmedia.org/saint-stephen/", saintDate: "26-12"),


                 "27-12" : Days(title: "Pope John Paul II tells us, \"The vow of celibacy is a matter of keeping one's word to Christ and the Church. a duty and a proof of the priest's inner maturity; it is the expression of his personal dignity.\"", reflection: "", url: "5", saint: "Saint John the Apostle: 12/27", saintURL: "https://www.franciscanmedia.org/saint-john-the-apostle/", saintDate: "27-12"),


                 "28-12" : Days(title: "Pope John Paul II once said, \"Never again war. Never again hatred and intolerance.\"", reflection: "", url: "6", saint: "Holy Innocents: 12/28", saintURL: "https://www.franciscanmedia.org/holy-innocents/", saintDate: "28-12"),


                 "29-12" : Days(title: "Pope John Paul II reminds us, \"Love is a constant challenge, thrown to us by God.\"", reflection: "", url: "7", saint: "Saint Thomas Becket: 12/29", saintURL: "https://www.franciscanmedia.org/saint-thomas-becket/", saintDate: "29-12"),


                 "30-12" : Days(title: "Pope John Paul II once said, \"Man must reconcile himself to his natural greatness.... he must not forget that he is a person.\"", reflection: "", url: "8", saint: "Saint Egwin: 12/30", saintURL: "https://www.franciscanmedia.org/saint-egwin/", saintDate: "30-12"),


                 "31-12" : Days(title: "Pope John Paul II tells us, \"None of us is alone in this world; each of us is a vital piece of the great mosaic of humanity as a whole.\"", reflection: "", url: "9", saint: "Saint Sylvester I: 12/31", saintURL: "https://www.franciscanmedia.org/saint-sylvester-i/", saintDate: "31-12"),

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
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[newDate]?.reflection
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
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[newDate]?.reflection
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
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[newDate]?.reflection
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
        reflectonLabel.sizeToFit()
        reflectonLabel.text = daysOfTheYear["Days"]?[formatDate(date: Date())]?.reflection
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

