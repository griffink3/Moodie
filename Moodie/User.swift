//
//  User.swift
//  Moodie
//
//  Created by Griffin on 5/13/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import Foundation

class User {
    
    // MARK: Properties
    var name: String
    var entries: Dictionary<NSDate, Entry>
    
    // MARK: Initialization
    init(name: String) {
        self.name = name
        entries = [NSDate: Entry]()
    }
    
    func addEntry(time: NSDate, entry: Entry) {
        entries[time] = entry
    }
    
}
