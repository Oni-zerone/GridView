//
//  GridViewDelegate.swift
//  SOTGridView
//
//  Created by Andrea Altea on 27/01/18.
//

import UIKit

public protocol GridViewDelegate: class {
    
    func gridView(_ gridView: GridView, didSelectItemAtIndex index: NSInteger)
}
