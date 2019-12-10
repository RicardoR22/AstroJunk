//
//  GameScene.swift
//  SpriteKitActivity
//
//  Created by Ricardo Rodriguez on 10/23/19.
//  Copyright © 2019 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let myShip = SKSpriteNode(imageNamed: "playerShip")
	let scoreLabel = Label(fontNamed: "Chalkduster", fontSize: 20, name: "scoreLabel", text: "Score: 0")
	var lives = 3
	var heart1 = SKSpriteNode(imageNamed: "heart")
	var heart2 = SKSpriteNode(imageNamed: "heart")
	var heart3 = SKSpriteNode(imageNamed: "heart")
	
	
    override func didMove(to view: SKView) {
		
		let backgroundSprite = SKSpriteNode(imageNamed: "backgroundImage")
		backgroundSprite.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
		backgroundSprite.size = CGSize(width: view.frame.width, height: view.frame.height)
		backgroundSprite.zPosition = -1
		self.addChild(backgroundSprite)
		
		myShip.name = "ship"
		myShip.size = CGSize(width: 75, height: 50)
		myShip.position =  CGPoint(x: frame.midX, y: 100)
		myShip.physicsBody = SKPhysicsBody(circleOfRadius: max((myShip.size.width) / 2.75, (myShip.size.height) / 3))
		myShip.physicsBody?.usesPreciseCollisionDetection = true
		myShip.physicsBody?.isDynamic = false
		myShip.physicsBody?.contactTestBitMask = myShip.physicsBody!.collisionBitMask
		
		
		
		scoreLabel.position = CGPoint(x: view.bounds.width - 50, y: view.bounds.height - 60)
		heart1.position = CGPoint(x: 25, y: scoreLabel.frame.midY)
		heart2.position = CGPoint(x: 50, y: scoreLabel.frame.midY)
		heart3.position = CGPoint(x: 75, y: scoreLabel.frame.midY)
		


		self.addChild(myShip)
		self.addChild(scoreLabel)
		self.addChild(heart1)
		self.addChild(heart2)
		self.addChild(heart3)
		
		let create = SKAction.run {
		   self.createObjects()
		}
			   
			   
		let wait = SKAction.wait(forDuration: 1)
		let sequence = SKAction.group([create, wait])
		let repeatForever = SKAction.repeatForever(sequence)
		self.run(repeatForever)
		physicsWorld.contactDelegate = self
		
		

    }
	
	func createObjects() {
		
		if Bool.random() {
			let meteor = Meteor()
			meteor.position = CGPoint(x: CGFloat.random(in: 0..<size.width), y: (view?.bounds.height)!)
			meteor.moveDown()
			self.addChild(meteor)
		} else {
			let debris = Debris()
			debris.position = CGPoint(x: CGFloat.random(in: 0..<size.width), y: (view?.bounds.height)!)
			debris.moveDown()
			self.addChild(debris)
		}
		
	}
	
	func didCollide(ship: SKNode, object: SKNode) {
		if object.name == "meteor" {
			destroy(object: object)
			takeDamage()
		} else if object.name == "debris" {
			destroy(object: object)
			collectDebris()
		}
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node else { return }
		guard let nodeB = contact.bodyB.node else { return }
		
		if contact.bodyA.node?.name == "ship" {
			didCollide(ship: nodeA, object: nodeB)
		} else if contact.bodyB.node?.name == "ship" {
			didCollide(ship: nodeB, object: nodeA)
		}
	}
	
	func destroy(object: SKNode) {
		object.removeFromParent()
	}
    
    
    func touchDown(atPoint pos : CGPoint) {
		let ship = self.myShip
		let moveAction = SKAction.moveTo(x: pos.x, duration: 0.75)
		ship.run(moveAction)
		
    }
	
	func collectDebris() {
		let collectEffect = SKEmitterNode(fileNamed: "CollectedDebris")
		collectEffect?.particlePosition = CGPoint(x: myShip.anchorPoint.x, y: myShip.anchorPoint.y)
		collectEffect?.targetNode = self
		myShip.addChild(collectEffect!)
		scoreLabel.Score += 1
		scoreLabel.text = "Score: " + String(scoreLabel.Score)
	}
	
	func takeDamage() {
		let hearts = [heart1, heart2, heart3]
		let colorize = SKAction.colorize(with: .gray, colorBlendFactor: 1.0, duration: 0.5)
		if lives > 0 {
			hearts[lives - 1].run(colorize)
			lives -= 1
		} else {
			let gameOverScene = GameOverScene(size: size)
			gameOverScene.scaleMode = scaleMode

			let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
			view?.presentScene(gameOverScene, transition: reveal)
		}
		
		print(lives)
	}
//
//    func touchMoved(toPoint pos : CGPoint) {
//		if let ship = self.myShip {
//			let moveAction = SKAction.move(to: pos, duration: 0.5)
//			ship.run(moveAction)
//		}
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
		
    }
}
