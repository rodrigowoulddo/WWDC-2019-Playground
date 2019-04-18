import SpriteKit

public class InstructionFinal: SKScene {

  override public func didMove(to view: SKView) {
    
    
    let bacteria = childNode(withName: "bacteria") as? SKSpriteNode
    bacteria!.run(SKAction.repeatForever(
        SKAction.sequence([
            SKAction.moveBy(x: 0, y: 30, duration: 0.8),
            SKAction.moveBy(x: 0, y: -30, duration: 0.8)
            ])))
    
    
    let confetti = childNode(withName: "confetti") as? SKSpriteNode
    confetti!.run(SKAction.repeatForever(
        SKAction.sequence([
        SKAction.moveBy(x: 0, y: -700, duration: 10),
        SKAction.moveBy(x: 0, y: 700, duration: 0)
        ])))
    confetti!.run(SKAction.repeatForever(
        SKAction.sequence([
            SKAction.moveBy(x: 0, y: 0, duration: 8),
            SKAction.fadeAlpha(to: 0, duration: 2),
            SKAction.moveBy(x: 0, y: 0, duration: 0.2),
            SKAction.fadeAlpha(to: 1, duration: 0)
            ])))
    
    
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let _ = touches.first {
            let scene = AboutMe(fileNamed: "AboutMe")!
            scene.scaleMode = .aspectFit
            let transition = SKTransition.flipVertical(withDuration: 1)
            self.view?.presentScene(scene, transition: transition)
            
        }
        
    }
}
