//
//  InterfaceController.swift
//  TrackWork WatchKit Extension
//
//  Created by Chrystian Salgado on 19/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var lbTitle: WKInterfaceLabel!
    @IBOutlet weak var lbTime: WKInterfaceLabel!
    
    var watchSession: WCSession? {
        didSet {
            if let session = watchSession {
                session.delegate = self
                session.activate()
            }
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        watchSession = WCSession.default
        lbTime.setAlpha(0.0)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    private func displayTime(from elements: [String: Any]) {
        for pair in elements {
            if pair.key == "timeString" {
                lbTime.setText(stringCast(pair.value))
                lbTime.setAlpha(1.0)
            }
        }
    }
}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated {
            print("Conectivity recheaded")
        } else { print(error?.localizedDescription ?? "error" ) }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        displayTime(from: applicationContext)
    }
    
    private func stringCast(_ value: Any) -> String {
        if let stringValue = value as? String {
            return stringValue
        } else {
            return ""
        }
    }
}
