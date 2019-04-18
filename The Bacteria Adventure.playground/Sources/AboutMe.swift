import SpriteKit

public class AboutMe: SKScene {

  override public func didMove(to view: SKView) {
    
    
    let label = self.childNode(withName: "aboutLabel") as? SKLabelNode
    label!.text =
    """
    Hi! I’m Rodrigo and I love coding as much as I love biology. That’s why I am an undergraduate student in Biomedical Informatics at UFCSPA in Brazil. I've been a student at the Apple Developer’s Academy in Porto Alegre for the past two months and, since then, I am getting to know the swift language (which is awesome, by the way) and started building some nice code, like this playground you are seeing.
    """
    label!.lineBreakMode = NSLineBreakMode.byWordWrapping
    label!.numberOfLines = 0
    label!.preferredMaxLayoutWidth = 580
    
    let label2 = self.childNode(withName: "aboutLabel2") as? SKLabelNode
    label2!.text =
    """
    Hopefully you got the idea that bacterias are not always bad to us, and they actually play an important role in our systems! I hope you liked the game as much as my little brother did.
    """
    label2!.lineBreakMode = NSLineBreakMode.byWordWrapping
    label2!.numberOfLines = 0
    label2!.preferredMaxLayoutWidth = 580
    
    let me = childNode(withName: "me") as? SKSpriteNode
    me!.run(SKAction.repeatForever(
        SKAction.sequence([
            SKAction.moveBy(x: 0, y: 20, duration: 1.1),
            SKAction.moveBy(x: 0, y: -20, duration: 1.1)
            ]
    )))
    

    }
}
