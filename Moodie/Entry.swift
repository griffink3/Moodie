//
//  Entry.swift
//  Moodie
//
//  Created by Griffin on 5/14/18.
//  Copyright © 2018 Griffin. All rights reserved.
//
//

import Foundation
import os.log

class Entry: NSObject, NSCoding  {
    
    struct PropertyKey {
        static let title = "title"
        static let text = "text"
        static let happiness = "happiness"
        static let sadness = "happiness"
        static let anger = "happiness"
        static let fear = "happiness"
        static let user = "user"
    }
    
    // MARK: Properties
    var text: String
    var title: String
    var happiness: Int
    var sadness: Int
    var anger: Int
    var fear: Int
    var user: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("entry")
    
    // MARK: Initialization
    init(text: String, title: String, happiness: Int, sadness: Int, anger: Int, fear: Int, user: String) {
        self.text = text
        self.title = title
        self.happiness = happiness
        self.sadness = sadness
        self.anger = anger
        self.fear = fear
        self.user = user
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the title for an entry object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let text = aDecoder.decodeObject(forKey: PropertyKey.text) as? String else {
            os_log("Unable to decode the text for an entry object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let happiness = aDecoder.decodeObject(forKey: PropertyKey.happiness) as? Int else {
            os_log("Unable to decode the happiness for an entry object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let sadness = aDecoder.decodeObject(forKey: PropertyKey.sadness) as? Int else {
            os_log("Unable to decode the sadness for an entry object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let anger = aDecoder.decodeObject(forKey: PropertyKey.anger) as? Int else {
            os_log("Unable to decode the anger for an entry object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let fear = aDecoder.decodeObject(forKey: PropertyKey.fear) as? Int else {
            os_log("Unable to decode the fear for an entry object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let user = aDecoder.decodeObject(forKey: PropertyKey.user) as? String else {
            os_log("Unable to decode the user for an entry object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(text: text, title: title, happiness: happiness, sadness: sadness, anger: anger, fear: fear, user: user)
    }
    
}
