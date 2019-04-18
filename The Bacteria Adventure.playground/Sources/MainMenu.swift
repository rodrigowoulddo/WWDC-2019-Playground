import SpriteKit
import AVFoundation


public class MainMenu: SKScene {
    
    var bombSoundEffect: AVAudioPlayer?
    
    override public func didMove(to view: SKView) {
        
        
        let bacteria = childNode(withName: "bacteria") as? SKSpriteNode
        bacteria!.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.moveBy(x: 0, y: 15, duration: 0.60),
                SKAction.moveBy(x: 0, y: -15, duration: 0.60)
                ]
        )))
        
        let startButton = childNode(withName: "startButton") as? SKLabelNode
        startButton!.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.fadeAlpha(to: 0, duration: 1),
                    SKAction.fadeAlpha(to: 1, duration: 2),
                    ]
            )))
        
        self.run(SKAction.playSoundFileNamed("music.mp3", waitForCompletion: false))
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?) { }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let _ = touches.first {
                let scene = Instruction1(fileNamed: "Instruction1")!
                scene.scaleMode = .aspectFit
                let transition = SKTransition.flipVertical(withDuration: 1)
                self.view?.presentScene(scene, transition: transition)
        }
    }
    
    fileprivate func handleTouches(_ touches: Set<UITouch>) { }
}
