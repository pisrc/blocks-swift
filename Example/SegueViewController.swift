//
//  SegueViewController.swift
//  Blocks
//
//  Created by ryan on 10/21/16.
//  Copyright © 2016 pi. All rights reserved.
//

import UIKit
import Blocks

class SegueViewController: UIViewController {

    private var popupSegue: Segue!
    
    @IBAction func showModal(_ sender: AnyObject) {
        Segue(
            source: self,
            destination: { () -> UIViewController in
                return UIViewController.from(storyboard: "Main", identifier: "new")
            }) { () -> SegueStyle in
                return SegueStyle.presentModally(animated: true)
            }.perform()
    }
    
    @IBAction func showPopup(_ sender: Any) {
        popupSegue.perform()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupSegue = Segue(
            source: self,
            destination: { () -> UIViewController in
                let vc = UIViewController.from(storyboard: "Main", identifier: "new")
                return vc
            },
            style: { () -> SegueStyle in
                return SegueStyle.presentPopup(
                    sizeHandler: { (rect) -> CGSize in
                        print("sizeHandler is called!: \(rect)")
                        return CGSize(width: 270, height: 290)
                    },
                    originHandler: { (containerBounds, presentedSize, isShowKeyboard) -> CGPoint in
                        print("originHandler is called!: containerBounds: \(containerBounds), presentedSize: \(presentedSize), isShowKeyboard: \(isShowKeyboard)")
                        let y = { () -> CGFloat in
                            let centerOriginY = (containerBounds.height - presentedSize.height) / 2
                            if isShowKeyboard {
                                let marginWithKeyboard: CGFloat = 50.0
                                let newY = containerBounds.height - marginWithKeyboard - presentedSize.height
                                if 0 <= newY {
                                    return newY
                                } else {
                                    return centerOriginY
                                }
                            } else {
                                return centerOriginY
                            }
                        }()
                        let origin = CGPoint(
                            x: (containerBounds.width - presentedSize.width) / 2,
                            y: y)
                        return origin
                    },
                    dimmedColor: UIColor.brown)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
