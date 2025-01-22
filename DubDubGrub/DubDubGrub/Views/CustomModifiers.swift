//
//  CustomModifiers.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/22/25.
//

import SwiftUI

struct ProfileNameText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
    }
}
