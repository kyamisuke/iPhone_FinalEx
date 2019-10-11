//
//  GlitchViewController.swift
//  c4_practise
//
//  Created by 村上航輔 on 2019/10/07.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

import UIKit
import C4

public class GlitchViewController: CanvasController {
    let gl_mid = Image("glitch-mid")
    let gl_top = Image("glitch-top")
    let gl_bottom = Image("glitch-bottom")
    var rs = [Shape]()
    
    override public func setup() {
        canvas.backgroundColor = black
        
        setupImage()
        setupTimer()
    }
    
    func glitch(image: Image) {
        var glitchNum = Double(arc4random_uniform(60))
        glitchNum = map(glitchNum, from: 0...40, to: -20...20)
        
        if abs(glitchNum) < 25 {
            return
        }
        
        image.center.x += glitchNum

        wait (0.1) {
            image.center.x -= glitchNum
        }
        
    }
    
    func setupImage() {
        gl_mid?.width = canvas.width + 2.9
        gl_mid?.height *= 1.9
        gl_mid?.center = canvas.center
        gl_mid?.width -= 2
        
        gl_top?.width = canvas.width
        gl_top?.height *= 1.9
        gl_top?.center = canvas.center
        gl_top?.center.y -= gl_top!.height/2.0 + gl_mid!.height/2.0 - 45
        
        gl_bottom?.width = canvas.width
        gl_bottom?.height *= 1.9
        gl_bottom?.center = canvas.center
        gl_bottom?.center.y += gl_top!.height/2.0 + gl_mid!.height/2.0 - 45
        
        canvas.add(gl_mid)
        canvas.add(gl_top)
        canvas.add(gl_bottom)
        gl_mid?.apply(Bloom())
        gl_top?.apply(Bloom())
        gl_bottom?.apply(Bloom())
    }
    
    func setupTimer() {
        //create a timer to run at 60fps
        let timer = Timer(interval: 0.25) {
            self.glitch(image: self.gl_top!)
            self.glitch(image: self.gl_mid!)
            self.glitch(image: self.gl_bottom!)
            self.generateRect()
        }
        timer.start()
    }
    
    func generateRect() {
        let x = random(in: 30..<200)
        let y = random(in: 30..<200)
        let centerX = Double(arc4random_uniform(UInt32(canvas.width)))
        let centerY = Double(arc4random_uniform(UInt32(canvas.height)))
        var opacity = random(in: 0.0..<1.0)
        if opacity < 0.8 { opacity = 0.0 }
        let shapes = [Point(), Point(x, 0), Point(x, y), Point(0, y), Point(0, 0)]
        let r = Polygon(shapes)
        r.center = Point(centerX, centerY)
        r.lineWidth = 5
        r.strokeColor = Color(red: 1.0, green: 1.0, blue: 1.0, alpha: opacity)
        r.fillColor = Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        canvas.add(r)
        
        wait (0.1) {
            r.removeFromSuperview()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
