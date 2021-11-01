//
//  LocationListViewModel.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 01.11.21.
//

import Foundation
import CloudKit

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
    
    func getCheckedInProfilesDictionary() {
        CloudKitManager.shared.getCheckedInProfileDictionary { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let checkedInProfiles):
                    self.checkedInProfiles = checkedInProfiles
                case .failure(_):
                   print("Error getting back dictionary")
                }
            }
        }
    }
    
    func createVoiceOverSummary(for location: DDGLocation) -> String {
        let count = checkedInProfiles[location.id, default: []].count
        let personPlurality = count == 1 ? "person" : "people"
        
        return "\(location.name) \(count) \(personPlurality) checked in."
    }
}
