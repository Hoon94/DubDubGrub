//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/15/25.
//

import MapKit
import SwiftUI

struct LocationMapView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                MapAnnotation(coordinate: location.location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.75)) {
                    DDGAnnotation(location: location, 
                                  number: viewModel.checkedInProfiles[location.id, default: 0])
                        .accessibilityLabel(Text("Map Pin, \(location.name), \(viewModel.checkedInProfiles[location.id, default: 0]) people checked in."))
                        .onTapGesture {
                            locationManager.selectedLocation = location
                            viewModel.isShowingDetailView = true
                        }
                }
            }
            .tint(.grubRed)
            .ignoresSafeArea()
            
            VStack {
                LogoView(frameWidth: 125)
                    .shadow(radius: 10)
                    .accessibilityHidden(true)
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            if let location = locationManager.selectedLocation {
                NavigationView {
                    LocationDetailView(viewModel: LocationDetailViewModel(location: location))
                        .toolbar {
                            Button("Dismiss", action: { viewModel.isShowingDetailView = false })
                        }
                }
            }
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
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
