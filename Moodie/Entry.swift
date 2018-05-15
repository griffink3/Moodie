//
//  Entry.swift
//  Moodie
//
//  Created by Griffin on 5/14/18.
//  Copyright © 2018 Griffin. All rights reserved.
//
//

import Foundation

class Entry {
    
    // MARK: Properties
    var text: String
    var happiness: Int
    var sadness: Int
    var anger: Int
    var fear: Int
    
    // MARK: Initialization
    init(text: String, happiness: Int, sadness: Int, anger: Int, fear: Int) {
        self.text = text
        self.happiness = happiness
        self.sadness = sadness
        self.anger = anger
        self.fear = fear
    }
    
}
