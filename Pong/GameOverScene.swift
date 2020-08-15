//
//  GameOverScene.swift
//  Pong
//
//  Created by Matt Powley on 2/15/17.
//  Copyright © 2017 Matt Powley. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOverScene: SKScene
{
    

    
    private var gameOverLabel : SKLabelNode?
    
    private var scoreLabel = SKLabelNode()
    private var highScoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView)
    {
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.position.x = 0
        scoreLabel.position.y = -30
        
        highScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        highScoreLabel.position.x = 0
        highScoreLabel.position.y = -60
        
        scoreLabel.text = "Score: \(UserDefaults().integer(forKey: "Score"))"
        highScoreLabel.text = "High Score: \(UserDefaults().integer(forKey: "Highscore"))"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let startSceneTemp = StartScene(fileNamed: "StartScene")
        self.scene?.view?.presentScene(startSceneTemp!, transition: SKTransition.doorsOpenHorizontal(withDuration: 0))
    }
    

    
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
}
