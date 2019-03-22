//
//  WatchAppManager.swift
//  TrackWorkTests
//
//  Created by Chrystian Salgado on 19/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import Foundation
import WatchConnectivity

public class WatchAppManager {
    
    public class func sendData(key: String, value: Any) {
        if WCSession.isSupported() && WCSession.default.isPaired {
            sendDataFromAppleWatch(dict: [key: value])
        }
    }
    
    fileprivate class func sendDataFromAppleWatch(dict: [String: Any]) {
        do {
            try WCSession.default.updateApplicationContext(dict)
        } catch {
            print(error.localizedDescription)
        }
    }
}
