import UIKit
import PlaygroundSupport
import SpriteKit

// Start game
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 720, height: 540))
if let scene = MainMenu(fileNamed: "MainMenu") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}

// Fullscreen
//if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
//    PlaygroundSupport.PlaygroundPage.current.wantsFullScreenLiveView = true
//}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
