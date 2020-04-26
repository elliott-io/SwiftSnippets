//
//  SnippetCell.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

class SnippetCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelSourceFiles: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!

    let cornerRadius: CGFloat = 30.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set the border
        self.bgImageView.layer.cornerRadius = self.cornerRadius
        self.blurView.layer.cornerRadius = self.cornerRadius
        self.blurView.layer.borderWidth = Styles.borderWidth
        self.blurView.layer.borderColor = Styles.borderColor
        self.blurView.clipsToBounds = true
    }
    
    func set(_ snippet: Snippet) {
        self.labelTitle.text = snippet.title
        self.labelSubtitle.text = snippet.subtitle
        self.labelSourceFiles.text = ""
        for file in snippet.sourceFiles {
            self.labelSourceFiles.text?.append("\(file)\r")
        }
        self.blurView.alpha = 1
        guard let imageName = snippet.assetImageName,
            let image = UIImage(named: imageName) else {
                let defaultImage = UIImage(named: "tile")!
                if self.bgImageView.image != defaultImage {
                    self.bgImageView.image = defaultImage
                }
                return }
        self.bgImageView.image = image
        UIView.animate(withDuration: 0.3, animations: {
            self.blurView.alpha = 0
        }, completion: { result in
            // success
        })
    }
}
