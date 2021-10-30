//
//  ProfileViewModel.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 30.10.21.
//

import Foundation
import CloudKit

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var companyName = ""
    @Published var bio = ""
    @Published var avatar = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var alertItem: AlertItem?
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    }
    
    func createProfilRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName] = firstName
        profileRecord[DDGProfile.kLastName] = lastName
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        return profileRecord
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        let profileRecord = createProfilRecord()
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            
            return
        }
        
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            switch result {
            case .success(_):
                
                break
            case .failure(_):
                
                break
            }
        }
    }
    
    func getProfile() {
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            
            return
        }
        
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
            
            return
        }
        
        let profileRecordID = profileReference.recordID
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let record):
                    
                    let profile = DDGProfile(record: record)
                    firstName = profile.firstName
                    lastName = profile.lastName
                    companyName = profile.companyName
                    bio = profile.bio
                    avatar = profile.createAvatarImage()
                    
                case .failure(_):
                    
                    break
                }
            }
        }
    }
}
