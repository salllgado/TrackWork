//
//  DateFormatterHelper.swift
//  TrackWork
//
//  Created by Chrystian Salgado on 19/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import Foundation

public class DateFormatterHelper {
    
    public class func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM h:mm a"
        return formatter.string(from: date)
    }
}
