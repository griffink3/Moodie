//
//  ViewController3.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UITableViewDataSource {
    
    // MARK: Properties
    @IBOutlet weak var userTable: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var userArray = [User]()
    var delete: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userTable.register(UITableViewCell.self, forCellReuseIdentifier: "user")
        userTable.dataSource = self
        userTable.allowsSelection = true
        userTable.allowsMultipleSelection = false
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textAlignment = .center
        userArray = appDelegate.userArray
        for user in userArray {
            print(user.name)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any!) -> Bool {
        if withIdentifier == "selectUser" {
            if (userTable.indexPathForSelectedRow == nil) {
                // No user selected
                errorLabel.text = "No user was selected!"
                return false
            } else {
                if delete {
                    for (index, user) in appDelegate.userArray.enumerated() {
                        if (user.name == userArray[userTable.indexPathForSelectedRow!.row].name) {
                            appDelegate.userArray.remove(at: index)
                        }
                    }
                    appDelegate.updateUserArray()
                } else {
                    appDelegate.currUser = userArray[userTable.indexPathForSelectedRow!.row]
                }
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTable.dequeueReusableCell(withIdentifier: "user", for: indexPath)
        cell.textLabel!.text = userArray[indexPath.row].name
        return cell
    }
    
    
    // MARK: Actions
    @IBAction func selectUser(_ sender: UIButton) {
        // Selects the user
        delete = false
    }
    
    @IBAction func deleteUser(_ sender: UIButton) {
        // Deletes the user
        delete = true
    }
    

    
}

