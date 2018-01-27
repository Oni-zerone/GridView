//
//  NSLayoutConstraint.swift
//  GridView_Tests
//
//  Created by Andrea Altea on 27/01/18.
//  Copyright © 2018 acct<blob>=<NULL>. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func check(withView view: UIView, attribute: NSLayoutAttribute? = nil) -> Bool {
        
        if let firstView = self.firstItem as? UIView,
            firstView == view {
            
            guard let attribute = attribute else {
                return true
            }
            
            return attribute == self.firstAttribute
        }
        
        if let secondView = self.secondItem as? UIView,
            secondView == view {
            
            guard let attribute = attribute else {
                return true
            }
            
            return attribute == self.secondAttribute
        }
        
        return false
    }
    
}

extension Array where Element == NSLayoutConstraint {
    
    func filter(byView view: UIView, withAttribute attribute: NSLayoutAttribute? = nil) -> [NSLayoutConstraint] {
        
        return self.filter { (constraint) -> Bool in
            return constraint.check(withView: view, attribute: attribute)
        }
    }
}
