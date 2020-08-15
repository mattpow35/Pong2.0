//
//  TapToPla.swift
//  Pong
//
//  Created by Matt Powley on 1/21/17.
//  Copyright © 2017 Matt Powley. All rights reserved.
//

import SpriteKit
import GameplayKit

class TapToPlay: GKState
{
    unowned let scene : GameScene
    
    init(scene: SKScene)
    {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?)
    {
        let scale = SKAction.scale(to: 1.0, duration: 0.25)
        scene.childNode(withName: "gameMessage")!.run(scale)
    }
    
    override func willExit(to nextState: GKState)
    {
        if nextState is PlayGame
        {
            let scale = SKAction.scale(to: 0, duration: 0.4)
            scene.childNode(withName: "gameMessage")!.run(scale)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool
    {
        return stateClass is PlayGame.Type
    }
    
    
    
    
    
}
