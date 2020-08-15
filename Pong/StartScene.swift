//
//  StartScene.swift
//  Pong
//
//  Created by Matt Powley on 2/15/17.
//  Copyright © 2017 Matt Powley. All rights reserved.
//

import GameplayKit
import UIKit
import SpriteKit



class StartScene : SKScene
{
    var topPaddle = SKSpriteNode()
    var bottomPaddle = SKSpriteNode()
    var startLabel = SKLabelNode()
    var pongBall = SKSpriteNode()
    
    var counter = Int()
    var titleLabel = SKLabelNode()
    
    
    override func didMove(to view: SKView)
    {
        super.didMove(to: view)
        
        
        //Load and initialize all elements to the screen
        topPaddle = self.childNode(withName: "topPaddle") as! SKSpriteNode
        topPaddle.position.x = 0
        topPaddle.position.y = (self.frame.height / 2) - 150
        
        bottomPaddle = self.childNode(withName: "bottomPaddle") as! SKSpriteNode
        bottomPaddle.position.x = 0
        bottomPaddle.position.y = (-self.frame.height / 2) + 150
        
        pongBall = self.childNode(withName: "pongBall") as! SKSpriteNode
        
        startLabel = self.childNode(withName: "startLabel") as! SKLabelNode
        startLabel.position.x = 0
        startLabel.position.y = 0
        
        titleLabel = self.childNode(withName: "titleLabel") as! SKLabelNode
        titleLabel.position.x = 0
        titleLabel.position.y = (self.frame.height / 2) - 100
        
        counter = 1
        
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        self.pongBall.physicsBody?.applyImpulse(CGVector(dx: 6, dy: -10))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        goToGameScreen()
    }
    
    func goToGameScreen()
    {
        let gameSceneTemp = GameScene(fileNamed: "GameScene")
        
        
        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.doorsOpenHorizontal(withDuration: 0))
    }
    
    func handleScoring()
    {
        counter += 1
        pongBall.position = CGPoint(x: 0, y: 0)
        pongBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if(counter % 2 == 1)
        {
            self.pongBall.physicsBody?.applyImpulse(CGVector(dx: -6, dy: -10))
        }
        else
        {
            self.pongBall.physicsBody?.applyImpulse(CGVector(dx: 6, dy: -10))
        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        
        var zero = CGFloat()
        zero = 0
        
        if((pongBall.physicsBody?.velocity.dy)! > zero)
        {
            topPaddle.run(SKAction .moveTo(x: pongBall.position.x, duration: 0.16))
        }
        
        if((pongBall.physicsBody?.velocity.dy)! < zero)
        {
            bottomPaddle.run(SKAction .moveTo(x: pongBall.position.x, duration: 0.26))
        }

        
        
        //Check if someone scored
        if pongBall.position.y <= bottomPaddle.position.y - 30
        {
            handleScoring()
        }
        else if pongBall.position.y >= topPaddle.position.y + 30
        {
            handleScoring()
        }
        
    }
}
