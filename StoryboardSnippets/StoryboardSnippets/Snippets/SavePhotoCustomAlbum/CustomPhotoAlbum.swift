//
//  CustomPhotoAlbum.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import Photos
import UIKit

class CustomPhotoAlbum: NSObject {
    static let albumName = "Elliott IO Snippets"
    static let sharedInstance = CustomPhotoAlbum()

    var assetCollection: PHAssetCollection!
    var assetCollectionError: Error?
    
    override init() {
        super.init()

        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }

        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                ()
            })
        }

        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            self.createAlbum()
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }

    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            // ideally this ensures the creation of the photo album even if authorization wasn't prompted till after init was done
            print("trying again to create the album")
            self.createAlbum()
        } else {
            print("should really prompt the user to let them know it's failed")
        }
    }

    func createAlbum() {
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)   // create an asset collection with the album name
        }) { success, error in
            if success {
                self.assetCollection = self.fetchAssetCollectionForAlbum()
            } else {
                self.assetCollectionError = error
                print("error \(String(describing: error))")
            }
        }
    }

    func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)

        if let _: AnyObject = collection.firstObject {
            return collection.firstObject
        }
        return nil
    }

    /// Saves image to custom album.
    ///
    /// ```
    /// Don't forget to set NSPhotoLibraryUsageDescription and NSPhotoLibraryAddUsageDescription in info.plist or you will receive a permissions error.
    /// ```
    ///
    /// - Warning: The returned string is not localized.
    /// - Parameter image: The image to saved.
    /// - Returns: A successful or not result Bool and optional Error in `completion`.
    func save(_ image: UIImage, completion: @escaping ((Bool, Error?) -> ())) {
        if assetCollection == nil {
            // if there was an error upstream, skip the save
            completion(false, assetCollectionError)
            return
        }

        PHPhotoLibrary.shared().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
            let enumeration: NSArray = [assetPlaceHolder!]
            albumChangeRequest!.addAssets(enumeration)

        }, completionHandler: { result, error in
            completion(result, error)
        })
    }
}
