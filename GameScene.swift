//
//  GameScene.swift
//  Pong
//
//  Created by Trey Burrell on 1/31/17.
//  Copyright © 2017 Trey. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var bottomLbl = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLbl = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        print(self.view?.bounds.height)
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame () {
        score = [0,0]
        topLbl.text = "\(score[1])"
        bottomLbl.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: -12, dy: -12))
        
    }
    
    func addScore(playerWhoWon : SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 12, dy: 12))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -12, dy: -12))
            
        }
        topLbl.text = "\(score[1])"
        bottomLbl.text = "\(score[0])"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
                
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
                
            }
            else {
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }

        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.1))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.9))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
            break
        case .player2:
            
            break
            
        }
        
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
            
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
            
            
        }
        
    }
}


