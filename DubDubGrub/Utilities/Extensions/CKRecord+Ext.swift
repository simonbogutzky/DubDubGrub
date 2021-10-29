//
//  CKRecord+Ext.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 29.10.21.
//


import CloudKit

extension CKRecord {
    func convertToDDGLocation() -> DDGLocation {
        DDGLocation(record: self)
    }
    
    func convertToDDGProfile() -> DDGProfile {
        DDGProfile(record: self)
    }
}
