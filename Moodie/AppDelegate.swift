//
//  AppDelegate.swift
//  Moodie
//
//  Created by Griffin on 5/9/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import UIKit
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currUser: User
    var currEntry: Entry
    var userArray: [User]
    var entryArray: [Entry]
    
    override init() {
        userArray = [User]()
        entryArray = [Entry]()
        currUser = User(name: "default")
        currEntry = Entry(text: "default", title: "default", happiness: 0, sadness: 0, anger: 0, fear: 0, user: "default")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        restoreUsers()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        saveUsers()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        saveUsers()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        restoreUsers()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        restoreUsers()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveUsers()
    }
    
    func restoreUsers() {
        var nameToUser = [String: User]() // A dictionary mapping usernames to users for entry restoration
        if let savedUsers = loadUsers() {
            for user in savedUsers {
                if (!userExists(name: user.name)) {
                    nameToUser[user.name] = user
                }
            }
        }
        if let savedEntries = loadEntries() {
            // Since entries store their users by name we can use the dictionary to restore the entries to
            // their proper users
            for entry in savedEntries {
                if (nameToUser[entry.user] != nil && !(nameToUser[entry.user]?.entryExists(title: entry.title))!) {
                    nameToUser[entry.user]?.addEntry(entry: entry)
                }
            }
        }
        for (_, user) in nameToUser {
            userArray.append(user)
        }
    }
    
    func userExists(name: String) -> Bool {
        for user in userArray {
            if name == user.name {
                return true
            }
        }
        return false
    }
    
    func updateUserArray() {
        saveUsers()
    }

    // MARK: Private Methods
    private func saveUsers() {
        saveEntries()
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(userArray, toFile: User.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Users successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save users...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadUsers() -> [User]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? [User]
    }
    
    // MARK: Data Methods
    func saveEntries() {
        entryArray = [Entry]()
        for user in userArray {
            entryArray += user.entries
        }
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(entryArray, toFile: Entry.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Entries successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save entries...", log: OSLog.default, type: .error)
        }
    }
    
    func loadEntries() -> [Entry]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Entry.ArchiveURL.path) as? [Entry]
    }
    
}

