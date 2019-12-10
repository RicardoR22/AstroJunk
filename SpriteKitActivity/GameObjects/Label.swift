//
//  Label.swift
//  SpriteKitActivity
//
//  Created by Ricardo Rodriguez on 11/4/19.
//  Copyright © 2019 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit


class Label: SKLabelNode {
    var Score = 0
    
    override init(fontNamed: String?) {
        super.init()
    }
    
    convenience init(fontNamed: String?, fontSize: CGFloat, name: String, text: String ) {
        self.init(fontNamed: fontNamed)
        self.fontSize = fontSize
        self.name = name
        self.text = text
        
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
