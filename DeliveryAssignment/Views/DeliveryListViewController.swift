//
//  ListViewController.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 03/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import PKHUD
import Crashlytics
class DeliveryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
  
  let viewModel = DeliveryListViewModel()
  var deliveriesTable = UITableView()
  var refreshControl = UIRefreshControl()
  var noDataLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.handleCallBacksFromViewModel()
    self.createUI()
  }
  
  // MARK: UI  CONFIGURATION METHODS
  func createUI () {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationController?.isNavigationBarHidden = false
    self.view.backgroundColor = .white
    self.title = LocalizedKeys.deliveryListTitle
    PKHUD.sharedHUD.contentView = PKHUDProgressView()
    self.configureTableView()
    self.viewModel.dataStoreKey = Constants.cachedObjectKey
    self.viewModel.getDataFromCache(keyString: Constants.cachedObjectKey)
    self.reloadTable()
  }
  
  func setConstraintsOnTableView() {
    let viewsDict = [
      "table": deliveriesTable
    ]
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[table]-0-|", options: [], metrics: nil, views: viewsDict as [String: Any]))
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[table]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: viewsDict as [String: Any]))
    
  }
  
  func getSpinnerViewForTable() -> UIActivityIndicatorView {
    let spinner = UIActivityIndicatorView(style: .gray)
    spinner.startAnimating()
    spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: ScreenDimensions.screenWidth, height: CGFloat(40))
    return spinner
  }
  
  func configureTableView() {
    noDataLabel.textColor = .red
    self.noDataLabel.textAlignment = .center
    self.noDataLabel.text = LocalizedKeys.noDataLabelText
    self.noDataLabel.isHidden = true
    self.deliveriesTable.backgroundView = noDataLabel
    deliveriesTable.dataSource = self
    deliveriesTable.delegate = self
    self.deliveriesTable.rowHeight = UITableView.automaticDimension
    self.deliveriesTable.estimatedRowHeight = 80
    self.deliveriesTable.separatorStyle = .none
    self.deliveriesTable.register(DeliveryTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.deliveryListCell)
    refreshControl.attributedTitle = NSAttributedString(string: LocalizedKeys.refreshDataMessage)
    refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    deliveriesTable.refreshControl = refreshControl
    self.deliveriesTable.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.deliveriesTable)
    self.setConstraintsOnTableView()
  }
  
  // MARK: TABLEVIEW DATASOURCE FUNCTIONS
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.deliveries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let listCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.deliveryListCell) as! DeliveryTableViewCell
    listCell.selectionStyle = .none
    let modelObject = self.viewModel.getModelForIndex(index: indexPath.row)
    listCell.setData(model: modelObject)
    return listCell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  // MARK: TABLEVIEW DELEGATE FUNCTIONS
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailVC = DeliveryDetailViewController()
    detailVC.viewModel = self.viewModel.getViewModelForIndex(index: indexPath.row)
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  
  // MARK: SCROLLVIEW DELEGATE FUNCTIONS
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {    
    if self.viewModel.isAtBottomOfScrollView(scrollView: scrollView) {
      //reach bottom
      self.deliveriesTable.tableFooterView = self.getSpinnerViewForTable()
      self.viewModel.loadMoreDataForTable(table: deliveriesTable)
      self.deliveriesTable.tableFooterView?.isHidden = false
      print("scrolled at bottom")
    }
  }
  
  // MARK: Refresh data Handler
  @objc func refresh() {
    // refresh all Data
    self.viewModel.refreshData()
  }
  
  // MARK: ViewModel Callback Handler
  func handleCallBacksFromViewModel() {
    
    self.viewModel.dataLoadingSuccess = {[weak self] () -> Void in
      self?.noDataLabel.isHidden = true
      self?.stopAllActivities()
      self?.reloadTable()
    }
    
    self.viewModel.dataLoadingError = { [weak self] () -> Void in
      self?.stopAllActivities()
    }
    
    self.viewModel.emptyData = { [weak self] () -> Void in
      self?.noDataLabel.isHidden = false
    }
    
    self.viewModel.showLoader = { () -> Void in
      PKHUD.sharedHUD.show()
    }
    
    self.viewModel.showAlert = { (message) -> Void in
      AssignmentHelper.showAlert(title: LocalizedKeys.messageHeading, message: message, success: { () in
        self.deliveriesTable.reloadData()
      })
    }
  }
  
  func stopAllActivities() {
    DispatchQueue.main.async {
      self.refreshControl.endRefreshing()
      self.deliveriesTable.tableFooterView?.isHidden = true
      PKHUD.sharedHUD.hide()
    }
  }
  
  func reloadTable() {
    DispatchQueue.main.async {
      self.deliveriesTable.reloadData()
    }
  }
  
}
