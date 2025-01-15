//
//  AppTabView.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/15/25.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            LocationMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            
            LocationListView()
                .tabItem {
                    Label("Locations", systemImage: "building")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(.brandPrimary)
    }
}

#Preview {
    AppTabView()
}
