//
//  Bullet.swift
//  Little-Space-2
//
//  Created by Henry Calderon on 7/14/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class Bullet: SKSpriteNode {

    init(){
        let texture = SKTexture(imageNamed: "bullet")
        let color = UIColor.clear
        let size = texture.size()
        super.init(texture: texture, color: color, size: size)
        self.name = "bullet"
        self.zPosition = 0
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        self.physicsBody?.collisionBitMask = PhysicsCategory.Meteor
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Meteor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire(){
        
    }
}

