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
}
