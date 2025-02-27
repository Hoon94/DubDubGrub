//
//  AppTabViewModel.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 2/16/25.
//

import CoreLocation
import Foundation
import SwiftUI

final class AppTabViewModel: NSObject, ObservableObject {
    
    @Published var isShowingOnboardView = false
    @Published var alertItem: AlertItem?
    @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
        didSet { isShowingOnboardView = hasSeenOnboardView }
    }
    
    var deviceLocationManager: CLLocationManager?
//    let kHasSeenOnboardView = "hasSeenOnboardView"
    
//    var hasSeenOnboardView: Bool {
//        return UserDefaults.standard.bool(forKey: kHasSeenOnboardView)
//    }
    
    func runStartupChecks() {
        if hasSeenOnboardView == false {
//            isShowingOnboardView = true
//            UserDefaults.standard.set(true, forKey: kHasSeenOnboardView)
            hasSeenOnboardView = true
        } else {
            checkIfLocationServicesIsEnabled()
        }
    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
            deviceLocationManager?.delegate = self
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }
    
    private func checkLocationAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }
        
        switch deviceLocationManager.authorizationStatus {
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
}

extension AppTabViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
