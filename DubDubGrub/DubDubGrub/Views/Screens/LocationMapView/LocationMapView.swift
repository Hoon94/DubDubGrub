//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/15/25.
//

import CoreLocationUI
import MapKit
import SwiftUI

struct LocationMapView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                MapAnnotation(coordinate: location.location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.75)) {
                    DDGAnnotation(location: location, number: viewModel.checkedInProfiles[location.id, default: 0])
                        .onTapGesture {
                            locationManager.selectedLocation = location
                            viewModel.isShowingDetailView = true
                        }
                }
            }
            .tint(.grubRed)
            .ignoresSafeArea()
            
            LogoView(frameWidth: 125)
                .shadow(radius: 10)
                .accessibilityHidden(true)
        }
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            if let location = locationManager.selectedLocation {
                NavigationStack {
                    LocationDetailView(viewModel: LocationDetailViewModel(location: location))
                        .toolbar {
                            Button("Dismiss", action: { viewModel.isShowingDetailView = false })
                        }
                }
            }
        }
        .overlay(alignment: .bottomLeading) {
            LocationButton(.currentLocation) {
                viewModel.requestAllowOnceLocationPermission()
            }
            .foregroundStyle(.white)
            .symbolVariant(.fill)
            .tint(.grubRed)
            .labelStyle(.iconOnly)
            .clipShape(Circle())
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 0))
        }
        .alert(item: $viewModel.alertItem, content: { $0.alert })
        .onAppear {
            if locationManager.locations.isEmpty { viewModel.getLocations(for: locationManager) }
            
            viewModel.getCheckedInCounts()
        }
    }
}

#Preview {
    LocationMapView()
        .environmentObject(LocationManager())
}
