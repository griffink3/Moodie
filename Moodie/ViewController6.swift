//
//  ViewController6.swift
//  Moodie
//
//  Created by Griffin on 5/14/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit

class ViewController6: UIViewController, UITableViewDataSource {
    
    // MARK: Properties
    
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userArray.removeAll()
        getUsers()
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("BUILDING TABLE")
        let cell = userTable.dequeueReusableCell(withIdentifier: "user", for: indexPath)
        print(userArray[indexPath.row])
        cell.textLabel!.text = userArray[indexPath.row]
        return cell
    }
    
    // MARK: Actions
    @IBAction func selectUser(_ sender: UIButton) {
        // Selects the user
        if (userTable.indexPathForSelectedRow == nil) {
            // No user selected
            errorLabel.text = "No user was selected!"
        } else {
            print(userTable.indexPathForSelectedRow!.row)
            print(userArray[userTable.indexPathForSelectedRow!.row])
            appDelegate.currUser = appDelegate.users[userArray[userTable.indexPathForSelectedRow!.row]]!
            shouldSegue = true
        }
    }
    
    
}
