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
    var entries: Dictionary<Date, Entry>
    
    // MARK: Initialization
    init(name: String) {
        self.name = name
        entries = [Date: Entry]()
    }
    
    func addEntry(time: Date, entry: Entry) {
        entries[time] = entry
    }
    
}
