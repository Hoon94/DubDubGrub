//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/16/25.
//

import SwiftUI

struct LocationDetailView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Image(.defaultBannerAsset)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                
                HStack {
                    Label("123 Main Street", systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("This is a test description. This is a test description. This is a test description. This is a test description. This is a test description.")
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .padding(.horizontal)
                
                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                    
                    HStack(spacing: 20) {
                        Button {
                            
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                        }
                        
                        Link(destination: URL(string: "https://www.apple.com")!, label: {
                            LocationActionButton(color: .brandPrimary, imageName: "network")
                        })
                        
                        Button {
                            
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                        }
                        
                        Button {
                            
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "person.fill.checkmark")
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Location Name")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LocationDetailView()
}

struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(color)
                .frame(width: 60, height: 60)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 22, height: 22)
        }
    }
}
