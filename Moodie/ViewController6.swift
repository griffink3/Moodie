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
    var entryArray = [String]()
    var shouldSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        entryTable.register(UITableViewCell.self, forCellReuseIdentifier: "entry")
        entryTable.dataSource = self
        entryTable.allowsSelection = true
        entryTable.allowsMultipleSelection = false
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textAlignment = .center
        shouldSegue = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier: String, sender: Any!) -> Bool {
        if withIdentifier == "selectEntry" {
            return shouldSegue
        }
        return true
    }
    
    func getEntries() {
        for (title, _) in appDelegate.currUser.entries {
            entryArray.append(title)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entryArray.removeAll()
        getEntries()
        return entryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entryTable.dequeueReusableCell(withIdentifier: "entry", for: indexPath)
        print(entryArray[indexPath.row])
        cell.textLabel!.text = entryArray[indexPath.row]
        return cell
    }
    
    // MARK: Actions
    @IBAction func selectEntry(_ sender: UIButton) {
        // Selects the entry
        if (entryTable.indexPathForSelectedRow == nil) {
            // No user selected
            errorLabel.text = "No user was selected!"
        } else {
            appDelegate.currEntry = appDelegate.currUser.entries[entryArray[entryTable.indexPathForSelectedRow!.row]]!
            shouldSegue = true
        }
    }
    
    @IBAction func deleteEntry(_ sender: UIButton) {
        if (entryTable.indexPathForSelectedRow == nil) {
            // No user selected
            errorLabel.text = "No user was selected!"
        } else {
            appDelegate.currUser.entries.removeValue(forKey: entryArray[entryTable.indexPathForSelectedRow!.row])
            shouldSegue = true
        }
    }
    
}
