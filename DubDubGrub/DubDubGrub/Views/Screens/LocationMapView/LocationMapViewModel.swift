//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/26/25.
//

import CloudKit
import MapKit
import Observation
import SwiftUI

@Observable
final class LocationMapViewModel: NSObject {
    
    var checkedInProfiles: [CKRecord.ID: Int] = [:]
    var isShowingDetailView = false
    var alertItem: AlertItem?
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054),
                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    let deviceLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        deviceLocationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        deviceLocationManager.requestLocation()
    }
    
    @MainActor
    func getLocations(for locationManager: LocationManager) {
        Task {
            do {
                locationManager.locations = try await CloudKitManager.shared.getLocations()
            } catch {
                alertItem = AlertContext.unableToGetLocations
            }
        }
    }
    
    @MainActor
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
