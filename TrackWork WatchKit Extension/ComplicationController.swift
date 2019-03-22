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
    
    var nextDate: Date?
    var nextDateString: String?
    var nextDateTimeInteral: TimeInterval?
    var template: CLKComplicationTemplate?
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        setup(for: complication)
        guard let _template = template else { return }
        handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: _template))
    }
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        setup(for: complication)
        handler(template)
    }
    
    private func getRingRange() -> Float {
        if let _nextDateTimeInteral = nextDateTimeInteral {
            let nowTimeInterval = Date().timeIntervalSinceReferenceDate
            let diference = _nextDateTimeInteral - nowTimeInterval
            return Float(((nowTimeInterval - _nextDateTimeInteral) * 100) / diference)
        } else {
            return 0.0
        }
    }
    
    private func setup(for complication: CLKComplication) {
        if let _nextDate = UserDefaults.standard.object(forKey: "nextDate") as? Date {
            nextDate = _nextDate
            nextDateString = DateFormatterHelper.formatDate(_nextDate)
            nextDateTimeInteral = _nextDate.timeIntervalSinceReferenceDate
        }
        
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
                body1: nextDateString != nil ? "Bater o ponto as:" : "",
                body2: nextDateString ?? "Abra o app para atualizar"
            )
        default:
            template = nil
        }
    }
}
