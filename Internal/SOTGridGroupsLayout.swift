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
        self.addSubview(group)

        self.addEqualityConstraint(forGroup: group)
    }
    
    private func addEqualityConstraint(forGroup group: SOTGridGroup) {
       
        guard let firstGroup = self.groups.first else {
            return
        }
        
        guard let groupIndex = self.groups.index(of: group),
             groupIndex > 0 else {
                return
        }
        
        switch self.compositionMode {
        
        case .vertical:
            firstGroup.widthAnchor.constraint(equalTo: group.widthAnchor).isActive = true
            
        case .horizontal:
            firstGroup.heightAnchor.constraint(equalTo: group.heightAnchor).isActive = true
        }
        
    }
}

