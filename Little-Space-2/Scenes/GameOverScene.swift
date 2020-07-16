//
//  GameOverScene.swift
//  Little-Space-2
//
//  Created by Henry Calderon on 7/16/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    let overLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
    var endScore = 0
    
    //MARK: Init
    override init(size: CGSize) {
        // do initial configuration work here
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    //MARK: Did Move
    override func didMove(to view: SKView) {
        let space = SKSpriteNode(imageNamed: "spaceBack")
        space.size = UIScreen.main.bounds.size
        space.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.addChild(space)
    }
    
    //MARK: Setup
    func setupScreen(){
        overLabel.text = "Game Over"
        overLabel.fontSize = 40
        overLabel.zPosition = 5
        overLabel.position = CGPoint(x: frame.size.width/2, y: self.frame.midY + 100)
        overLabel.horizontalAlignmentMode = .center
        overLabel.verticalAlignmentMode = .center
        self.addChild(overLabel)
        
        scoreLabel.text = "Final Score: \(endScore)"
        scoreLabel.fontSize = 30
        scoreLabel.zPosition = 5
        scoreLabel.position = CGPoint(x: frame.size.width/2, y: self.frame.midY - 85)
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .center
        self.addChild(scoreLabel)
        
        
    }
    
    //MARK: Objective Actions
    @objc func playAgain(){
        
    }
    
    @objc func goHome(){
        print("Go Home")
    }
}
