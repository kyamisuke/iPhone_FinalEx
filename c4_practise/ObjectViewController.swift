//
//  ObjectViewController.swift
//  c4_practise
//
//  Created by 村上航輔 on 2019/10/07.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

import UIKit
import C4

public class ObjectViewController: CanvasController {

    var shapes = [Shape]()
    var bloomShapes = [Shape]()
    
    override public func setup() {
        canvas.backgroundColor = black
        var pt = Point(8, 8)
        
        repeat {
            repeat {
                let c = Circle(center: pt, radius: 0.5)
                // let d = distance(pt, rhs: canvas.center) / maxDistance
                let d = 0.5
                c.lineWidth = 0.0
                c.fillColor = Color(red: d, green: d, blue: d, alpha: 1.0)
                canvas.add(c)
                pt.x += 10.0
            } while pt.x < canvas.width
            pt.y += 10.0
            pt.x = 8.0
        } while pt.y < canvas.height
        
        canvas.addPanGestureRecognizer { locations, center, translation, velocity, state in
            ShapeLayer.disableActions = true
            let circle = Circle(center: center, radius: 60)
            circle.fillColor = Color(red: 0.14, green: 0.42, blue: 0.42, alpha: 0.0)
            circle.strokeColor = Color(red: 0.4, green: 0.8, blue: 0.7, alpha: 1.0)
            
            let bloomCircle = Circle(center: center, radius: 60)
            bloomCircle.lineWidth = 15
            bloomCircle.fillColor = Color(red: 0.14, green: 0.42, blue: 0.42, alpha: 0.0)
            bloomCircle.strokeColor = Color(red: 0.4, green: 0.8, blue: 0.7, alpha: 0.1)
            self.canvas.add(circle)
            self.canvas.add(bloomCircle)
            ShapeLayer.disableActions = false
            
            let a = ViewAnimation(duration: 0.5) {
                circle.opacity = 0.0
                circle.transform.scale(0.01, 0.01)
                bloomCircle.opacity = 0.0
                bloomCircle.transform.scale(0.01, 0.01)
            }
            a.addCompletionObserver {
                circle.removeFromSuperview()
                bloomCircle.removeFromSuperview()
            }
            a.curve = .linear
            a.animate()
        }
        
        canvas.addTapGestureRecognizer{ locations, center, state in
            ShapeLayer.disableActions = true
            self.shapes.removeAll()
            self.bloomShapes.removeAll()
            
            for _ in 0..<5 {
                let rect = Rectangle(frame: Rect(0, 0, 20, 20))
                rect.fillColor = Color(red: 0, green: 0, blue: 0, alpha: 0)
                rect.strokeColor = Color(red: 0.9, green: 0.2, blue: 0.35, alpha: 1)
                rect.center = center
                self.shapes.append(rect)
                self.canvas.add(rect)
                
                let bloomRect = Rectangle(frame: Rect(0, 0, 20, 20))
                bloomRect.fillColor = Color(red: 0, green: 0, blue: 0, alpha: 0)
                bloomRect.strokeColor = Color(red: 0.6, green: 0.1, blue: 0.2, alpha: 0.1)
                bloomRect.lineWidth = 5
                bloomRect.center = center
                self.bloomShapes.append(bloomRect)
                self.canvas.add(bloomRect)
            }
            
            
                self.initiateAnimations()
            
            
            ShapeLayer.disableActions = false
        }
    }
    
    func scale(shape: Shape, duration: Double) {
        //create the animation
        let a = ViewAnimation(duration: duration) {
            //rotate it halfway around a circle
            shape.transform.scale(50, 50)
            shape.opacity = 0
        }
        //when complete, initiate another rotation
        a.addCompletionObserver {
            shape.removeFromSuperview()
        }
        a.curve = .easeIn
        a.animate()
    }
    
    func initiateAnimations() {
        //offset the duration of each shape by the current index
        //shapes further away will take longer to rotate
        for i in 0..<shapes.count {
            
            let s = self.shapes[i]
            let bs = self.bloomShapes[i]
            self.scale(shape: s, duration: Double(i) * 0.05 + 0.05)
            self.scale(shape: bs, duration: Double(i) * 0.05 + 0.05)
            
        }
    }
    
    // MARK: - Mofing
    
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
            avImg.center.x += 100
        })
        
        let avImgAnimOut = ViewAnimation(duration: 0.5, animations: {
            avImg.width = 40
            avImg.center = self.canvas.center
            
        })
        let glImgAnimIn = ViewAnimation(duration: 0.5, animations: {
            glImg.width = 80
            glImg.center = self.canvas.center
        })
        
        let glImgAnimOut = ViewAnimation(duration: 0.5, animations: {
            glImg.width = 40
            glImg.center = self.canvas.center
        })
        
        let avImgAnimChoice = ViewAnimation(duration: 0.5, animations: {
            avImg.width = 100
            avImg.center = self.canvas.center
            avImg.center.x +=  100
        })
        
        let avImgAnimNotChoice = ViewAnimation(duration: 0.5, animations: {
            avImg.width = 80
            avImg.center = self.canvas.center
            avImg.center.x +=  100
        })
        
        //        canvas.addTapGestureRecognizer { (_, _, _) in
        //            if self.animCount == 0 {
        //                ViewAnimationGroup(animations: [rAnimIn, avImgAnimIn, glImgAnimIn]).animate()
        //            } else {
        //                ViewAnimationGroup(animations: [rAnimOut, avImgAnimOut, glImgAnimOut]).animate()
        //            }
        //            self.animCount += 1
        //            self.animCount %= 2
        //        }
        //
        //        glImg.addTapGestureRecognizer { (_, _, _) in
        //            let glView = GlitchViewController()
        //            glView.setup()
        //            print("tap: glImage")
        //        }
        
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
                if avImg.center.x-40 < fingerPos &&  fingerPos < avImg.center.x+40 {
                    avImgAnimChoice.animate()
                } else {
                    avImgAnimNotChoice.animate()
                }
                break
            case .ended:
                print("end")
                if avImg.center.x-40 < fingerPos &&  fingerPos < avImg.center.x+40 {
                    let avView = ViewController()
                    self.dismiss(animated: false, completion: nil)
                    self.present(avView, animated: false, completion: nil)
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
        canvas.add(avImg)
        canvas.add(glImg)
        canvas.add(c)
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
