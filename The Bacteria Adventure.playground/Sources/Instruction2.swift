import SpriteKit

public class Instruction2: SKScene {

  override public func didMove(to view: SKView) {
    
    for child in self.children {
        
        if child.name == "bacteriophague" {
            if let phague = child as? SKSpriteNode {
                
                phague.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.moveBy(x: 0, y: 900, duration: 15),
                        SKAction.moveBy(x: 0, y: -900, duration: 0),
                        ] )))
                
                phague.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.moveBy(x: -15, y: 0, duration: 0.30),
                        SKAction.moveBy(x: 15, y: 0, duration: 0.30),
                        ])))
            }
        }
        
        if child.name == "bacteria" {
            if let bacteria = child as? SKSpriteNode {
                
                bacteria.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.moveBy(x: 0, y: 900, duration: 15),
                        SKAction.moveBy(x: 0, y: -900, duration: 0),
                        ])))
                
                bacteria.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.moveBy(x: 15, y: 0, duration: 0.30),
                        SKAction.moveBy(x: -15, y: 0, duration: 0.30),
                        ])))
            }
        }
    }
    
    
    }
  
    
    override public func touchesEnded(_ touches: Set<UITouch>,
                                      with event: UIEvent?) {
        
        if let _ = touches.first {
            
                let scene = Instruction3(fileNamed: "Instruction3")!
                scene.scaleMode = .aspectFit
                let transition = SKTransition.flipVertical(withDuration: 1)
                self.view?.presentScene(scene, transition: transition)
        }
    }
}
