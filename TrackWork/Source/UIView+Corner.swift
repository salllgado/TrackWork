//
//  UIView+Corner.swift
//  TrackWork
//
//  Created by Chrystian Salgado on 22/03/19.
//  Copyright © 2019 Chrystian Salgado. All rights reserved.
//

import Foundation
import UIKit

enum RoundType {
    case top
    case none
    case left
    case right
    case bottom
    case both
}

extension UIView {
    
    func round(with type: RoundType, radius: CGFloat = 3.0) {
        var corners: UIRectCorner
        
        switch type {
        case .top:
            corners = [.topLeft, .topRight]
        case .none:
            corners = []
        case .left:
            corners = [.topLeft, .bottomLeft]
        case .right:
            corners = [.topRight, .bottomRight]
        case .bottom:
            corners = [.bottomLeft, .bottomRight]
        case .both:
            corners = [.allCorners]
        }
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
