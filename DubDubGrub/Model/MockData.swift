//
//  MockData.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 29.10.21.
//

import CloudKit

struct MockData {
    static var location: CKRecord {
        let record = CKRecord(recordType: "DDGLocation")
        record[DDGLocation.kName] = "Sean's Bar and Grill"
        record[DDGLocation.kAddress] = "123 Main Street"
        record[DDGLocation.kDescription] = "This is a description. Isn't it awesome. Not sure how long it to test the 3 lines."
        record[DDGLocation.kWebsiteURL] = "https://seanallen.com"
        record[DDGLocation.kLocation] = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber] = "+49 171 3198538"
        
        return record
    }
}
