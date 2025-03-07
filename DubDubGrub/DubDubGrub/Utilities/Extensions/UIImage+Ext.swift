//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/31/25.
//

import CloudKit
import UIKit

extension UIImage {
    
    func convertToCKAsset() -> CKAsset? {
        
        // Get our apps base document directory url
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document Directory url came back nil.")
            return nil
        }
        
        // Append some unique identifier for our profile image
        let fileUrl = urlPath.appendingPathComponent("selectedAvatarImage")
        
        // Compress image data
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        
        do {
            // Write the image data to the location the address points to
            try imageData.write(to: fileUrl)
            // Create our CKAsset with that fileURL
            return CKAsset(fileURL: fileUrl)
        } catch {
            return nil
        }
    }
}
