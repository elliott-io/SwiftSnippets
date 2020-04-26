//
//  GalleryViewController.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

class GalleryViewController : UICollectionViewController {
    
    let cellId = "photoCell"
    let assets = ["goodVibesOnly", // https://www.instagram.com/p/Bji3MLiAP3r/
        "charredTree", // https://www.instagram.com/p/Bj5TJvvF9ZO/
        "elCapitan", // https://www.instagram.com/p/Bo3S28mHgF5/
        "tunnel2ndSt", // https://www.instagram.com/p/Bir4CY_FxAs/
        "tagYoureIt", // https://www.instagram.com/p/BiI5h4BFbrt/
        "unionStation", // https://www.instagram.com/p/BiYMOJEF-0N/
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.decelerationRate = .fast
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("photo selected at row \(indexPath.row)")
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            cell.selected(true)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("photo selected at row \(indexPath.row)")
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            cell.selected(false)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let assetName = assets[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotoCell,
            let image = UIImage(named: assetName) else {
                return PhotoCell.init() }
        
        cell.set(image)
        
        return cell
    }
}
