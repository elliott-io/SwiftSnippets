//
//  Extensions.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }

        // Page height used for estimating and calculating paging.
        let pageHeight = self.itemSize.height + self.minimumLineSpacing

        // Make an estimation of the current page position.
        let approximatePage = collectionView.contentOffset.y/pageHeight

        // Determine the current page based on velocity.
        let currentPage = velocity.y == 0 ? round(approximatePage) : (velocity.y < 0.0 ? floor(approximatePage) : ceil(approximatePage))

        // Create custom flickVelocity.
        let flickVelocity = velocity.y * 0.4

        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)

        let newVerticalOffset = ((currentPage + flickedPages) * pageHeight) - collectionView.contentInset.top

        // give haptic feedback based on how many cells are scrolls
        if abs(flickedPages) > 1 {
            TapticGenerator.notification(.success)
        } else {
            TapticGenerator.impact(.medium)
        }

        return CGPoint(x: proposedContentOffset.x, y: newVerticalOffset - collectionView.safeAreaInsets.top)
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows[0].rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UIViewController {
    static var existingPopover: PopoverViewController?
    
    func showPopover(message: String, sourceView: UIView, sourceRect: CGRect, arrowDirection: UIPopoverArrowDirection = [], passthroughViews: [UIView]? = []) {
        DispatchQueue.main.async {
            
            // init view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "popover") as! PopoverViewController
            controller.message = message
            controller.sendingViewController = self
            controller.arrowDirection = arrowDirection
            
            // set preferred size
            let margins = CGPoint(x: 20, y: 14)
            let textSize = message.size(width: 220)
            let adjustedSize = CGSize(width: textSize.width + (margins.x * 2), height: textSize.height + (margins.y * 2))
            controller.preferredContentSize = adjustedSize

            // create view controller as popover style presentation instead of a normal view controller
            let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
            presentationController.sourceView = sourceView
            presentationController.sourceRect = sourceRect
            presentationController.permittedArrowDirections = arrowDirection
            
            // passthroughViews are views that can be tapped without dismissing the popover
            if let views = passthroughViews {
                presentationController.passthroughViews = views
            }
                                    
            // if there is an existing presenting view controller, dismiss it before presenting this popover
            if let existing = UIViewController.existingPopover {
                existing.dismiss(animated: true, completion: {
                    self.present(controller, animated: true, completion: {
                        UIViewController.existingPopover = controller
                    })
                })
            } else {
                self.present(controller, animated: true, completion: {
                    UIViewController.existingPopover = controller
                })
            }
        }
    }

    func showAlert(title: String, message: String, actionName: String, headerImage: UIImage? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: actionName, style: .default, handler: nil)
            if let image = headerImage {
                let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
                imageView.image = image
                imageView.layer.cornerRadius = Styles.thumbnailRadius
                imageView.clipsToBounds = true
                alertController.view.addSubview(imageView)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension String {
    func size(width:CGFloat = 220.0, font: UIFont = UIFont.systemFont(ofSize: 17.0, weight: .regular)) -> CGSize {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        
        return CGSize(width: label.frame.width, height: label.frame.height)
    }
}
