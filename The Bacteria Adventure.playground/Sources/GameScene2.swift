import SpriteKit
import UIKit

public class GameScene2: SKScene, SKPhysicsContactDelegate {
    
    let bacteriaSpeed: CGFloat = 155.0
    let bacteriophagueSpeed: CGFloat = 40.0
    let plasmidDuration: Double = 6.0
    
    var cell: SKSpriteNode?
    var bacteria: SKSpriteNode?
    var plasmid: SKSpriteNode?
    var phagues: [SKSpriteNode] = []
    var powerup: Bool = false
    var powerupCount = 0;
    
    var lastTouch: CGPoint? = nil
    
    override public func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        // Animations
        bacteria = childNode(withName: "bacteria") as? SKSpriteNode
        
        cell = childNode(withName: "cell") as? SKSpriteNode
        cell!.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.moveBy(x: 0, y: 10, duration: 0.45),
                SKAction.moveBy(x: 0, y: -10, duration: 0.45)
                ]
        )))
        
        for child in self.children {
            if child.name == "bacteriophague" {
                if let child = child as? SKSpriteNode {
                    phagues.append(child)
                }
            }
        }
        
        plasmid = childNode(withName: "plasmid") as? SKSpriteNode
        for child in self.children {
            if child.name == "plasmid" {
                if let child = child as? SKSpriteNode {
                    child.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(3.14), duration: 4.0)))
                }
            }
        }
        // </> Animations
        
    }
    
    
    override public func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?) { handleTouches(touches) }
    
    override public func touchesMoved(_ touches: Set<UITouch>,with event: UIEvent?) { handleTouches(touches) }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { handleTouches(touches) }
    
    fileprivate func handleTouches(_ touches: Set<UITouch>) { lastTouch = touches.first?.location(in: self) }
    
    override public func didSimulatePhysics() {
        if bacteria != nil {
            updatePlayer()
            updateZombies()
        }
    }
    
    fileprivate func shouldMove(currentPosition: CGPoint,
                                touchPosition: CGPoint) -> Bool {
        guard let bacteria = bacteria else { return false }
        return abs(currentPosition.x - touchPosition.x) > bacteria.frame.width / 2 ||
            abs(currentPosition.y - touchPosition.y) > bacteria.frame.height / 2
    }
    
    fileprivate func updatePlayer() {
        guard let bacteria = bacteria,
            let touch = lastTouch
            else { return }
        let currentPosition = bacteria.position
        if shouldMove(currentPosition: currentPosition,
                      touchPosition: touch) {
            updatePosition(for: bacteria, to: touch, speed: bacteriaSpeed)
        } else {
            bacteria.physicsBody?.isResting = true
        }
    }
    
    func updateZombies() {
        guard let bacteria = bacteria else { return }
        let targetPosition = bacteria.position
        
        for bacteriophague in phagues {
            updatePosition(for: bacteriophague, to: targetPosition, speed: bacteriophagueSpeed)
        }
    }
    
    fileprivate func updatePosition(for sprite: SKSpriteNode, to target: CGPoint, speed: CGFloat) {
        
        let currentPosition = sprite.position
        let angle = CGFloat.pi + atan2(currentPosition.y - target.y, currentPosition.x - target.x)
        let rotateAction = SKAction.rotate(toAngle: angle + (CGFloat.pi*0.5), duration: 0)
        sprite.run(rotateAction)
        
        let velocityX = speed * cos(angle)
        let velocityY = speed * sin(angle)
        
        let newVelocity = CGVector(dx: velocityX, dy: velocityY)
        sprite.physicsBody?.velocity = newVelocity
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Check contact
        if firstBody.categoryBitMask == bacteria?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == phagues[0].physicsBody?.categoryBitMask {
            // Bacteria & Phague
            if !powerup { gameOver(false) }
            
        } else if firstBody.categoryBitMask == bacteria?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == cell?.physicsBody?.categoryBitMask {
            // Bacteria & Cell
            gameOver(true)
            
        }else if firstBody.categoryBitMask == bacteria?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == plasmid?.physicsBody?.categoryBitMask {
            // Bacteria & Plasmid
            let plasmid = secondBody.node as! SKSpriteNode
            plasmid.removeFromParent()
            self.gainPowerUp()
            
        }
    }
    
    func gainPowerUp() {
        powerup = true
        powerupCount += 1
        
        // different animation
        bacteria?.run(SKAction.repeat(
            SKAction.sequence([
                SKAction.setTexture(SKTexture(imageNamed: "bacteria-powered")),
                SKAction.moveBy(x: 0, y: 0, duration: 0.15),
                SKAction.setTexture(SKTexture(imageNamed: "bacteria")),
                SKAction.moveBy(x: 0, y: 0, duration: 0.15),
                ]
            ), count: 20
        ))
        
        bacteria?.texture = SKTexture(imageNamed: "bacteria-powered")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.plasmidDuration) {
            if self.powerupCount <= 1 { self.powerup = false }
            self.powerupCount -= 1
        }
    }
    
    fileprivate func gameOver(_ didWin: Bool) {
        let resultScene = MenuScene(size: size, didWin: didWin, levelToSend: 3)
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        view?.presentScene(resultScene, transition: transition)
    }
    
}

