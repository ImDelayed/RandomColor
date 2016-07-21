//
//  GameScene.swift
//  Random Color
//
//  Created by Alex Saltstein on 7/20/16.
//  Copyright (c) 2016 Alex Saltstein. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene {
    let randomButton = SKLabelNode(text: "Random")
    let randomButtonShadow = SKShapeNode(rectOfSize: CGSize(width: 150, height: 50))
    let hexadecimal = SKLabelNode(text: "LOL")
    let saveButton = SKLabelNode(text: "Save This Color")
    let saveButtonShadow = SKShapeNode(rectOfSize: CGSize(width: 250, height: 50))
    var savedColors: [String] = []
    var colorSaved = false
    let previousSession = NSUserDefaults.standardUserDefaults()
    let colorsButton = SKSpriteNode(imageNamed: "Options")
    
    override func didMoveToView(view: SKView) {
        randomColor()
        saveButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)*1.5)
        saveButtonShadow.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)*1.53)
        colorsButton.position = CGPoint(x: CGRectGetMidX(self.frame)/2, y: CGRectGetMidY(self.frame)*1.9)
        saveButtonShadow.fillColor = SKColor.clearColor()
        saveButtonShadow.strokeColor = SKColor.whiteColor()
        saveButtonShadow.lineWidth = 1
        randomButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)/2)
        hexadecimal.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        randomButtonShadow.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)/1.9)
        randomButtonShadow.fillColor = SKColor.clearColor()
        randomButtonShadow.strokeColor = SKColor.whiteColor()
        randomButtonShadow.lineWidth = 1
        self.addChild(colorsButton)
        self.addChild(randomButtonShadow)
        self.addChild(randomButton)
        self.addChild(hexadecimal)
        self.addChild(saveButton)
        self.addChild(saveButtonShadow)
        self.addChild(mySavedColorsButton)
        self.addChild(mySavedColorsButtonShadow)
        if previousSession.valueForKey("colorArr") != nil{
            savedColors = previousSession.valueForKey("colorArr") as! [String]
            print(savedColors)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            for i in savedColors{
                if i == hexadecimal.text!{
                    colorSaved = true
                }
            }
            if randomButtonShadow.containsPoint(location){
                randomButtonShadow.fillColor = SKColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
            }
            if saveButtonShadow.containsPoint(location){
                saveButtonShadow.fillColor = SKColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        randomButtonShadow.fillColor = SKColor.clearColor()
        saveButtonShadow.fillColor = SKColor.clearColor()
        for touch in touches{
            let location = touch.locationInNode(self)
            if randomButtonShadow.containsPoint(location){
                randomColor()
            }
            if saveButtonShadow.containsPoint(location){
                if !colorSaved{
                    print("Your Color Has Been Saved")
                    savedColors.append(hexadecimal.text!)
                    print(savedColors)
                    colorSaved = true
                    previousSession.setValue(savedColors, forKey: "colorArr")
                }else{
                    print("color already saved LOL")
                }
            }
        }
    }
   
    func randomColor(){
        let red = Float(drand48() * 255.0)
        let green = Float(drand48() * 255.0)
        let blue = Float(drand48() * 255.0)
 //       print("red: " + "\(red)")
   //     print("green: " + "\(green)")
     //   print("blue: " + "\(blue)")
        backgroundColor = SKColor(colorLiteralRed: red/255, green: green/255, blue: blue/255, alpha: 1.0)
        hexadecimal.text = "#" + decToHex(Int(red)) + decToHex(Int(green)) + decToHex(Int(blue))
        colorSaved = false
        goToLastColor += 1
        previousSession.setValue(red, forKey: "red")
        previousSession.setValue(green, forKey: "green")
        previousSession.setValue(blue, forKey: "blue")
    }
    
    func decToHex(let decimal:Int)->String{
        var output:String = ""
        var result = decimal
        var remainder:Int = 0
        while result != 0{
            remainder = result % 16
            result /= 16
            switch remainder{
            case 10:
                output = "A" + output
                break
            case 11:
                output = "B" + output
                break
            case 12:
                output = "C" + output
                break
            case 13:
                output = "D" + output
                break
            case 14:
                output = "E" + output
                break
            case 15:
                output = "F" + output
                break
            default:
                output = "\(remainder)" + output
                break
            }
        }
        if result == 0 && output.characters.count == 0{
            output = "00"
        }
        if output.characters.count == 1{
            output = "0" + output
        }
        return output
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}
