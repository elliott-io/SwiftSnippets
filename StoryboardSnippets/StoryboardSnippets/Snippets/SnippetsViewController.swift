//
//  CollectionViewController.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

class SnippetsViewController : UICollectionViewController {
    
    let cellId = "snippetCell"
    var snippets: [Snippet]!
    var cellSize = CGSize.init()
    var loggedIn = false
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.decelerationRate = .fast

        self.snippets = SnippetManager.shared.loadSnippets()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let snippet = snippets?[indexPath.row] else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if snippet.vcIdentifier == "nil" {
            guard let vc = UIApplication.topViewController() else { return }
            vc.showAlert(title: "Oops", message: "This snippet example hasn't been implemented yet.", actionName: "Close")
            return
        } else {
            let vc = storyboard.instantiateViewController(withIdentifier: snippet.vcIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return snippets?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SnippetCell,
            let snippet = snippets?[indexPath.row] else { return UICollectionViewCell.init() }
         
        cell.set(snippet)
        
        return cell
    }
}
