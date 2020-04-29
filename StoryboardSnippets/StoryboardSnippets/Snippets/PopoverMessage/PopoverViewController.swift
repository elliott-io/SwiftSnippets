//
//  AlwaysPresentAsPopover.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/26/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

class PopoverViewController: UIViewController {
    
    @IBOutlet weak var labelMessage: UILabel!
    var message:String?
    weak var sendingViewController: UIViewController?
    var arrowDirection: UIPopoverArrowDirection = .any

    let ltPadding: CGFloat = 20 // leading/trailing padding
    let tbPadding: CGFloat = 14 // top/bottom padding
    let arrowPadding: CGFloat = 13 // popover arrow padding
    let dimLevel: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let message = self.message {
            self.labelMessage.text = message
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)

        // dim sendingViewController
        UIView.animate(withDuration: AntimationDuration.fadeInOut.rawValue, animations: {
            self.sendingViewController?.view.alpha = self.dimLevel
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("arrowDirection: \(arrowDirection)")

        let item: UIView = self.labelMessage
        
        guard let superview = item.superview else { return }

        // all constaints must be set for a proper display

        // set centered constraincts
        item.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        item.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true

        // iOS grows view if there is an arrow, so adjust anchors to fix offset
        if arrowDirection.rawValue == 2 { //.down {
            item.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: ltPadding).isActive = true
            item.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: ltPadding).isActive = true
            item.topAnchor.constraint(equalTo: superview.topAnchor, constant: tbPadding).isActive = true
            item.bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor, constant: tbPadding + arrowPadding).isActive = true
            item.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -(ltPadding * 2)).isActive = true
            item.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: -(tbPadding * 2) - arrowPadding).isActive = true
        } else if arrowDirection.rawValue == 1 { //.up {
            item.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: ltPadding).isActive = true
            item.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: ltPadding).isActive = true
            item.topAnchor.constraint(equalTo: superview.topAnchor, constant: tbPadding + arrowPadding).isActive = true
            item.bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor, constant: tbPadding).isActive = true
            item.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -(ltPadding * 2)).isActive = true
            item.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: -(tbPadding * 2) - arrowPadding).isActive = true
        } else if arrowDirection.rawValue == 4 { //.left {
            item.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: ltPadding + arrowPadding).isActive = true
            item.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: ltPadding).isActive = true
            item.topAnchor.constraint(equalTo: superview.topAnchor, constant: tbPadding).isActive = true
            item.bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor, constant: tbPadding).isActive = true
            item.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -(ltPadding * 2) - arrowPadding).isActive = true
            item.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: -(tbPadding * 2)).isActive = true
        } else if arrowDirection.rawValue == 8 { //.right {
            item.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: ltPadding).isActive = true
            item.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: ltPadding + arrowPadding).isActive = true
            item.topAnchor.constraint(equalTo: superview.topAnchor, constant: tbPadding).isActive = true
            item.bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor, constant: tbPadding).isActive = true
            item.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -(ltPadding * 2) - arrowPadding).isActive = true
            item.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: -(tbPadding * 2)).isActive = true
        } else {
            // center if no arrows
            item.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: ltPadding).isActive = true
            item.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: ltPadding).isActive = true
            item.topAnchor.constraint(equalTo: superview.topAnchor, constant: tbPadding).isActive = true
            item.bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor, constant: tbPadding).isActive = true
            item.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -(ltPadding * 2)).isActive = true
            item.heightAnchor.constraint(equalTo: superview.heightAnchor, constant: -(tbPadding * 2)).isActive = true
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIViewController.existingPopover = nil

        // restore dimmed sendingViewController
        UIView.animate(withDuration: AntimationDuration.fadeInOut.rawValue, animations: {
            self.sendingViewController?.view.alpha = 1
        })
    }
}
