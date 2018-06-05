//
//  ViewController8.swift
//  Moodie
//
//  Created by Griffin on 6/3/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit
import Charts

class ViewController8: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var trackControl: UISegmentedControl!
    @IBOutlet weak var emotionControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var barChart: BarChartView!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currUser = User(name: "default");
    var entries = [Entry]()
    var people = [String: [Int]]()
    var places = [String: [Int]]()
    var organizations = [String: [Int]]()
    var actions = [String: [Int]]()
    var total = [0,0,0,0]
    var topPeople = [[String](), [String](), [String](), [String]()]
    var topPlaces = [[String](), [String](), [String](), [String]()]
    var topOrgs = [[String](), [String](), [String](), [String]()]
    var topActions = [[String](), [String](), [String](), [String]()]
    var topPeopleScores = [[Double](), [Double](), [Double](), [Double]()]
    var topPlacesScores = [[Double](), [Double](), [Double](), [Double]()]
    var topOrgsScores = [[Double](), [Double](), [Double](), [Double]()]
    var topActionsScores = [[Double](), [Double](), [Double](), [Double]()]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        totalLabel.text = ""
        totalLabel.textAlignment = .center
        totalLabel.adjustsFontSizeToFitWidth = true
        currUser = appDelegate.currUser
        entries = currUser.entries
        calculateHighests()
        setChartToPerson(index: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateHighests() {
        for entry in entries {
            total[0] = total[0] + entry.happiness
            total[1] = total[1] + entry.sadness
            total[2] = total[2] + entry.anger
            total[3] = total[3] + entry.fear
            processEntry(entry: entry)
        }
        totalLabel.text = "Total Happiness is " + String(total[0])
    }
    
    func processEntry(entry: Entry) {
        let text: String = entry.text
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: 0)
        tagger.string = text
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName, .verb]
        tagger.enumerateTags(in: NSMakeRange(0, (text as NSString).length), unit: .word, scheme: NSLinguisticTagScheme.nameTypeOrLexicalClass, options: options) { tag, tokenRange, stop in
            if let tag = tag, tags.contains(tag) {
                let name = (text as NSString).substring(with: tokenRange)
                addToDict(word: name, tag: tag, entry: entry)
            }
        }
    }
    
    func addToDict(word: String, tag: NSLinguisticTag, entry: Entry) {
        // Adds the a word and its corresponding emotional weights to the proper dictionary depending on the tag
        if (tag == NSLinguisticTag.personalName) {
            if (people[word] == nil) {
                people[word] = [0,0,0,0]
            }
            people = updateDictEntries(tempDict: people, word: word, entry: entry)
        } else if (tag == NSLinguisticTag.placeName) {
            if (places[word] == nil) {
                places[word] = [0,0,0,0]
            }
            places = updateDictEntries(tempDict: places, word: word, entry: entry)
        } else if (tag == NSLinguisticTag.organizationName) {
            if (organizations[word] == nil) {
                organizations[word] = [0,0,0,0]
            }
            organizations = updateDictEntries(tempDict: organizations, word: word, entry: entry)
        } else if (tag == NSLinguisticTag.verb) {
            if (actions[word] == nil) {
                actions[word] = [0,0,0,0]
            }
            actions = updateDictEntries(tempDict: actions, word: word, entry: entry)
        }
    }
    
    func updateDictEntries(tempDict: [String: [Int]], word: String, entry: Entry) -> [String: [Int]] {
        var dict = tempDict
        dict[word]![0] = dict[word]![0] + entry.happiness
        dict[word]![1] = dict[word]![1] + entry.sadness
        dict[word]![2] = dict[word]![2] + entry.anger
        dict[word]![3] = dict[word]![3] + entry.fear
        return dict
    }
    
    func setChartToPerson(index: Int) {
        if (topPeople[index].isEmpty) {
            var topP = [String]()
            var topScores = [Double]()
            var dict = [Int: [String]]()
            var scores = [Int]()
            for (person, values) in people {
                if dict[values[index]] == nil {
                    dict[values[index]] = [String]()
                    scores.append(values[index])
                }
                dict[values[index]]?.append(person)
            }
            scores = scores.sorted().reversed()
            while (!scores.isEmpty && topPeople[index].count < 6) {
                let score = scores.remove(at: 0)
                for word in dict[score]! {
                    topP.append(word)
                    topScores.append(Double(score))
                }
            }
            topPeople[index] = topP
            topPeopleScores[index] = topScores
        }
        setChart(dataPoints: topPeople[index], values: topPeopleScores[index])
    }
    
    func setChartToPlace(index: Int) {
        if (topPlaces[index].isEmpty) {
            var topP = [String]()
            var topScores = [Double]()
            var dict = [Int: [String]]()
            var scores = [Int]()
            for (place, values) in places {
                if dict[values[index]] == nil {
                    dict[values[index]] = [String]()
                    scores.append(values[index])
                }
                dict[values[index]]?.append(place)
            }
            scores = scores.sorted().reversed()
            while (!scores.isEmpty && topPlaces[index].count < 6) {
                let score = scores.remove(at: 0)
                for word in dict[score]! {
                    topP.append(word)
                    topScores.append(Double(score))
                }
            }
            topPlaces[index] = topP
            topPlacesScores[index] = topScores
        }
        setChart(dataPoints: topPlaces[index], values: topPlacesScores[index])
    }
    
    func setChartToOrg(index: Int) {
        if (topOrgs[index].isEmpty) {
            var top = [String]()
            var topScores = [Double]()
            var dict = [Int: [String]]()
            var scores = [Int]()
            for (org, values) in organizations {
                if dict[values[index]] == nil {
                    dict[values[index]] = [String]()
                    scores.append(values[index])
                }
                dict[values[index]]?.append(org)
            }
            scores = scores.sorted().reversed()
            while (!scores.isEmpty && topOrgs[index].count < 6) {
                let score = scores.remove(at: 0)
                for word in dict[score]! {
                    top.append(word)
                    topScores.append(Double(score))
                }
            }
            topOrgs[index] = top
            topOrgsScores[index] = topScores
        }
        setChart(dataPoints: topOrgs[index], values: topOrgsScores[index])
    }
    
    func setChartToAction(index: Int) {
        if (topActions[index].isEmpty) {
            var top = [String]()
            var topScores = [Double]()
            var dict = [Int: [String]]()
            var scores = [Int]()
            for (action, values) in actions {
                if dict[values[index]] == nil {
                    dict[values[index]] = [String]()
                    scores.append(values[index])
                }
                dict[values[index]]?.append(action)
            }
            scores = scores.sorted().reversed()
            while (!scores.isEmpty && topActions[index].count < 6) {
                let score = scores.remove(at: 0)
                for word in dict[score]! {
                    top.append(word)
                    topScores.append(Double(score))
                }
            }
            topActions[index] = top
            topActionsScores[index] = topScores
        }
        setChart(dataPoints: topActions[index], values: topActionsScores[index])
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        let d = Description()
        barChart.animate(yAxisDuration: 1)
        if (trackControl.selectedSegmentIndex == 0) {
            d.text = "People"
        } else if (trackControl.selectedSegmentIndex == 1) {
            d.text = "Places"
        } else if (trackControl.selectedSegmentIndex == 2) {
            d.text = "Organizations"
        } else if (trackControl.selectedSegmentIndex == 3) {
            d.text = "Actions"
        }
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry()
            dataEntry.y = values[i]
            dataEntry.x = Double(i)
            dataEntries.append(dataEntry)
        }
        
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: "")
        
        if (emotionControl.selectedSegmentIndex == 0) {
            barChartDataSet.colors = [UIColor(red: 0.9882, green: 0.9647, blue: 0.502, alpha: 1.0)]
        } else if (emotionControl.selectedSegmentIndex == 1) {
            barChartDataSet.colors = [UIColor(red: 0.0784, green: 0.5216, blue: 1, alpha: 1.0)]
        } else if (emotionControl.selectedSegmentIndex == 2) {
            barChartDataSet.colors = [UIColor(red: 1, green: 0.5098, blue: 0.5098, alpha: 1.0)]
        } else if (emotionControl.selectedSegmentIndex == 3) {
            barChartDataSet.colors = [UIColor(red: 0.3294, green: 0.3294, blue: 0.3294, alpha: 1.0)]
        }
        
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChart.data = barChartData

        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:dataPoints)
        barChart.xAxis.granularity = 1
        barChart.chartDescription = d
        
        if (dataPoints.isEmpty && values.isEmpty) {
            barChart.clear()
            barChart.noDataTextColor = UIColor.red
            barChart.noDataFont = UIFont(name: "Futura-CondensedExtraBold", size: 18)
            barChart.noDataTextAlignment = .center
            if (trackControl.selectedSegmentIndex == 0) {
                barChart.noDataText = "No people were found in your entries"
            } else if (trackControl.selectedSegmentIndex == 1) {
                barChart.noDataText = "No places were found in your entries"
            } else if (trackControl.selectedSegmentIndex == 2) {
                barChart.noDataText = "No organizations were found in your entries"
            } else if (trackControl.selectedSegmentIndex == 3) {
                barChart.noDataText = "No actions were found in your entries"
            }
        }
    }
    
    func segmentChange() {
        if trackControl.selectedSegmentIndex == 0 {
            if emotionControl.selectedSegmentIndex == 0 {
                setChartToPerson(index: 0)
            } else if emotionControl.selectedSegmentIndex == 1 {
                setChartToPerson(index: 1)
            } else if emotionControl.selectedSegmentIndex == 2 {
                setChartToPerson(index: 2)
            } else if emotionControl.selectedSegmentIndex == 3 {
                setChartToPerson(index: 3)
            }
        } else if trackControl.selectedSegmentIndex == 1 {
            if emotionControl.selectedSegmentIndex == 0 {
                setChartToPlace(index: 0)
            } else if emotionControl.selectedSegmentIndex == 1 {
                setChartToPlace(index: 1)
            } else if emotionControl.selectedSegmentIndex == 2 {
                setChartToPlace(index: 2)
            } else if emotionControl.selectedSegmentIndex == 3 {
                setChartToPlace(index: 3)
            }
        } else if trackControl.selectedSegmentIndex == 2 {
            if emotionControl.selectedSegmentIndex == 0 {
                setChartToOrg(index: 0)
            } else if emotionControl.selectedSegmentIndex == 1 {
                setChartToOrg(index: 1)
            } else if emotionControl.selectedSegmentIndex == 2 {
                setChartToOrg(index: 2)
            } else if emotionControl.selectedSegmentIndex == 3 {
                setChartToOrg(index: 3)
            }
        } else if trackControl.selectedSegmentIndex == 3 {
            if emotionControl.selectedSegmentIndex == 0 {
                setChartToAction(index: 0)
            } else if emotionControl.selectedSegmentIndex == 1 {
                setChartToAction(index: 1)
            } else if emotionControl.selectedSegmentIndex == 2 {
                setChartToAction(index: 2)
            } else if emotionControl.selectedSegmentIndex == 3 {
                setChartToAction(index: 3)
            }
        }
    }
    
    // MARK: Actions
    @IBAction func changeTrack(_ sender: UISegmentedControl) {
        segmentChange()
    }
    
    @IBAction func changeEmotion(_ sender: UISegmentedControl) {
        if emotionControl.selectedSegmentIndex == 0 {
            totalLabel.text = "Total Happiness is " + String(total[0])
        } else if emotionControl.selectedSegmentIndex == 1 {
            totalLabel.text = "Total Sadness is " + String(total[1])
        } else if emotionControl.selectedSegmentIndex == 2 {
            totalLabel.text = "Total Anger is " + String(total[2])
        } else if emotionControl.selectedSegmentIndex == 3 {
            totalLabel.text = "Total Fear is " + String(total[3])
        }
        segmentChange()
    }
    
}
