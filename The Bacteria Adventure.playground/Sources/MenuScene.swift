import SpriteKit

public class MenuScene: SKScene {
    
    var didWin: Bool
    var levelToSend: Int

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

    init(size: CGSize, didWin: Bool, levelToSend: Int) {
    self.didWin = didWin
    self.levelToSend = levelToSend
    super.init(size: size)
    scaleMode = .aspectFill
  }

  override public func didMove(to view: SKView) {
    
    self.removeAllActions()
    
    // Set up labels
    let winLabel = SKLabelNode(text: didWin ? "You survived!" : "You got infected!")
    winLabel.fontName = "AvenirNext-Bold"
    winLabel.fontSize = 45
    winLabel.fontColor = .white
    winLabel.position = CGPoint(x: frame.midX, y: frame.midY*1.5)
    addChild(winLabel)
    
    let label = SKLabelNode(text: didWin ? "Tap the screen to play the next level" : "Tap the screen to play again")
    label.fontName = "AvenirNext-Bold"
    label.fontSize = 30
    label.fontColor = .white
    label.position = CGPoint(x: frame.midX, y: frame.midY*0.5)
    addChild(label)
    
    
    
    let winIcon = SKSpriteNode(imageNamed: !didWin ? "bacteriophague.png" : "cell.png")
        winIcon.position = CGPoint(x: frame.midX, y: frame.midY)
        winIcon.setScale(0.6)
        
        winIcon.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.moveBy(x: 0, y: 10, duration: 0.2),
                SKAction.moveBy(x: 0, y: -10, duration: 0.2)
                ]
        )))
        
        addChild(winIcon)

  }

  override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    //change depending on next level and win/lose
    if !didWin {
        
        levelToSend -= 1  // if its a fail repeats the level
        
        //Level 1
        if levelToSend == 1 {
            guard let nextScene = GameScene(fileNamed: "GameScene") else { fatalError("GameScene not found") }
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            nextScene.scaleMode = .aspectFit
            view?.presentScene(nextScene, transition: transition)
        }
        
        //Level 2
        if levelToSend == 2 {
            guard let nextScene = GameScene2(fileNamed: "GameScene2") else { fatalError("GameScene not found") }
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            nextScene.scaleMode = .aspectFit
            view?.presentScene(nextScene, transition: transition)
        }
        
        //Level 2
        if levelToSend == 3 {
            guard let nextScene = GameScene3(fileNamed: "GameScene3") else { fatalError("GameScene not found") }
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            nextScene.scaleMode = .aspectFit
            view?.presentScene(nextScene, transition: transition)
        }
        
    }
    
    if didWin {
        
        if levelToSend == 2 {
            
            guard let nextScene = Instruction4(fileNamed: "Instruction4") else { fatalError("GameScene not found") }
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            nextScene.scaleMode = .aspectFit
            view?.presentScene(nextScene, transition: transition)
            
        }
        
        if levelToSend == 3 {
            
            guard let nextScene = GameScene3(fileNamed: "GameScene3") else { fatalError("GameScene not found") }
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            nextScene.scaleMode = .aspectFit
            view?.presentScene(nextScene, transition: transition)
            
        }
        
        if levelToSend == 4 {
            
            // send to final page
            
            //and from the final page send to main menu
            
            guard let nextScene = MainMenu(fileNamed: "MainMenu") else { fatalError("GameScene not found") }
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            nextScene.scaleMode = .aspectFit
            view?.presentScene(nextScene, transition: transition)
            
        }
        
    }
    
  }
}
