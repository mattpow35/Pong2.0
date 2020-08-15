//
//  PlayGame.swift
//  Pong
//
//  Created by Matt Powley on 1/21/17.
//  Copyright © 2017 Matt Powley. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayGame : GKState
{
    unowned let scene : GameScene
    
    init(scene : SKScene)
    {
        self.scene = scene as! GameScene
        super.init()
    }
    
    func randomDirection() -> CGFloat
    {
        let speedFactor: CGFloat = 3.0
        if scene.randomFloat(from: 0.0, to: 100.0) >= 50 {
            return -speedFactor
        } else {
            return speedFactor
        }
    }
    override func didEnter(from previousState: GKState?)
    {
        if previousState is TapToPlay
        {
            //let pongBall = scene.childNode(withName: "pongBall") as! SKSpriteNode
            //pongBall.physicsBody!.applyImpulse(CGVector(dx: randomDirection(), dy: randomDirection()))
            
            startGame()
        }
    }
    
    
//    override func update(deltaTime seconds: TimeInterval)
//    {
//        let pongBall = scene.childNode(withName: "pongBall") as! SKSpriteNode
//        let maxSpeed: CGFloat = 400.0
//        
//        let xSpeed = sqrt(pongBall.physicsBody!.velocity.dx * pongBall.physicsBody!.velocity.dx)
//        let ySpeed = sqrt(pongBall.physicsBody!.velocity.dy * pongBall.physicsBody!.velocity.dy)
//        
//        let speed = sqrt(pongBall.physicsBody!.velocity.dx * pongBall.physicsBody!.velocity.dx + pongBall.physicsBody!.velocity.dy * pongBall.physicsBody!.velocity.dy)
//        
//        if xSpeed <= 10.0 {
//            pongBall.physicsBody!.applyImpulse(CGVector(dx: randomDirection(), dy: 0.0))
//        }
//        if ySpeed <= 10.0 {
//            pongBall.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: randomDirection()))
//        }
//        
//        if speed > maxSpeed {
//            pongBall.physicsBody!.linearDamping = 0.4
//        } else {
//            pongBall.physicsBody!.linearDamping = 0.0
//        }
//    }
//    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameOver.Type
    }
    
    
    func startGame()
    {
        score = [0,0]
        
        enemyScore.text = "\(score[1])"
        userScore.text = "\(score[0])"
        
        onePlayerScore = [0]
        
        endlessScore.text = "\(onePlayerScore[0])"
        
        
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when)
        {
            self.pongBall.physicsBody?.applyImpulse(CGVector(dx: 12, dy: -12))
        }
        
        
    }
    
}
