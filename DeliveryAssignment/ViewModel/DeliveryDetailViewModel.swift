//
//  DetailViewModel.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 05/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

class DeliveryDetailViewModel: NSObject {
  var deliveryDataObject: DeliveryObject?
  let regionRadius: CLLocationDistance = 1000
  
  init(delivery: DeliveryObject) {
    self.deliveryDataObject = delivery
  }
  
  func configureMapView(mapView: MKMapView) -> MKMapView {
    let initialLocation = CLLocationCoordinate2D(latitude: deliveryDataObject?.location?.lat ?? 0, longitude: deliveryDataObject?.location?.lng ?? 0)
    return self.centerMapOnLocation(location: initialLocation, mapView: mapView)
  }
  
  func centerMapOnLocation(location: CLLocationCoordinate2D, mapView: MKMapView) -> MKMapView {
    let coordinateRegion = MKCoordinateRegion(center: location,
                                              latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
    let location = MKPointAnnotation()
    location.title = deliveryDataObject?.location?.address
    location.coordinate = CLLocationCoordinate2D(latitude: deliveryDataObject?.location?.lat ?? 0, longitude: deliveryDataObject?.location?.lng ?? 0)
    mapView.addAnnotation(location)
    return mapView
  }
}
