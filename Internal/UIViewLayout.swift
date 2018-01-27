//
//  SOTGridViewLayout.swift
//  Pods-GridView_Example
//
//  Created by Andrea Altea on 27/01/18.
//

import UIKit

internal typealias UIViewLayout = UIView

internal extension UIViewLayout {
    
    internal func attachOnSuperview(mode: SOTGridCompositionMode, contentMargins margins: UIEdgeInsets) {
        
        switch mode {
        
        case SOTGridCompositionModeVertical:
            self.attachVertical(contentMargins: margins)
        
        case SOTGridCompositionModeHorizontal:
            self.attachHorizontal(contentMargins: margins)
        
        default:
            break
        }
    }

    internal func attachOrthogonalOnSuperview(mode: SOTGridCompositionMode, contentMargins margins: UIEdgeInsets) {
        
        switch mode {
            
        case SOTGridCompositionModeHorizontal:
            self.attachVertical(contentMargins: margins)
            
        case SOTGridCompositionModeVertical:
            self.attachHorizontal(contentMargins: margins)
            
        default:
            break
        }
    }
    
    internal func attachVertical(contentMargins margins: UIEdgeInsets) {

        guard let superview = self.superview else {
            return
        }
        
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: margins.top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.topAnchor, constant: margins.bottom).isActive = true
    }
    
    internal func attachHorizontal(contentMargins margins: UIEdgeInsets) {

        guard let superview = self.superview else {
            return
        }
        
        self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: margins.left).isActive = true
        self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: margins.right).isActive = true
    }
}
