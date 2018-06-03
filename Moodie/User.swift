//
//  User.swift
//  Moodie
//
//  Created by Griffin on 5/13/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import Foundation
import os.log

class User: NSObject, NSCoding {
    
    struct PropertyKey {
        static let name = "name"
    }
    
    // MARK: Properties
    var name: String
    var entries: [Entry]
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")
    
    // MARK: Initialization
    init(name: String) {
        self.name = name
        entries = [Entry]()
    }
    
    func addEntry(entry: Entry) {
        entries.append(entry)
    }
    
    func titleExist(title: String) -> Bool {
        for entry in entries {
            if entry.title == title {
                return true
            }
        }
        return false
    }
    
    
    func entryExists(title: String) -> Bool {
        for entry in entries {
            if title == entry.title {
                return true
            }
        }
        return false
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a user object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(name: name)
    }
    
}
