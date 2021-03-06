//
//  PhotoCell.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var buttonSave: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set the border
        self.bgImageView.layer.cornerRadius = Styles.cornerRadius
        self.bgImageView.clipsToBounds = true
        self.borderView.layer.cornerRadius = Styles.cornerRadius
        self.borderView.layer.borderWidth = Styles.borderWidth
        self.borderView.layer.borderColor = Styles.borderColor
        self.borderView.clipsToBounds = true
        
        self.buttonSave.alpha = 0
        self.buttonSave.isUserInteractionEnabled = false
        self.buttonSave.layer.cornerRadius = Styles.buttonRadius
    }
    
    func set(_ image: UIImage) {
        self.blurView.alpha = 1
        self.bgImageView.image = image
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.alpha = 0
        }, completion: { result in
            // success
        })
    }
    
    func selected(_ selected: Bool) {
        if selected {
            borderView.layer.borderColor = Styles.borderColor_Selected
            borderView.layer.borderWidth = Styles.borderWidth_Selected
            animateSave(alpha: 1)
        } else {
            borderView.layer.borderColor = Styles.borderColor
            borderView.layer.borderWidth = Styles.borderWidth
            animateSave(alpha: 0)
        }
    }
    
    func animateSave(alpha: CGFloat) {
        UIView.animate(withDuration: AntimationDuration.fadeInOut.rawValue, animations: {
            self.buttonSave.alpha = alpha
        }, completion: { result in
            // success
            self.buttonSave.isUserInteractionEnabled = (alpha == 1) ? true : false
        })
    }
    
    @IBAction func save_TouchUpInside(_ sender: Any) {
        guard let vc = UIApplication.topViewController() else { return }
        if let image = self.bgImageView.image {
            CustomPhotoAlbum.sharedInstance.save(image, completion: { result, error in
                if let e = error {
                    // show error
                    print(e)
                    switch (e) {
                    case CustomPhotoAlbumError.unauthorized:
                        vc.showAlert(title: "Access Error", message: "Swift Snippets doesn't have access to your Photos to save anything.\n\nPlease change this in the Settings app by scrolling down to Swift Snippets and changing the Photos setting to All Photos.", actionName: "Close", headerImage: image)
                    default:
                        vc.showAlert(title: "Error", message: e.localizedDescription, actionName: "Close", headerImage: image)
                    }
                    return
                }
                // save successful, inform user
                vc.showAlert(title: "Success", message: "Photo saved to custom album named: \(CustomPhotoAlbum.albumName)", actionName: "Nice", headerImage: image)
            })
        }
    }
}
