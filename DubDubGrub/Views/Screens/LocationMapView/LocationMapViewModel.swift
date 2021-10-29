//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 29.10.21.
//

import Foundation
import MapKit

final class LocationMapViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var locations: [DDGLocation] = []
    
    func getLocations() {
        CloudKitManager.getLocations { [self] result in
            switch result {
                
            case .success( let locations):
                print("\(locations)")
            case .failure(_):
                alertItem = AlertContext.unableToGetLocations
            }
        }
    }
}
