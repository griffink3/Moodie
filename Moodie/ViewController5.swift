//
//  ViewController5.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit

class ViewController5: UIViewController, UITextViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var entryField: UITextView!
    @IBOutlet weak var emotionControl: UISegmentedControl!
    @IBOutlet weak var emotionSlider: UISlider!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currText: String = ""
    var currHappiness: Int = 0
    var currSadness: Int = 0
    var currAnger: Int = 0
    var currFear: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        entryField.delegate = self
        currText = ""
        currHappiness = 0
        currSadness = 0
        currAnger = 0
        currFear = 0
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textAlignment = .center
        errorLabel.text = " "
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.textAlignment = .center
        valueLabel.text = " 0"
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
    
    // MARK: UITextViewDelegate
    func textViewDidEndEditing(_ textView: UITextView) {
        currText = textView.text
        print(currText)
    }
    
    // MARK: Actions
    @IBAction func adjustSlider(_ sender: UISlider) {
        if (emotionControl.selectedSegmentIndex == 0) {
            currHappiness = Int(sender.value)
            valueLabel.text = " " + String(currHappiness)
         } else if (emotionControl.selectedSegmentIndex == 1) {
            currSadness = Int(sender.value)
            valueLabel.text = " " + String(currSadness)
        } else if (emotionControl.selectedSegmentIndex == 2) {
            currAnger = Int(sender.value)
            valueLabel.text = " " + String(currAnger)
        } else if (emotionControl.selectedSegmentIndex == 3) {
            currFear = Int(sender.value)
            valueLabel.text = " " + String(currFear)
        }
    }
    
    @IBAction func changeEmotion(_ sender: UISegmentedControl) {
        if (emotionControl.selectedSegmentIndex == 0) {
            valueLabel.text = " " + String(currHappiness)
            emotionSlider.setValue(Float(currHappiness), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 1) {
            valueLabel.text = " " + String(currSadness)
            emotionSlider.setValue(Float(currSadness), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 2) {
            valueLabel.text = " " + String(currAnger)
            emotionSlider.setValue(Float(currAnger), animated: true)
        } else if (emotionControl.selectedSegmentIndex == 3) {
            valueLabel.text = " " + String(currFear)
            emotionSlider.setValue(Float(currFear), animated: true)
        }
    }
    
    @IBAction func newEntry(_ sender: UIButton) {
        print("MADE A NEW ENTRY")
        if (currText != "") {
            appDelegate.currUser.addEntry(time: NSDate(), entry: Entry(text: currText, happiness: currHappiness, sadness: currSadness, anger: currAnger, fear: currFear))
            errorLabel.text = ""
        } else {
            errorLabel.text = "Please enter text"
        }
    }
    
    
}
