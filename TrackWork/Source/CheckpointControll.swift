//
//  CheckpointControll.swift
//  TrackWork
//
//  Created by Chrystian Salgado on 26/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import Foundation

public class CheckpointControll {
    
    public class func getFutureDate(from date: Date) -> Date {
        let addHour = 9 // Horas no futuro.
        let timeintervalForHour = TimeInterval(addHour.hours)
        return date.addingTimeInterval(TimeInterval(timeintervalForHour))
    }
}
