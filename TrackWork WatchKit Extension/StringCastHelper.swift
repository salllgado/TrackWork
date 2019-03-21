//
//  StringCastHelper.swift
//  TrackWork WatchKit Extension
//
//  Created by Chrystian Salgado on 20/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import Foundation

public class StringCastHelper {
    
    public class func stringCast(_ value: Any) -> String {
        if let stringValue = value as? String {
            return stringValue
        }
        else {
            return ""
        }
    }
}
