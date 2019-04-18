import SpriteKit

public class Instruction3: SKScene {

  override public func didMove(to view: SKView) {
    
    
    let bacteria = childNode(withName: "bacteria") as? SKSpriteNode
    
    bacteria!.run(SKAction.repeatForever(
        SKAction.sequence([
            SKAction.moveBy(x: 0, y: 240, duration: 5),
            SKAction.moveBy(x: 0, y: -240, duration: 0),
            ])))
    
    bacteria!.run(SKAction.repeatForever(
        SKAction.sequence([
            SKAction.moveBy(x: 15, y: 0, duration: 0.30),
            SKAction.moveBy(x: -15, y: 0, duration: 0.30),
            ])))
    }
  
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                
                let scene = GameScene(fileNamed: "GameScene")!
                scene.scaleMode = .aspectFit
                let transition = SKTransition.flipVertical(withDuration: 1)
                self.view?.presentScene(scene, transition: transition)
                
        }
        
    }
