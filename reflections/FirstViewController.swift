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
                             "01-01" : Days(title: "On this day in 1990 Pope John Paul II told us, \"When man turns his back on the Creator's plan, he provokes a disorder which has inevitable repercussions on the rest of the created order. If man is not at peace with God, then earth itself cannot be at peace.\"", reflection: "This was part of the MESSAGE OF HIS HOLINESS POPE JOHN PAUL II FOR THE CELEBRATION OF THE WORLD DAY OF PEACE", url: "1", saint: "Mary, Mother of God : 01/01", saintURL: "https://www.franciscanmedia.org/mary-mother-of-god/", saintDate: "01-01"),


                             "02-01" : Days(title: "Pope John Paul II once said, \"Have no fear of moving into the unknown. Simply step out fearlessly knowing that I am with you, therefore no harm can befall you; all is very, very well. Do this in complete faith and confidence.\"", reflection: "", url: "2", saint: "Saint Basil the Great : 01/02", saintURL: "https://www.franciscanmedia.org/saint-basil-the-great/", saintDate: "02-01"),


                             "03-01" : Days(title: "Pope John Paul II once said, \"Marriage is an act of will that signifies and involves a mutual gift, which unites the spouses and binds them to their eventual souls, with whom they make up a sole family - a domestic church.\"", reflection: "", url: "3", saint: "Most Holy Name of Jesus : 01/03", saintURL: "https://www.franciscanmedia.org/mosaint-holy-name-of-jesus/", saintDate: "03-01"),


                             "04-01" : Days(title: "Pope John Paul II once said, \"Wars generally do not resolve the problems for which they are fought and therefore... prove ultimately futile.\"", reflection: "", url: "4", saint: "Saint Elizabeth Ann Seton : 01/04", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-ann-seton/", saintDate: "04-01"),


                             "05-01" : Days(title: "Pope John Paul II once said, \"Young people are threatened... by the evil use of advertising techniques that stimulate the natural inclination to avoid hard work by promising the immediate satisfaction of every desire.\"", reflection: "", url: "5", saint: "Saint John Neumann : 01/05", saintURL: "https://www.franciscanmedia.org/saint-john-neumann/", saintDate: "05-01"),


                             "06-01" : Days(title: "Pope John Paul II once said, \"The historical experience of socialist countries has sadly demonstrated that collectivism does not do away with alienation but rather increases it, adding to it a lack of basic necessities and economic inefficiency.\"", reflection: "", url: "6", saint: "Saint André Bessette : 01/06", saintURL: "https://www.franciscanmedia.org/saint-andr-eacute-bessette/", saintDate: "06-01"),


                             "07-01" : Days(title: "Pope John Paul II once said, \"Humanity should question itself, once more, about the absurd and always unfair phenomenon of war...\"", reflection: "", url: "7", saint: "Saint Raymond of Peñafort : 01/07", saintURL: "https://www.franciscanmedia.org/saint-raymond-of-pe-afort/", saintDate: "07-01"),


                             "08-01" : Days(title: "Pope John Paul II once said, \"As the family goes, so goes the nation and so goes the whole world in which we live.\"", reflection: "", url: "8", saint: "Saint Angela of Foligno : 01/08", saintURL: "https://www.franciscanmedia.org/saint-angela-of-foligno/", saintDate: "08-01"),


                             "09-01" : Days(title: "Pope John Paul II once said, \"Love is never defeated, and I could add, the history of Ireland proves it.\"", reflection: "", url: "9", saint: "Saint Adrian of Canterbury : 01/09", saintURL: "https://www.franciscanmedia.org/saint-adrian-of-canterbury/", saintDate: "09-01"),


                             "10-01" : Days(title: "Pope John Paul II once said, \"Do not abandon yourselves to despair. We are the Easter people and hallelujah is our song.\"", reflection: "", url: "10", saint: "Saint Gregory of Nyssa : 01/10", saintURL: "https://www.franciscanmedia.org/saint-gregory-of-nyssa/", saintDate: "10-01"),


                             "11-01" : Days(title: "Pope John Paul II once said, \"I kiss the soil as if I placed a kiss on the hands of a mother, for the homeland is our earthly mother. I consider it my duty to be with my compatriots in this sublime and difficult moment.\"", reflection: "", url: "11", saint: "Blessed William Carter : 01/11", saintURL: "https://www.franciscanmedia.org/blessed-william-carter/", saintDate: "11-01"),


                             "12-01" : Days(title: "Pope John Paul II once said, \"When freedom does not have a purpose, when it does not wish to know anything about the rule of law engraved in the hearts of men and women, when it does not listen to the voice of conscience, it turns against humanity and society.\"", reflection: "", url: "12", saint: "Saint Marguerite Bourgeoys : 01/12", saintURL: "https://www.franciscanmedia.org/saint-marguerite-bourgeoys/", saintDate: "12-01"),


                             "13-01" : Days(title: "Pope John Paul II once said, \"I hope to have communion with the people, that is the most important thing.\"", reflection: "", url: "13", saint: "Saint Hilary of Poitiers : 01/13", saintURL: "https://www.franciscanmedia.org/saint-hilary/", saintDate: "13-01"),


                             "14-01" : Days(title: "Pope John Paul II once said, \"The vow of celibacy is a matter of keeping one's word to Christ and the Church. a duty and a proof of the priest's inner maturity; it is the expression of his personal dignity.\"", reflection: "", url: "14", saint: "Saint Gregory Nazianzen : 01/14", saintURL: "https://www.franciscanmedia.org/saint-gregory-nazianzen/", saintDate: "14-01"),


                             "15-01" : Days(title: "Pope John Paul II once said, \"The question confronting the Church today is not any longer whether the man in the street can grasp a religious message, but how to employ the communications media so as to let him have the full impact of the Gospel message.\"", reflection: "", url: "15", saint: "Saint Paul the Hermit : 01/15", saintURL: "https://www.franciscanmedia.org/saint-paul-the-hermit/", saintDate: "15-01"),


                             "16-01" : Days(title: "Pope John Paul II once said, \"I have a sweet tooth for song and music. This is my Polish sin.\"", reflection: "", url: "16", saint: "Saint Berard and Companions : 01/16", saintURL: "https://www.franciscanmedia.org/saint-berard-and-companions/", saintDate: "16-01"),


                             "17-01" : Days(title: "Pope John Paul II once said, \"From now on it is only through a conscious choice and through a deliberate policy that humanity can survive.\"", reflection: "", url: "17", saint: "Saint Anthony of Egypt : 01/17", saintURL: "https://www.franciscanmedia.org/saint-anthony-of-egypt/", saintDate: "17-01"),


                             "18-01" : Days(title: "Pope John Paul II once said, \"To maintain a joyful family requires much from both the parents and the children. Each member of the family has to become, in a special way, the servant of the others.\"", reflection: "", url: "18", saint: "Saint Charles of Sezze : 01/18", saintURL: "https://www.franciscanmedia.org/saint-charles-of-sezze/", saintDate: "18-01"),


                             "19-01" : Days(title: "Pope John Paul II once said, \"Social justice cannot be attained by violence. Violence kills what it intends to create.\"", reflection: "", url: "19", saint: "Saint Fabian : 01/19", saintURL: "https://www.franciscanmedia.org/saint-fabian/", saintDate: "19-01"),


                             "20-01" : Days(title: "Pope John Paul II once said, \"There are people and nations, Mother, that I would like to say to you by name. I entrust them to you in silence, I entrust them to you in the way that you know best.\"", reflection: "", url: "20", saint: "Saint Sebastian : 01/20", saintURL: "https://www.franciscanmedia.org/saint-sebastian/", saintDate: "20-01"),


                             "21-01" : Days(title: "Pope John Paul II once said, \"Stupidity is also a gift of God, but one mustn't misuse it.\"", reflection: "", url: "21", saint: "Saint Agnes : 01/21", saintURL: "https://www.franciscanmedia.org/saint-agnes/", saintDate: "21-01"),


                             "22-01" : Days(title: "On this day in 1973 the supreme court ruled on Roe v. Wade. On the 25th anniversary of the decision, at a prayer vigil at the Basilica of the National Shrine of the Immaculate Conception in Washington, Pope John Paul II said, \"The 25th anniversary of the decision ... is a call to people of good will to reflect. Now is the time for recommitment to the building of a culture of absolute respect for life.\"", reflection: "", url: "22", saint: "Saint Vincent of Zaragossa : 01/22", saintURL: "https://www.franciscanmedia.org/saint-vincent-of-zaragossa/", saintDate: "22-01"),


                             "23-01" : Days(title: "Pope John Paul II once said, \"The great danger for family life, in the midst of any society whose idols are pleasure, comfort and independence, lies in the fact that people close their hearts and become selfish.\"", reflection: "", url: "23", saint: "Saint Marianne Cope : 01/23", saintURL: "https://www.franciscanmedia.org/saint-marianne-cope/", saintDate: "23-01"),


                             "24-01" : Days(title: "Pope John Paul II once said, \"Science can purify religion from error and superstition. Religion can purify science from idolatry and false absolutes.\"", reflection: "", url: "24", saint: "Saint Francis de Sales : 01/24", saintURL: "https://www.franciscanmedia.org/saint-francis-de-sales/", saintDate: "24-01"),


                             "25-01" : Days(title: "Pope John Paul II once said, \"Violence and arms can never resolve the problems of men.\"", reflection: "", url: "25", saint: "Conversion of Saint Paul : 01/25", saintURL: "https://www.franciscanmedia.org/conversion-of-saint-paul/", saintDate: "25-01"),


                             "26-01" : Days(title: "Pope John Paul II once said, \"You will reciprocally promise love, loyalty and matrimonial honesty. We only want for you this day that these words constitute the principle of your entire life and that with the help of divine grace you will observe these solemn vows that today, before God, you formulate.\"", reflection: "", url: "26", saint: "Saints Timothy and Titus : 01/26", saintURL: "https://www.franciscanmedia.org/saints-timothy-and-titus/", saintDate: "26-01"),


                             "27-01" : Days(title: "Pope John Paul II once said, \"Radical changes in world politics leave America with a heightened responsibility to be, for the world, an example of a genuinely free, democratic, just and humane society.\"", reflection: "", url: "27", saint: "Saint Angela Merici : 01/27", saintURL: "https://www.franciscanmedia.org/saint-angela-merici/", saintDate: "27-01"),


                             "28-01" : Days(title: "Pope John Paul II once said, \"You are our dearly beloved brothers, and in a certain way, it could be said that you are our elder brothers.\"", reflection: "", url: "28", saint: "Saint Thomas Aquinas : 01/28", saintURL: "https://www.franciscanmedia.org/saint-thomas-aquinas/", saintDate: "28-01"),


                             "29-01" : Days(title: "Pope John Paul II once said, \"The unworthy successor of Peter who desires to benefit from the immeasurable wealth of Christ feels the great need of your assistance, your prayers, your sacrifice, and he most humbly asks this of you.\"", reflection: "", url: "29", saint: "Servant of God Brother Juniper : 01/29", saintURL: "https://www.franciscanmedia.org/servant-of-god-brother-juniper/", saintDate: "29-01"),


                             "30-01" : Days(title: "Pope John Paul II once said, \"You are priests, not social or political leaders. Let us not be under the illusion that we are serving the Gospel through an exaggerated interest in the wide field of temporal problems.\"", reflection: "", url: "30", saint: "Blessed Mary Angela Truszkowska : 01/30", saintURL: "https://www.franciscanmedia.org/blessed-mary-angela-truszkowska/", saintDate: "30-01"),


                             "31-01" : Days(title: "Pope John Paul II once said, \"The cemetery of the victims of human cruelty in our century is extended to include yet another vast cemetery, that of the unborn.\"", reflection: "", url: "31", saint: "Saint John Bosco : 01/31", saintURL: "https://www.franciscanmedia.org/saint-john-bosco/", saintDate: "31-01"),
                             





                             "01-02" : Days(title: "Pope John Paul II once said, \"Today, for the first time in history, a Bishop of Rome sets foot on English soil. This fair land, once a distant outpost of the pagan world, has become, through the preaching of the Gospel, a beloved and gifted portion of Christ's vineyard.\"", reflection: "", url: "32", saint: "Saint Ansgar : 02/01", saintURL: "https://www.franciscanmedia.org/saint-ansgar/", saintDate: "01-02"),


                             "02-02" : Days(title: "Pope John Paul II once said, \"In the depths of the human soul... the desire to give meaning to one's own life is joined by the fleeting vision of beauty and of the mysterious unity of things.\"", reflection: "", url: "33", saint: "Presentation of the Lord : 02/02", saintURL: "https://www.franciscanmedia.org/presentation-of-the-lord/", saintDate: "02-02"),


                             "03-02" : Days(title: "Pope John Paul II once said, \"Consequently, theories of evolution which, in accordance with the philosophies inspiring them, consider the mind as emerging from the forces of living matter, or as a mere epiphenomenon of this matter, are incompatible with the truth about man. Nor are they able to ground the dignity of the person.\"", reflection: "", url: "34", saint: "Saint Blaise : 02/03", saintURL: "https://www.franciscanmedia.org/saint-blaise/", saintDate: "03-02"),


                             "04-02" : Days(title: "Pope John Paul II once said, \"The world designed by God cannot be a world in which some hoard immoderate wealth in their hands, while others suffer from destitution and poverty, and die of hunger. Love must inspire justice and the struggle for justice\"", reflection: "", url: "35", saint: "Saint Joseph of Leonissa : 02/04", saintURL: "https://www.franciscanmedia.org/saint-joseph-of-leonissa/", saintDate: "04-02"),


                             "05-02" : Days(title: "Pope John Paul II once said, \"People must not attempt to impose their own 'truth' on others. The right to profess the truth must always be upheld, but not in a way that involves contempt for those who may think differently. Truth imposes itself solely by the force of its own truth.\"", reflection: "", url: "36", saint: "Saint Agatha : 02/05", saintURL: "https://www.franciscanmedia.org/saint-agatha/", saintDate: "05-02"),


                             "06-02" : Days(title: "Pope John Paul II once said, \"A society will be judged on the basis of how it treats its weakest members; and among the most vulnerable are surely the unborn and the dying.\"", reflection: "", url: "37", saint: "Saint Paul Miki and Companions : 02/06", saintURL: "https://www.franciscanmedia.org/saint-paul-miki-and-companions/", saintDate: "06-02"),


                             "07-02" : Days(title: "Pope John Paul II once said, \"Every scientist, through personal study and research, completes himself and his own humanity. ... Scientific research constitutes for you, as it does for many, the way for the personal encounter with truth, and perhaps the privileged place for the encounter itself with God, the Creator of heaven and earth. Science shines forth in all its value as a good capable of motivating our existence, as a great experience of freedom for truth, as a fundamental work of service. Through research each scientist grows as a human being and helps others to do likewise.\"", reflection: "", url: "38", saint: "Saint Colette : 02/07", saintURL: "https://www.franciscanmedia.org/saint-colette/", saintDate: "07-02"),


                             "08-02" : Days(title: "Pope John Paul II once said, \"Only faith in Christ gives rise to a culture contrary to egotism and death.\"", reflection: "", url: "39", saint: "Saint Josephine Bakhita : 02/08", saintURL: "https://www.franciscanmedia.org/saint-josephine-bakhita/", saintDate: "08-02"),


                             "09-02" : Days(title: "Pope John Paul II once said, \"The mystery of the Holy Night, which historically happened two thousand years ago, must be lived as a spiritual event in the 'today' of the Liturgy.  The Word who found a dwelling in Mary's womb comes to knock on the heart of every person with singular intensity this Christmas.\"", reflection: "", url: "40", saint: "Saint Jerome Emiliani : 02/09", saintURL: "https://www.franciscanmedia.org/saint-jerome-emiliani/", saintDate: "09-02"),


                             "10-02" : Days(title: "Pope John Paul II once said, \"The obligation to earn one's bread presumes the right to do so. A society that denies this right cannot be justified, nor can it attain social peace.\"", reflection: "", url: "41", saint: "Saint Scholastica : 02/10", saintURL: "https://www.franciscanmedia.org/saint-scholastica/", saintDate: "10-02"),


                             "11-02" : Days(title: "Pope John Paul II once said, \"To recite the Rosary is nothing other than to contemplate the face of Christ with Mary.\"", reflection: "", url: "42", saint: "Our Lady of Lourdes : 02/11", saintURL: "https://www.franciscanmedia.org/our-lady-of-lourdes/", saintDate: "11-02"),


                             "12-02" : Days(title: "Pope John Paul II once said, \"Today, the scale and horror of modern warfare - whether nuclear or not - makes it totally unacceptable as a means of settling differences between nations. War should belong to the tragic past, to history; it should find no place on humanity's agenda for the future.\"", reflection: "", url: "43", saint: "Saint Apollonia : 02/12", saintURL: "https://www.franciscanmedia.org/saint-apollonia/", saintDate: "12-02"),


                             "13-02" : Days(title: "Pope John Paul II once said, \"We emphasize the transcendent worth of the human person. We insist that the human person must never be treated as an object; he must always be considered the subject. That is the basis for our teaching, the absolute standard.\"", reflection: "", url: "44", saint: "Saint Giles Mary of Saint Joseph : 02/13", saintURL: "https://www.franciscanmedia.org/saint-giles-mary-of-saint-joseph/", saintDate: "13-02"),


                             "14-02" : Days(title: "Pope John Paul II once said, \"For by his incarnation the Son of God united himself in a certain way with every man. He labored with human hands... and loved with a human heart. Born of Mary the Virgin, he truly became one of us...\"", reflection: "", url: "45", saint: "Saints Cyril and Methodius : 02/14", saintURL: "https://www.franciscanmedia.org/saints-cyril-and-methodius/", saintDate: "14-02"),


                             "15-02" : Days(title: "Pope John Paul II once said, \"Love is a constant challenge, thrown to us by God.\"", reflection: "", url: "46", saint: "Saint Claude de la Colombière : 02/15", saintURL: "https://www.franciscanmedia.org/saint-claude-de-la-colombi-egrave-re/", saintDate: "15-02"),


                             "16-02" : Days(title: "Pope John Paul II once said, \"The Internet causes billions of images to appear on millions of computer monitors around the planet. From this galaxy of sight and sound will the face of Christ emerge and the voice of Christ be heard? For it is only when his face is seen and his voice heard that the world will know the glad tidings of our redemption. This is the purpose of evangelization. And this is what will make the Internet a genuinely human space, for if there is no room for Christ, there is no room for man.\"", reflection: "", url: "47", saint: "Saint Gilbert of Sempringham : 02/16", saintURL: "https://www.franciscanmedia.org/saint-gilbert-of-sempringham/", saintDate: "16-02"),


                             "17-02" : Days(title: "Pope John Paul II once said, \"Pervading nationalism imposes its dominion on man today in many different forms and with an aggressiveness that spares no one. The challenge that is already with us is the temptation to accept as true freedom what in reality is only a new form of slavery.\"", reflection: "", url: "48", saint: "Seven Founders of the Servite Order : 02/17", saintURL: "https://www.franciscanmedia.org/seven-founders-of-the-servite-order/", saintDate: "17-02"),


                             "18-02" : Days(title: "Pope John Paul II once said, \"The Church must persist in the teaching transmitted to her by Christ.\"", reflection: "", url: "49", saint: "Blessed John of Fiesole : 02/18", saintURL: "https://www.franciscanmedia.org/blessed-john-of-fiesole/", saintDate: "18-02"),


                             "19-02" : Days(title: "Pope John Paul II once said, \"If development is the new name for peace, war and preparations for war are the major enemy of the healthy development of peoples. If we take the common good of all humanity as our norm, instead of individual greed, peace would be possible.\"", reflection: "", url: "50", saint: "Saint Conrad of Piacenza : 02/19", saintURL: "https://www.franciscanmedia.org/saint-conrad-of-piacenza/", saintDate: "19-02"),


                             "20-02" : Days(title: "Pope John Paul II once said, \"Sensitivity to the immense needs of humanity brings with it a spontaneous rejection of the arms race, which is incompatible with the all out struggle against hunger, sickness, under-development and illiteracy.\"", reflection: "", url: "51", saint: "Saints Jacinta and Francisco Marto : 02/20", saintURL: "https://www.franciscanmedia.org/saints-jacinta-and-francisco-marto/", saintDate: "20-02"),


                             "21-02" : Days(title: "Pope John Paul II once said, \"Love the family! Defend and promote it as the basic cell of human society; nurture it as the prime sanctuary of life. Give great care to the preparation of engaged couples and be close to young married couples, so that they will be for their children and the whole community an eloquent testimony of God's love.\"", reflection: "", url: "52", saint: "Saint Peter Damian : 02/21", saintURL: "https://www.franciscanmedia.org/saint-peter-damian/", saintDate: "21-02"),


                             "22-02" : Days(title: "Pope John Paul II once said, \"Love the family! Defend and promote it as the basic cell of human society; nurture it as the prime sanctuary of life. Give great care to the preparation of engaged couples and be close to young married couples, so that they will be for their children and the whole community an eloquent testimony of God's love.\"", reflection: "", url: "53", saint: "Chair of Saint Peter : 02/22", saintURL: "https://www.franciscanmedia.org/chair-of-saint-peter/", saintDate: "22-02"),


                             "23-02" : Days(title: "Pope John Paul II once said, \"None are so poor that they have nothing to give...and none are so rich that they have nothing to receive.\"", reflection: "", url: "54", saint: "Saint Polycarp : 02/23", saintURL: "https://www.franciscanmedia.org/saint-polycarp/", saintDate: "23-02"),


                             "24-02" : Days(title: "Pope John Paul II once said, \"Condemning class struggle does not mean condemning every possible form of social conflict. Such conflicts inevitably arise and Christians must often take a position in the \"struggle for social justice.\" What is condemned is \"total war,\" which has no respect for the dignity of others (and consequently of oneself). It excludes reasonable compromise, does not pursue the common good but the good of a group, and sets out to destroy whatever stands in its way.\"", reflection: "", url: "55", saint: "Blessed Luke Belludi : 02/24", saintURL: "https://www.franciscanmedia.org/blessed-luke-belludi/", saintDate: "24-02"),


                             "25-02" : Days(title: "Pope John Paul II once said, \"It is not enough to long for a person as a good for oneself, one must also, and above all, long for that person's good.\"", reflection: "", url: "56", saint: "Blessed Sebastian of Aparicio : 02/25", saintURL: "https://www.franciscanmedia.org/blessed-sebastian-of-aparicio/", saintDate: "25-02"),


                             "26-02" : Days(title: "Pope John Paul II once said, \"With supernatural intuition Blessed Josemaria untiringly preached the universal call to holiness and apostolate. Christ calls everyone to become holy in the realities of everyday life. Hence work too is a means of personal holiness and apostolate when it is done in union with Jesus Christ", reflection: "Josemaría Escrivá de Balaguer y Albás was a Spanish Roman Catholic priest who founded Opus Dei, an organization of laypeople and priests dedicated to the teaching that everyone is called to holiness by God and that ordinary life can result in sanctity.", url: "57", saint: "Saint Maria Bertilla Boscardin : 02/26", saintURL: "https://www.franciscanmedia.org/saint-maria-bertilla-boscardin/", saintDate: "26-02"),


                             "27-02" : Days(title: "Pope John Paul II once said, \"Interdependence must be transformed into solidarity based upon the principle that the goods of creation are meant for all. That which human industry produces through the processing of raw materials with the contribution of work must serve equally for the good of all.\"", reflection: "", url: "58", saint: "Saint Gabriel of Our Lady of Sorrows : 02/27", saintURL: "https://www.franciscanmedia.org/saint-gabriel-of-our-lady-of-sorrows/", saintDate: "27-02"),


                             "28-02" : Days(title: "Pope John Paul II once said, \"Man must reconcile himself to his natural greatness.... he must not forget that he is a person.\"", reflection: "", url: "59", saint: "Blessed Daniel Brottier : 02/28", saintURL: "https://www.franciscanmedia.org/blessed-daniel-brottier/", saintDate: "28-02"),


                             "29-02" : Days(title: "Pope John Paul II once said, \"There is no need to be dismayed if love sometimes follows torturous ways. Grace has the power to make straight the paths of human love.\"", reflection: "", url: "60", saint: "Saint Oswald : 02/29", saintURL: "https://www.franciscanmedia.org/saint-oswald/", saintDate: "29-02"),


                             "30-02" : Days(title: "", reflection: "", url: "61", saint: "", saintURL: "", saintDate: "30-02"),


                             "31-02" : Days(title: "", reflection: "", url: "62", saint: "", saintURL: "", saintDate: "31-02"),






                             "01-03" : Days(title: "Pope John Paul II once said, \"The heart is our hidden center, beyond the grasp of our reason and of others; only the Spirit of God can fathom the human heart and know it fully. The heart is the place of decision, deeper than our psychic drives. It is the place of truth, where we choose life or death. It is the place of encounter...\"", reflection: "", url: "63", saint: "Saint David of Wales: 03/01", saintURL: "https://www.franciscanmedia.org/saint-david-of-wales/", saintDate: "01-03"),


                             "02-03" : Days(title: "Pope John Paul II once said, \"To the family is entrusted the task of striving, first and foremost, to unleash the forces of good...\"", reflection: "", url: "64", saint: "Saint Agnes of Bohemia : 03/02", saintURL: "https://www.franciscanmedia.org/saint-agnes-of-bohemia/", saintDate: "02-03"),


                             "03-03" : Days(title: "Pope John Paul II once said, \"Creating the human race in His own image and continually keeping it in being, God inscribed in the humanity of man and woman the vocation... of love and communion. Love is therefore the fundamental and innate vocation of every human being.\"", reflection: "", url: "65", saint: "Saint Katharine Drexel : 03/03", saintURL: "https://www.franciscanmedia.org/saint-katharine-drexel/", saintDate: "03-03"),


                             "04-03" : Days(title: "On this day in 1979, in Redemptor hominis, Pope John Paul II wrote that man cannot live without love. He remains a being that is incomprehensible for himself, his life is senseless, if love is not revealed to him, if he does not encounter love, if he does not experience it and make it his own, if he does not participate intimately in it.", reflection: "Redemptor hominis is the name of the first encyclical written by Pope John Paul II. It lays a blueprint for his pontificate in its exploration of contemporary human problems and especially their proposed solutions found in a deeper understanding of the human person.", url: "66", saint: "Saint Casimir : 03/04", saintURL: "https://www.franciscanmedia.org/saint-casimir/", saintDate: "04-03"),


                             "05-03" : Days(title: "On this day in 2000, Pope John Paul said, \"Young friends, do not hesitate to follow the example of Pedro, who 'pleased God and was loved by him' and who, having come to perfection in so short a time, lived a full life.\"", reflection: "Pope John Paul II was refering to Pedro Calungsod: A 17-year-old Filipino catechist who was killed for his faith.  Pope John Paul II told us how strong Pedro's faith was from his chidhood years. How his faith inspired him to devote his teenage years to teaching the faith. Young or old, do not hesitate to follow the example of Pedro!", url: "67", saint: "Saint John Joseph of the Cross : 03/05", saintURL: "https://www.franciscanmedia.org/saint-john-joseph-of-the-cross/", saintDate: "05-03"),


                             "06-03" : Days(title: "Pope John Paul II once said, \"But sometimes it is necessary to do that which is too much.\"", reflection: "", url:"68", saint: "Saint Mary Ann of Jesus of Paredes : 03/06", saintURL: "https://www.franciscanmedia.org/saint-mary-ann-of-jesus-of-paredes/", saintDate: "06-03"),


                             "07-03" : Days(title: "Pope John Paul II once said, \"The modern world, a world which has experienced marvelous achievements but which seems to have lost its sense of ultimate realities and of existence itself.\"", reflection: "", url: "69", saint: "Saints Perpetua and Felicity : 03/07", saintURL: "https://www.franciscanmedia.org/saints-perpetua-and-felicity/", saintDate: "07-03"),


                             "08-03" : Days(title: "Pope John Paul II once said, \"The vocation and mission of the faithful can only be understood in light of a renewed awareness of the Church as sacrament or sign and instrument of intimate union with God, of the unity of the whole of mankind, and of the personal duty to adhere more closely to her.\"", reflection: "", url: "70", saint: "Saint John of God : 03/08", saintURL: "https://www.franciscanmedia.org/saint-john-of-god/", saintDate: "08-03"),


                             "09-03" : Days(title: "Pope John Paul II once said, \"Yes, the civilization of love is possible; it is not a utopia. But it is only possible by a constant and ready reference to the \"Father from whom all fatherhood and motherhood on earth is named,\" from whom every human family comes.\"", reflection: "", url: "71", saint: "Saint Frances of Rome : 03/09", saintURL: "https://www.franciscanmedia.org/saint-frances-of-rome/", saintDate: "09-03"),


                             "10-03" : Days(title: "Pope John Paul II once said, \"Only a socially just country has the right to exist.\"", reflection: "", url: "72", saint: "Saint Dominic Savio : 03/10", saintURL: "https://www.franciscanmedia.org/saint-dominic-savio/", saintDate: "10-03"),


                             "11-03" : Days(title: "Pope John Paul II once said, \"In the life of husband and wife together, fatherhood and motherhood represent such a sublime \"novelty\" and richness as can only be approached \"on one's knees\".\"", reflection: "", url: "73", saint: "Saint John Ogilvie : 03/11", saintURL: "https://www.franciscanmedia.org/saint-john-ogilvie/", saintDate: "11-03"),


                             "12-03" : Days(title: "Pope John Paul II once said, \"Man matures through work which inspires him to difficult good.\"", reflection: "", url: "74", saint: "Blessed Angela Salawa : 03/12", saintURL: "https://www.franciscanmedia.org/blessed-angela-salawa/", saintDate: "12-03"),


                             "13-03" : Days(title: "Pope John Paul II once said, \"The true Christian can nurture a trustful optimism, because he is certain of not walking alone. In sending us Jesus, the eternal Son made man, God has drawn near to each of us. In Christ he has become our travelling companion.\"", reflection: "", url: "75", saint: "Saint Dominic Savio : 03/10", saintURL: "https://www.franciscanmedia.org/saint-dominic-savio/", saintDate: "10-03"),


                             "14-03" : Days(title: "", reflection: "", url: "76", saint: "Saint John of God : 03/08", saintURL: "https://www.franciscanmedia.org/saint-john-of-god/", saintDate: "08-03"),


                             "15-03" : Days(title: "Pope John Paul II once said, \"The challenge is to make the church's yes to life concrete and effective. The struggle will be long, and it needs each one of you. Place your intelligence, your talents, your enthusiasm, your compassion and your fortitude at the service of life!\"", reflection: "", url: "77", saint: "Saint Louise de Marillac : 03/15", saintURL: "https://www.franciscanmedia.org/saint-louise-de-marillac/", saintDate: "15-03"),


                             "16-03" : Days(title: "Pope John Paul II once said, \"All are called to holiness, and holy people alone can renew humanity.\"", reflection: "", url: "78", saint: "Saint Clement Mary Hofbauer : 03/16", saintURL: "https://www.franciscanmedia.org/saint-clement-mary-hofbauer/", saintDate: "16-03"),


                             "17-03" : Days(title: "Pope John Paul II once said, \"Never again war. Never again hatred and intolerance.\"", reflection: "", url: "79", saint: "Saint Patrick : 03/17", saintURL: "https://www.franciscanmedia.org/saint-patrick/", saintDate: "17-03"),


                             "18-03" : Days(title: "Pope John Paul II once said, \"Christ called as his Apostles only men. He did this in a totally free and sovereign way.\"", reflection: "", url: "80", saint: "Saint Cyril of Jerusalem : 03/18", saintURL: "https://www.franciscanmedia.org/saint-cyril-of-jerusalem/", saintDate: "18-03"),


                             "19-03" : Days(title: "Pope John Paul II once said, \"Faced with today's problems and disappointments , many people will try to escape from their responsibility. Escape in selfishness, escape in sexual pleasure, escape in drugs, escape in violence, escape in indifference and cynical attitudes. I propose to you the option of love, which is the opposite of escape.\"", reflection: "", url: "81", saint: "Saint Joseph, Husband of Mary : 03/19", saintURL: "https://www.franciscanmedia.org/saint-joseph-husband-of-mary/", saintDate: "19-03"),


                             "20-03" : Days(title: "Pope John Paul II once said, Without wonder, men and women would lapse into deadening routine and little by little would become incapable of a life which is genuinely personal.", reflection: "", url: "82", saint: "Saint Salvator of Horta : 03/20", saintURL: "https://www.franciscanmedia.org/saint-salvator-of-horta/", saintDate: "20-03"),


                             "21-03" : Days(title: "Pope John Paul II once said, \"But responsibility likewise falls on the legislators who have promoted and approved abortion laws, and, to the extent that they have a say in the matter, on the administrators of the health-care centers where abortions are performed. In this sense abortion goes beyond the responsibility of individuals and beyond the harm done to them, and takes on a distinctly social dimension. It is a most serious wound inflicted on society and its culture by the very people who ought to be societys promoters and defenders.\"", reflection: "", url: "83", saint: "Blessed John of Parma : 03/21", saintURL: "https://www.franciscanmedia.org/blessed-john-of-parma/", saintDate: "21-03"),


                             "22-03" : Days(title: "Pope John Paul II once said, \"Mary's role is to make Her Son Shine\"", reflection: "", url: "84", saint: "Saint Nicholas Owen : 03/22", saintURL: "https://www.franciscanmedia.org/saint-nicholas-owen/", saintDate: "22-03"),


                             "23-03" : Days(title: "Pope John Paul II once said, \"An effective proclamation of the Gospel in contemporary Western society will need to confront directly the widespread spirit of agnosticism and relativism which has cast doubt on reason's ability to know the truth, which alone satisfies the human heart's restless quest for meaning.\"", reflection: "", url: "85", saint: "Saint Turibius of Mogrovejo : 03/23", saintURL: "https://www.franciscanmedia.org/saint-turibius-of-mogrovejo/", saintDate: "23-03"),


                             "24-03" : Days(title: "Pope John Paul II once said, \"The seriousness of ecological degradation lays bare the depth of man's moral crisis... Simplicity, moderation, and discipline as well as the spirit of sacrifice must become a part of everyday life.\"", reflection: "", url: "86", saint: "Saint Oscar Arnulfo Romero : 03/24", saintURL: "https://www.franciscanmedia.org/saint-oscar-arnulfo-romero/", saintDate: "24-03"),


                             "25-03" : Days(title: "On this day in 1995, Pope John Paul wrote, \"Humanity, its dignity and its balance, will depend at every moment and on every place on the globe,on who man is for woman and who woman is for man.\"", reflection: "EVANGELIUM VITAE: To the Bishops, Priests and Deacons, Men and Women religious lay Faithful and all People of Good Will on the Value and Inviolability of Human Life", url: "87", saint: "Annunciation of the Lord : 03/25", saintURL: "https://www.franciscanmedia.org/annunciation-of-the-lord/", saintDate: "25-03"),


                             "26-03" : Days(title: "Pope John Paul II once said, \"Freedom consists not in doing what we like, but in having the right to do what we ought.\"", reflection: "", url: "88", saint: "Saint Catherine of Genoa : 03/26", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-genoa/", saintDate: "26-03"),


                             "27-03" : Days(title: "Pope John Paul II once said, \"I encourage Christians regularly to visit Christ present in the Blessed Sacrament, for we are all called to abide in the presence of God.\"", reflection: "", url: "89", saint: "Lazarus : 03/27", saintURL: "https://www.franciscanmedia.org/lazarus/", saintDate: "27-03"),


                             "28-03" : Days(title: "Pope John Paul II once told us, \"The Eucharist is not only a particularly intense expression of the reality of the Church's life, but also in a sense its fountainhead. The Eucharist feeds and forms the Church: 'Because there is one bread, we who are many are one body, for we all partake of the one bread' (1 Cor 10:17, RSV). Because of this vital link with the sacrament of the Body and Blood of the Lord, the mystery of the Church is savored, proclaimed, and lived supremely in the Eucharist.\"", reflection: "", url: "90", saint: "Saint Catharine of Bologna : 03/28", saintURL: "https://www.franciscanmedia.org/saint-catharine-of-bologna/", saintDate: "28-03"),


                             "29-03" : Days(title: "Pope John Paul II tells us, \"The essential commitment and, above all, the visible grace and source of supernatural strength for the Church as the People of God is to persevere and advance constantly in Eucharistic life and Eucharistic piety and to develop spiritually in the climate of the Eucharist.\"", reflection: "", url: "91", saint: "Saint Ludovico of Casoria : 03/29", saintURL: "https://www.franciscanmedia.org/saint-ludovico-of-casoria/", saintDate: "29-03"),


                             "30-03" : Days(title: "Pope John Paul II once said, \"The legal toleration of abortion or of euthanasia can in no way claim to be based on respect for the conscience of others, precisely because society has the right and the duty to protect itself against the abuses which can occur in the name of conscience and under the pretext of freedom.\"", reflection: "", url: "92", saint: "Saint Peter Regalado : 03/30", saintURL: "https://www.franciscanmedia.org/saint-peter-regalado/", saintDate: "30-03"),


                             "31-03" : Days(title: "Pope John Paul II tells us, \"The Rosary mystically transports us to Mary's side as she is busy watching over the human growth of Christ in the home of Nazareth. This enables her to train us and to mold us with the same care, until Christ is \"fully formed\" in us... Why should we not once more have recourse to the Rosary, with the same faith as those who have gone before us?\"", reflection: "", url: "93", saint: "Saint Stephen of Mar Saba : 03/31", saintURL: "https://www.franciscanmedia.org/saint-stephen-of-mar-saba/", saintDate: "31-03"),






                             "01-04" : Days(title: "Pope John Paul II once told us, \"In suffocating the voice of conscience, passion carries with itself a restlessness of the body and the senses: it is the restlessness of the \"external man.\" When the internal man has been reduced to silence, then passion, once it has been given freedom of action, so to speak, exhibits itself as an insistent tendency to satisfy the senses and the body.\"", reflection: "", url: "94", saint: "Saint Hugh of Grenoble : 04/01", saintURL: "https://www.franciscanmedia.org/saint-hugh-of-grenoble/", saintDate: "01-04"),


                             "02-04" : Days(title: "Pope John Paul II tells us, \"Laws which authorize and promote abortion and euthanasia are therefore radically opposed not only to the good of the individual but also to the common good; as such they are completely lacking in authentic juridical validity. Disregard for the right to life, precisely because it leads to the killing of the person whom society exists to serve, is what most directly conflicts with the possibility of achieving the common good. Consequently, a civil law authorizing abortion or euthanasia ceases by that very fact to be a true, morally binding civil law.\"", reflection: "", url: "95", saint: "Saint Francis of Paola : 04/02", saintURL: "https://www.franciscanmedia.org/saint-francis-of-paola/", saintDate: "02-04"),


                             "03-04" : Days(title: "Pope John Paul II once said, \"It is manifestly unjust that a privileged few should continue to accumulate excess goods, squandering available resources, while masses of people are living in conditions of misery at the very lowest level of subsistence.\"", reflection: "", url: "96", saint: "Saint Benedict the African : 04/03", saintURL: "https://www.franciscanmedia.org/saint-benedict-the-african/", saintDate: "03-04"),


                             "04-04" : Days(title: "Pope John Paul II once said, \"Truth can prevail only in virtue of truth itself.\"", reflection: "", url: "97", saint: "Saint Isidore of Seville : 04/04", saintURL: "https://www.franciscanmedia.org/saint-isidore-of-seville/", saintDate: "04-04"),


                             "05-04" : Days(title: "Pope John Paul II once told us, \"We are all one family in the world. Building a community that empowers everyone to attain their full potential through each of us respecting each other's dignity, rights and responsibilities makes the world a better place to live.\"", reflection: "", url: "98", saint: "Saint Vincent Ferrer : 04/05", saintURL: "https://www.franciscanmedia.org/saint-vincent-ferrer/", saintDate: "05-04"),


                             "06-04" : Days(title: "Pope John Paul II tells us, \"Learning to think rigorously, so as to act rightly and to serve humanity better.\"", reflection: "", url: "99", saint: "Saint Crescentia Hoess : 04/06", saintURL: "https://www.franciscanmedia.org/saint-crescentia-hoess/", saintDate: "06-04"),


                             "07-04" : Days(title: "Pope John Paul II once said, \"When we go before Jesus in the Blessed Sacrament we represent the one in the world who is in most need of God's Mercy.\" We \"Stand in behalf of the one in the world who does not know Christ and who is farthest away from God and we bring down upon their soul the Precious Blood of The Lamb.\"", reflection: "", url: "100", saint: "Saint John Baptist de La Salle : 04/07", saintURL: "https://www.franciscanmedia.org/saint-john-baptist-de-la-salle/", saintDate: "07-04"),


                             "08-04" : Days(title: "Pope John Paul II once said, \"The encouragement and the deepening of Eucharistic worship are proofs of the authentic renewal which the Council set itself as an aim and of which they are the central point.\"", reflection: "", url: "101", saint: "Saint Julie Billiart : 04/08", saintURL: "https://www.franciscanmedia.org/saint-julie-billiart/", saintDate: "08-04"),


                             "09-04" : Days(title: "Pope John Paul II once said, \"Every act of reverence, every genuflection that you make before the Blessed Sacrament is important because it is an act of faith in Christ, and act of love for Christ. And every sign of the cross and gesture of respect made each time you pass a church is also an act of faith.\"", reflection: "", url: "102", saint: "Saint Casilda : 04/09", saintURL: "https://www.franciscanmedia.org/saint-casilda/", saintDate: "09-04"),


                             "10-04" : Days(title: "Pope John Paul II tells us that \"Eucharistic worship is not so much worship of the inaccessible transcendence as worship of the divine condescension, and it is also the merciful and redeeming transformation of the world in the human heart\"", reflection: "", url: "103", saint: "Saint Magdalen of Canossa : 04/10", saintURL: "https://www.franciscanmedia.org/saint-magdalen-of-canossa/", saintDate: "10-04"),


                             "11-04" : Days(title: "On this day in 2000, Easter Sunday Pope John Paul II, in URBI ET ORBI, related to us the following. \"May the temptation to seek revenge give way to the courage to forgive; may the culture of life and love render vain the logic of death; may trust once more give breath to the lives of peoples.\"", reflection: "", url: "104", saint: "Saint Stanislaus : 04/11", saintURL: "https://www.franciscanmedia.org/saint-stanislaus/", saintDate: "11-04"),


                             "12-04" : Days(title: "Pope John Paul II once said, \"Original sin is not only the violation of a positive command … but … attempts … to abolish fatherhood, destroying its rays which permeate the created world, placing in doubt the truth about God who is Love and leaving man with only a sense of the master-slave relationship.\"", reflection: "", url: "105", saint: "Saint Teresa of Los Andes : 04/12", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-los-andes/", saintDate: "12-04"),


                             "13-04" : Days(title: "Pope John Paul II told us, \"When our whole life is one faith, hope, love, prayer and silence, a consecrated life always bound up in the Eucharist, then the 'urge' towards God springs...\"", reflection: "", url: "106", saint: "Saint Martin I : 04/13", saintURL: "https://www.franciscanmedia.org/saint-martin-i/", saintDate: "13-04"),


                             "14-04" : Days(title: "Pope John Paul II reminds us, \"...if desire is predominant it can deform love between man and woman and rob them both of it.\"", reflection: "", url: "107", saint: "Blessed Peter Gonzalez : 04/14", saintURL: "https://www.franciscanmedia.org/blessed-peter-gonzalez/", saintDate: "14-04"),


                             "15-04" : Days(title: "Pope John Paul II tells us, \"Friendship, as has been said, consists in a full commitment of the will to another person with a view to that person's good.\"", reflection: "", url: "108", saint: "Blessed Caesar de Bus : 04/15", saintURL: "https://www.franciscanmedia.org/blessed-caesar-de-bus/", saintDate: "15-04"),


                             "16-04" : Days(title: "Pope John Paul II once told us, \"Take away from love the fullness of self surrender, the completeness of personal commitment, and what remains will be a total denial and negation of it.\"", reflection: "", url: "109", saint: "Saint Bernadette Soubirous : 04/16", saintURL: "https://www.franciscanmedia.org/saint-bernadette-soubirous/", saintDate: "16-04"),


                             "17-04" : Days(title: "Pope John Paul II once said, \"And so, like Moses (cf Ex 3, 5), in spirit we remove the shoes from our feet, on the threshold of the inner sanctuary that each of us must become as we meet the Lord.\"", reflection: "", url: "110", saint: "Saint Benedict Joseph Labre : 04/17", saintURL: "https://www.franciscanmedia.org/saint-benedict-joseph-labre/", saintDate: "17-04"),


                             "18-04" : Days(title: "Pope John Paul II once told us, \"The dramatic threat of ecological breakdown is teaching us the extent to which greed and selfishness are contrary to the order of creation. ...A given culture reveals its understanding of life through the choices it makes in production and consumption... a great deal of educational and cultural work is urgently needed, including the education of consumers in the responsible use of their power of choice...\"", reflection: "", url: "111", saint: "Blessed James Oldo : 04/18", saintURL: "https://www.franciscanmedia.org/blessed-james-oldo/", saintDate: "18-04"),


                             "19-04" : Days(title: "Pope John Paul II once said, \"Limitation of one's freedom might seem to be something negative and unpleasant, but love makes it a positive, joyful and creative thing. Freedom exists for the sake of love.\"", reflection: "", url: "112", saint: "Saint Gianna Beretta Molla : 04/19", saintURL: "https://www.franciscanmedia.org/saint-gianna-beretta-molla/", saintDate: "19-04"),


                             "20-04" : Days(title: "Pope John Paul II reminds us, \"The dignity of the human person is a transcendent value, always recognized as such by those who sincerely search for the truth. Indeed, the whole of human history should be interpreted in the light of this certainty. Every person, created in the image and likeness of God (cf. Gn 1:26 28), is therefore radically oriented towards the Creator, and is constantly in relationship with those possessed of the same dignity. To promote the good of the individual is thus to serve the common good, which is that point where rights and duties converge and reinforce one another.\"", reflection: "", url: "113", saint: "Saint Conrad of Parzham : 04/20", saintURL: "https://www.franciscanmedia.org/saint-conrad-of-parzham/", saintDate: "20-04"),


                             "21-04" : Days(title: "Pope John Paul II tells us, \"Our communal worship at Mass must go together with our personal worship of Jesus in Eucharistic adoration in order that our love may be complete\"", reflection: "", url: "114", saint: "Saint Anselm : 04/21", saintURL: "https://www.franciscanmedia.org/saint-anselm/", saintDate: "21-04"),


                             "22-04" : Days(title: "Pope John Paul II once said, \"Love consists of a commitment which limits one's freedom - it is a giving of the self, and to give oneself means just that: to limit one's freedom on behalf of another.\"", reflection: "", url: "115", saint: "Saint Adalbert of Prague : 04/22", saintURL: "https://www.franciscanmedia.org/saint-adalbert-of-prague/", saintDate: "22-04"),


                             "23-04" : Days(title: "Pope John Paul II tells us, \"Reason and faith cannot be separated without diminishing the capacity of men and women to know themselves, the world and God in an appropriate way.\"", reflection: "", url: "116", saint: "Saint George : 04/23", saintURL: "https://www.franciscanmedia.org/saint-george/", saintDate: "23-04"),


                             "24-04" : Days(title: "Pope John Paul II once said, \"The family, as the fundamental and essential educating community, is the privileged means for transmitting the religious and cultural values which help the person to acquire his or her own identity. Founded on love and open to the gift of life, the family contains in itself the very future of society; its most special task is to contribute effectively to a future of peace.\"", reflection: "", url: "117", saint: "Saint Fidelis of Sigmaringen : 04/24", saintURL: "https://www.franciscanmedia.org/saint-fidelis-of-sigmaringen/", saintDate: "24-04"),


                             "25-04" : Days(title: "Pope John Paul II told us, \"The obligation to earn one's bread by the sweat of one's brow also presumes the right to do so. A society in which this right is systematically denied, in which economic policies do not allow workers to reach satisfactory levels of employment, cannot be justified from an ethical point of view, nor can that society attain social peace.\"", reflection: "", url: "118", saint: "Saint Mark : 04/25", saintURL: "https://www.franciscanmedia.org/saint-mark/", saintDate: "25-04"),


                             "26-04" : Days(title: "Pope John Paul said, \"Amongst all unimportant subjects, football is by far the most important.\"", reflection: "Being that football (soccer) is a popular sport in Europe it is no surprise that Pope John Paul II was a fan. This is a nice humorous quote but also a good chance for us to be thankful for the little things in life that we take for granted that sometimes bring us together with friends and family.", url: "119", saint: "Saint Pedro de San José Betancur : 04/26", saintURL: "https://www.franciscanmedia.org/saint-pedro-de-san-jos-eacute-betancur/", saintDate: "26-04"),


                             "27-04" : Days(title: "Pope John Paul II once said, \"In the Eucharistic Sacrifice the Church venerates the memory of Mary the ever Virgin Mother of God and the memory of Saint Joseph, because he fed Him whom the faithful must eat as the Bread of Life.\"", reflection: "", url: "120", saint: "Saint Louis Mary Grignion de Montfort : 04/27", saintURL: "https://www.franciscanmedia.org/saint-louis-mary-grignion-de-montfort/", saintDate: "27-04"),


                             "28-04" : Days(title: "Pope John Paul II reminds us, \"To believe in Jesus is to accept what he says, even when it runs contrary to what others are saying. It means rejecting the lure of sin, however attractive it may be, in order to set out on the difficult path of the Gospel virtues.\"", reflection: "", url: "121", saint: "Saint Peter Chanel : 04/28", saintURL: "https://www.franciscanmedia.org/saint-peter-chanel/", saintDate: "28-04"),


                             "29-04" : Days(title: "Pope John Paul II reminds us, \"The inviolability of the person which is a reflection of the absolute inviolability of God, finds its primary and fundamental expression in the inviolability of human life. Above all, the common outcry, which is justly made on behalf of human rights-for example, the right to health, to home, to work, to family, to culture- is false and illusory if the right to life, the most basic and fundamental right and the condition for all other personal rights, is not defended with maximum determination.\"", reflection: "", url: "1", saint: "Saint Catherine of Siena : 04/29", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-siena/", saintDate: "29-04"),


                             "30-04" : Days(title: "Pope John Paul II once said, \"All human life-from the moment of conception and through all subsequent stages-is sacred, because human life is created in the image and likeness of God. Nothing surpasses the greatness or dignity of a human person...If a person's right to life is violated at the moment in which he is first conceived in his mother's womb, an indirect blow is struck also at the whole moral order.\"", reflection: "", url: "2", saint: "Saint Pius V : 04/30", saintURL: "https://www.franciscanmedia.org/saint-pius-v/", saintDate: "30-04"),


                             "31-04" : Days(title: "", reflection: "", url: "3", saint: "", saintURL: "", saintDate: "31-04"),






                             "01-05" : Days(title: "", reflection: "", url: "4", saint: "Saint Joseph the Worker : 05/01", saintURL: "https://www.franciscanmedia.org/saint-joseph-the-worker/", saintDate: "01-05"),


                             "02-05" : Days(title: "Pope John Paul II tells us, \"Freedom consists not in doing what we like, but in having the right to do what we ought.\"", reflection: "Take a moment and try and really get to the bottom of what it means not only to your life but what you do for others.", url: "5", saint: "Saint Athanasius : 05/02", saintURL: "https://www.franciscanmedia.org/saint-athanasius/", saintDate: "02-05"),


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


                             "25-05" : Days(title: "On this day in 1995, Ut unum sint, an encyclical by Pope John Paul II was published. In it, John Paul II wrote, \"The Church must breathe with her two lungs\". He was refering to the Western (Roman Catholic) and Eastern (Orthodox) churches, known as \"Sister Churches\".  One body two lungs.", reflection: "On this day, let us pray, along side Saint Pope John Paul II, that the holy spirit can unit these two lungs toward diversity and a sincere commitment to unity.", url: "28", saint: "Saint Bede the Venerable : 05/25", saintURL: "https://www.franciscanmedia.org/saint-bede-the-venerable/", saintDate: "25-05"),


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






                             "01-07" : Days(title: "", reflection: "", url: "66", saint: "Saint Junipero Serra : 07/01", saintURL: "https://www.franciscanmedia.org/saint-junipero-serra/", saintDate: "01-07"),


                             "02-07" : Days(title: "", reflection: "", url: "67", saint: "Saint Oliver Plunkett : 07/02", saintURL: "https://www.franciscanmedia.org/saint-oliver-plunkett/", saintDate: "02-07"),


                             "03-07" : Days(title: "", reflection: "", url: "68", saint: "Saint Thomas the Apostle : 07/03", saintURL: "https://www.franciscanmedia.org/saint-thomas-the-apostle/", saintDate: "03-07"),


                             "04-07" : Days(title: "", reflection: "", url: "69", saint: "Saint Elizabeth of Portugal : 07/04", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-of-portugal/", saintDate: "04-07"),


                             "05-07" : Days(title: "", reflection: "", url: "70", saint: "Saint Anthony Zaccaria : 07/05", saintURL: "https://www.franciscanmedia.org/saint-anthony-zaccaria/", saintDate: "05-07"),


                             "06-07" : Days(title: "", reflection: "", url: "71", saint: "Saint Maria Goretti : 07/06", saintURL: "https://www.franciscanmedia.org/saint-maria-goretti/", saintDate: "06-07"),


                             "07-07" : Days(title: "", reflection: "", url: "72", saint: "Blessed Emmanuel Ruiz and Companions : 07/07", saintURL: "https://www.franciscanmedia.org/blessed-emmanuel-ruiz-and-companions/", saintDate: "07-07"),


                             "08-07" : Days(title: "", reflection: "", url: "73", saint: "Saint Gregory Grassi and Companions : 07/08", saintURL: "https://www.franciscanmedia.org/saint-gregory-grassi-and-companions/", saintDate: "08-07"),


                             "09-07" : Days(title: "", reflection: "", url: "74", saint: "Saint Augustine Zhao Rong and Companions : 07/09", saintURL: "https://www.franciscanmedia.org/saint-augustine-zhao-rong-and-companions/", saintDate: "09-07"),


                             "10-07" : Days(title: "", reflection: "", url: "75", saint: "Saint Veronica Giuliani : 07/10", saintURL: "https://www.franciscanmedia.org/saint-veronica-giuliani/", saintDate: "10-07"),


                             "11-07" : Days(title: "", reflection: "", url: "76", saint: "Saint Benedict : 07/11", saintURL: "https://www.franciscanmedia.org/saint-benedict/", saintDate: "11-07"),


                             "12-07" : Days(title: "", reflection: "", url: "77", saint: "Saints John Jones and John Wall : 07/12", saintURL: "https://www.franciscanmedia.org/saints-john-jones-and-john-wall/", saintDate: "12-07"),


                             "13-07" : Days(title: "", reflection: "", url: "78", saint: "Saint Henry : 07/13", saintURL: "https://www.franciscanmedia.org/saint-henry/", saintDate: "13-07"),


                             "14-07" : Days(title: "", reflection: "", url: "79", saint: "Saint Kateri Tekakwitha : 07/14", saintURL: "https://www.franciscanmedia.org/saint-kateri-tekakwitha/", saintDate: "14-07"),


                             "15-07" : Days(title: "", reflection: "", url: "80", saint: "Saint Bonaventure : 07/15", saintURL: "https://www.franciscanmedia.org/saint-bonaventure/", saintDate: "15-07"),


                             "16-07" : Days(title: "", reflection: "", url: "81", saint: "Our Lady of Mount Carmel : 07/16", saintURL: "https://www.franciscanmedia.org/our-lady-of-mount-carmel/", saintDate: "16-07"),


                             "17-07" : Days(title: "", reflection: "", url: "82", saint: "Saint Francis Solano : 07/17", saintURL: "https://www.franciscanmedia.org/saint-francis-solano/", saintDate: "17-07"),


                             "18-07" : Days(title: "", reflection: "", url: "83", saint: "Saint Camillus de Lellis : 07/18", saintURL: "https://www.franciscanmedia.org/saint-camillus-de-lellis/", saintDate: "18-07"),


                             "19-07" : Days(title: "", reflection: "", url: "84", saint: "Saint Mary MacKillop : 07/19", saintURL: "https://www.franciscanmedia.org/saint-mary-mackillop/", saintDate: "19-07"),


                             "20-07" : Days(title: "", reflection: "", url: "85", saint: "Saint Apollinaris : 07/20", saintURL: "https://www.franciscanmedia.org/saint-apollinaris/", saintDate: "20-07"),


                             "21-07" : Days(title: "", reflection: "", url: "86", saint: "Saint Lawrence of Brindisi : 07/21", saintURL: "https://www.franciscanmedia.org/saint-lawrence-of-brindisi/", saintDate: "21-07"),


                             "22-07" : Days(title: "", reflection: "", url: "87", saint: "Saint Mary Magdalene : 07/22", saintURL: "https://www.franciscanmedia.org/saint-mary-magdalene/", saintDate: "22-07"),


                             "23-07" : Days(title: "", reflection: "", url: "88", saint: "Saint Bridget of Sweden : 07/23", saintURL: "https://www.franciscanmedia.org/saint-bridget/", saintDate: "23-07"),


                             "24-07" : Days(title: "", reflection: "", url: "89", saint: "Saint Sharbel Makhluf : 07/24", saintURL: "https://www.franciscanmedia.org/saint-sharbel-makhluf/", saintDate: "24-07"),


                             "25-07" : Days(title: "", reflection: "", url: "90", saint: "Saint James the Apostle : 07/25", saintURL: "https://www.franciscanmedia.org/saint-james/", saintDate: "25-07"),


                             "26-07" : Days(title: "", reflection: "", url: "91", saint: "Saints Joachim and Anne : 07/26", saintURL: "https://www.franciscanmedia.org/saints-joachim-and-anne/", saintDate: "26-07"),


                             "27-07" : Days(title: "", reflection: "", url: "92", saint: "Blessed Antonio Lucci : 07/27", saintURL: "https://www.franciscanmedia.org/blessed-antonio-lucci/", saintDate: "27-07"),


                             "28-07" : Days(title: "", reflection: "", url: "93", saint: "Blessed Stanley Rother : 07/28", saintURL: "https://www.franciscanmedia.org/blessed-stanley-rother/", saintDate: "28-07"),


                             "29-07" : Days(title: "", reflection: "", url: "94", saint: "Saint Martha : 07/29", saintURL: "https://www.franciscanmedia.org/saint-martha/", saintDate: "29-07"),


                             "30-07" : Days(title: "", reflection: "", url: "95", saint: "Blessed Solanus Casey : 07/30", saintURL: "https://www.franciscanmedia.org/venerable-solanus-casey/", saintDate: "30-07"),


                             "31-07" : Days(title: "", reflection: "", url: "96", saint: "Saint Ignatius of Loyola : 07/31", saintURL: "https://www.franciscanmedia.org/saint-ignatius-of-loyola/", saintDate: "31-07"),





                             "01-08" : Days(title: "", reflection: "", url: "97", saint: "Saint Alphonsus Liguori : 08/01", saintURL: "https://www.franciscanmedia.org/saint-alphonsus-liguori/", saintDate: "01-08"),


                             "02-08" : Days(title: "", reflection: "", url: "98", saint: "Saint Eusebius of Vercelli : 08/02", saintURL: "https://www.franciscanmedia.org/saint-eusebius-of-vercelli/", saintDate: "02-08"),


                             "03-08" : Days(title: "", reflection: "", url: "99", saint: "Saint Peter Julian Eymard : 08/03", saintURL: "https://www.franciscanmedia.org/saint-peter-julian-eymard/", saintDate: "03-08"),


                             "04-08" : Days(title: "", reflection: "", url: "100", saint: "Saint John Vianney : 08/04", saintURL: "https://www.franciscanmedia.org/saint-john-vianney/", saintDate: "04-08"),


                             "05-08" : Days(title: "", reflection: "", url: "101", saint: "Dedication of Saint Mary Major Basilica : 08/05", saintURL: "https://www.franciscanmedia.org/dedication-of-saint-mary-major-basilica/", saintDate: "05-08"),


                             "06-08" : Days(title: "", reflection: "", url: "102", saint: "Transfiguration of the Lord : 08/06", saintURL: "https://www.franciscanmedia.org/transfiguration-of-the-lord/", saintDate: "06-08"),


                             "07-08" : Days(title: "", reflection: "", url: "103", saint: "Saint Cajetan : 08/07", saintURL: "https://www.franciscanmedia.org/saint-cajetan/", saintDate: "07-08"),


                             "08-08" : Days(title: "", reflection: "", url: "104", saint: "Saint Dominic : 08/08", saintURL: "https://www.franciscanmedia.org/saint-dominic/", saintDate: "08-08"),


                             "09-08" : Days(title: "", reflection: "", url: "105", saint: "Saint Teresa Benedicta of the Cross : 08/09", saintURL: "https://www.franciscanmedia.org/saint-teresa-benedicta-of-the-cross-edith-stein/", saintDate: "09-08"),


                             "10-08" : Days(title: "", reflection: "", url: "106", saint: "Saint Lawrence : 08/10", saintURL: "https://www.franciscanmedia.org/saint-lawrence/", saintDate: "10-08"),


                             "11-08" : Days(title: "", reflection: "", url: "107", saint: "Saint Clare of Assisi : 08/11", saintURL: "https://www.franciscanmedia.org/saint-clare-of-assisi/", saintDate: "11-08"),


                             "12-08" : Days(title: "", reflection: "", url: "108", saint: "Saint Jane Frances de Chantal : 08/12", saintURL: "https://www.franciscanmedia.org/saint-jane-frances-de-chantal/", saintDate: "12-08"),


                             "13-08" : Days(title: "", reflection: "", url: "109", saint: "Saints Pontian and Hippolytus : 08/13", saintURL: "https://www.franciscanmedia.org/saints-pontian-and-hippolytus/", saintDate: "13-08"),


                             "14-08" : Days(title: "", reflection: "", url: "110", saint: "Saint Maximilian Mary Kolbe : 08/14", saintURL: "https://www.franciscanmedia.org/saint-maximilian-mary-kolbe/", saintDate: "14-08"),


                             "15-08" : Days(title: "", reflection: "", url: "111", saint: "Solemnity of the Assumption of Mary : 08/15", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-assumption-of-mary/", saintDate: "15-08"),


                             "16-08" : Days(title: "", reflection: "", url: "112", saint: "Saint Stephen of Hungary : 08/16", saintURL: "https://www.franciscanmedia.org/saint-stephen-of-hungary/", saintDate: "16-08"),


                             "17-08" : Days(title: "", reflection: "", url: "113", saint: "Saint Joan of the Cross : 08/17", saintURL: "https://www.franciscanmedia.org/saint-joan-of-the-cross/", saintDate: "17-08"),


                             "18-08" : Days(title: "", reflection: "", url: "114", saint: "Saint Louis of Toulouse : 08/18", saintURL: "https://www.franciscanmedia.org/saint-louis-of-toulouse/", saintDate: "18-08"),


                             "19-08" : Days(title: "", reflection: "", url: "115", saint: "Saint John Eudes : 08/19", saintURL: "https://www.franciscanmedia.org/saint-john-eudes/", saintDate: "19-08"),


                             "20-08" : Days(title: "", reflection: "", url: "116", saint: "Saint Bernard of Clairvaux : 08/20", saintURL: "https://www.franciscanmedia.org/saint-bernard-of-clairvaux/", saintDate: "20-08"),


                             "21-08" : Days(title: "", reflection: "", url: "117", saint: "Saint Pius X : 08/21", saintURL: "https://www.franciscanmedia.org/saint-pius-x/", saintDate: "21-08"),


                             "22-08" : Days(title: "", reflection: "", url: "118", saint: "Queenship of Mary : 08/22", saintURL: "https://www.franciscanmedia.org/queenship-of-mary/", saintDate: "22-08"),


                             "23-08" : Days(title: "", reflection: "", url: "119", saint: "Saint Rose of Lima : 08/23", saintURL: "https://www.franciscanmedia.org/saint-rose-of-lima/", saintDate: "23-08"),


                             "24-08" : Days(title: "", reflection: "", url: "120", saint: "Saint Bartholomew : 08/24", saintURL: "https://www.franciscanmedia.org/saint-bartholomew/", saintDate: "24-08"),


                             "25-08" : Days(title: "", reflection: "", url: "121", saint: "Saint Louis of France : 08/25", saintURL: "https://www.franciscanmedia.org/saint-louis-of-france/", saintDate: "25-08"),


                             "26-08" : Days(title: "", reflection: "", url: "1", saint: "Saint Joseph Calasanz : 08/26", saintURL: "https://www.franciscanmedia.org/saint-joseph-calasanz/", saintDate: "26-08"),


                             "27-08" : Days(title: "", reflection: "", url: "2", saint: "Saint Monica : 08/27", saintURL: "https://www.franciscanmedia.org/saint-monica/", saintDate: "27-08"),


                             "28-08" : Days(title: "", reflection: "", url: "3", saint: "Saint Augustine of Hippo : 08/28", saintURL: "https://www.franciscanmedia.org/saint-augustine-of-hippo/", saintDate: "28-08"),


                             "29-08" : Days(title: "", reflection: "", url: "4", saint: "Martyrdom of John the Baptist : 08/29", saintURL: "https://www.franciscanmedia.org/martyrdom-of-john-the-baptist/", saintDate: "29-08"),


                             "30-08" : Days(title: "", reflection: "", url: "5", saint: "Saint Jeanne Jugan : 08/30", saintURL: "https://www.franciscanmedia.org/saint-jeanne-jugan/", saintDate: "30-08"),


                             "31-08" : Days(title: "", reflection: "", url: "6", saint: "Saints Joseph of Arimathea and Nicodemus : 08/31", saintURL: "https://www.franciscanmedia.org/saints-joseph-of-arimathea-and-nicodemus/", saintDate: "31-08"),




                             "01-09" : Days(title: "", reflection: "", url: "7", saint: "Saint Giles: 09/01", saintURL: "https://www.franciscanmedia.org/saint-giles/", saintDate: "01-09"),


                             "02-09" : Days(title: "", reflection: "", url: "8", saint: "Blessed John Francis Burté and Companions: 09/02", saintURL: "https://www.franciscanmedia.org/blessed-john-francis-burt-eacute-and-companions/", saintDate: "02-09"),


                             "03-09" : Days(title: "", reflection: "", url: "9", saint: "Saint Gregory the Great: 09/03", saintURL: "https://www.franciscanmedia.org/saint-gregory-the-great/", saintDate: "03-09"),


                             "04-09" : Days(title: "", reflection: "", url: "10", saint: "Saint Rose of Viterbo: 09/04", saintURL: "https://www.franciscanmedia.org/saint-rose-of-viterbo/", saintDate: "04-09"),


                             "05-09" : Days(title: "", reflection: "", url: "11", saint: "Saint Teresa of Calcutta: 09/05", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-calcutta/", saintDate: "05-09"),


                             "06-09" : Days(title: "", reflection: "", url: "12", saint: "Blessed Claudio Granzotto: 09/06", saintURL: "https://www.franciscanmedia.org/blessed-claudio-granzotto/", saintDate: "06-09"),


                             "07-09" : Days(title: "", reflection: "", url: "13", saint: "Blessed Frédéric Ozanam: 09/07", saintURL: "https://www.franciscanmedia.org/blessed-fr-d-ric-ozanam/", saintDate: "07-09"),


                             "08-09" : Days(title: "", reflection: "", url: "14", saint: "Nativity of the Blessed Virgin Mary: 09/08", saintURL: "https://www.franciscanmedia.org/nativity-of-the-blessed-virgin-mary/", saintDate: "08-09"),


                             "09-09" : Days(title: "", reflection: "", url: "15", saint: "Saint Peter Claver: 09/09", saintURL: "https://www.franciscanmedia.org/saint-peter-claver/", saintDate: "09-09"),


                             "10-09" : Days(title: "", reflection: "", url: "16", saint: "Saint Thomas of Villanova: 09/10", saintURL: "https://www.franciscanmedia.org/saint-thomas-of-villanova/", saintDate: "10-09"),


                             "11-09" : Days(title: "", reflection: "", url: "17", saint: "Saint Cyprian: 09/11", saintURL: "https://www.franciscanmedia.org/saint-cyprian/", saintDate: "11-09"),


                             "12-09" : Days(title: "", reflection: "", url: "18", saint: "Most Holy Name of the Blessed Virgin Mary: 09/12", saintURL: "https://www.franciscanmedia.org/mosaint-holy-name-of-the-blessed-virgin-mary/", saintDate: "12-09"),


                             "13-09" : Days(title: "", reflection: "", url: "19", saint: "Saint John Chrysostom: 09/13", saintURL: "https://www.franciscanmedia.org/saint-john-chrysostom/", saintDate: "13-09"),


                             "14-09" : Days(title: "", reflection: "", url: "20", saint: "Exaltation of the Holy Cross: 09/14", saintURL: "https://www.franciscanmedia.org/exaltation-of-the-holy-cross/", saintDate: "14-09"),


                             "15-09" : Days(title: "", reflection: "", url: "21", saint: "Our Lady of Sorrows: 09/15", saintURL: "https://www.franciscanmedia.org/our-lady-of-sorrows/", saintDate: "15-09"),


                             "16-09" : Days(title: "", reflection: "", url: "22", saint: "Saint Cornelius: 09/16", saintURL: "https://www.franciscanmedia.org/saint-cornelius/", saintDate: "16-09"),


                             "17-09" : Days(title: "", reflection: "", url: "23", saint: "Saint Robert Bellarmine: 09/17", saintURL: "https://www.franciscanmedia.org/saint-robert-bellarmine/", saintDate: "17-09"),


                             "18-09" : Days(title: "", reflection: "", url: "24", saint: "Saint Joseph of Cupertino: 09/18", saintURL: "https://www.franciscanmedia.org/saint-joseph-of-cupertino/", saintDate: "18-09"),


                             "19-09" : Days(title: "", reflection: "", url: "25", saint: "Saint Januarius: 09/19", saintURL: "https://www.franciscanmedia.org/saint-januarius/", saintDate: "19-09"),


                             "20-09" : Days(title: "", reflection: "", url: "26", saint: "Saints Andrew Kim Taegon, Paul Chong Hasang, and Companions: 09/20", saintURL: "https://www.franciscanmedia.org/saints-andrew-kim-taegon-paul-chong-hasang-and-companions/", saintDate: "20-09"),


                             "21-09" : Days(title: "", reflection: "", url: "27", saint: "Saint Matthew: 09/21", saintURL: "https://www.franciscanmedia.org/saint-matthew/", saintDate: "21-09"),


                             "22-09" : Days(title: "On this day in 1999, Pope John Paul wrote a message to the young people of Israel and Palestine. One thing he said was, \"None of us is alone in this world; each of us is a vital piece of the great mosaic of humanity as a whole.\"", reflection: "", url: "28", saint: "Saint Lorenzo Ruiz and Companions: 09/22", saintURL: "https://www.franciscanmedia.org/saint-lorenzo-ruiz-and-companions/", saintDate: "22-09"),


                             "23-09" : Days(title: "", reflection: "", url: "29", saint: "Saint Pio of Pietrelcina: 09/23", saintURL: "https://www.franciscanmedia.org/saint-pio-of-pietrelcina/", saintDate: "23-09"),


                             "24-09" : Days(title: "", reflection: "", url: "30", saint: "Saint John Henry Newman: 09/24", saintURL: "https://www.franciscanmedia.org/blessed-john-henry-newman/", saintDate: "24-09"),


                             "25-09" : Days(title: "", reflection: "", url: "31", saint: "Saints Louis Martin and Zélie Guerin: 09/25", saintURL: "https://www.franciscanmedia.org/blesseds-louis-martin-and-zelie-guerin/", saintDate: "25-09"),


                             "26-09" : Days(title: "", reflection: "", url: "32", saint: "Saint Paul VIL 09/26", saintURL: "https://www.franciscanmedia.org/saint-paul-vi/", saintDate: "26-09"),


                             "27-09" : Days(title: "", reflection: "", url: "33", saint: "Saint Vincent de Paul: 09/27", saintURL: "https://www.franciscanmedia.org/saint-vincent-de-paul/", saintDate: "27-09"),


                             "28-09" : Days(title: "", reflection: "", url: "34", saint: "Saint Wenceslaus: 09/28", saintURL: "https://www.franciscanmedia.org/saint-wenceslaus/", saintDate: "28-09"),


                             "29-09" : Days(title: "", reflection: "", url: "35", saint: "Saints Michael, Gabriel, and Raphael: 09/29", saintURL: "https://www.franciscanmedia.org/saints-michael-gabriel-and-raphael/", saintDate: "29-09"),


                             "30-09" : Days(title: "", reflection: "", url: "36", saint: "Saint Jerome: 09/30", saintURL: "https://www.franciscanmedia.org/saint-jerome/", saintDate: "30-09"),


                             "31-09" : Days(title: "", reflection: "", url: "37", saint: "", saintURL: "", saintDate: "31-09"),





                             "01-10" : Days(title: "", reflection: "", url: "38", saint: "Saint Thérèse of Lisieux: 10/01", saintURL: "https://www.franciscanmedia.org/saint-theresa-of-the-child-jesus/", saintDate: "01-10"),


                             "02-10" : Days(title: "", reflection: "", url: "39", saint: "Feast of the Guardian Angels: 10/02", saintURL: "https://www.franciscanmedia.org/feasaint-of-the-guardian-angels/", saintDate: "02-10"),


                             "03-10" : Days(title: "", reflection: "", url: "40", saint: "Saint Theodora Guérin: 10/03", saintURL: "https://www.franciscanmedia.org/saint-theodora-gu-eacute-rin/", saintDate: "03-10"),


                             "04-10" : Days(title: "", reflection: "", url: "41", saint: "Saint Francis of Assisi: 10/04", saintURL: "https://www.franciscanmedia.org/saint-francis-of-assisi/", saintDate: "04-10"),


                             "05-10" : Days(title: "", reflection: "", url: "42", saint: "Saint Maria Faustina Kowalska: 10/05", saintURL: "https://www.franciscanmedia.org/saint-maria-faustina-kowalska/", saintDate: "05-10"),


                             "06-10" : Days(title: "", reflection: "", url: "43", saint: "Saint Bruno: 10/06", saintURL: "https://www.franciscanmedia.org/saint-bruno/", saintDate: "06-10"),


                             "07-10" : Days(title: "", reflection: "", url: "44", saint: "Our Lady of the Rosary: 10/07", saintURL: "https://www.franciscanmedia.org/our-lady-of-the-rosary/", saintDate: "07-10"),


                             "08-10" : Days(title: "On this day in 1995 Pope John Paul gave a homily in Orioles Park at Camden Yards.  One thing he said that we can relfect on is, \"It is important for America that the moral truths which make freedom possible should be passed on to each new generation. Every generation of Americans needs to know that freedom consists not in doing what we like, but in having the right to do what we ought. ... Christ asks us to guard the truth because, as he promised us: 'You will know the truth and the truth will make you free.' Depositum custodi! We must guard the truth that is the condition of authentic freedom, the truth that allows freedoms to be fulfilled in goodness. We must guard the deposit of divine truth handed down to us.\"", reflection: "", url: "45", saint: "Saint John Leonardi: 10/08", saintURL: "https://www.franciscanmedia.org/saint-john-leonardi/", saintDate: "08-10"),


                             "09-10" : Days(title: "", reflection: "", url: "46", saint: "Saint Denis and Companions: 10/09", saintURL: "https://www.franciscanmedia.org/saint-denis-and-companions/", saintDate: "09-10"),


                             "10-10" : Days(title: "", reflection: "", url: "47", saint: "Saint Francis Borgia: 10/10", saintURL: "https://www.franciscanmedia.org/saint-francis-borgia/", saintDate: "10-10"),


                             "11-10" : Days(title: "", reflection: "", url: "48", saint: "Saint John XXIII: 10/11", saintURL: "https://www.franciscanmedia.org/saint-john-xxiii/", saintDate: "11-10"),


                             "12-10" : Days(title: "", reflection: "", url: "49", saint: "Blessed Francis Xavier Seelos: 10/12", saintURL: "https://www.franciscanmedia.org/blessed-francis-xavier-seelos/", saintDate: "12-10"),


                             "13-10" : Days(title: "", reflection: "", url: "50", saint: "Blessed Marie-Rose Durocher: 10/13", saintURL: "https://www.franciscanmedia.org/blessed-marie-rose-durocher/", saintDate: "13-10"),


                             "14-10" : Days(title: "", reflection: "", url: "51", saint: "Saint Callistus I: 10/14", saintURL: "https://www.franciscanmedia.org/saint-callistus-i/", saintDate: "14-10"),


                             "15-10" : Days(title: "", reflection: "", url: "52", saint: "Saint Teresa of Avila: 10/15", saintURL: "https://www.franciscanmedia.org/saint-teresa-of-avila/", saintDate: "15-10"),


                             "16-10" : Days(title: "", reflection: "", url: "53", saint: "Saint Margaret Mary Alacoque: 10/16", saintURL: "https://www.franciscanmedia.org/saint-margaret-mary-alacoque/", saintDate: "16-10"),


                             "17-10" : Days(title: "", reflection: "", url: "54", saint: "Saint Ignatius of Antioch: 10/17", saintURL: "https://www.franciscanmedia.org/saint-ignatius-of-antioch/", saintDate: "17-10"),


                             "18-10" : Days(title: "", reflection: "", url: "55", saint: "Saint Luke: 10/18", saintURL: "https://www.franciscanmedia.org/saint-luke/", saintDate: "18-10"),


                             "19-10" : Days(title: "", reflection: "", url: "56", saint: "Saints Isaac Jogues, Jean de Brébeuf, and Companions: 10/19", saintURL: "https://www.franciscanmedia.org/saint-isaac-jogues-jean-de-br-eacute-beuf-and-companions/", saintDate: "19-10"),


                             "20-10" : Days(title: "", reflection: "", url: "57", saint: "Saint Paul of the Cross: 10/20", saintURL: "https://www.franciscanmedia.org/saint-paul-of-the-cross/", saintDate: "20-10"),


                             "21-10" : Days(title: "", reflection: "", url: "58", saint: "Saint Hilarion: 10/21", saintURL: "https://www.franciscanmedia.org/saint-hilarion/", saintDate: "21-10"),


                             "22-10" : Days(title: "", reflection: "", url: "59", saint: "Saint John Paul II: 10/22", saintURL: "https://www.franciscanmedia.org/saint-john-paul-ii/", saintDate: "22-10"),


                             "23-10" : Days(title: "", reflection: "", url: "60", saint: "Saint John of Capistrano: 10/23", saintURL: "https://www.franciscanmedia.org/saint-john-of-capistrano/", saintDate: "23-10"),


                             "24-10" : Days(title: "", reflection: "", url: "61", saint: "Saint Anthony Mary Claret: 10/24", saintURL: "https://www.franciscanmedia.org/saint-anthony-claret/", saintDate: "24-10"),


                             "25-10" : Days(title: "", reflection: "", url: "62", saint: "Saint Antônio de Sant’Anna Galvão: 10/25", saintURL: "https://www.franciscanmedia.org/saint-ant-ocirc-nio-de-sant-146-anna-galv-atilde-o/", saintDate: "25-10"),


                             "26-10" : Days(title: "", reflection: "", url: "63", saint: "Saint Peter of Alcantara: 10/26", saintURL: "https://www.franciscanmedia.org/saint-peter-of-alcantara/", saintDate: "26-10"),


                             "27-10" : Days(title: "", reflection: "", url: "64", saint: "Blessed Bartholomew of Vicenza: 10/27", saintURL: "https://www.franciscanmedia.org/blessed-bartholomew-of-vicenza/", saintDate: "27-10"),


                             "28-10" : Days(title: "", reflection: "", url: "65", saint: "Saints Simon and Jude: 10/28", saintURL: "https://www.franciscanmedia.org/saints-simon-and-jude/", saintDate: "28-10"),


                             "29-10" : Days(title: "", reflection: "", url: "66", saint: "Saint Narcissus of Jerusalem: 10/29", saintURL: "https://www.franciscanmedia.org/saint-narcissus-of-jerusalem/", saintDate: "29-10"),


                             "30-10" : Days(title: "", reflection: "", url: "67", saint: "Saint Alphonsus Rodriguez: 10/30", saintURL: "https://www.franciscanmedia.org/saint-alphonsus-rodriguez/", saintDate: "30-10"),


                             "31-10" : Days(title: "", reflection: "", url: "68", saint: "Saint Wolfgang of Regensburg: 10/31", saintURL: "https://www.franciscanmedia.org/saint-wolfgang-of-regensburg/", saintDate: "31-10"),





                             "01-11" : Days(title: "", reflection: "", url: "69", saint: "Solemnity of All Saints: 11/01", saintURL: "https://www.franciscanmedia.org/solemnity-of-all-saints/", saintDate: "01-11"),


                             "02-11" : Days(title: "", reflection: "", url: "70", saint: "Commemoration of All the Faithful Departed: 11/02", saintURL: "https://www.franciscanmedia.org/commemoration-of-all-the-faithful-departed/", saintDate: "02-11"),


                             "03-11" : Days(title: "", reflection: "", url: "71", saint: "Saint Martin de Porres: 11/03", saintURL: "https://www.franciscanmedia.org/saint-martin-de-porres/", saintDate: "03-11"),


                             "04-11" : Days(title: "", reflection: "", url: "72", saint: "Saint Charles Borromeo: 11/04", saintURL: "https://www.franciscanmedia.org/saint-charles-borromeo/", saintDate: "04-11"),


                             "05-11" : Days(title: "", reflection: "", url: "73", saint: "Saint Peter Chrysologus: 11/05", saintURL: "https://www.franciscanmedia.org/saint-peter-chrysologus/", saintDate: "05-11"),


                             "06-11" : Days(title: "", reflection: "", url: "74", saint: "Saint Nicholas Tavelic and Companions: 11/06", saintURL: "https://www.franciscanmedia.org/saint-nicholas-tavelic-and-companions/", saintDate: "06-11"),


                             "07-11" : Days(title: "", reflection: "", url: "75", saint: "Saint Didacus: 11/07", saintURL: "https://www.franciscanmedia.org/saint-didacus/", saintDate: "07-11"),


                             "08-11" : Days(title: "", reflection: "", url: "76", saint: "Blessed John Duns Scotus: 11/08", saintURL: "https://www.franciscanmedia.org/blessed-john-duns-scotus/", saintDate: "08-11"),


                             "09-11" : Days(title: "", reflection: "", url: "77", saint: "Dedication of St. John Lateran: 11/09", saintURL: "https://www.franciscanmedia.org/dedication-of-saint-john-lateran/", saintDate: "09-11"),


                             "10-11" : Days(title: "", reflection: "", url: "78", saint: "Saint Leo the Great: 11/10", saintURL: "https://www.franciscanmedia.org/saint-leo-the-great/", saintDate: "10-11"),


                             "11-11" : Days(title: "", reflection: "", url: "79", saint: "Saint Martin of Tours: 11/11", saintURL: "https://www.franciscanmedia.org/saint-martin-of-tours/", saintDate: "11-11"),


                             "12-11" : Days(title: "", reflection: "", url: "80", saint: "Saint Josaphat: 11/12", saintURL: "https://www.franciscanmedia.org/saint-josaphat/", saintDate: "12-11"),


                             "13-11" : Days(title: "", reflection: "", url: "81", saint: "Saint Frances Xavier Cabrini: 11/13", saintURL: "https://www.franciscanmedia.org/saint-frances-xavier-cabrini/", saintDate: "13-11"),


                             "14-11" : Days(title: "", reflection: "", url: "82", saint: "Saint Gertrude the Great: 11/14", saintURL: "https://www.franciscanmedia.org/saint-gertrude-the-great/", saintDate: "14-11"),


                             "15-11" : Days(title: "", reflection: "", url: "83", saint: "Saint Albert the Great: 11/15", saintURL: "https://www.franciscanmedia.org/saint-albert-the-great/", saintDate: "15-11"),


                             "16-11" : Days(title: "", reflection: "", url: "84", saint: "Saint Margaret of Scotland: 11/16", saintURL: "https://www.franciscanmedia.org/saint-margaret-of-scotland/", saintDate: "16-11"),


                             "17-11" : Days(title: "", reflection: "", url: "85", saint: "Saint Elizabeth of Hungary: 11/17", saintURL: "https://www.franciscanmedia.org/saint-elizabeth-of-hungary/", saintDate: "17-11"),


                             "18-11" : Days(title: "", reflection: "", url: "86", saint: "Dedication of Churches of Saints Peter and Paul: 11/18", saintURL: "https://www.franciscanmedia.org/dedication-of-churches-of-saints-peter-and-paul/", saintDate: "18-11"),


                             "19-11" : Days(title: "", reflection: "", url: "87", saint: "Saint Agnes of Assisi: 11/19", saintURL: "https://www.franciscanmedia.org/saint-agnes-of-assisi/", saintDate: "19-11"),


                             "20-11" : Days(title: "", reflection: "", url: "88", saint: "Saint Rose Philippine Duchesne: 11/20", saintURL: "https://www.franciscanmedia.org/saint-rose-philippine-duchesne/", saintDate: "20-11"),


                             "21-11" : Days(title: "", reflection: "", url: "89", saint: "Presentation of the Blessed Virgin Mary: 11/21", saintURL: "https://www.franciscanmedia.org/presentation-of-mary/", saintDate: "21-11"),


                             "22-11" : Days(title: "", reflection: "", url: "90", saint: "Saint Cecilia: 11/22", saintURL: "https://www.franciscanmedia.org/saint-cecilia/", saintDate: "22-11"),


                             "23-11" : Days(title: "", reflection: "", url: "91", saint: "Blessed Miguel Agustín Pro: 11/23", saintURL: "https://www.franciscanmedia.org/blessed-miguel-agusaint-iacute-n-pro/", saintDate: "23-11"),


                             "24-11" : Days(title: "", reflection: "", url: "92", saint: "Saint Andrew Dung-Lac and Companions: 11/24", saintURL: "https://www.franciscanmedia.org/saint-andrew-dung-lac-and-companions/", saintDate: "24-11"),


                             "25-11" : Days(title: "BRISBANE, AUSTRALIA - NOVEMBER 25: Pope John Paul II holds a koala in his arms during his official visit to Oceania on November 25, 1986 in Brisbane, Australia.", reflection: "Saint Pope John Paul II once said, \"Freedom consists not in doing what we like, but in having the right to do what we ought.\"\n\nThis is a powerful statement that I am sure many of us struggle with.  Let us reflect for a moment on the things we have done in the last week.  How many of these things have been for the benefit of ourselves as opposed to others?", url: "93", saint: "Saint Catherine of Alexandria: 11/25", saintURL: "https://www.franciscanmedia.org/saint-catherine-of-alexandria/", saintDate: "25-11"),


                             "26-11" : Days(title: "", reflection: "", url: "94", saint: "Saint Columban: 11/26", saintURL: "https://www.franciscanmedia.org/saint-columban/", saintDate: "26-11"),


                             "27-11" : Days(title: "", reflection: "", url: "95", saint: "Saint Francesco Antonio Fasani: 11/27", saintURL: "https://www.franciscanmedia.org/saint-francesco-antonio-fasani/", saintDate: "27-11"),


                             "28-11" : Days(title: "", reflection: "", url: "96", saint: "Saint James of the Marche: 11/28", saintURL: "https://www.franciscanmedia.org/saint-james-of-the-marche/", saintDate: "28-11"),


                             "29-11" : Days(title: "", reflection: "", url: "97", saint: "Saint Clement: 11/29", saintURL: "https://www.franciscanmedia.org/saint-clement/", saintDate: "29-11"),


                             "30-11" : Days(title: "", reflection: "", url: "98", saint: "Saint Andrew: 11/30", saintURL: "https://www.franciscanmedia.org/saint-andrew/", saintDate: "30-11"),


                             "31-11" : Days(title: "", reflection: "", url: "99", saint: "", saintURL: "", saintDate: "31-11"),





                             "01-12" : Days(title: "", reflection: "", url: "100", saint: "Blessed Charles de Foucauld: 12/01", saintURL: "https://www.franciscanmedia.org/blessed-charles-de-foucauld/", saintDate: "01-12"),


                             "02-12" : Days(title: "", reflection: "", url: "101", saint: "Blessed Rafal Chylinski: 12/02", saintURL: "https://www.franciscanmedia.org/blessed-rafal-chylinski/", saintDate: "02-12"),


                             "03-12" : Days(title: "", reflection: "", url: "102", saint: "Saint Francis Xavier: 12/03", saintURL: "https://www.franciscanmedia.org/saint-francis-xavier/", saintDate: "03-12"),


                             "04-12" : Days(title: "", reflection: "", url: "103", saint: "Saint John Damascene: 12/04", saintURL: "https://www.franciscanmedia.org/saint-john-damascene/", saintDate: "04-12"),


                             "05-12" : Days(title: "", reflection: "", url: "104", saint: "Saint Sabas: 12/05", saintURL: "https://www.franciscanmedia.org/saint-sabas/", saintDate: "05-12"),


                             "06-12" : Days(title: "", reflection: "", url: "105", saint: "Saint Nicholas:12/06", saintURL: "https://www.franciscanmedia.org/saint-nicholas/", saintDate: "06-12"),


                             "07-12" : Days(title: "", reflection: "", url: "106", saint: "Saint Ambrose: 12/07", saintURL: "https://www.franciscanmedia.org/saint-ambrose/", saintDate: "07-12"),


                             "08-12" : Days(title: "", reflection: "", url: "107", saint: "Immaculate Conception of the Blessed Virgin Mary: 12/08", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-immaculate-conception/", saintDate: "08-12"),


                             "09-12" : Days(title: "", reflection: "", url: "108", saint: "Saint Juan Diego: 12/09", saintURL: "https://www.franciscanmedia.org/saint-juan-diego/", saintDate: "09-12"),


                             "10-12" : Days(title: "", reflection: "", url: "109", saint: "Blessed Adolph Kolping: 12/10", saintURL: "https://www.franciscanmedia.org/blessed-adolph-kolping/", saintDate: "10-12"),


                             "11-12" : Days(title: "", reflection: "", url: "110", saint: "Saint Damasus I: 12/11", saintURL: "https://www.franciscanmedia.org/saint-damasus-i/", saintDate: "11-12"),


                             "12-12" : Days(title: "", reflection: "", url: "111", saint: "Our Lady of Guadalupe: 12/12", saintURL: "https://www.franciscanmedia.org/our-lady-of-guadalupe/", saintDate: "12-12"),


                             "13-12" : Days(title: "", reflection: "", url: "112", saint: "Saint Lucy: 12/13", saintURL: "https://www.franciscanmedia.org/saint-lucy/", saintDate: "13-12"),


                             "14-12" : Days(title: "", reflection: "", url: "113", saint: "Saint John of the Cross: 12/14", saintURL: "https://www.franciscanmedia.org/saint-john-of-the-cross/", saintDate: "14-12"),


                             "15-12" : Days(title: "", reflection: "", url: "114", saint: "Blessed Mary Frances Schervier: 12/15", saintURL: "https://www.franciscanmedia.org/blessed-mary-frances-schervier/", saintDate: "15-12"),


                             "16-12" : Days(title: "", reflection: "", url: "115", saint: "Blessed Honoratus Kozminski: 12/16", saintURL: "https://www.franciscanmedia.org/blessed-honoratus-kozminski/", saintDate: "16-12"),


                             "17-12" : Days(title: "", reflection: "", url: "116", saint: "Saint Hildegard of Bingen: 12/17", saintURL: "https://www.franciscanmedia.org/saint-hildegard-of-bingen/", saintDate: "17-12"),


                             "18-12" : Days(title: "", reflection: "", url: "117", saint: "Blessed Anthony Grassi: 12/18", saintURL: "https://www.franciscanmedia.org/blessed-anthony-grassi/", saintDate: "18-12"),


                             "19-12" : Days(title: "", reflection: "", url: "118", saint: "Blessed Pope Urban V: 12/19", saintURL: "https://www.franciscanmedia.org/blessed-pope-urban-v/", saintDate: "19-12"),


                             "20-12" : Days(title: "", reflection: "", url: "119", saint: "Saint Dominic of Silos: 12/20", saintURL: "https://www.franciscanmedia.org/saint-dominic-of-silos/", saintDate: "20-12"),


                             "21-12" : Days(title: "", reflection: "", url: "120", saint: "Saint Peter Canisius: 12/21", saintURL: "https://www.franciscanmedia.org/saint-peter-canisius/", saintDate: "21-12"),


                             "22-12" : Days(title: "", reflection: "", url: "121", saint: "Blessed Jacopone da Todi: 12/22", saintURL: "https://www.franciscanmedia.org/blessed-jacopone-da-todi/", saintDate: "22-12"),


                             "23-12" : Days(title: "", reflection: "", url: "1", saint: "Saint John of Kanty: 12/23", saintURL: "https://www.franciscanmedia.org/saint-john-kanty/", saintDate: "23-12"),


                             "24-12" : Days(title: "", reflection: "", url: "2", saint: "Christmas at Greccio: 12/24", saintURL: "https://www.franciscanmedia.org/christmas-at-greccio/", saintDate: "24-12"),


                             "25-12" : Days(title: "", reflection: "", url: "3", saint: "Nativity of the Lord: 12/25", saintURL: "https://www.franciscanmedia.org/solemnity-of-the-nativity-of-the-lord/", saintDate: "25-12"),


                             "26-12" : Days(title: "", reflection: "", url: "4", saint: "Saint Stephen: 12/26", saintURL: "https://www.franciscanmedia.org/saint-stephen/", saintDate: "26-12"),


                             "27-12" : Days(title: "", reflection: "", url: "5", saint: "Saint John the Apostle: 12/27", saintURL: "https://www.franciscanmedia.org/saint-john-the-apostle/", saintDate: "27-12"),


                             "28-12" : Days(title: "", reflection: "", url: "6", saint: "Holy Innocents: 12/28", saintURL: "https://www.franciscanmedia.org/holy-innocents/", saintDate: "28-12"),


                             "29-12" : Days(title: "", reflection: "", url: "7", saint: "Saint Thomas Becket: 12/29", saintURL: "https://www.franciscanmedia.org/saint-thomas-becket/", saintDate: "29-12"),


                             "30-12" : Days(title: "", reflection: "", url: "8", saint: "Saint Egwin: 12/30", saintURL: "https://www.franciscanmedia.org/saint-egwin/", saintDate: "30-12"),


                             "31-12" : Days(title: "", reflection: "", url: "9", saint: "Saint Sylvester I: 12/31", saintURL: "https://www.franciscanmedia.org/saint-sylvester-i/", saintDate: "31-12"),

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

