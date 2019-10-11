//
//  MainViewController.swift
//  c4_practise
//
//  Created by 村上航輔 on 2019/10/07.
//  Copyright © 2019 kyamisuke. All rights reserved.
//

import UIKit
import C4

class MainViewController: CanvasController {
    var nc = [CanvasController]()
    var currentView = 0

    override func setup() {
        let avView = ViewController()
        let glView = GlitchViewController()
        let obView = ObjectViewController()
        
        nc.append(avView)
        nc.append(glView)
        nc.append(obView)
        nc[currentView].setup()
        
//        canvas.addTapGestureRecognizer{ locations, center, state in
//            
//        }
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

