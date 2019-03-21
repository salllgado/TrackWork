//
//  ComplicationController.swift
//  TrackWork WatchKit Extension
//
//  Created by Chrystian Salgado on 19/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import ClockKit
import WatchKit
import WatchConnectivity

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    var nextDateString: String?
    var nextDateTimeInteral: TimeInterval?
    var template: CLKComplicationTemplate?
    var notificationWasRegistred: Bool = false
    
    private func registerNotification() {
        if !notificationWasRegistred {
            NotificationCenter.default.addObserver(self, selector: #selector(updateCompilation(_:)), name: NSNotification.Name("someNotification"), object: nil)
        }
    }
    
    @objc func updateCompilation(_ notification: NSNotification) {
        guard let exitDate = notification.userInfo?["exitDateString"] as? Date else { return }
        let complicationServer = CLKComplicationServer.sharedInstance()
        
        nextDateString = DateFormatterHelper.formatDate(exitDate)
        nextDateTimeInteral = exitDate.timeIntervalSinceReferenceDate
        
        if let activeCompilation = complicationServer.activeComplications {
            for complication in activeCompilation {
                print("UPDATE COMPLICATION")
                complicationServer.reloadTimeline(for: complication)
            }
        }
    }
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        setup(for: complication)
        guard let _template = template else { return }
        handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: _template))
    }
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        registerNotification()
        setup(for: complication)
        handler(template)
    }
    
    private func getRingRange() -> Float {
        if let _nextDateTimeInteral = nextDateTimeInteral {
            let nowTimeInterval = Date().timeIntervalSinceReferenceDate
            let diference = _nextDateTimeInteral - nowTimeInterval
            return 1.1
        } else {
            return 0.0
        }
    }
    
    private func setup(for complication: CLKComplication) {
        switch complication.family {
        case .modularSmall:
            let modularSmallTemplate =
                CLKComplicationTemplateModularSmallRingText()
            modularSmallTemplate.textProvider =
                CLKSimpleTextProvider(text: "->")
            modularSmallTemplate.fillFraction = getRingRange()
            modularSmallTemplate.ringStyle = CLKComplicationRingStyle.closed
            template = modularSmallTemplate
        case .modularLarge:
            template = CreateCompilationTemplate.modularLarge(
                title: "TrackWork",
                body1: "Bater o ponto as:",
                body2: nextDateString ?? "Abra o app para atualizar"
            )
        default:
            template = nil
        }
    }
}
