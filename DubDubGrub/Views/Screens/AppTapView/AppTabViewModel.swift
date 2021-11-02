//
//  AppTabViewModel.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 01.11.21.
//

import CoreLocation
import SwiftUI

extension AppTabView {
    final class AppTabViewModel: ObservableObject {
        @Published var isShowingOnboardView = false
        
        @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
            didSet {
                isShowingOnboardView = hasSeenOnboardView
            }
        }
        let kHasSeenOnboardView = "hasSeenOnboardView"
        
        func checkIfHasSeenObboard() {
            if !hasSeenOnboardView { hasSeenOnboardView = true }
        }
    }
}

