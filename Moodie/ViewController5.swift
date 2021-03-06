//
//  ViewController5.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit
import Charts

class ViewController5: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var emotionControl: UISegmentedControl!
    @IBOutlet weak var emotionSlider: UISlider!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var entryField: UITextField!
    @IBOutlet weak var pieChart: PieChartView!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currText: String = ""
    var emotions = ["Happiness", "Sadness", "Anger", "Fear"]
    var emotionValues = [1.0, 1.0, 1.0, 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currText = ""
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textAlignment = .center
        errorLabel.text = " "
        entryField.delegate = self
        entryField.text = ""
        valueField.delegate = self
        valueField.text = "0"
        setChart(dataPoints: emotions, values: emotionValues)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any!) -> Bool {
        if withIdentifier == "newEntry" {
            if (currText == "") {
                errorLabel.text = "Please enter text"
                return false
            } else {
                errorLabel.text = ""
                let date: Date = Date()
                let title: String = dateToString(date: date)
                if (!appDelegate.currUser.titleExist(title: title)) {
                    appDelegate.currUser.addEntry(entry: Entry(text: currText, title: dateToString(date: date), happiness: Int(emotionValues[0]), sadness: Int(emotionValues[1]), anger: Int(emotionValues[2]), fear: Int(emotionValues[3]), user: appDelegate.currUser.name))
                    errorLabel.text = ""
                } else {
                    errorLabel.text = "Title already exists"
                    return false
                }
            }
        }
        return true
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [PieChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry()
            dataEntry.y = values[i]
            dataEntry.label = dataPoints[i]
            dataEntries.append(dataEntry)
        }

        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")

        var colors: [UIColor] = []
        // Adding yellow
        colors.append(UIColor(red: 0.9882, green: 0.9647, blue: 0.502, alpha: 1.0))
        // Adding blue
        colors.append(UIColor(red: 0.0784, green: 0.5216, blue: 1, alpha: 1.0))
        // Adding red
        colors.append(UIColor(red: 1, green: 0.5098, blue: 0.5098, alpha: 1.0))
        // Adding black
        colors.append(UIColor(red: 0.3294, green: 0.3294, blue: 0.3294, alpha: 1.0))

        pieChartDataSet.colors = colors
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        
        let d = Description()
        d.text = "Emotional Weights"
        pieChart.chartDescription = d
        pieChart.holeColor = UIColor(red: 0.5765, green: 0.5765, blue: 0.5765, alpha: 1.0)
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.restorationIdentifier == "entryField") {
            currText = textField.text!
        } else if (textField.restorationIdentifier == "valueField") {
            if (Int(textField.text!) == nil || Int(textField.text!)! > 100) {
                errorLabel.text = "Please enter a valid integer"
            } else {
                errorLabel.text = " "
                if (emotionControl.selectedSegmentIndex == 0) {
                    emotionValues[0] = Double(Int(Float(textField.text!)!))
                    valueField.text = String(emotionValues[0])
                } else if (emotionControl.selectedSegmentIndex == 1) {
                    emotionValues[1] = Double(Int(Float(textField.text!)!))
                    valueField.text = String(emotionValues[1])
                } else if (emotionControl.selectedSegmentIndex == 2) {
                    emotionValues[2] = Double(Int(Float(textField.text!)!))
                    valueField.text = String(emotionValues[2])
                } else if (emotionControl.selectedSegmentIndex == 3) {
                    emotionValues[3] = Double(Int(Float(textField.text!)!))
                    valueField.text = String(emotionValues[3])
                }
                setChart(dataPoints: emotions, values: emotionValues)
            }
        }
    }
    
    // MARK: Actions
    @IBAction func adjustSlider(_ sender: UISlider) {
        if (emotionControl.selectedSegmentIndex == 0) {
            emotionValues[0] = Double(Int(sender.value))
            valueField.text = String(emotionValues[0])
         } else if (emotionControl.selectedSegmentIndex == 1) {
            emotionValues[1] = Double(Int(sender.value))
            valueField.text = String(emotionValues[1])
        } else if (emotionControl.selectedSegmentIndex == 2) {
            emotionValues[2] = Double(Int(sender.value))
            valueField.text = String(emotionValues[2])
        } else if (emotionControl.selectedSegmentIndex == 3) {
            emotionValues[3] = Double(Int(sender.value))
            valueField.text = String(emotionValues[3])
        }
        setChart(dataPoints: emotions, values: emotionValues)

    }
    
    @IBAction func changeEmotion(_ sender: UISegmentedControl) {
        if (emotionControl.selectedSegmentIndex == 0) {
            valueField.text = String(emotionValues[0])
            emotionSlider.setValue(Float(emotionValues[0]), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 1) {
            valueField.text = String(emotionValues[1])
            emotionSlider.setValue(Float(emotionValues[1]), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 2) {
            valueField.text = String(emotionValues[2])
            emotionSlider.setValue(Float(emotionValues[2]), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 3) {
            valueField.text = String(emotionValues[3])
            emotionSlider.setValue(Float(emotionValues[3]), animated: true)
        }
    }
    
    @IBAction func newEntry(_ sender: UIButton) {
    }
    
}
