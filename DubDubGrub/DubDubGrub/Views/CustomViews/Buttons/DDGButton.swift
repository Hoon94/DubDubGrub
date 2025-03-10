//
//  DDGButton.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/22/25.
//

import SwiftUI

struct DDGButton: View {
    
    var title: String
    var color: Color = .brandPrimary
    
    var body: some View {
        Text(title)
            .bold()
            .frame(width: 280, height: 44)
            .background(color.gradient)
            .foregroundStyle(.white)
            .cornerRadius(8)
    }
}

#Preview("Light Mode") {
    DDGButton(title: "Test Button")
}

#Preview("Dark Mode") {
    DDGButton(title: "Test Button")
        .preferredColorScheme(.dark)
}

#Preview("Dark Landscape", traits: .landscapeRight) {
    DDGButton(title: "Test Button")
        .preferredColorScheme(.dark)
}
