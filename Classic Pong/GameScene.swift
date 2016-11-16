//
//  GameScene.swift
//  Classic Pong
//
//  Created by Rodolfo Zenil Cruz on 14/11/16.
//  Copyright © 2016 Rodolfo Zenil Cruz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player1 = SKSpriteNode()
    var player2 = SKSpriteNode()
    var ball = SKSpriteNode()
    
    var player1Label = SKLabelNode()
    var player2Label = SKLabelNode()
    
    
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        player1 = self.childNode(withName: "player1") as! SKSpriteNode
        player2 = self.childNode(withName: "player2") as! SKSpriteNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: 20))
        
        player1Label = self.childNode(withName: "player1Label") as! SKLabelNode
        player2Label = self.childNode(withName: "player2Label") as! SKLabelNode
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame () {
        score = [0,0]
        
        player2Label.text = "\(score[1])"
        player1Label.text = "\(score[0])"
        
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == player1 {
            score[0] += 1
            
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))

        }
        else if playerWhoWon == player2 {
            score [1] += 1
            
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        
        player2Label.text = "\(score[1])"
        player1Label.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            player1.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player1.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        player2.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
        
        if ball.position.y <= player1.position.y - 70 {
            addScore(playerWhoWon: player2)
        }
        else if ball.position.y >= player2.position.y + 70 {
            addScore(playerWhoWon: player1)
        }
        
        
    }
}
