//
//  GreyMeteor.swift
//  SpriteKitActivity
//
//  Created by Ricardo Rodriguez on 10/28/19.
//  Copyright © 2019 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit

class Meteor: SKSpriteNode {
	
	enum Meteors: String, CaseIterable {
		case greyMeteorBig = "meteorGrey_big"
		case greyMeteor = "meteorGrey_med"
		case brownMeteor = "meteorBrown_big"
	}
	
	init(){
		let meteor = Meteors.allCases.randomElement()
		let texture = SKTexture(imageNamed: meteor!.rawValue)
        let size = CGSize(width: 60, height: 60)
		super.init(texture: texture, color: .clear, size: size)
        self.name = "meteor"
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
