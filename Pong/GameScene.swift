//
//  GameScene.swift
//  Pong
//
//  Created by Matt Powley on 12/7/16.
//  Copyright © 2016 Matt Powley. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    var pongBall = SKSpriteNode()
    var enemyPaddle = SKSpriteNode()
    var userPaddle = SKSpriteNode()
    var endlessScore = SKLabelNode()
    var onePlayerScore = Int()
    var isGameOver = false
    var counter = 3
    var countdownTimer = SKLabelNode()
    var highScore = UserDefaults().integer(forKey: "Highscore")
    var endScore = UserDefaults().integer(forKey: "Score")
    var highScoreLabel = SKLabelNode()
    
    var difficultyFactor = Double()
    
    
    override func didMove(to view: SKView)
    {
        
        endlessScore = self.childNode(withName: "endlessScore") as! SKLabelNode
        endlessScore.position.x = 0
        endlessScore.position.y = (self.frame.height / 2) - 45
        
        highScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        highScoreLabel.position.x = 0
        highScoreLabel.position.y = (self.frame.height / 2) - 100
        
     
            
        pongBall = self.childNode(withName: "pongBall") as! SKSpriteNode
        enemyPaddle = self.childNode(withName: "enemyPaddle") as! SKSpriteNode
        enemyPaddle.position.y = (self.frame.height / 2) - 150
        
        
        userPaddle = self.childNode(withName: "userPaddle") as! SKSpriteNode
        userPaddle.position.y = (-self.frame.height / 2) + 150
        
        countdownTimer = self.childNode(withName: "countdownTimer") as! SKLabelNode
       
        difficultyFactor = 0.28
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    

        
        
        
        
        
   
        
        startGame()
        
    }
    
    func startGame()
    {
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        
        onePlayerScore = 0
        endlessScore.text = "Score: \(onePlayerScore)"
        
      
        highScoreLabel.text = "High Score: \(UserDefaults().integer(forKey: "Highscore"))"
        
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when)
        {
            self.pongBall.physicsBody?.applyImpulse(CGVector(dx: self.randomFloat(from: 5, to: 10), dy: -10))
        }
       
    }
    
    @objc func updateCounter()
    {
        if counter >= 0
        {
            print("\(counter)")
            countdownTimer.text = "\(counter)"
            counter -= 1
           
        }
    }
    
    func randomFloat(from: CGFloat, to: CGFloat) -> CGFloat
    {
        let rand: CGFloat = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        return (rand) * (to - from) + from
    }

    
    func addScore(winningPlayer : SKSpriteNode)
    {
        pongBall.position = CGPoint(x: 0, y: 0)
        pongBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if winningPlayer == userPaddle
        {

            
            onePlayerScore += 1
            if(difficultyFactor != 0.14 && onePlayerScore % 4 == 0)
            {
                difficultyFactor -= 0.02
            }
            
            if(onePlayerScore % 2 == 1)
            {
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    self.pongBall.physicsBody?.applyImpulse(CGVector(dx: self.randomFloat(from: -10, to: -5), dy: -10))
                }
            }
            else
            {
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    self.pongBall.physicsBody?.applyImpulse(CGVector(dx: self.randomFloat(from: 5, to: 10), dy: -10))
                }
            }
            if(onePlayerScore >= UserDefaults().integer(forKey: "Highscore"))
            {
                saveHighScore()
                
            }
            

        
            
            
        }
        else if winningPlayer == enemyPaddle
        {
            UserDefaults.standard.set(onePlayerScore, forKey: "Score")
            
            
            onePlayerScore = 0
            
            let gameOverSceneTemp = GameOverScene(fileNamed: "GameOverScene")
            self.scene?.view?.presentScene(gameOverSceneTemp!, transition: SKTransition.doorsOpenHorizontal(withDuration: 0))
        }
        
        endlessScore.text = "Score: \(onePlayerScore)"
        highScoreLabel.text = "High Score: \(UserDefaults().integer(forKey: "Highscore"))"
    }
    
    func saveHighScore()
    {
        UserDefaults.standard.set(onePlayerScore, forKey: "Highscore")
        highScoreLabel.text = "High Score: \(UserDefaults().integer(forKey: "Highscore"))"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            userPaddle.run(SKAction .moveTo(x: location.x, duration: 0.1))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            userPaddle.run(SKAction .moveTo(x: location.x, duration: 0.1))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        
        var zero = CGFloat()
        zero = 0
        
       if((pongBall.physicsBody?.velocity.dy)! > zero)
       {
        enemyPaddle.run(SKAction .moveTo(x: pongBall.position.x, duration: difficultyFactor))
        }
            
        
        //Check if someone scored
        if pongBall.position.y <= userPaddle.position.y - 30
        {
            addScore(winningPlayer : enemyPaddle)
            
        }
        else if pongBall.position.y >= enemyPaddle.position.y + 30
        {
            addScore(winningPlayer : userPaddle)
           
        }
        
        
        //Remove timer when it hits 0
        if(countdownTimer.text == "0")
        {
            countdownTimer.removeFromParent()
        }
        
//        var xVel = CGFloat()
//        xVel = 350
//      
//        
//        if((pongBall.physicsBody?.velocity.dx)! > xVel)
//        {
//            pongBall.physicsBody?.velocity.dx = xVel
//        }
//        
//        var yVel = CGFloat()
//        yVel = 350
//        
//        
//        if((pongBall.physicsBody?.velocity.dy)! > yVel)
//        {
//            pongBall.physicsBody?.velocity.dy = yVel
//        }
        
        
       
        
    }
    
}
