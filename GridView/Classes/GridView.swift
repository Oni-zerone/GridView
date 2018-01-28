//
//  GridView.swift
//  SOTGridView
//
//  Created by Andrea Altea on 27/01/18.
//

import UIKit

@objc public class GridView: UIView {

    @objc public enum Composition: Int {
        case vertical
        case horizontal
    }

    public weak var delegate: GridViewDelegate? {
        didSet {
            self.reloadContent()
        }
    }
    
    public weak var dataSource: GridViewDataSource? {
        didSet {
            self.reloadContent()
        }
    }
    
    public var numberOfColumns: Int = 1 {
        
        didSet {
            guard self.numberOfColumns != oldValue,
                self.numberOfColumns > 0 else {
                return
            }
            
            self.reloadContent()
        }
    }
    
    public var compositionMode: Composition = .vertical {
        
        didSet {
            guard self.compositionMode != oldValue else {
                return
            }
            
            self.reloadContent()
        }
    }
    
    public var itemMargins: UIEdgeInsets = .zero {
        
        didSet {
            guard self.itemMargins != oldValue else {
                return
            }
            
            self.reloadContent()
        }
    }
    
    internal var groups: [SOTGridGroup] = []
}
