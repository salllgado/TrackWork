//
//  CreateCompilationTemplate.swift
//  TrackWork WatchKit Extension
//
//  Created by Chrystian Salgado on 20/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import Foundation
import ClockKit

public class CreateCompilationTemplate {
    
    public class func modularLarge(title: String, body1: String, body2: String) -> CLKComplicationTemplate {
        let modularLargeTemplate = CLKComplicationTemplateModularLargeStandardBody()
        modularLargeTemplate.headerTextProvider =
            CLKSimpleTextProvider(text: title)
        modularLargeTemplate.body1TextProvider =
            CLKSimpleTextProvider(text: body1,
                                  shortText: body1)
        modularLargeTemplate.body2TextProvider =
            CLKSimpleTextProvider(text: body2,
                                  shortText: body2)
        return modularLargeTemplate
    }
}
