//
//  InterfaceController.swift
//  TrackWork WatchKit Extension
//
//  Created by Chrystian Salgado on 19/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import Foundation
import ClockKit
import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var lbTitle: WKInterfaceLabel!
    @IBOutlet weak var lbTime: WKInterfaceLabel!
//    @IBOutlet weak var lbLastedTime: WKInterfaceLabel!
    
    var nextDate: Date?
    var nextDateString: String = ""
    var nextDateTimeInteral: TimeInterval = 0.0
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
        if let _nextDate = UserDefaults.standard.object(forKey: Constants.Defaults.Watch.nextDate.rawValue) as? Date {
            nextDate = _nextDate
            nextDateString = DateFormatterHelper.formatDate(_nextDate)
        }
        
        watchSession = WCSession.default
        lbTitle.setText("Horario")
        lbTime.setAlpha(0.0)
//        lbLastedTime.setAlpha(0.0)
    }
    
    private func displayTime() {
        lbTime.setText("É a data que você deve bater o ponto novamente.")
        lbTime.setAlpha(1.0)
        lbTitle.setText(nextDateString)
    }
    
    fileprivate func storeData(from elements: [String: Any]) {
        for pair in elements {
            if pair.key == Constants.Date.exit.rawValue {
                guard let date = pair.value as? Date else { return }
                nextDateString = DateFormatterHelper.formatDate(date)
                UserDefaults.standard.set(date, forKey: Constants.Defaults.Watch.nextDate.rawValue)
            }
            if pair.key == "startDateString" {
//                lbLastedTime.setText("Foi a data do ultimo ponto.")
//                lbLastedTime.setAlpha(1.0)
//                lbLastedTitle.setText(stringCast(pair.value))
            }
        }
    }
}

extension InterfaceController {
    private func updateCompilation() {
        let complicationServer = CLKComplicationServer.sharedInstance()
        
        if nextDate != nil {
            if let activeCompilation = complicationServer.activeComplications {
                for complication in activeCompilation {
                    print("UPDATE COMPLICATION")
                    complicationServer.reloadTimeline(for: complication)
                }
            }
        }
    }
}


extension InterfaceController: WCSessionDelegate  {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated {
            print("Conectivity recheaded")
        } else { print(error?.localizedDescription ?? "error" ) }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        storeData(from: applicationContext)
        displayTime()
        updateCompilation()
    }
}
