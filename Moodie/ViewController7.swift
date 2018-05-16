//
//  ViewController7.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit

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
    @IBAction func deleteButton(_ sender: Any) {
    }
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currEntry: Entry = Entry(text: "default", title: "default", happiness: 0, sadness: 0, anger: 0, fear: 0)
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any!) -> Bool {
        if withIdentifier == "submitEntry" {
            if (currEntry.text == "") {
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
            currEntry.text = textField.text!
        } else if (textField.restorationIdentifier == "valueField") {
            if (Float(textField.text!) == nil) {
                errorLabel.text = "Please enter a valid number"
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
            }
        }
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
    
    @IBAction func newEntry(_ sender: UIButton) {
        if (currEntry.text != "") {
            errorLabel.text = ""
        } else {
            errorLabel.text = "Please enter text"
        }
    }
    
}
