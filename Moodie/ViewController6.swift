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
    @IBOutlet weak var entryTable: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var entryArray = [Entry]()
    var delete: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        entryTable.register(UITableViewCell.self, forCellReuseIdentifier: "entry")
        entryTable.dataSource = self
        entryTable.allowsSelection = true
        entryTable.allowsMultipleSelection = false
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textAlignment = .center
        entryArray = appDelegate.currUser.entries
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any!) -> Bool {
        if withIdentifier == "selectEntry" {
            if (entryTable.indexPathForSelectedRow == nil) {
                // No user selected
                errorLabel.text = "No user was selected!"
                return false
            } else {
                if delete {
                    for (index, entry) in appDelegate.currUser.entries.enumerated() {
                        if (entry.title == entryArray[entryTable.indexPathForSelectedRow!.row].title) {
                            appDelegate.currUser.entries.remove(at: index)
                        }
                    }
                } else {
                    appDelegate.currEntry = entryArray[entryTable.indexPathForSelectedRow!.row]
                }
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entryTable.dequeueReusableCell(withIdentifier: "entry", for: indexPath)
        cell.textLabel!.text = entryArray[indexPath.row].title
        return cell
    }
    
    // MARK: Actions
    @IBAction func selectEntry(_ sender: UIButton) {
        // Selects the entry
        delete = false
    }
    
    @IBAction func deleteEntry(_ sender: UIButton) {
        // Deletes the entry
        delete = true
    }
    
}
