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
    var isShowingLookAround = false
    var alertItem: AlertItem?
    var route: MKRoute?
    
    var cameraPosition = MapCameraPosition.region(.init(center: CLLocationCoordinate2D(latitude: 37.331516,
                                                                                       longitude: -121.891054),
                                                        latitudinalMeters: 1200,
                                                        longitudinalMeters: 1200))
    
    var lookAroundScene: MKLookAroundScene? {
        didSet {
            if let _ = lookAroundScene {
                isShowingLookAround = true
            }
        }
    }
    
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
    
    @MainActor
    func getLookAroundScene(for location: DDGLocation) {
        Task {
            let request = MKLookAroundSceneRequest(coordinate: location.location.coordinate)
            lookAroundScene = try? await request.scene
        }
    }
    
    @MainActor
    func getDirections(to location: DDGLocation) {
        guard let userLocation = deviceLocationManager.location?.coordinate else { return }
        
        let destination = location.location.coordinate
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: userLocation))
        request.destination = MKMapItem(placemark: .init(coordinate: destination))
        request.transportType = .walking
        
        Task {
            let directions = try? await MKDirections(request: request).calculate()
            route = directions?.routes.first
        }
    }
}

extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        withAnimation {
            cameraPosition = .region(.init(center: currentLocation.coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Did Fail With Error")
    }
}
