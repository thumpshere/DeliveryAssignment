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
class DetailViewController: UIViewController, MKMapViewDelegate {
  var mapView = MKMapView()
  
  var viewModel: DetailViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.createUI()
  }
  
  func createUI() {
    self.title = StringIdentifiers.deliveryDetailTitle
    self.view.backgroundColor = .white
    self.mapView = (self.viewModel?.configureMapView(mapView: self.mapView))!
    self.showDetailView()
  }
  
  func showDetailView() {
    let contentView = UIView()
    let img = UIImageView()
    let message = UILabel()
    img.backgroundColor = .red
    img.contentMode = .scaleAspectFill
    img.translatesAutoresizingMaskIntoConstraints = false
    message.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    message.font = UIFont.systemFont(ofSize: CellViewConstants.labelFontSize)
    message.numberOfLines = 0
    message.text = self.viewModel?.dataObject?.descriptionField
    contentView.layer.borderColor = UIColor.darkGray.cgColor
    contentView.layer.borderWidth = CellViewConstants.cellBorderWidth
    contentView.addSubview(img)
    contentView.addSubview(message)
    
    let scrollView = UIScrollView()
    let scrollContentView = UIView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollContentView.translatesAutoresizingMaskIntoConstraints = false
    mapView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    scrollContentView.addSubview(mapView)
    scrollContentView.addSubview(contentView)
    scrollView.addSubview(scrollContentView)
    self.view.addSubview(scrollView)
    
    let viewsDict = [
      "image": img,
      "message": message,
      "dataview": contentView,
      "scrollContentView": scrollContentView,
      "scrollView": scrollView,
      "map": mapView
    ]
    
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(80)]", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[message]-10-|", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-10-[message]-10-|", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[image(80)]", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[image(80)]", options: [], metrics: nil, views: viewsDict))
    
    let bottomSpaceToLabelConstraint = NSLayoutConstraint.init(item: contentView, attribute: .bottomMargin, relatedBy: .greaterThanOrEqual, toItem: img, attribute: .bottomMargin, multiplier: 1, constant: 10)
    contentView.addConstraint(bottomSpaceToLabelConstraint)
    
    img.layer.cornerRadius = CellViewConstants.imageCornerRadius
    img.layer.masksToBounds = true
    if let imgURL = self.viewModel?.dataObject?.imageUrl {
      img.sd_setImage(with: URL(string: imgURL), placeholderImage: nil, options: SDWebImageOptions.continueInBackground, context: nil)
    }
    
    let mapConst = NSLayoutConstraint.init(item: mapView, attribute: .topMargin, relatedBy: .equal, toItem: scrollContentView, attribute: .topMargin, multiplier: 1, constant: 0)
    let mapwidth =  NSLayoutConstraint.init(item: mapView, attribute: .width, relatedBy: .equal, toItem: scrollContentView, attribute: .width, multiplier: 1, constant: 0)
    scrollContentView.addConstraint(mapwidth)
    let mapHeight =  NSLayoutConstraint.init(item: mapView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: (ScreenDimensions.screenHeight-264))
    let viewtop =  NSLayoutConstraint.init(item: mapView, attribute: .bottomMargin, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1, constant: -20)
    let viewwidth =  NSLayoutConstraint.init(item: contentView, attribute: .width, relatedBy: .equal, toItem: mapView, attribute: .width, multiplier: 1, constant: -10)
    scrollContentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[dataview]-5-|", options: [], metrics: nil, views: viewsDict))
    let viewBottom =  NSLayoutConstraint.init(item: contentView, attribute: .bottomMargin, relatedBy: .equal, toItem: scrollContentView, attribute: .bottomMargin, multiplier: 1, constant: 10)
    
scrollContentView.addConstraints([mapConst, mapHeight, viewtop, viewwidth, viewBottom])
    
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollView]-0-|", options: [], metrics: nil, views: viewsDict))
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scrollView]-0-|", options: [], metrics: nil, views: viewsDict))
    scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollContentView]-0-|", options: [], metrics: nil, views: viewsDict))
    scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scrollContentView]-0-|", options: [], metrics: nil, views: viewsDict))
    scrollView.addConstraint(NSLayoutConstraint.init(item: scrollContentView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0))
    
    self.view.layoutIfNeeded()
  }
}
