//
//  GameScene.swift
//  RocketGame_completed
//
//  Created by Ethan Look on 2/15/16.
//  Copyright (c) 2016 Ethan Look. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let UFO   : UInt32 = 0b1       // 1
    static let Rocket: UInt32 = 0b10      // 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var lastUFO: NSTimeInterval = NSTimeInterval()
    
    private var score: Int = 0
    private var scoreLabel: SKLabelNode = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        scoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        scoreLabel.text = String(score)
        scoreLabel.color = UIColor.whiteColor()
        self.addChild(scoreLabel)
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let rocket = Rocket(x: location.x, y: location.y, z: 0)
            rocket.addTo(self)
            rocket.flyAndRemove(self.frame.height + 100)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        let isFirstInScene = firstBody.node?.inParentHierarchy(self)
        let isSecondInScene = secondBody.node?.inParentHierarchy(self)
        if (isFirstInScene != nil && isSecondInScene != nil) {
            let collision = (contact.bodyA.categoryBitMask & contact.bodyB.categoryBitMask)
            
            if (collision == (PhysicsCategory.UFO & PhysicsCategory.Rocket)) {
                var aUFO:SKNode
                var aRocket:SKNode
                
                if (contact.bodyA.categoryBitMask == PhysicsCategory.UFO && contact.bodyB.categoryBitMask == PhysicsCategory.Rocket)
                {
                    aUFO = contact.bodyA.node!
                    aRocket = contact.bodyB.node!
                    
                } else {
                    aUFO = contact.bodyB.node!
                    aRocket = contact.bodyA.node!
                }
                
                aUFO.removeFromParent()
                aRocket.removeFromParent()
                
                self.scoreLabel.text = String(++score)
            }
        }
    }
    
    func addUFO() {
        let ufo = UFO(x: self.frame.width / 2, y: self.frame.height + 10, z: 0)
        ufo.addTo(self)
        ufo.flyAndRemove(self.frame.height + 100, time: 3.5)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if (currentTime - lastUFO > 3.0) {
            lastUFO = currentTime
            
            addUFO()
        }
    }
}
