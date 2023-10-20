//
//  GameScene.swift
//  16-AngryBirdClone
//
//  Created by Berke Ersiz on 29.08.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false
    var originalPosition : CGPoint?
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Box = 2
        //case Ground = 4
        //case Tree = 8
    }
    
    
    override func didMove(to view: SKView) {
        /*let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y: 0)
        bird2.size = CGSize(width: self.frame.width / 17, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)*/
        
        //Kus yere dusunce ekranda kalsin cercevemde. Physics Body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit//Ekrandan dusen kusumuz alta gidiyor diye yazdik.
        self.physicsWorld.contactDelegate = self
        
        //Bird
        bird = childNode(withName: "bird") as! SKSpriteNode
        
        let birdTexture = SKTexture(imageNamed: "bird")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 14)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
        
        //CARPISMA
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue//Carpisma fonks.
        
        //Box
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 6, height: boxTexture.size().height / 6)
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true ///Saga sola donebilir mi?
        box1.physicsBody?.mass = 0.4
        //Carpisma
        box1.physicsBody?.collisionBitMask=ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true ///Saga sola donebilir mi?
        box2.physicsBody?.mass = 0.4
        //Carpisma
        box2.physicsBody?.collisionBitMask=ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true ///Saga sola donebilir mi?
        box3.physicsBody?.mass = 0.4
        //Carpisma
        box3.physicsBody?.collisionBitMask=ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true ///Saga sola donebilir mi?
        box4.physicsBody?.mass = 0.4
        //Carpisma
        box4.physicsBody?.collisionBitMask=ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true ///Saga sola donebilir mi?
        box5.physicsBody?.mass = 0.4
        //Carpisma
        box5.physicsBody?.collisionBitMask=ColliderType.Bird.rawValue
        
        
        //Label
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            //print("contact")
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))//Ekrana tiklayainca kuvvet uygular.
        bird.physicsBody?.affectedByGravity = true//Tikladigimiz anda yer cekimi devreye girmesi icin.*/
        
        //KUSU TASIMAK
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //KUSU TASIMAK
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       //KUSU FIRLATMAK --Cektigimiz kadar firlaticaz.
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //Oyunu Resetlemek
        
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.2 && birdPhysicsBody.velocity.dy <= 0.2 && birdPhysicsBody.angularVelocity <= 0.2 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!

                score = 0
                scoreLabel.text = "0"
                gameStarted = false
            }
        }
    }
}
