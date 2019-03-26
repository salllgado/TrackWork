//
//  Checkpoint.swift
//  TrackWork
//
//  Created by Chrystian Salgado on 26/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import Foundation

struct Checkpoint {
    private (set) var actualTime: Date?
    private (set) var futureTime: Date?
    private (set) var futureTimeFormatted: String = ""
    
    mutating func checkIn(date: Date) {
        actualTime = date
        futureTime = CheckpointControll.getFutureDate(from: Date())
        futureTimeFormatted = DateFormatterHelper.formatDate(futureTime!)
    }
}
