//
//  Ship.swift
//  Little-Space-2
//
//  Created by Henry Calderon on 7/8/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

// ref 1: https://stackoverflow.com/questions/37807227/simulate-zero-gravity-style-player-movement

import UIKit
import SpriteKit
import GameplayKit

class Ship: SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "shipV1")
        let color = UIColor.clear
        let size = CGSize(width: 44, height: 44)
        super.init(texture: texture, color: color, size: size)
        self.name = "ship"
        self.zPosition = 4
        
        //            let fireEmitter = SKEmitterNode(fileNamed: "boosterFire.sks")!
        //            fireEmitter.position = CGPoint(x: self.position.x, y: self.position.y - self.size.height/2)
        //    //        fireEmitter.particleColor = .blue
        //            fireEmitter.zPosition = -1
        //            self.addChild(fireEmitter)
        
        //Physics
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.mass = 1000
        self.physicsBody?.categoryBitMask = PhysicsCategory.Ship
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Movement
    func moveShip(dxVectorValue: CGFloat, dyVectorValue: CGFloat, duration: TimeInterval)->(){
//        print("move player")
        let movement = CGVector(dx: dxVectorValue, dy: dyVectorValue)
        let moveShip = SKAction.applyForce(movement, duration: 1/duration)
        self.run(moveShip)
        
    }
    
    func stopMove(){
        let delay:TimeInterval = 1
        let stop: SKAction = SKAction.run{
            self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
        let wait = SKAction.wait(forDuration: delay)
        let stopping = SKAction.sequence([wait, stop])
        self.run(stopping)

    }
}
