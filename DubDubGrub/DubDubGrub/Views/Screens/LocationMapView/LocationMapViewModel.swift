//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/26/25.
//

import CloudKit
import MapKit
import SwiftUI

@MainActor
final class LocationMapViewModel: NSObject, ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: Int] = [:]
    @Published var isShowingDetailView = false
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054),
                                               span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    let deviceLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        deviceLocationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        deviceLocationManager.requestLocation()
    }
    
    func getLocations(for locationManager: LocationManager) {
        Task {
            do {
                locationManager.locations = try await CloudKitManager.shared.getLocations()
            } catch {
                alertItem = AlertContext.unableToGetLocations
            }
        }
    }
    
    func getCheckedInCounts() {
        Task {
            do {
                checkedInProfiles = try await CloudKitManager.shared.getCheckedInProfilesCount()
            } catch {
                alertItem = AlertContext.checkedInCount
            }
        }
    }
}

extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        withAnimation {
            region = MKCoordinateRegion(center: currentLocation.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Did Fail With Error")
    }
}
