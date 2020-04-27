//
//  Styles.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

class Styles {
    static let borderColor: CGColor = UIColor.tertiarySystemBackground.cgColor
    static let borderColor_Selected: CGColor = UIColor.systemIndigo.cgColor
    static let borderWidth: CGFloat = 2
    static let borderWidth_Selected: CGFloat = 4
    static let cornerRadius: CGFloat = 30.0
    static let buttonRadius: CGFloat = 15.0
    static let thumbnailRadius: CGFloat = 4.0
}

enum AntimationDuration: TimeInterval {
    case fadeInOut = 0.2
}
