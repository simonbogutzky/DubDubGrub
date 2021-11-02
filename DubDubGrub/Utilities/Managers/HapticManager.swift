//
//  HapticManager.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 02.11.21.
//

import UIKit

struct HapticManager {
    
    static func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
