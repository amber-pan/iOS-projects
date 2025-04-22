//
//  BounceScene.swift
//  Bounce
//
//  Created by amber on 3/4/25.
//

import Foundation
import SpriteKit

class BounceScene: NSObject {
    let scene = SKScene(size: CGSize(width: 320, height: 320))
    let sprite = SKSpriteNode(color: .gray, size: CGSize(width: 20, height: 20))
    let top = SKSpriteNode(color: .clear, size: CGSize(width: 320, height: 1))
    let bottom = SKSpriteNode(color: .clear, size: CGSize(width: 320, height: 1))
    let magic = SKEmitterNode(fileNamed: "magic")

    override init() {
        super.init()
        scene.backgroundColor = .cyan
        sprite.position = CGPoint(x: 160, y: 160)
        scene.addChild(sprite)
        let scoreText = SKLabelNode(text: "0 points")
        scoreText.position = CGPoint(x: 240, y: 260)
        scene.addChild(scoreText)
        top.position = CGPoint(x: 160, y: 319)
        bottom.position = CGPoint(x: 160, y: 1)
        scene.addChild(top)
        scene.addChild(bottom)

        // set up some physics stuff
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        top.physicsBody = SKPhysicsBody(rectangleOf: top.size)
        bottom.physicsBody = SKPhysicsBody(rectangleOf: bottom.size)
        top.physicsBody?.affectedByGravity = false
        bottom.physicsBody?.affectedByGravity = false
        top.physicsBody?.categoryBitMask = 1
        bottom.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.categoryBitMask = 1
        top.physicsBody?.contactTestBitMask = 1
        bottom.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.contactTestBitMask = 1
        top.physicsBody?.collisionBitMask = 0
        bottom.physicsBody?.collisionBitMask = 0
        scene.physicsWorld.contactDelegate = self
    }

    func bounceBox() {
        sprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 8))
    }
}

extension BounceScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let particles = magic, particles.parent == nil else { return  }
        sprite.addChild(particles)
    }
}
