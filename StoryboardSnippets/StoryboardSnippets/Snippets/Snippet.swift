//
//  Snippet.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

struct Snippet: Codable, Equatable
{
    let id: String
    let title: String
    let subtitle: String
    let sourceFiles: [String]
    let assetImageName: String?
    let vcIdentifier: String
    
    static func == (lhs: Snippet, rhs: Snippet) -> Bool {
        return lhs.id == rhs.id
    }
}
