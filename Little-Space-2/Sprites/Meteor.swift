//
//  Meteor.swift
//  Little-Space-2
//
//  Created by Henry Calderon on 7/8/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

enum MeteorType: String, CaseIterable{
    case largeMeteor = "MeteorBig"
    case medMeteor = "MeteorMed"
    case smallMeteor = "MeteorSmall"
}

class Meteor: SKSpriteNode {
    
    init(){
        //            let randomTexture = MeteorType.allCases.randomElement()!
//        let texture = SKTexture(imageNamed: randomTexture.rawValue)
        let texture = SKTexture(imageNamed: "MeteorBig")
        let color = UIColor.clear
        let size = CGSize(width: 50, height: 50)
        super.init(texture: texture, color: color, size: size)
        self.name = "meteor"
        self.zPosition = 2
        
        //Physics
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Meteor
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ship | PhysicsCategory.Bullet
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ship | PhysicsCategory.Bullet
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeMeteor(scene: SKScene){
        if let view = scene.view{
            //            position.x = view.bounds.width
            self.position.x = CGFloat.random(in: 0...view.bounds.width)
            self.position.y = CGFloat.random(in: 0...view.bounds.height)
        }
        let numX = [-13,-12,-11,-10,-9,-8,8,9,10,11,12,13]
        self.physicsBody?.velocity = CGVector(dx: numX.randomElement()!, dy: numX.randomElement()!)
    }
    
    //MARK: Check Bounds
    //Not being used
    func checkBounds(playableArea: CGRect){
        let bottomLeft = CGPoint(x: 0, y: playableArea.minY)
        let topRight = CGPoint(x: playableArea.size.width, y: playableArea.maxY)
        
        if(self.position.x < bottomLeft.x){
            self.position.x = topRight.x
        }
        
        
        if(self.position.y < bottomLeft.y){
            self.position.y = topRight.y
        }
        
        if(self.position.x > topRight.x){
            self.position.x = bottomLeft.x
        }
        
        if(self.position.y > topRight.y){
            self.position.y = bottomLeft.y
        }
        
    }
}
