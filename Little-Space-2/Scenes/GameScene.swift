//
//  GameScene.swift
//  Little-Space-2
//
//  Created by Henry Calderon on 7/7/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

//ref 1: https://stackoverflow.com/questions/37807227/simulate-zero-gravity-style-player-movement

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ship: Ship!
    let lifeLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
    
    var lives = 3
    var score = 0
    
    var currentTouchPos: CGPoint  = CGPoint(x: 0, y: 0)
    var startTouchPos: CGPoint = CGPoint(x: 0, y: 0)
    
    var dt:TimeInterval = 0
    
    //MARK: Did Move
    override func didMove(to view: SKView) {
        let space = SKSpriteNode(imageNamed: "spaceBack")
        space.size = UIScreen.main.bounds.size
        space.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.addChild(space)
        
        //Physics World
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.02)
        
        createShip()
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    //MARK: Creation
    func createShip(){
        ship = Ship()
        ship.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.addChild(ship)
    }
    
    func createMeteor(){
        
    }
    
    
//    func touchDown(atPoint pos : CGPoint) {
//    
//    }
//    
//    func touchMoved(toPoint pos : CGPoint) {
//    
//    }
//    
//    func touchUp(atPoint pos : CGPoint) {
//        
//    }
//
    //MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        ship.physicsBody?.velocity = CGVector(dx: 2, dy: 0)
        print("TOuch")
        for t: AnyObject in touches{
            startTouchPos = t.location(in: self)
            currentTouchPos = startTouchPos
        }
    }
//    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        ship.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
//        ship.physicsBody?.velocity = CGVector(dx: 2, dy: 0)
//        print("TOuches")
//        for t: AnyObject in touches{
//            currentTouchPos = t.location(in: self)
//        }
//        let dxVectorValue = (-1) * (startTouchPos.x - currentTouchPos.x)
//        let dyVectorValue = (-1) * (startTouchPos.y - currentTouchPos.y)
//
//        ship.moveShip(dxVectorValue: dxVectorValue, dyVectorValue: dyVectorValue, duration: dt)


    }
//    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TOuch end")
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        ship.removeAllActions()
        ship.stopMove()
    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }

}
