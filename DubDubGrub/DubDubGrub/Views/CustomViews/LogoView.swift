//
//  LogoView.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/27/25.
//

import SwiftUI

struct LogoView: View {
    
    var frameWidth: CGFloat
    
    var body: some View {
        Image(.ddgMapLogo)
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth)
    }
}

#Preview {
    LogoView(frameWidth: 250)
}
