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
    var entries: Dictionary<String, Entry>
    
    // MARK: Initialization
    init(name: String) {
        self.name = name
        entries = [String: Entry]()
    }
    
    func addEntry(title: String, entry: Entry) {
        entries[title] = entry
    }
    
    func titleExist(title: String) -> Bool {
        if (entries[title] == nil) {
            return false
        }
        return true
    }
    
}
