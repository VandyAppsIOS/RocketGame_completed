//
//  Rocket.swift
//  RocketGame_completed
//
//  Created by Ethan Look on 2/15/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import SpriteKit

class Rocket: Sprite {
    
    init(x:CGFloat, y:CGFloat, z:CGFloat) {
        super.init(imageNamed: "rocket", name: "rocket", x: x, y: y, z: z)
        
        self.sprite.physicsBody = SKPhysicsBody(circleOfRadius: self.sprite.frame.width/2)
        let physBody = sprite.physicsBody!
        physBody.dynamic = true
        physBody.categoryBitMask = PhysicsCategory.Rocket
        physBody.contactTestBitMask = PhysicsCategory.UFO
        physBody.collisionBitMask = PhysicsCategory.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flyAndRemove(height: CGFloat) {
        let destination = CGPoint(x: self.sprite.position.x, y: height + self.sprite.position.y)
        
        let actionMove = SKAction.moveTo(destination, duration: 12.0)
        let actionAccel = SKAction.speedBy(50, duration: 12.0)
        let actionMoveDone = SKAction.runBlock() {
            self.sprite.removeFromParent()
        }
        self.sprite.runAction(SKAction.sequence([SKAction.group([actionMove,actionAccel]), actionMoveDone]))
    }
    
}
