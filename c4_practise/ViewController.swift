//
//  ViewController.swift
//  c4_practise
//
//  Created by 村上航輔 on 2019/09/30.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

import UIKit
import C4

public class  ViewController: CanvasController {
    // MARK: - Variable
    var player: AudioPlayer!
    
    //create tuples for storing paths
    var maxPaths = (Path(), Path())
    var avgPaths = (Path(), Path())
    
    var maxTransparentPaths = (Path(), Path())
    var avgTransparentPaths = (Path(), Path())
    
    var maxTransparent2Paths = (Path(), Path())
    var avgTransparent2Paths = (Path(), Path())
    
    //create tuples for storing shapes to represent the paths
    var maxShapes = (Shape(), Shape())
    var avgShapes = (Shape(), Shape())
    
    var maxTransparentShapes = (Shape(), Shape())
    var avgTransparentShapes = (Shape(), Shape())
    
    var maxTransparent2Shapes = (Shape(), Shape())
    var avgTransparent2Shapes = (Shape(), Shape())
    
    
    //the current angle for drawing
    var Θ = 0.0
    
    //store the max values for peak and average for the sample
    //we will use these to normalize the metered values
    var maxPeak = (30.981050491333, 31.1506500244141)
    var avgPeak = (63.9939880371094, 63.8977127075195)
    
    var animCount = 0
    
