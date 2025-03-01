//
//  HapticManager.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 3/1/25.
//

import UIKit

struct HapticManager {
    
    static func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
