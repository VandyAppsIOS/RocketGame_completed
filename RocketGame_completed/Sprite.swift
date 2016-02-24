//
//  Sprite.swift
//  RocketGame_completed
//
//  Created by Ethan Look on 2/15/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import SpriteKit

class Sprite {
    
    let sprite = SKSpriteNode()
    
    init(imageNamed:String, name:String, x:CGFloat, y:CGFloat, z: CGFloat) {
        sprite.texture = SKTexture(imageNamed: imageNamed)
        sprite.position = CGPoint(x: x, y: y)
        sprite.size = sprite.texture!.size()
        sprite.name = name
        sprite.zPosition = z
    }
    
    func addTo(parentNode: SKScene) -> Sprite {
        parentNode.addChild(sprite)
        return self
    }
}
