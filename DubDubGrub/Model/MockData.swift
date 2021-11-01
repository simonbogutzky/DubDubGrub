//
//  MockData.swift
//  DubDubGrub
//
//  Created by Simon Bogutzky on 29.10.21.
//

import CloudKit

struct MockData {
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName] = "Sean's Bar and Grill"
        record[DDGLocation.kAddress] = "123 Main Street"
        record[DDGLocation.kDescription] = "This is a description. Isn't it awesome. Not sure how long it to test the 3 lines."
        record[DDGLocation.kWebsiteURL] = "https://seanallen.com"
        record[DDGLocation.kLocation] = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber] = "+49 171 3198538"
        
        return record
    }
    
    static var chipotle: CKRecord {
            let record                          = CKRecord(recordType: RecordType.location,
                                                           recordID: CKRecord.ID(recordName:
                                                                                    "BC0E8503-44DE-DD9C-C749-2D6C33D68E98"))
            record[DDGLocation.kName]           = "Chipotle"
            record[DDGLocation.kAddress]        = "1 S Market St Ste 40"
            record[DDGLocation.kDescription]    = "Our local San Jose One South Market Chipotle Mexican Grill is cultivating a better world by serving responsibly sourced, classically-cooked, real food."
            record[DDGLocation.kWebsiteURL]     = "https://locations.chipotle.com/ca/san-jose/1-s-market-st"
            record[DDGLocation.kLocation]       = CLLocation(latitude: 37.334967, longitude: -121.892566)
            record[DDGLocation.kPhoneNumber]    = "408-938-0919"
            
            return record
        }
    
    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName] = "Test"
        record[DDGProfile.kLastName] = "User"
        record[DDGProfile.kCompanyName] = "Best Company Ever"
        record[DDGProfile.kBio] = "This is my bio, I hope it's not too long I can't check character count."
        
        return record
    }
}
