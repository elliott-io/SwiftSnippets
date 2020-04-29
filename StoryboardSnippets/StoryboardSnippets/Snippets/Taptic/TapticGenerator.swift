//
//  TapticGenerator.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/28/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation
import UIKit

class TapticGenerator {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    static func selectionChanged() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
