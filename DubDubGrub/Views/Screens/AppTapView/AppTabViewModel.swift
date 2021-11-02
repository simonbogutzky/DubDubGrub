//
//  AppTabViewModel.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 01.11.21.
//

import CoreLocation
import SwiftUI

extension AppTabView {
    final class AppTabViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        @Published var alertItem: AlertItem?
        @Published var isShowingOnboardView = false
        @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
            didSet {
                isShowingOnboardView = hasSeenOnboardView
            }
        }
        
        var deviceLocationManager: CLLocationManager?
        let kHasSeenOnboardView = "hasSeenOnboardView"
        
        
        func runStartupChecks() {
            if !hasSeenOnboardView {
                hasSeenOnboardView = true
            } else {
                checkIfLocationServicesIsEnabled()
            }
        }
        
        
        func checkIfLocationServicesIsEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                deviceLocationManager = CLLocationManager()
                deviceLocationManager!.delegate = self
            } else {
                alertItem = AlertContext.locationDisabled
            }
        }
        
        
        private func checkLocationAuthorization() {
            guard let deviceLocationManager = deviceLocationManager else {
                return
            }
            switch deviceLocationManager.authorizationStatus {
                
            case .notDetermined:
                deviceLocationManager.requestWhenInUseAuthorization()
            case .restricted:
                alertItem = AlertContext.locationRestricted
                break
            case .denied:
                alertItem = AlertContext.locationDenied
                break
            case .authorizedAlways, .authorizedWhenInUse:
                break
            @unknown default:
                break
            }
        }
        
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
    }
}

