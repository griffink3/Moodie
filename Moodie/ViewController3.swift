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
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var userArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userTable.register(UITableViewCell.self, forCellReuseIdentifier: "user")
        userTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUsers() {
        for (name, _) in appDelegate.users {
            print(name)
            userArray.append(name)
        }
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
    
}

