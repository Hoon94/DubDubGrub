//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/15/25.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName    = ""
    @State private var lastName     = ""
    @State private var companyName  = ""
    @State private var bio          = ""
    
    var body: some View {
        VStack {
            ZStack {
                Color(.secondarySystemBackground)
                    .frame(height: 130)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84)
                        
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.white)
                            .offset(y: 30)
                    }
                    .padding(.leading, 12)
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        
                        TextField("Company Name", text: $companyName)
                    }
                    .padding(.trailing, 16)
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Bio: ")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                +
                Text("\(100 - bio.count)")
                    .bold()
                    .font(.callout)
                    .foregroundStyle(bio.count <= 100 ? .brandPrimary : Color(.systemPink))
                +
                Text(" Characters Remain")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(.secondary, lineWidth: 1))
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Create Profile")
                    .bold()
                    .frame(width: 280, height: 44)
                    .background(.brandPrimary)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
