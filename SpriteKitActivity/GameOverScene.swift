//
//  GameOverScene.swift
//  SpriteKitActivity
//
//  Created by Ricardo Rodriguez on 11/6/19.
//  Copyright © 2019 Ricardo Rodriguez. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    let gameOver = Label(fontNamed: "Chalkduster", fontSize: 30, name: "GameOverLabel", text: "GAME OVER")
    let replay = Label(fontNamed: "Chalkduster", fontSize: 20, name: "tapToReplayLabel", text: "Tap anywhere to Replay")

    
    
    override func didMove(to view: SKView) {
        
        if let view = self.view {
            gameOver.position = CGPoint(x: view.bounds.width/2, y: (view.bounds.height/2) + 20)
			replay.position = CGPoint(x: view.bounds.width/2, y: gameOver.position.y - 25)
            replay.zPosition = 2
            
        }
        addChild(gameOver)
        addChild(replay)
    }
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		let gameScene = GameScene(size: size)
		gameScene.scaleMode = scaleMode

		let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
		view?.presentScene(gameScene, transition: reveal)

    }
    

}
