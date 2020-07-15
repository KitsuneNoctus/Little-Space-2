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
    let base = SKSpriteNode(imageNamed: "holder")
    let ball = SKSpriteNode(imageNamed: "ball")
    let lifeLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
    
    var lives = 3
    var score = 0
    
    var currentTouchPos: CGPoint  = CGPoint(x: 0, y: 0)
    var startTouchPos: CGPoint = CGPoint(x: 0, y: 0)
    
    var dt:TimeInterval = 0
    var playableRectArea:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var stickActive:Bool = false
    
    //MARK: Did Move
    override func didMove(to view: SKView) {
        let space = SKSpriteNode(imageNamed: "spaceBack")
        space.size = UIScreen.main.bounds.size
        space.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.addChild(space)
        
        // Constant - Max aspect ratio supported
        let maxAspectRatio:CGFloat = 16.0/9.0
        // Calculate playable height
        let playableHeight = size.width / maxAspectRatio
        
        // Determine margin on top and bottom by subtracting playable height
        // from scene height and then divide by 2
        let playableMargin = (size.height-playableHeight)/2.0
        playableRectArea = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        //Physics World
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        createShip()
        createJoy()
        createButton()
        
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        ship.boundsCheckPlayer(playableArea: playableRectArea)
        ship.boundsCheckPlayer2(playableArea: playableRectArea)
    }
    
    //MARK: Creation
    func createShip(){
        ship = Ship()
        ship.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.addChild(ship)
    }
    
    func createMeteor(){
        let meteor = Meteor()
//        let meteor2 = Meteor()
//        let meteor3 = Meteor()
//        let meteor4 = Meteor()
        meteor.placeMeteor(scene: self)
        meteor.zPosition = 2
        self.addChild(meteor)
    }
    
    func createJoy(){
        base.zPosition = 5
        base.position = CGPoint(x: 70, y: 70)
        base.size = CGSize(width: 110, height: 100)
        self.addChild(base)
        
        ball.zPosition = 6
        ball.position = CGPoint(x: 70, y: 72)
        ball.size = CGSize(width: 80, height: 80)
        self.addChild(ball)
    }
    
    func createButton(){
        let buttonTexture = SKTexture(imageNamed: "ball")
        let button = ButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTexture, disabledTexture: buttonTexture)
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameScene.fire))
        
        button.setButtonLabel(title: "Fire", font: "Helvetica", fontSize: 15)
        button.size = CGSize(width: 80, height: 80)
        button.position = CGPoint(x: self.frame.width - 70, y: 70)
        button.zPosition = 20
        button.name = "button"
        self.addChild(button)
    }
        
    
    
    //MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        ship.physicsBody?.velocity = CGVector(dx: 2, dy: 0)
        print("TOuch")
        for t: AnyObject in touches{
            startTouchPos = t.location(in: self)
            currentTouchPos = startTouchPos
        }
        ship.physicsBody?.linearDamping = 0
        
        if ball.frame.contains(currentTouchPos){
            stickActive = true
        }else{
            stickActive = false
        }
    }
//    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        print("TOuches")
        for t: AnyObject in touches{
            currentTouchPos = t.location(in: self)
        }
        //Reference: https://cartoonsmart.com/how-to-create-a-virtual-ios-joystick-with-swift-and-sprite-kit/
        
        if stickActive == true{
            
            let v = CGVector(dx: currentTouchPos.x - base.position.x, dy: currentTouchPos.y - base.position.y)
            let angle = atan2(v.dy, v.dx)
            
            var deg = angle * CGFloat(180 / M_PI)
            //        print( deg + 180 )
            
            let length: CGFloat = (base.frame.size.height / 2) - 20
            
            let xDist:CGFloat = sin(angle - 1.570796) * length
            let yDist:CGFloat = cos(angle - 1.570796) * length
            print(xDist)
            print(yDist)
            
            if base.frame.contains(currentTouchPos){
                ball.position = currentTouchPos
            }else{
                ball.position = CGPoint(x: base.position.x - xDist, y: base.position.y + yDist)
            }
            
            ship.zRotation = angle - 1.570796
            
//            ship.move(velocity: CGPoint(x: xDist + ship.position.x, y: yDist + ship.position.y))
//            ship.startEngine()
            
//                        ship.physicsBody?.applyForce(CGVector(dx: 1, dy: 0), at: ship.position)
//            ship.physicsBody?.angularVelocity = angle - 1.570796
            
        }
        
        //        ship.physicsBody?.velocity = CGVector(dx: (-0.5) * (startTouchPos.x - currentTouchPos.x), dy: -0.5 * (startTouchPos.y-currentTouchPos.y))
        
        
        
    }
//    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TOuch end")
        ship.physicsBody?.linearDamping = CGFloat(floatLiteral: 0.5)
//        ship.removeAllActions()
//        ship.stopMove()
        if stickActive == true{
            let move = SKAction.move(to: base.position, duration: 0.2)
            move.timingMode = .easeOut
            ball.run(move)
        }
        
        
    }
    
    //MARK: Actions
    @objc func fire(){
        let bullet = Bullet()
        bullet.position = ship.position
        bullet.zRotation = ship.zRotation
        bullet.zPosition = ship.zPosition - 1
        
//        let xDist:CGFloat = sin(angle - 1.570796) * length
//        let yDist:CGFloat = cos(angle - 1.570796) * length
        
        let action = SKAction.move(to: CGPoint(x: 100 * cos(bullet.zRotation) + bullet.position.x, y: 100 * sin(bullet.zRotation) + bullet.position.y), duration: 1)
        let actionDone = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([action, actionDone]))
    
        self.addChild(bullet)
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

}
