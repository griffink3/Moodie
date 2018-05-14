//
//  ViewController4.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newEntryButton: UIButton!
    @IBOutlet weak var pastEntryButton: UIButton!
    @IBOutlet weak var trackButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameLabel.text = appDelegate.currUser.name
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
