//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 29.10.21.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
