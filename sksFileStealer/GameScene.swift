//
//  GameScene.swift
//  sksFileStealer
//
//  Created by Carly Cameron on 5/30/19.
//  Copyright © 2019 Carly Cameron. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKSpriteNode!
    var paddle: SKSpriteNode!
    var label: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        ball = (childNode(withName: "Ball") as! SKSpriteNode)
        paddle = (childNode(withName: "Paddle") as! SKSpriteNode)
        label = (childNode(withName: "LoseLabel") as! SKLabelNode)
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "BottomBorder" || bodyBName == "BottomBorder" {
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            label.text = "You Lose!"
            label.isHidden = false
        } else if children.count == 7 {
            label.text = "You Win!"
            label.isHidden = false
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }else if bodyAName == "Ball" && bodyBName == "Brick" || bodyBName == "Ball" && bodyAName == "Brick" {
            if bodyAName == "Brick" {
                contact.bodyA.node?.removeFromParent()
            } else if bodyBName == "Brick" {
                contact.bodyB.node?.removeFromParent()
            }
        }
    }
}

