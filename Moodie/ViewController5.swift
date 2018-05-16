//
//  ViewController5.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit

class ViewController5: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var emotionControl: UISegmentedControl!
    @IBOutlet weak var emotionSlider: UISlider!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var entryField: UITextField!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currText: String = ""
    var currHappiness: Int = 0
    var currSadness: Int = 0
    var currAnger: Int = 0
    var currFear: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currText = ""
        currHappiness = 0
        currSadness = 0
        currAnger = 0
        currFear = 0
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textAlignment = .center
        errorLabel.text = " "
        entryField.delegate = self
        entryField.text = "Enter entry here"
        valueField.delegate = self
        valueField.text = "0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any!) -> Bool {
        if withIdentifier == "newEntry" {
            if (currText == "") {
                return false
            }
        }
        return true
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
            if (Float(textField.text!) == nil) {
                errorLabel.text = "Please enter a valid number"
            } else {
                errorLabel.text = " "
                if (emotionControl.selectedSegmentIndex == 0) {
                    currHappiness = Int(Float(textField.text!)!)
                    valueField.text = String(currHappiness)
                } else if (emotionControl.selectedSegmentIndex == 1) {
                    currSadness = Int(Float(textField.text!)!)
                    valueField.text = String(currSadness)
                } else if (emotionControl.selectedSegmentIndex == 2) {
                    currAnger = Int(Float(textField.text!)!)
                    valueField.text = String(currAnger)
                } else if (emotionControl.selectedSegmentIndex == 3) {
                    currFear = Int(Float(textField.text!)!)
                    valueField.text = String(currFear)
                }
            }
        }
    }
    
    // MARK: Actions
    @IBAction func adjustSlider(_ sender: UISlider) {
        if (emotionControl.selectedSegmentIndex == 0) {
            currHappiness = Int(sender.value)
            valueField.text = String(currHappiness)
         } else if (emotionControl.selectedSegmentIndex == 1) {
            currSadness = Int(sender.value)
            valueField.text = String(currSadness)
        } else if (emotionControl.selectedSegmentIndex == 2) {
            currAnger = Int(sender.value)
            valueField.text = String(currAnger)
        } else if (emotionControl.selectedSegmentIndex == 3) {
            currFear = Int(sender.value)
            valueField.text = String(currFear)
        }
    }
    
    @IBAction func changeEmotion(_ sender: UISegmentedControl) {
        if (emotionControl.selectedSegmentIndex == 0) {
            valueField.text = String(currHappiness)
            emotionSlider.setValue(Float(currHappiness), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 1) {
            valueField.text = String(currSadness)
            emotionSlider.setValue(Float(currSadness), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 2) {
            valueField.text = String(currAnger)
            emotionSlider.setValue(Float(currAnger), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 3) {
            valueField.text = String(currFear)
            emotionSlider.setValue(Float(currFear), animated: true)
        }
    }
    
    @IBAction func newEntry(_ sender: UIButton) {
        if (currText != "") {
            appDelegate.currUser.addEntry(time: Date(), entry: Entry(text: currText, happiness: currHappiness, sadness: currSadness, anger: currAnger, fear: currFear)) 
            errorLabel.text = ""
        } else {
            errorLabel.text = "Please enter text"
        }
    }
    
}
