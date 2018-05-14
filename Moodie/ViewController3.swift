//
//  ViewController3.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
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
        getUsers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUsers() {
        for (name, _) in appDelegate.users {
            userArray.append(name)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = userTable.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        cell.textLabel!.text = userArray[indexPath.row]
        return cell
    }
    
}

