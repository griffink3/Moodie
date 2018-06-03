//
//  ViewController2.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var newNameField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currName: String = ""
    var shouldSegue: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newNameField.delegate = self
        shouldSegue = false
        errorLabel.text = " "
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textAlignment = .center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any!) -> Bool {
        if withIdentifier == "newUser" {
            return shouldSegue
        }
        return true
    }
    
    func userExists(name: String) -> Bool {
        for user in appDelegate.userArray {
            if (user.name == name) {
                return true
            }
        }
        return false
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        currName = textField.text!
    }
    
    // MARK: Actions
    @IBAction func newUser(_ sender: UIButton) {
        if (currName == "" || userExists(name: currName)) {
            // Throw error
            errorLabel.text = "Invalid name or name already taken!"
        } else {
            // Create a new user
            appDelegate.currUser = User(name: currName)
            appDelegate.userArray.append(appDelegate.currUser)
            appDelegate.updateUserArray()
            shouldSegue = true
        }
        currName = ""
    }
    
}

