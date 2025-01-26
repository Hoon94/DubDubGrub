//
//  CKRecord+Ext.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/26/25.
//

import CloudKit

extension CKRecord {
    func convertToDDGLocation() -> DDGLocation { DDGLocation(record: self) }
    func convertToDDGProfile() -> DDGProfile { DDGProfile(record: self) }
}
