//
//  SOTGridGroup.swift
//  SOTGridView
//
//  Created by Andrea Altea on 27/01/18.
//

import UIKit

internal class SOTGridGroup: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    private func setupUI() {

        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
    }
    
}
