import SpriteKit
import PlaygroundSupport

class Scene: SKScene {
    let cowboy = SKLabelNode(text: "🤠")
    let coins = ["💰", "💵", "💴", "💶", "💷", "💎"]
    var coin = SKLabelNode(text: "💰")

    override func sceneDidLoad() {
        cowboy.position.x = frame.midX
        cowboy.position.y = frame.midY
        addChild(cowboy)

        addCoin()
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

        if cowboy.frame.intersects(coin.frame) {
            // BOOM
            coin.removeFromParent()
            addCoin()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        cowboy.run(.move(to: touches.first!.location(in: self), duration: 2.0))
    }

    private func makeGround() -> SKShapeNode {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: 100)
        return SKShapeNode(rect: rect)
    }

    private func addCoin() {
        let coinNode = SKLabelNode(text: coins.random())

        self.coin = coinNode

        coinNode.position.x = CGFloat(arc4random_uniform(365))
        coinNode.position.y = CGFloat(arc4random_uniform(667))
        addChild(coinNode)
    }
}

extension Array {
    /// Pick a random element from the array
    func random() -> Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}

let viewFrame = CGRect(x: 0, y: 0, width: 365, height: 667)
let view = SKView(frame: viewFrame)
view.presentScene(Scene(size: viewFrame.size))
PlaygroundPage.current.liveView = view
