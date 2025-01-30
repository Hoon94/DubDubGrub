//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/22/25.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
