//
//  AppDelegate.swift
//  Noti
//
//  Created by Jari on 22/06/16.
//  Copyright © 2016 Jari Zwarts. All rights reserved.
//

import Cocoa
import Starscream

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var pushManager: PushManager?
    let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var iwc:NSWindowController?;
    var pwc:NSWindowController?;
    
    func loadPushManager() {
        let token = userDefaults.stringForKey("token")
        
        if(token != nil) {
            pushManager = PushManager(token: token!)
        } else {
            print("WARN: PushManager not initialized because of missing token. Displaying Intro")
            
            if(pushManager != nil) {
                pushManager!.disconnect()
            }
            
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            iwc = storyboard.instantiateControllerWithIdentifier("IntroWindowController") as? NSWindowController
            NSApplication.sharedApplication().activateIgnoringOtherApps(true)
            iwc!.showWindow(self)
            iwc!.window?.makeKeyAndOrderFront(self)
        }
    }
    
    func displayPreferencesWindow() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        pwc = storyboard.instantiateControllerWithIdentifier("PreferencesWindowController") as? NSWindowController
        NSApplication.sharedApplication().activateIgnoringOtherApps(true)
        pwc!.showWindow(self)
        pwc!.window?.makeKeyAndOrderFront(self)
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        loadPushManager()
//        displayPreferencesWindow()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

