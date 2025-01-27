//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Daehoon Lee on 1/27/25.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
