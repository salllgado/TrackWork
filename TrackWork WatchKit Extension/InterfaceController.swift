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
//    @IBOutlet weak var lbLastedTime: WKInterfaceLabel!
    
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
        lbTitle.setText("Horario")
        lbTime.setAlpha(0.0)
//        lbLastedTime.setAlpha(0.0)
    }
    
    private func displayTime(from elements: [String: Any]) {
        sendNotification(elements: elements)
        
        for pair in elements {
            if pair.key == "exitDateString" {
                guard let date = pair.value as? Date else { return }
                let dateFormatted = DateFormatterHelper.formatDate(date)
                lbTime.setText("É a data que você deve bater o ponto novamente.")
                lbTime.setAlpha(1.0)
                lbTitle.setText(dateFormatted)
            }
            if pair.key == "startDateString" {
//                lbLastedTime.setText("Foi a data do ultimo ponto.")
//                lbLastedTime.setAlpha(1.0)
//                lbLastedTitle.setText(stringCast(pair.value))
            }
        }
    }
    
    private func sendNotification(elements: [String: Any]) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "someNotification"), object: nil, userInfo: elements)
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
}
