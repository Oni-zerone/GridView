//
//  SOTGridGroupsLayout.swift
//  SOTGridView
//
//  Created by Andrea Altea on 27/01/18.
//

import Foundation

internal typealias SOTGridGroupsLayout = GridView

internal extension SOTGridGroupsLayout {
    
    internal func insertGroup() {
        
        let group = SOTGridGroup(frame: .zero)
        self.groups.append(group)
        guard let index = self.groups.index(of: group) else {
            return
        }
        self.addSubview(group)

        group.attachOnSuperview(mode: self.compositionMode, contentMargins: .zero)
        self.addEqualityConstraint(forGroup: group, atIndex: index)
        
    }
    
    private func addEqualityConstraint(forGroup group: SOTGridGroup, atIndex index: Int) {
       
        guard let firstGroup = self.groups.first else {
            return
        }
        
        guard index > 0 else {
            return
        }
        
        switch self.compositionMode {
        
        case .vertical:
            firstGroup.widthAnchor.constraint(equalTo: group.widthAnchor).isActive = true
            
        case .horizontal:
            firstGroup.heightAnchor.constraint(equalTo: group.heightAnchor).isActive = true
        }
    }
    
    private func attachGroup(_ group: SOTGridGroup, toGroup: SOTGridGroup) {
    
        
        
    }
    
}
