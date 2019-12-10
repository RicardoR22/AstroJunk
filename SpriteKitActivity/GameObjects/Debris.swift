//
//  Debris.swift
//  SpriteKitActivity
//
//  Created by Ricardo Rodriguez on 10/29/19.
//  Copyright © 2019 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit

class Debris: SKSpriteNode {
	
	enum DebrisList: String, CaseIterable {
		case greyMeteorBig = "beam"
		case greyMeteor = "wingGreen"
		case brownMeteor = "wingRed"
	}
	
	init(){
		let debris = DebrisList.allCases.randomElement()
		let texture = SKTexture(imageNamed: debris!.rawValue)
        let size = CGSize(width: 40, height: 40)
		super.init(texture: texture, color: .clear, size: size)
        self.name = "debris"
		self.physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width / 2, self.size.height / 2))
		self.physicsBody?.usesPreciseCollisionDetection = true
		self.physicsBody?.affectedByGravity = false
	}
	
	func moveDown() {
		let moveDown = SKAction.moveTo(y: -50, duration: 8)
		let remove = SKAction.removeFromParent()
		let moveSequence = SKAction.sequence([moveDown, remove])
		self.run(moveSequence)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
