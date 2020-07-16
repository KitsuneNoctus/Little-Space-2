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
    
    let fireEmitter = SKEmitterNode(fileNamed: "rocket.sks")!
    let blast = SKAction.playSoundFileNamed("blaster.mp3", waitForCompletion: false)
    
    init() {
        let texture = SKTexture(imageNamed: "shipV1")
        let color = UIColor.clear
        let size = CGSize(width: 44, height: 44)
        super.init(texture: texture, color: color, size: size)
        self.name = "ship"
        self.zPosition = 4
        
//        fireEmitter.position = CGPoint(x: self.position.x, y: self.position.y - self.size.height/2)
//        fireEmitter.zPosition = -1
//        self.addChild(fireEmitter)
        
        //            let fireEmitter = SKEmitterNode(fileNamed: "boosterFire.sks")!
        //            fireEmitter.position = CGPoint(x: self.position.x, y: self.position.y - self.size.height/2)
        //    //        fireEmitter.particleColor = .blue
        //            fireEmitter.zPosition = -1
        //            self.addChild(fireEmitter)
        
        //Physics
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = PhysicsCategory.Ship
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Sounds
    func blaster(){
        self.run(blast)
    }
    
    //MARK: Move / Engine
    func startEngine(){
        
    }
    
    func move(velocity: CGPoint){
        let amountToMove = CGPoint(x: velocity.x, y: velocity.y)
        position = CGPoint(x: position.x + amountToMove.x, y: position.y + amountToMove.y)
    }
    
    //MARK: Check Bounds
//    func checkBounds(scene: SKScene){
//        let bottomLeft = CGPoint(x: 0, y: scen)
//    }
    
    func boundsCheckPlayer(playableArea: CGRect){
        let bottomLeft = CGPoint(x: 0, y: playableArea.minY)
        let topRight = CGPoint(x: playableArea.size.width, y: playableArea.maxY)

        if(self.position.x < bottomLeft.x){
            self.position.x = topRight.x
//            self.position.x = bottomLeft.x
        }


        if(self.position.y < bottomLeft.y){
            self.position.y = topRight.y
//            self.position.y = bottomLeft.y
        }

    }
    
    func boundsCheckPlayer2(playableArea: CGRect){
        let bottomLeft = CGPoint(x: 0, y: playableArea.minY)
        let topRight = CGPoint(x: playableArea.size.width, y: playableArea.maxY)
        
        if(self.position.x > topRight.x){
            self.position.x = bottomLeft.x
            //            self.position.x = topRight.x
        }
        
        if(self.position.y > topRight.y){
            self.position.y = bottomLeft.y
            //            self.position.y = topRight.y
        }
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
