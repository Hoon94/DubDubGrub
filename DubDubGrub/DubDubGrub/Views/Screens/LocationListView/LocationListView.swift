//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/15/25.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink(destination: LocationDetailView(viewModel: LocationDetailViewModel(location: location))) {
                        LocationCell(location: location, 
                                     profiles: viewModel.checkedInProfiles[location.id, default: []])
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
            .onAppear { viewModel.getCheckedInProfilesDictionary() }
        }
    }
}

#Preview {
    LocationListView()
        .environmentObject(LocationManager())
}
