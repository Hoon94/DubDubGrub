//
//  AppTabViewModel.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 2/16/25.
//

import Foundation
import SwiftUI

final class AppTabViewModel: ObservableObject {
    
    @Published var isShowingOnboardView = false
    @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
        didSet { isShowingOnboardView = hasSeenOnboardView }
    }
    
    func checkIfHasSeenOnboard() {
        if hasSeenOnboardView == false {
            hasSeenOnboardView = true
        }
    }
}
