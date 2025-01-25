//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/22/25.
//

import SwiftUI

struct LocationCell: View {
    
    var location: DDGLocation
    
    var body: some View {
        HStack {
            Image(.defaultSquareAsset)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                HStack {
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    Group {
        LocationCell(location: DDGLocation(record: MockData.location))
            .previewLayout(.sizeThatFits)
            .padding()
        
        LocationListView().preferredColorScheme(.dark)
    }
}