    // MARK: - Setup
    override public func setup() {
        canvas.backgroundColor = Color(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        setupShapes()
        setupPlayer()
        setupTimer()
        
        backgroundShape()
        backgroundShape2()
        mofing()
    }
    
    // MARK: - Shape
    func styleShape(shape: Shape) {
        shape.lineWidth = 0.5
        shape.fillColor = clear
        shape.strokeColor = Color(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)
    }
    
    func styleTransparentShape(shape: Shape) {
        shape.lineWidth = 8.0
        shape.fillColor = clear
        shape.strokeColor = Color(red: 0.2, green: 0.5, blue: 0.9, alpha: 0.05)
    }
    
    func styleTransparent2Shape(shape: Shape) {
        shape.lineWidth = 15.0
        shape.fillColor = clear
        shape.strokeColor = Color(red: 0.2, green: 0.5, blue: 0.9, alpha: 0.02)
    }
    
    func backgroundShape() {
        var waves: [Point] = []
        waves.append(Point())
        for i in 0...500 {
            waves.append(Point(i, Int(sin(Double(i)/180.0 * Double.pi)*50)))
        }
        let polygon = Polygon(waves)
        polygon.center = canvas.center
        polygon.lineWidth = 0.5
        polygon.strokeColor = Color(red: 0.2, green: 0.9, blue: 0.5, alpha: 0.6)
        canvas.add(polygon)
        
        var waves2: [Point] = []
        waves2.append(Point())
        for i in 0...500 {
            waves2.append(Point(i, Int(sin(Double(i)/180.0 * Double.pi)*50)))
        }
        let polygon2 = Polygon(waves2)
        polygon2.center = canvas.center
        polygon2.lineWidth = 6.0
        polygon2.strokeColor = Color(red: 0.2, green: 0.9, blue: 0.5, alpha: 0.1)
        canvas.add(polygon2)
        
        var waves3: [Point] = []
        waves3.append(Point())
        for i in 0...500 {
            waves3.append(Point(i, Int(sin(Double(i)/180.0 * Double.pi)*50)))
        }
        let polygon3 = Polygon(waves3)
        polygon3.center = canvas.center
        polygon3.lineWidth = 12.0
        polygon3.strokeColor = Color(red: 0.2, green: 0.9, blue: 0.5, alpha: 0.05)
        canvas.add(polygon3)
        
        let a = ViewAnimation(duration: 5.0) {
            polygon.strokeStart = 1.0
        }
        
        a.repeats = true
        a.autoreverses = true
        
        let b = ViewAnimation(duration: 5.0) {
            polygon2.strokeStart = 1.0
        }
        
        b.repeats = true
        b.autoreverses = true
        
        let c = ViewAnimation(duration: 5.0) {
            polygon3.strokeStart = 1.0
        }
        
        c.repeats = true
        c.autoreverses = true
        
        let grp = ViewAnimationGroup(animations: [a, b, c])
        grp.animate()
    }
    
    func backgroundShape2() {
        var waves: [Point] = []
        waves.append(Point())
        for i in 0...500 {
            waves.append(Point(i, Int(sin(Double(i)/180.0 * Double.pi + sin(Double(i)/180.0 * Double.pi + cos(Double(i)/180.0 * Double.pi)))*60)))
        }
        let polygon = Polygon(waves)
        polygon.center = canvas.center
        polygon.lineWidth = 0.5
        polygon.strokeColor = Color(red: 0.86, green: 0.62, blue: 0.92, alpha: 0.6)
        canvas.add(polygon)
        
        var waves2: [Point] = []
        waves2.append(Point())
        for i in 0...500 {
            waves2.append(Point(i, Int(sin(Double(i)/180.0 * Double.pi + sin(Double(i)/180.0 * Double.pi + cos(Double(i)/180.0 * Double.pi)))*60)))
        }
        let polygon2 = Polygon(waves2)
        polygon2.center = canvas.center
        polygon2.lineWidth = 6.0
        polygon2.strokeColor = Color(red: 0.86, green: 0.62, blue: 0.92, alpha: 0.1)
        canvas.add(polygon2)
        
        var waves3: [Point] = []
        waves3.append(Point())
        for i in 0...500 {
            waves3.append(Point(i, Int(sin(Double(i)/180.0 * Double.pi + sin(Double(i)/180.0 * Double.pi + cos(Double(i)/180.0 * Double.pi)))*60)))
        }
        let polygon3 = Polygon(waves3)
        polygon3.center = canvas.center
        polygon3.lineWidth = 12.0
        polygon3.strokeColor = Color(red: 0.86, green: 0.62, blue: 0.92, alpha: 0.05)
        canvas.add(polygon3)
        
        let a = ViewAnimation(duration: 7.0) {
            polygon.strokeEnd = 0.0
        }
        
        a.repeats = true
        a.autoreverses = true
        
        let b = ViewAnimation(duration: 7.0) {
            polygon2.strokeEnd = 0.0
        }
        
        b.repeats = true
        b.autoreverses = true
        
        let c = ViewAnimation(duration: 7.0) {
            polygon3.strokeEnd = 0.0
        }
        
        c.repeats = true
        c.autoreverses = true
        
        let grp = ViewAnimationGroup(animations: [a, b, c])
        grp.animate()
    }
    
    func setupShapes() {
        //set the paths for each shape
        maxShapes.0.path = maxPaths.0
        maxShapes.1.path = maxPaths.1
        
        maxTransparentShapes.0.path = maxTransparentPaths.0
        maxTransparentShapes.1.path = maxTransparentPaths.1
        
        maxTransparent2Shapes.0.path = maxTransparent2Paths.0
        maxTransparent2Shapes.1.path = maxTransparent2Paths.1
        
        avgShapes.0.path = avgPaths.0
        avgShapes.1.path = avgPaths.1
        
        avgTransparentShapes.0.path = avgTransparentPaths.0
        avgTransparentShapes.1.path = avgTransparentPaths.1
        
        avgTransparent2Shapes.0.path = avgTransparent2Paths.0
        avgTransparent2Shapes.1.path = avgTransparent2Paths.1
        
        
        //style all the shapes
        styleShape(shape: maxShapes.0)
        styleShape(shape: maxShapes.1)
        styleShape(shape: avgShapes.0)
        styleShape(shape: avgShapes.1)
        
        styleTransparentShape(shape: maxTransparentShapes.0)
        styleTransparentShape(shape: maxTransparentShapes.1)
        styleTransparentShape(shape: avgTransparentShapes.0)
        styleTransparentShape(shape: avgTransparentShapes.1)
        
        styleTransparent2Shape(shape: maxTransparent2Shapes.0)
        styleTransparent2Shape(shape: maxTransparent2Shapes.1)
        styleTransparent2Shape(shape: avgTransparent2Shapes.0)
        styleTransparent2Shape(shape: avgTransparent2Shapes.1)
        
        //add them all the the canvas
        canvas.add(maxShapes.0)
        canvas.add(maxShapes.1)
        canvas.add(avgShapes.0)
        canvas.add(avgShapes.1)
        
        canvas.add(maxTransparentShapes.0)
        canvas.add(maxTransparentShapes.1)
        canvas.add(avgTransparentShapes.0)
        canvas.add(avgTransparentShapes.1)
        
        canvas.add(maxTransparent2Shapes.0)
        canvas.add(maxTransparent2Shapes.1)
        canvas.add(avgTransparent2Shapes.0)
        canvas.add(avgTransparent2Shapes.1)
        
        //rotate the 2nd, 3rd, and 4th shapes
        maxShapes.1.transform.rotate(.pi)
        avgShapes.0.transform.rotate(.pi / 2)
        avgShapes.1.transform.rotate(.pi / 2 * 3)
        
        maxTransparentShapes.1.transform.rotate(.pi)
        avgTransparentShapes.0.transform.rotate(.pi / 2)
        avgTransparentShapes.1.transform.rotate(.pi / 2 * 3)
        
        maxTransparent2Shapes.1.transform.rotate(.pi)
        avgTransparent2Shapes.0.transform.rotate(.pi / 2)
        avgTransparent2Shapes.1.transform.rotate(.pi / 2 * 3)
    }
    
    func updateShapes() {
        //set the path for each shape, and recenter it
        maxShapes.0.path = maxPaths.0
        maxShapes.0.center = canvas.center
        
        maxShapes.1.path = maxPaths.1
        maxShapes.1.center = canvas.center
        
        avgShapes.0.path = avgPaths.0
        avgShapes.0.center = canvas.center
        
        avgShapes.1.path = avgPaths.1
        avgShapes.1.center = canvas.center
        
        maxTransparentShapes.0.path = maxTransparentPaths.0
        maxTransparentShapes.0.center = canvas.center
        
        maxTransparentShapes.1.path = maxTransparentPaths.1
        maxTransparentShapes.1.center = canvas.center
        
        avgTransparentShapes.0.path = avgTransparentPaths.0
        avgTransparentShapes.0.center = canvas.center
        
        avgTransparentShapes.1.path = avgTransparentPaths.1
        avgTransparentShapes.1.center = canvas.center
        
        maxTransparent2Shapes.0.path = maxTransparent2Paths.0
        maxTransparent2Shapes.0.center = canvas.center
        
        maxTransparent2Shapes.1.path = maxTransparent2Paths.1
        maxTransparent2Shapes.1.center = canvas.center
        
        avgTransparent2Shapes.0.path = avgTransparent2Paths.0
        avgTransparent2Shapes.0.center = canvas.center
        
        avgTransparent2Shapes.1.path = avgTransparent2Paths.1
        avgTransparent2Shapes.1.center = canvas.center
        
        maxShapes.1.transform.rotate(.pi)
        avgShapes.0.transform.rotate(.pi / 2)
        avgShapes.1.transform.rotate(.pi / 2 * 3)
        
        maxTransparentShapes.1.transform.rotate(.pi)
        avgTransparentShapes.0.transform.rotate(.pi / 2)
        avgTransparentShapes.1.transform.rotate(.pi / 2 * 3)
        
        maxTransparent2Shapes.1.transform.rotate(.pi)
        avgTransparent2Shapes.0.transform.rotate(.pi / 2)
        avgTransparent2Shapes.1.transform.rotate(.pi / 2 * 3)
    }
    
    func resetPaths() {
        maxPaths = (Path(), Path())
        avgPaths = (Path(), Path())
        
        maxTransparentPaths = (Path(), Path())
        avgTransparentPaths = (Path(), Path())
        
        maxTransparent2Paths = (Path(), Path())
        avgTransparent2Paths = (Path(), Path())
    }
    
    func generateNextPoints() {
        //generates new points for each path
        let max0 = normalize(val: player.peakPower(0), max: maxPeak.0)
        maxPaths.0.addLineToPoint(generatePoint(radius: max0))
        
        let max1 = normalize(val: player.peakPower(1), max: maxPeak.1)
        maxPaths.1.addLineToPoint(generatePoint(radius: max1))
        
        let avg0 = normalize(val: player.averagePower(0), max: avgPeak.0)
        avgPaths.0.addLineToPoint(generatePoint(radius: avg0))
        
        let avg1 = normalize(val: player.averagePower(1), max: avgPeak.1)
        avgPaths.1.addLineToPoint(generatePoint(radius: avg1))
        
        
        let maxTransparent0 = normalize(val: player.peakPower(0), max: maxPeak.0)
        maxTransparentPaths.0.addLineToPoint(generatePoint(radius: maxTransparent0))
        
        let maxTransparent1 = normalize(val: player.peakPower(1), max: maxPeak.1)
        maxTransparentPaths.1.addLineToPoint(generatePoint(radius: maxTransparent1))
        
        let avgTransparent0 = normalize(val: player.averagePower(0), max: avgPeak.0)
        avgTransparentPaths.0.addLineToPoint(generatePoint(radius: avgTransparent0))
        
        let avgTransparent1 = normalize(val: player.averagePower(1), max: avgPeak.1)
        avgTransparentPaths.1.addLineToPoint(generatePoint(radius: avgTransparent1))
        
        
        let maxTransparent20 = normalize(val: player.peakPower(0), max: maxPeak.0)
        maxTransparent2Paths.0.addLineToPoint(generatePoint(radius: maxTransparent20))
        
        let maxTransparent21 = normalize(val: player.peakPower(1), max: maxPeak.1)
        maxTransparent2Paths.1.addLineToPoint(generatePoint(radius: maxTransparent21))
        
        let avgTransparent20 = normalize(val: player.averagePower(0), max: avgPeak.0)
        avgTransparent2Paths.0.addLineToPoint(generatePoint(radius: avgTransparent20))
        
        let avgTransparent21 = normalize(val: player.averagePower(1), max: avgPeak.1)
        avgTransparent2Paths.1.addLineToPoint(generatePoint(radius: avgTransparent21))
        
        //increments the current angle
        Θ += .pi / 180.0
        
        //resets the paths for each full rotation
        if Θ >= 2 * .pi {
            Θ = 0.0
            resetPaths()
        }
    }
    
    // MARK: - Player
    func setupPlayer() {
        player = AudioPlayer("media.io_BlackVelvet.mp3")
        player?.meteringEnabled = true //needs to be on
        player?.loops = true
        player?.play()
    }
    
    func generatePoint(radius: Double) -> Point {
        return Point(radius * cos(Θ), radius * sin(Θ))
    }
    
    func normalize(val: Double, max: Double) -> Double {
        //Normalizes an incoming value based on a provided max
        var normMax = abs(val)
        //gives us a value between 0 and 1
        normMax /= max
        //map the value so that the shape doesn't overlap with the logo
        return map(normMax, from: 0...1, to: 100...200)
    }
    
    func setupTimer() {
        //create a timer to run at 60fps
        let timer = Timer(interval: 1.0/60.0) {
            self.player.updateMeters()
            self.generateNextPoints()
            self.updateShapes()
        }
        timer.start()
    }
    
    func mofing() {
        let c = Circle(center: canvas.center, radius: 20)
        c.strokeColor = Color(red: 1.0, green: 0, blue: 0, alpha: 0.0)
        c.fillColor = Color(red: 1.0, green: 0, blue: 0, alpha: 0.0)
        
        
        let r = Rectangle(frame: Rect(0, 0, canvas.width, canvas.height))
        r.center = canvas.center
        r.strokeColor = Color(red: 0, green: 0, blue: 0, alpha: 0)
        r.fillColor = Color(red: 0, green: 0, blue: 0, alpha: 0)
        canvas.add(r)
        
        let glImg = Image("glitch")!
        glImg.constrainsProportions = true
        glImg.width = 40
        glImg.center = canvas.center
        glImg.apply(Bloom())
        
        let avImg = Image("audioVisualizer")!
        avImg.constrainsProportions = true
        avImg.width = 40
        avImg.center = canvas.center
        avImg.apply(Bloom())
        
        let rAnimIn = ViewAnimation(duration: 0.5, animations: {
            r.fillColor = Color(red: 0, green: 0, blue: 0, alpha: 0.6)
        })
        
        let rAnimOut = ViewAnimation(duration: 0.5, animations: {
            r.fillColor = Color(red: 0, green: 0, blue: 0, alpha: 0.0)
        })
        
        let avImgAnimIn = ViewAnimation(duration: 0.5, animations: {
            avImg.width = 80
            avImg.center = self.canvas.center
        })
        
        let avImgAnimOut = ViewAnimation(duration: 0.5, animations: {
            avImg.width = 40
            avImg.center = self.canvas.center
        })
        let glImgAnimIn = ViewAnimation(duration: 0.5, animations: {
            glImg.width = 80
            glImg.center = self.canvas.center
            glImg.center.x +=  100
        })
        
        let glImgAnimOut = ViewAnimation(duration: 0.5, animations: {
            glImg.width = 40
            glImg.center = self.canvas.center
        })
        
        let glImgAnimChoice = ViewAnimation(duration: 0.5, animations: {
            glImg.width = 100
            glImg.center = self.canvas.center
            glImg.center.x +=  100
        })
        
        let glImgAnimNotChoice = ViewAnimation(duration: 0.5, animations: {
            glImg.width = 80
            glImg.center = self.canvas.center
            glImg.center.x +=  100
        })
                
        c.addLongPressGestureRecognizer { locations, center, state in
            let fingerPos = center.x+self.canvas.center.x/2+80
            print("locations: \(locations) center: \(fingerPos) glImg: \(glImg.center)")
            switch state {
                case .possible:
                    break
                case .began:
                    print("begin")
                    ViewAnimationGroup(animations: [rAnimIn, avImgAnimIn, glImgAnimIn]).animate()
                    break
                case .changed:
                    if glImg.center.x-40 < fingerPos &&  fingerPos < glImg.center.x+40 {
                        glImgAnimChoice.animate()
                    } else {
                        glImgAnimNotChoice.animate()
                    }
                    break
                case .ended:
                    print("end")
                    if glImg.center.x-40 < fingerPos &&  fingerPos < glImg.center.x+40 {
                        let glView = GlitchViewController()
                        self.dismiss(animated: false, completion: nil)
                        self.present(glView, animated: false, completion: nil)
                        ViewAnimationGroup(animations: [rAnimOut, avImgAnimOut, glImgAnimOut]).animate()
                    } else {
                        ViewAnimationGroup(animations: [rAnimOut, avImgAnimOut, glImgAnimOut]).animate()
                    }
                case .cancelled:
                    break
                case .failed:
                    break
                @unknown default:
                    break
            }
        }
        canvas.add(glImg)
        canvas.add(avImg)
        canvas.add(c)
    }
}




/*
 - 一つの画面で切り替え
 - シーン切り替え周りは、extensionを使って、ファイルをまとめて見やすく整理すると良い
 - 先に切り替えだけやっとくと良いかも
 - 操作がかなり直感的になるので、導線の要素を残すと良い（cosmosでいうと真ん中のまる、あるいはhelpボタン）
 */
