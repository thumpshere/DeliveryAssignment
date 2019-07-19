//
//  DetailViewController.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 05/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController, MKMapViewDelegate {
  var mapView = MKMapView()
  let scrollView = UIScrollView()
  let scrollContentView = UIView()
  let deliveryDetailView = UIView()
  var viewModel: DeliveryDetailViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.createUI() // implemented in extension of this class named DeliveryDetailExtension
  }
  
}
