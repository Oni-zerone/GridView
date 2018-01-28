//
//  SOTGridGroupLayoutTests.swift
//  GridView_Tests
//
//  Created by Andrea Altea on 27/01/18.
//  Copyright © 2018 acct<blob>=<NULL>. All rights reserved.
//

import XCTest
@testable import SOTGridView

class SOTGridGroupLayoutTests: XCTestCase {
    
    var gridView: GridView = GridView(frame: .zero)
    
    override func setUp() {
        super.setUp()
        
        self.gridView = GridView(frame: CGRect(origin: .zero, size: CGSize(width: 150, height: 150)))
    }
    
    override func tearDown() {

        self.gridView = GridView(frame: .zero)
        super.tearDown()
    }
    
    func testColumnCreation() {
        
        let column = SOTGridGroup(frame: .zero)
        
        XCTAssert(column.backgroundColor == UIColor.clear, "Color should be clear")
        XCTAssert(column.clipsToBounds == false, "Bounds should not clip")
        XCTAssert(column.translatesAutoresizingMaskIntoConstraints == false, "TranslateAutoresizingMask should be disabled.")
    }
    
    func testGroupInsertion() {
        
        self.gridView.insertGroup()
        
        XCTAssert(self.gridView.groups.count == 1, "Columns should be 1 are: \(self.gridView.groups.count)")
    }
    
    func testFirstColumnEqualityConstraintCreation() {
        
        self.gridView.insertGroup()
        let equalityConstraints = self.gridView.constraints.filter(byView: self.gridView.groups.first!, withAttribute: .width)
        XCTAssert(equalityConstraints.count == 0, "EqualityConstraint for firstColumn should be nil")
    }

    func testMoreColumnEqualityConstraintCreation() {
        
        self.gridView.insertGroup()
        self.gridView.insertGroup()
        self.gridView.insertGroup()
        
        let equalityConstraints = self.gridView.constraints.filter(byView: self.gridView.groups.first!, withAttribute: .width)
        XCTAssert(equalityConstraints.count == 2, "EqualityConstraint for firstColumn should be 2")
    }
    
    func testFirstColumnEqualityConstraintCreationOnHorizontalConfiguration() {
        
        self.gridView.insertGroup()
        let equalityConstraints = self.gridView.constraints.filter(byView: self.gridView.groups.first!, withAttribute: .height)
        XCTAssert(equalityConstraints.count == 0, "EqualityConstraint for firstColumn should be nil")
    }

    func testMoreColumnEqualityConstraintCreationOnHorizontalConfiguration() {
        
        self.gridView.compositionMode = .horizontal
        
        self.gridView.insertGroup()
        self.gridView.insertGroup()
        self.gridView.insertGroup()
        
        let equalityConstraints = self.gridView.constraints.filter(byView: self.gridView.groups.first!, withAttribute: .height)
        XCTAssert(equalityConstraints.count == 2, "EqualityConstraint for firstColumn should be 2")
    }

    func testEqualityConstraintValidity() {

        self.gridView.insertGroup()
        self.gridView.insertGroup()
        
        guard let constraint = self.gridView.constraints.filter(byView: self.gridView.groups.first!, withAttribute: .width).first else {
            XCTFail("Unable to find equalityConstraint")
            return
        }

        XCTAssert((constraint.firstItem as? UIView) == self.gridView.groups.first, "firstItem should be first column")
        XCTAssert((constraint.secondItem as? UIView) == self.gridView.groups.last, "secondItem should be second column")
    }
    
}
