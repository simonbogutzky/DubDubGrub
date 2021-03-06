//
//  DubDubGrubApp.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 28.10.21.
//

import SwiftUI

@main
struct DubDubGrubApp: App {
    var body: some Scene {
        
        let locationManager = LocationManager()
        
        WindowGroup {
            AppTabView()
                .environmentObject(locationManager)
        }
    }
}
