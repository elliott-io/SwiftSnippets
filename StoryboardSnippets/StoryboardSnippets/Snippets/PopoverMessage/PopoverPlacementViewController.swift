//
//  PopoverPlacementViewController.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/26/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

class PopoverPlacementViewController: UIViewController {
    
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var buttonReset: UIButton!
    @IBOutlet weak var buttonScope: UIButton!
    @IBOutlet weak var buttonLeft: UIButton!

    override func viewDidLoad() {
        self.buttonReset.layer.cornerRadius = Styles.buttonRadius
        self.buttonScope.layer.cornerRadius = Styles.buttonRadius
        self.buttonLeft.layer.cornerRadius = Styles.buttonRadius
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        self.showPopover(message: "Select any icon in the segmented control.", sourceView: segments.subviews[1], sourceRect: segments.subviews[1].bounds, arrowDirection: .down, passthroughViews: [segments])
        
        segments.addTarget(self, action: #selector(segments_ValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segments_ValueChanged(_ sender: UISegmentedControl) {
        self.showPopover(message: "Tap to reset selection. As you can see here, popovers resize automatically based on the size of the message.", sourceView: self.buttonReset, sourceRect: self.buttonReset.bounds, arrowDirection: .right, passthroughViews: [self.buttonReset])
    }
    
    @IBAction func reset_TouchUpInside(_ sender: Any) {
        self.segments.selectedSegmentIndex = -1

        self.showPopover(message: "Choose any icon.", sourceView: segments.subviews[1], sourceRect: segments.subviews[1].bounds, arrowDirection: .up, passthroughViews: [segments])
    }
    
    @IBAction func scope_TouchUpInside(_ sender: Any) {
        self.showPopover(message: "The scope button displays a popover centered within the view controller without arrows.", sourceView: self.view, sourceRect: self.view.bounds)
    }

    @IBAction func left_TouchUpInside(_ sender: Any) {
        self.showPopover(message: "The left hand pointing button displays this popover with a left arrow.", sourceView: self.buttonLeft, sourceRect: self.buttonLeft.bounds, arrowDirection: .left, passthroughViews: [buttonLeft])
    }

}
