//
//  ViewController.swift
//  AutoLayoutFunS1
//
//  Created by Drew Bies on 10/7/20.
//

import UIKit

// MARK: - Auto Layout
// so far, we have been hardcoding the postioning of our views
// a view is defined by a rectangle
// this rectangle has lots of properties (attributes)
// origin: the upper left hand corner and its used to position the view in its super view (container view)
// size: the width and the height of the view
// point: is a relative unit of measurment
// the number of pixels in a point is dependent on the screen
// demo 1:
// auto layout will determine the size and position and runtime based on the size of the screen
// constraint: a relationship between views that can be determined at runtime
// 4 constraints
// position: x and y constraint (horizontal and vertical)
// size: width and height constraint
// views have implicit width and height based on their content
//

// so far when we have used stack views, we have set the distribution to "fill equally"
// what if we want one view to take up more space than another view?
// 2 ways to do this
// 1. specify the content hugging priority (CHP) and compression resistance priority (CRP)
// suppose we have two views, and we want one to fill available space (if there is any) and the other to "hug" its intrinsic content size
// CHP: this is like a rubber band around a view's content
// the higher the CHP, the more likely the view will hug its content (e.g. keep its intrinsic content size)
// CRP: the higher the CRP the more likely the view will "resist" getting smaller

// task: create a 3x3 grid of buttons that equally share the height and the width of the screen

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton){
        // how do i find out which button was pressed/
        // 2 ways:
        // 1. use the tag property of UIView
        print("button pressed from #\(sender.tag)")
        // 2. use an outlet collection
        //if let senderIndex = 
    }

}

