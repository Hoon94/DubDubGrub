//
//  XDismissButton.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/27/25.
//

import SwiftUI

struct XDismissButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(.brandPrimary)
            
            Image(systemName: "xmark")
                .foregroundStyle(.white)
                .imageScale(.small)
                .frame(width: 44, height: 44)
        }
    }
}

#Preview {
    XDismissButton()
}
