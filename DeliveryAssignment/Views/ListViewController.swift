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
class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let viewModel = ListViewModel()
  var listTable = UITableView()
  var refreshControl = UIRefreshControl()
  var noDataLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.handleCallBacksFromViewModel()
    self.createUI()
    // Do any additional setup after loading the view.
  }
  
  // MARK: CREATE UI METHODS
  func createUI () {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationController?.isNavigationBarHidden = false
    self.view.backgroundColor = .white
    self.title = StringIdentifiers.deliveryListTitle
    PKHUD.sharedHUD.contentView = PKHUDProgressView()
    self.configureTableView()
    self.viewModel.dataStoreKey = Constants.cachedObjectKey
    self.viewModel.getDataFromCache(keyString: Constants.cachedObjectKey)
    self.reloadTable()
  }
  
  func setConstraintsOnTableView() {
    let viewsDict = [
      "table": listTable,
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
    self.noDataLabel.text = "No Data Found"
    self.noDataLabel.isHidden = true
    self.listTable.backgroundView = noDataLabel
    listTable.dataSource = self
    listTable.delegate = self
    self.listTable.rowHeight = UITableView.automaticDimension
    self.listTable.estimatedRowHeight = 80
    self.listTable.separatorStyle = .none
    self.listTable.register(DeliveryTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.deliveryListCell)
    refreshControl.attributedTitle = NSAttributedString(string: StringIdentifiers.refreshDataMessage)
    refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    listTable.addSubview(refreshControl)
    self.listTable.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.listTable)
    self.setConstraintsOnTableView()
  }
  
  // MARK: TABLEVIEW DATASOURCE FUNCTIONS
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.dataModelArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let listCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.deliveryListCell) as! DeliveryTableViewCell
    let modelObject = self.viewModel.getModelForIndex(index: indexPath.row)
    listCell.setData(model: modelObject)
    return listCell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  // MARK: TABLEVIEW DELEGATE FUNCTIONS
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    detailVC.viewModel = self.viewModel.getViewModelForIndex(index: indexPath.row)
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if  self.viewModel.isLastCellOfTableView(tableView: tableView, indexPath: indexPath) {
      self.listTable.tableFooterView = self.getSpinnerViewForTable()
      self.viewModel.loadMoreDataForTable(table: listTable)
      self.listTable.tableFooterView?.isHidden = false
    }
  }
  
  @objc func refresh() {
    // refresh all Data
    self.viewModel.refreshData()
  }
  
  func handleCallBacksFromViewModel() {
    
    self.viewModel.dataLoadingSuccess = {[weak self] () -> Void in
      self?.refreshControl.endRefreshing()
      self?.reloadTable()
      PKHUD.sharedHUD.hide()
    }
    
    self.viewModel.dataLoadingError = { [weak self] () -> Void in
      self?.refreshControl.endRefreshing()
      PKHUD.sharedHUD.hide()
    }
    
    self.viewModel.emptyData = { [weak self] () -> Void in
      self?.noDataLabel.isHidden = false
    }
    
    self.viewModel.showLoader = { () -> Void in
      PKHUD.sharedHUD.show()
    }
    
  }
  func reloadTable() {
    DispatchQueue.main.async {
      self.listTable.reloadData()
    }
  }
  
}
