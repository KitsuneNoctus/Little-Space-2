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
        self.physicsBody?.categoryBitMask = PhysicsCategory.Meteor
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ship
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ship
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeMeteor(scene: SKScene){
        if let view = scene.view{
            position.x = CGFloat.random(in: 0...view.bounds.width)
            position.y = view.bounds.height
        }
    }
}
