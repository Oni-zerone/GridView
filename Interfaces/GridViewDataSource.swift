//
//  GridViewDataSource.swift
//  SOTGridView
//
//  Created by Andrea Altea on 27/01/18.
//

import UIKit

public protocol GridViewDataSource: class {
 
    func numberOfItems(inGridView gridView: GridView) -> NSInteger
    
    func gridView(_ gridView: GridView, itemAtIndex: NSInteger) -> SOTGridItem
}
