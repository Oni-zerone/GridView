//
//  SOTGridItemLayoutTests.swift
//  GridView_Tests
//
//  Created by Andrea Altea on 27/01/18.
//  Copyright © 2018 acct<blob>=<NULL>. All rights reserved.
//

import XCTest
@testable import SOTGridView

class SOTGridItemLayoutTests: XCTestCase {
 
    var superview: UIView = UIView()
    var gridItem: SOTGridItem = SOTGridItem()
    
    override func setUp() {
        super.setUp()
        
        self.superview = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        self.gridItem = SOTGridItem(frame: .zero)
        self.gridItem.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.superview = UIView()
        self.gridItem = SOTGridItem()
    }

    func testVerticalAttachWithMode() {
        
        self.superview.addSubview(self.gridItem)
        self.gridItem.attachOrthogonal(mode: SOTGridCompositionModeVertical, contentMargins: UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20))
        
        self.checkVerticalConstraints()
    }
    
    func testHorizontalAttachWithMode() {
        
        self.superview.addSubview(self.gridItem)
        self.gridItem.attachOrthogonal(mode: SOTGridCompositionModeHorizontal, contentMargins: UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20))
        
        self.checkHorizontalConstraints()
    }
    
    func testAttachVertical() {
        
        self.superview.addSubview(self.gridItem)
        self.gridItem.attachVertical(contentMargins: UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20))

        self.checkVerticalConstraints()
    }
    
    func testUnattacchedVertical() {
        
        self.gridItem.attachVertical(contentMargins: UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20))
        XCTAssert(self.superview.constraints.count == 0, "Shouln't have constraints")
    }
    
    func testAttachHorizontal() {
        
        self.superview.addSubview(self.gridItem)
        self.gridItem.attachHorizontal(contentMargins: UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20))
        
        self.checkHorizontalConstraints()
    }

    func testUnattacchedHorizontal() {
        
        self.gridItem.attachHorizontal(contentMargins: UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20))
        XCTAssert(self.superview.constraints.count == 0, "Shouln't have constraints")
    }

    func checkVerticalConstraints() {

        let constraints = self.superview.constraints.filter(byView: self.gridItem)
        XCTAssert(constraints.count == 2, "Constraints should be 2, are \(self.gridItem.constraints.count)")
        
        let topConstraints = constraints.filter(byView: self.gridItem, withAttribute: .top)
        guard topConstraints.count == 1,
            topConstraints.first?.constant == 5 else {
            return XCTFail("Top Constraint not set correctly.")
        }
        
        let bottomConstraints = constraints.filter(byView: self.gridItem, withAttribute: .bottom)
        guard bottomConstraints.count == 1,
            bottomConstraints.first?.constant == 15 else {
            return XCTFail("Bottom Constraint not set correctly.")
        }
    }
    
    func checkHorizontalConstraints() {
        
        let constraints = self.superview.constraints.filter(byView: self.gridItem)
        XCTAssert(constraints.count == 2, "Constraints should be 2, are \(self.gridItem.constraints.count)")
        
        let leftConstraints = constraints.filter(byView: self.gridItem, withAttribute: .left)
        guard leftConstraints.count == 1,
            leftConstraints.first?.constant == 10 else {
            return XCTFail("Top Constraint not set.")
        }
        
        let rightConstraints = constraints.filter(byView: self.gridItem, withAttribute: .right)
        guard rightConstraints.count == 1,
            rightConstraints.first?.constant == 20 else {
            return XCTFail("Bottom Constraint not set.")
        }
    }
}

extension Array where Element == NSLayoutConstraint {
    
    func filter(byView view: UIView, withAttribute attribute: NSLayoutAttribute? = nil) -> [NSLayoutConstraint] {
        
        return self.filter { (constraint) -> Bool in
            return constraint.check(withView: view, attribute: attribute)
        }
    }
}

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
