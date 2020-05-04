//
//  MapModel.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 04/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import MapKit

class MapModel: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  
  init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
  }
}
