//
//  DetailViewController.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 05/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

class DeliveryDetailViewController: UIViewController, MKMapViewDelegate {
  var mapView = MKMapView()
  let scrollView = UIScrollView()
  let scrollContentView = UIView()
  let deliveryDetailView = UIView()
  var viewModel: DeliveryDetailViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.createUI()
  }
}

extension DeliveryDetailViewController {
  
  func createUI() {
    self.title = LocalizedKeys.deliveryDetailTitle
    self.view.backgroundColor = UIColor.white
    self.mapView = (self.viewModel?.configureMapView(mapView: self.mapView))!
    self.showDetailView()
  }
  
  func showDetailView() {
    
    let img = UIImageView()
    let message = UILabel()
    img.backgroundColor = UIColor.red
    img.contentMode = .scaleAspectFill
    img.translatesAutoresizingMaskIntoConstraints = false
    message.translatesAutoresizingMaskIntoConstraints = false
    deliveryDetailView.translatesAutoresizingMaskIntoConstraints = false
    message.font = UIFont.systemFont(ofSize: TableViewConstants.labelFontSize)
    message.numberOfLines = 0
    message.text = (self.viewModel?.deliveryDataObject?.descriptionField ?? "") + LocalizedKeys.appendedStringAt + (self.viewModel?.deliveryDataObject?.location?.address ?? "")
    deliveryDetailView.layer.borderColor = UIColor.darkGray.cgColor
    deliveryDetailView.layer.borderWidth = TableViewConstants.cellBorderWidth
    deliveryDetailView.addSubview(img)
    deliveryDetailView.addSubview(message)
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollContentView.translatesAutoresizingMaskIntoConstraints = false
    mapView.translatesAutoresizingMaskIntoConstraints = false
    deliveryDetailView.translatesAutoresizingMaskIntoConstraints = false
    
    scrollContentView.addSubview(mapView)
    scrollContentView.addSubview(deliveryDetailView)
    scrollView.addSubview(scrollContentView)
    self.view.addSubview(scrollView)
    
    let viewsDict = [
      "image": img,
      "message": message,
      "dataview": deliveryDetailView,
      "scrollContentView": scrollContentView,
      "scrollView": scrollView,
      "map": mapView
    ]
    
    deliveryDetailView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(80)]", options: [], metrics: nil, views: viewsDict))
    deliveryDetailView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[message]-10-|", options: [], metrics: nil, views: viewsDict))
    deliveryDetailView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-10-[message]-10-|", options: [], metrics: nil, views: viewsDict))
    deliveryDetailView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[image(80)]", options: [], metrics: nil, views: viewsDict))
    deliveryDetailView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[image(80)]", options: [], metrics: nil, views: viewsDict))
    
    let bottomSpaceToLabelConstraint = NSLayoutConstraint.init(item: deliveryDetailView, attribute: .bottomMargin, relatedBy: .greaterThanOrEqual, toItem: img, attribute: .bottomMargin, multiplier: 1, constant: 10)
    deliveryDetailView.addConstraint(bottomSpaceToLabelConstraint)
    
    img.layer.cornerRadius = TableViewConstants.imageCornerRadius
    img.layer.masksToBounds = true
    if let imgURL = self.viewModel?.deliveryDataObject?.imageUrl {
      img.sd_setImage(with: URL(string: imgURL), placeholderImage: nil, options: SDWebImageOptions.continueInBackground, context: nil)
    }
    self.setConstraintsForMapAndDeliveryDetail(viewDictionary: viewsDict)
    self.setConstraintsForScrollView(viewDictionary: viewsDict)
    self.view.layoutIfNeeded()
  }
  
  func setConstraintsForMapAndDeliveryDetail(viewDictionary: [String: Any]) {
    
    let mapConst = NSLayoutConstraint.init(item: mapView, attribute: .topMargin, relatedBy: .equal, toItem: scrollContentView, attribute: .topMargin, multiplier: 1, constant: 0)
    let mapwidth =  NSLayoutConstraint.init(item: mapView, attribute: .width, relatedBy: .equal, toItem: scrollContentView, attribute: .width, multiplier: 1, constant: 0)
    scrollContentView.addConstraint(mapwidth)
    let mapHeight =  NSLayoutConstraint.init(item: mapView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: (ScreenDimensions.screenHeight-264))
    let viewtop =  NSLayoutConstraint.init(item: mapView, attribute: .bottomMargin, relatedBy: .equal, toItem: deliveryDetailView, attribute: .topMargin, multiplier: 1, constant: -20)
    let viewwidth =  NSLayoutConstraint.init(item: deliveryDetailView, attribute: .width, relatedBy: .equal, toItem: mapView, attribute: .width, multiplier: 1, constant: -10)
    scrollContentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[dataview]-5-|", options: [], metrics: nil, views: viewDictionary))
    let viewBottom =  NSLayoutConstraint.init(item: deliveryDetailView, attribute: .bottomMargin, relatedBy: .equal, toItem: scrollContentView, attribute: .bottomMargin, multiplier: 1, constant: 10)
    
    scrollContentView.addConstraints([mapConst, mapHeight, viewtop, viewwidth, viewBottom])
    
  }
  
  func setConstraintsForScrollView(viewDictionary: [String: Any]) {
    
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollView]-0-|", options: [], metrics: nil, views: viewDictionary))
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scrollView]-0-|", options: [], metrics: nil, views: viewDictionary))
    scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollContentView]-0-|", options: [], metrics: nil, views: viewDictionary))
    scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scrollContentView]-0-|", options: [], metrics: nil, views: viewDictionary))
    scrollView.addConstraint(NSLayoutConstraint.init(item: scrollContentView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0))
    
  }
  
}
