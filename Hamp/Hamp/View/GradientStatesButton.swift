//
//  GradientStatesButton.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 10/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

public class GradientStatesButtonActionContent {
    public typealias StatesActionBlock = ()->()
    public var identifier: String!
    public var action: StatesActionBlock!
    public var title: String?
    
    init(identifier: String,
         action: @escaping StatesActionBlock,
         title: String?) {
        self.identifier = identifier
        self.action = action
        self.title = title
    }
}

class GradientStatesButton: GradientButton {
    
    private var contents = [String: GradientStatesButtonActionContent]()
    private var currentContent: GradientStatesButtonActionContent?
    
    func addActionContent(content: GradientStatesButtonActionContent, identifier: String) {
        contents[identifier] = content
    }
    
    func changeContent(to identifier: String) {
        guard let c = contents[identifier] else {
            assert(false, "No content for this identifier")
        }
        
        currentContent = c
        self.setTitle(c.title, for: .normal)
    }
}
