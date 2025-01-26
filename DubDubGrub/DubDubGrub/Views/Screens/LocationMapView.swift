//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/15/25.
//

import MapKit
import SwiftUI

struct LocationMapView: View {
    
    @State private var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            Map(position: $position)
                .ignoresSafeArea()
            
            VStack {
                LogoView()
                    .shadow(radius: 10)
                
                Spacer()
            }
        }
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .onAppear {
            CloudKitManager.getLocations { result in
                switch result {
                case .success(let locations):
                    print(locations)
                case .failure(_):
                    alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
}

#Preview {
    LocationMapView()
}

struct LogoView: View {
    var body: some View {
        Image(.ddgMapLogo)
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}
