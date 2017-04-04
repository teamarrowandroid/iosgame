//
//  GameScene.swift
//  Grand Casino
//
//  Created by CSI Admin on 2017-03-28.
//  Copyright © 2017 apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    let background = SKSpriteNode(imageNamed: "slotmachine")
    let spin = SKSpriteNode(imageNamed: "spin")
    let reset = SKSpriteNode(imageNamed: "reset")
    let bet = SKSpriteNode(imageNamed: "bet")
    let bets = SKLabelNode()
    let winnings = SKLabelNode()
    let totalamt = SKLabelNode()
    let status = SKLabelNode()

    
    var img1 = SKSpriteNode(imageNamed: "bell")
    var img2 = SKSpriteNode(imageNamed: "bell")
    var img3 = SKSpriteNode(imageNamed: "bell")
    
    let slotimg = ["banana","grapes","cherry","bell","orange"]
    
    var betamt = 10
    var intTotal = 1000
    var win = 0
    
    var currentimg1:String = ""
    var currentimg2:String = ""
    var currentimg3:String = ""
    
    var active:Bool = false
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -100
        addChild(background)
        
        spin.position = CGPoint(x: 220, y: -380)
        spin.scale(to: CGSize(width: 200, height: 200))
        spin.zPosition = 100
        addChild(spin)
        
        bet.position = CGPoint(x: 0, y: -380)
        bet.scale(to: CGSize(width: 200, height: 200))
        bet.zPosition = 100
        addChild(bet)
        
        reset.position = CGPoint(x:-220, y: -380)
        reset.scale(to: CGSize(width: 200, height: 200))
        reset.zPosition = 100
        addChild(reset)
        
        
        totalamt.position = CGPoint(x: -200, y: -250)
        totalamt.fontSize = 50.0
        totalamt.text = "1000"
        totalamt.fontName = "AvenirNext-Bold"
        totalamt.horizontalAlignmentMode = .center
        totalamt.zPosition = 100
        addChild(totalamt)
        
        bets.position = CGPoint(x: 0, y: -250)
        bets.fontSize = 50.0
        bets.text = "100"
        bets.fontName = "AvenirNext-Bold"
        bets.horizontalAlignmentMode = .center
        bets.zPosition = 100
        addChild(bets)
        
        winnings.position = CGPoint(x: 200, y: -250)
        winnings.fontSize = 50.0
        winnings.text = "0"
        winnings.fontName = "AvenirNext-Bold"
        winnings.horizontalAlignmentMode = .center
        winnings.zPosition = 100
        addChild(winnings)
        
        
        img1.position = CGPoint(x:-220, y: -45)
        img1.zPosition = 100
        addChild(img1)
        
        img2.position = CGPoint(x: 0, y: -45)
        img2.zPosition = 100
        addChild(img2)
        
        img3.position = CGPoint(x: 220, y: -45)
        img3.zPosition = 100
        addChild(img3)
        
        status.position = CGPoint(x: 5, y: 160)
        status.fontName = "AvenirNext-Bold"
        status.fontSize = 35.0
        status.text = "Let's Play !!!"
        status.horizontalAlignmentMode = .center
        status.zPosition = 100
        addChild(status)
        
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
//        let touchLocation = touch.location(in: spin)
         if (spin.contains(touch.location(in: self)) && (active == false))
         {
            
            betamt = Int(bets.text!)!
            intTotal = Int(totalamt.text!)!
            print ("spinning .....")
            status.text = "Spinning ..."
            intTotal = intTotal - betamt
            totalamt.text = String(intTotal)
            active = true
            spin.texture = SKTexture(imageNamed: "spine")
            let wait:SKAction = SKAction.wait(forDuration: 0.5)
            
            let spin1:SKAction = SKAction.run({
                self.spin(which: 1)
            })
            
            let spin2:SKAction = SKAction.run({
                self.spin(which: 2)
            })
            
            let spin3:SKAction = SKAction.run({
                self.spin(which: 3)
            })
            
            let test:SKAction = SKAction.run({
                self.testvalues()
            })
            
            self.run(SKAction.sequence([wait, spin1, wait, spin2, wait, spin3, wait, test]))
        }
        
        if bet.contains(touch.location(in: self))
        {
            betamt = Int(bets.text!)!
            if (betamt < 500)
            {
                betamt = betamt + 100
            }
            else{
                betamt = 100
            }
            bets.text = String(betamt)
            
        }
        
        if reset.contains(touch.location(in: self))
        {
            bets.text = "100"
            totalamt.text = "1000"
            winnings.text = "0"
            status.fontSize = 35.0
            status.text = "Let's Play !!!"
            spin.texture = SKTexture(imageNamed: "spin")
            active = false
            
            
        }
        
    }
    
    func spin (which:Int){
        
        
        
        let randomNum:UInt32 = arc4random_uniform(UInt32(slotimg.count))
        
        let pick:String  = slotimg[Int(randomNum)]
        
        print("Wheel ",which, " gives value of", pick)
        
        if (which == 1){
            currentimg1 = pick
            img1.texture = SKTexture(imageNamed: currentimg1)
        }
        
        else  if (which == 2){
            currentimg2 = pick
             img2.texture = SKTexture(imageNamed: currentimg2)
        }
        
        else if (which == 3){
            currentimg3 = pick
            img3.texture = SKTexture(imageNamed: currentimg3)
        }
        
    }
    
    func testvalues(){
        betamt = Int(bets.text!)!
        intTotal = Int(totalamt.text!)!
        win = Int(winnings.text!)!
        
        if(currentimg1 == currentimg2 && currentimg2 == currentimg3){
            
            win = betamt * 5
            intTotal = intTotal + win
            print("  You Won a Jackpot of ", win ,"!!!!!! yeeeeeee")
            status.text = "Jackpot !!!"
        }
        else{
              if(currentimg1 == currentimg2 || currentimg2 == currentimg3 || currentimg1 == currentimg3){
                
                win = betamt * 2
                intTotal = intTotal + win
                
                print("  You Won ",win,"!! To win a Jackpot Play Again")
                status.text = "You Won !!!"
            }
              else{
                
                
                win = betamt * 0
                intTotal = intTotal + win
                
                print("  You lost! Play again .... ")
                status.text = "You Lost !!!"
            }
        }
        
        totalamt.text = String(intTotal)
        winnings.text = String(win)
        
        if(intTotal == 0 || intTotal < betamt){
            active = true
            status.fontSize = 30.0
            status.text = "Reset to Play"
            spin.texture = SKTexture(imageNamed: "spine")
            
        }
        else
        {
            spin.texture = SKTexture(imageNamed: "spin")
            active = false
        }
    }
    

}












