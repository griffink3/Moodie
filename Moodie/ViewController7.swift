//
//  ViewController7.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit
import Charts

class ViewController7: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryField: UITextField!
    @IBOutlet weak var emotionControl: UISegmentedControl!
    @IBOutlet weak var emotionSlider: UISlider!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var pieChart: PieChartView!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currEntry: Entry = Entry(text: "default", title: "default", happiness: 0, sadness: 0, anger: 0, fear: 0, user: "default")
    var emotions = ["Happiness", "Sadness", "Anger", "Fear"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currEntry = appDelegate.currEntry
        titleLabel.text = currEntry.title
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textAlignment = .center
        errorLabel.text = " "
        entryField.delegate = self
        entryField.text = currEntry.text
        valueField.delegate = self
        valueField.text = String(currEntry.happiness)
        updateChart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChart() {
        setChart(dataPoints: emotions, values: [Double(currEntry.happiness), Double(currEntry.sadness), Double(currEntry.anger), Double(currEntry.fear)])
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Emotional Weight")
        let pieChartData = PieChartData()
        pieChartData.addDataSet(pieChartDataSet)
        pieChart.data = pieChartData
        
        var colors: [UIColor] = []
        // Adding yellow
        colors.append(UIColor(red: CGFloat(255/255), green: CGFloat(255/255), blue: CGFloat(0/255), alpha: 1))
        // Adding blue
        colors.append(UIColor(red: CGFloat(0/255), green: CGFloat(0/255), blue: CGFloat(255/255), alpha: 1))
        // Adding red
        colors.append(UIColor(red: CGFloat(255/255), green: CGFloat(0/255), blue: CGFloat(0/255), alpha: 1))
        // Adding black
        colors.append(UIColor(red: CGFloat(0/255), green: CGFloat(0/255), blue: CGFloat(0/255), alpha: 1))
        
        pieChartDataSet.colors = colors
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.restorationIdentifier == "entryField") {
            currEntry.text = textField.text!
        } else if (textField.restorationIdentifier == "valueField") {
            if (Int(textField.text!) == nil || Int(textField.text!)! > 100) {
                errorLabel.text = "Please enter a valid integer"
            } else {
                errorLabel.text = " "
                if (emotionControl.selectedSegmentIndex == 0) {
                    currEntry.happiness = Int(Float(textField.text!)!)
                    valueField.text = String(currEntry.happiness)
                } else if (emotionControl.selectedSegmentIndex == 1) {
                    currEntry.sadness = Int(Float(textField.text!)!)
                    valueField.text = String(currEntry.sadness)
                } else if (emotionControl.selectedSegmentIndex == 2) {
                    currEntry.anger = Int(Float(textField.text!)!)
                    valueField.text = String(currEntry.anger)
                } else if (emotionControl.selectedSegmentIndex == 3) {
                    currEntry.fear = Int(Float(textField.text!)!)
                    valueField.text = String(currEntry.fear)
                }
                updateChart()
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any!) -> Bool {
        if withIdentifier == "submit" {
            for (index, entry) in appDelegate.currUser.entries.enumerated() {
                if (entry.title == currEntry.title) {
                    appDelegate.currUser.entries.remove(at: index)
                }
            }
            appDelegate.currUser.entries.append(currEntry)
        }
        return true
    }
    
    // MARK: Actions
    @IBAction func adjustSlider(_ sender: UISlider) {
        if (emotionControl.selectedSegmentIndex == 0) {
            currEntry.happiness = Int(sender.value)
            valueField.text = String(currEntry.happiness)
        } else if (emotionControl.selectedSegmentIndex == 1) {
            currEntry.sadness = Int(sender.value)
            valueField.text = String(currEntry.sadness)
        } else if (emotionControl.selectedSegmentIndex == 2) {
            currEntry.anger = Int(sender.value)
            valueField.text = String(currEntry.anger)
        } else if (emotionControl.selectedSegmentIndex == 3) {
            currEntry.fear = Int(sender.value)
            valueField.text = String(currEntry.fear)
        }
        updateChart()
    }
    
    @IBAction func changeEmotion(_ sender: UISegmentedControl) {
        if (emotionControl.selectedSegmentIndex == 0) {
            valueField.text = String(currEntry.happiness)
            emotionSlider.setValue(Float(currEntry.happiness), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 1) {
            valueField.text = String(currEntry.sadness)
            emotionSlider.setValue(Float(currEntry.sadness), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 2) {
            valueField.text = String(currEntry.anger)
            emotionSlider.setValue(Float(currEntry.anger), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 3) {
            valueField.text = String(currEntry.fear)
            emotionSlider.setValue(Float(currEntry.fear), animated: true)
        }
    }
    
}
