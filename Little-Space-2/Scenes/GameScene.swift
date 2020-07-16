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
        createMeteorShower()
        createLabels()
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        lifeLabel.text = "Lives: \(lives)"
        scoreLabel.text = "Score: \(score)"
        ship.boundsCheckPlayer(playableArea: playableRectArea)
        ship.boundsCheckPlayer2(playableArea: playableRectArea)
        for node in self.children{
            if node.name == "meteor" || node.name == "bullet" {
                let bottomLeft = CGPoint(x: 0, y: playableRectArea.minY)
                let topRight = CGPoint(x: playableRectArea.size.width, y: playableRectArea.maxY)
                
                if(node.position.x < bottomLeft.x){
                    node.position.x = topRight.x
                }
                
                
                if(node.position.y < bottomLeft.y){
                    node.position.y = topRight.y
                }
                
                if(node.position.x > topRight.x){
                    node.position.x = bottomLeft.x
                }
                
                if(node.position.y > topRight.y){
                    node.position.y = bottomLeft.y
                }
            }
        }
//        gameScene.rootNode.childNodes.filter({ $0.name == "Enemy" }).forEach({ $0.removeFromParentNode() })
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
        meteor.checkBounds(playableArea: playableRectArea)
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
    
    func createMeteorShower(){
        let wait = SKAction.wait(forDuration: 5)
        let createObject = SKAction.run{
            self.createMeteor()
        }
        let objects = SKAction.sequence([wait,createObject])
        let showerObjects = SKAction.repeatForever(objects)
        self.run(showerObjects)
    }
    
    func createLabels(){
        lifeLabel.text = "Lives: \(lives)"
        lifeLabel.fontSize = 20
        lifeLabel.zPosition = 10
        lifeLabel.position = CGPoint(x: 20, y: frame.size.height - 20)
        lifeLabel.horizontalAlignmentMode = .left
        lifeLabel.verticalAlignmentMode = .top
        self.addChild(lifeLabel)
        
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 20
        scoreLabel.zPosition = 10
        scoreLabel.position = CGPoint(x: frame.size.width - 20, y: frame.size.height - 20)
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .top
        self.addChild(scoreLabel)
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
            
            
        }
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
        
        let action = SKAction.move(to: CGPoint(x: 500 * cos(ship.zRotation) + bullet.position.x, y: 500 * sin(ship.zRotation) + bullet.position.y), duration: 1)
        let actionDone = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([action, actionDone]))
    
        self.addChild(bullet)
    }
    
    //MARK: Game Over
    func gameOver(){
        
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

    
    //MARK: Collision Detection
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //2
        if collision == PhysicsCategory.Meteor | PhysicsCategory.Bullet {
            print("Meteor Destroyed")
            self.score += 10
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            
            //            if (contact.bodyA.node?.isKind(of: Junk.self))!{
            //                contact.bodyA.node?.removeFromParent()
            //            }else if (contact.bodyB.node?.isKind(of: Junk.self))!{
            //                contact.bodyB.node?.removeFromParent()
            //            }
            
        }else if collision == PhysicsCategory.Ship | PhysicsCategory.Meteor {
            print("Collision with Meteor")
            self.lives -= 1
            //            self.run(crash)
            
            if (contact.bodyA.node?.isKind(of: Meteor.self))!{
                //                let pso = contact.bodyA.node?.position
                //                let mplosion = SKEmitterNode(fileNamed: "mExplosion.sks")!
                //                mplosion.position = pso!
                //                mplosion.zPosition = 1
                //                self.addChild(mplosion)
                contact.bodyA.node?.removeFromParent()
            }else if (contact.bodyB.node?.isKind(of: Meteor.self))!{
                //                let pso = contact.bodyB.node?.position
                //                let mplosion = SKEmitterNode(fileNamed: "mExplosion.sks")!
                //                mplosion.position = pso!
                //                mplosion.zPosition = 1
                //                self.addChild(mplosion)
                contact.bodyB.node?.removeFromParent()
            }
        }
    }
}
