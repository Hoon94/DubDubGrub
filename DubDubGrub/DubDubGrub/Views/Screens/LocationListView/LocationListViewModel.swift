//
//  LocationListViewModel.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 2/14/25.
//

import CloudKit
import Foundation

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
    
    func getCheckedInProfilesDictionary() {
        CloudKitManager.shared.getCheckedInProfilesDictionary { result in
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
