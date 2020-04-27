![Swift Snippets Icon](/StoryboardSnippets/StoryboardSnippets/Assets.xcassets/AppIcon.appiconset/120.png)

# Swift Snippets

A collection of Swift snippets implemented in actual projects. 

When you run the app you will see a list of snippets, tapping one will navigate to another ViewController with an example implementation of the snippet.


# Storyboard Snippets

This project contains snippet implementations in an Xcode project that uses storyboards for UI. Built in Swift 5 for iOS 13.2.

## How to Use

Launching the project will display the [SnippetsViewController](/StoryboardSnippets/StoryboardSnippets/Snippets/SnippetViewController.swift). 

On viewDidLoad, [SnippetManager](/StoryboardSnippets/StoryboardSnippets/Snippets/SnippetManager.swift) reads the local [snippet.json](/StoryboardSnippets/StoryboardSnippets/Snippets/snippets.json) file and converts the data into an array of [Snippets](/StoryboardSnippets/StoryboardSnippets/Snippets/Snippet.swift). 

This Snippet array is displayed as custom [SnippetCell](/StoryboardSnippets/StoryboardSnippets/Snippets/SnippetCell.swift)'s. Tapping a SnippetCell will navigate to an example of any given snippet.

Source files related to a snippet are located in [Snippets](/StoryboardSnippets/StoryboardSnippets/Snippets/) within an appropriate subdirectory, such as [SavePhotoCustomAlbum](/StoryboardSnippets/StoryboardSnippets/Snippets/SavePhotoCustomAlbum/). UI independent source files are displayed as a list the Snippet.

> Extensions.swift and Styles.swift are referenced throughout this project and are located under [Helpers](/StoryboardSnippets/StoryboardSnippets/Helpers/). More information in their own sections below.

## Save Photo to Custom Album

Selecting this [snippet](/StoryboardSnippets/StoryboardSnippets/Snippets/SavePhotoCustomAlbum/), you will see a [GalleryViewController](/StoryboardSnippets/StoryboardSnippets/Snippets/SavePhotoCustomAlbum/GalleryViewController.swift) titled **Asset Gallery** displaying some images embedded in Assets.xcassets as custom [PhotoCell](/StoryboardSnippets/StoryboardSnippets/Snippets/SavePhotoCustomAlbum/PhotoCell.swift)'s. 

Each PhotoCell's image fades in as they are loaded using CoreAnimation.

Selecting a photo in this **Asset Gallery** will display a save button and highlight the PhotoCell. 

Tapping the save button will save the image to a custom album declared as **albumName** in [CustomPhotoAlbum.swift](/StoryboardSnippets/StoryboardSnippets/Snippets/SavePhotoCustomAlbum/CustomPhotoAlbum.swift). 

Once saved, you will see an alert with a small thumbnail of the image in the alert header.

> **ProTip:** If you copy these source files into another project, make sure you add entries to your info.plist for **NSPhotoLibraryUsageDescription** and **NSPhotoLibraryAddUsageDescription**.


# Extensions
Several extensions were written in [Extensions.swift](/StoryboardSnippets/StoryboardSnippets/Helpers/Extensions.swift) to help facilitate common functions that are used across snippets.

## UICollectionViewFlowLayout - targetContentOffset
Short swipes scroll cell-by-cell in a collection view. Long swipes will scroll multiple items.

## UIApplication - topViewController
Returns the top UIViewController in the app heirarchy. Useful for presenting alerts from any source file.

## UIViewController - showAlert
Displays an alert on any view controller with parameters for title, message, action name (which will appear on the alert button), and an optional image in corner of the header. 

# Styles
Light and Dark themes are supported using storyboard theming and a global [Styles.swift](/StoryboardSnippets/StoryboardSnippets/Helpers/Styles.swift) for consistency.

# Swift UI Snippets
Coming soon...


# Licensing

All code is free to be used personally or commercially under the [MIT License](/LICENSE).


# Support This Project
If you've found this useful, consider buying me a coffee. 

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/W7W81NIP9)

