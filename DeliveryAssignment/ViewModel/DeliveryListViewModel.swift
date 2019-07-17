//
//  ListViewModel.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 03/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import Cache
class DeliveryListViewModel: NSObject {
  
  var apiRequestManager: APIManagerProtocol = ApiManager()
  var refresh:(() -> Void)?
  var emptyData:(() -> Void)?
  var dataLoadingSuccess:(() -> Void)?
  var dataLoadingError:(() -> Void)?
  var showLoader:(() -> Void)?
  var showAlert:((_ message: String) -> Void)?
  var limit: Int = 20
  var offset: Int = 0
  var deliveries = [DeliveryObject]()
  var shouldRefresh = false
  var willLoadFirstTime = false
  var isDataLoading = false
  var dataStoreKey: String?
  
  func getDeliveries() {
    
    if self.isDataLoading || !self.isNetworkAvailable() {
      return
    }
    if willLoadFirstTime {
      self.showLoader?()
    }
    shouldRefresh ? (offset = 0) : (offset = self.deliveries.count)
    print("Calling API")
    
    apiRequestManager.fetchDeliveries(offset: offset, limit: limit, success: {[weak self] (deliveryResponse) in
      
      if !deliveryResponse.isEmpty {
        self?.processApiData(deliveryArray: deliveryResponse)
      } else {
        self?.dataLoadingError?()
      }
      }, failure: {[weak self] (error) in
        self?.processFailedAPI(error: error)
    })
  }
  
  func processApiData(deliveryArray: [DeliveryObject]) {
    print("response sucesss")
    if self.shouldRefresh {
      self.deliveries.removeAll()
      self.deleteDataFromCache(keyString: self.dataStoreKey ?? "")
    }
    self.deliveries.append(contentsOf: deliveryArray)
    self.shouldRefresh = false
    self.isDataLoading = false
    self.willLoadFirstTime = false
    self.dataLoadingSuccess?()
    self.saveDataToCache(data: self.deliveries, keyString: self.dataStoreKey ?? "")
  }
  
  func processFailedAPI(error: AnyObject) {
    print("response error")
    self.dataLoadingError?()
    self.checkIfDataIsEmpty()
    self.isDataLoading = false
    if let err = error as? Error {
      self.showAlert?(err.localizedDescription)
    } else if let err = error as? String {
      self.showAlert?(err)
    }
  }
  
  func saveDataToCache (data: [DeliveryObject], keyString: String) {
    StorageHelper.sharedInstance.saveDataToCache(data: data, keyString: keyString)
  }
  
  func getDataFromCache(keyString: String) {
    let cachedData = StorageHelper.sharedInstance.getDataFromCache(keyString: keyString)
    if cachedData.count == 0 {
      willLoadFirstTime = true
      self.getDeliveries()
      return
    }
    // use the cached version
    self.deliveries.removeAll()
    self.deliveries.append(contentsOf: cachedData)
  }
  
  func deleteDataFromCache(keyString: String) {
    StorageHelper.sharedInstance.deleteDataFromCache(keyString: keyString)
  }
  
  func checkIfDataIsEmpty() {
    if self.deliveries.isEmpty {
      self.emptyData?()
      return
    }
  }
  
  func refreshData () {
    if !self.isNetworkAvailable() {
      return
    }
    self.shouldRefresh = true
    self.getDeliveries()
  }
  
  func isNetworkAvailable() -> Bool {
    if !AssignmentHelper.isConnectedToInternet() {
      self.checkIfDataIsEmpty()
      self.dataLoadingError?()
      self.showAlert?(LocalizedKeys.noInternet)
      return false
    }
    return true
  }
  
  func getModelForIndex(index: Int) -> DeliveryObject {
    return self.deliveries[index]
  }
  
  func getViewModelForIndex(index: Int) -> DeliveryDetailViewModel {
    let deliveryObject = self.deliveries[index]
    let deliveryDetailViewModel = DeliveryDetailViewModel.init(delivery: deliveryObject)
    return deliveryDetailViewModel
  }
  
  func isAtBottomOfScrollView(scrollView: UIScrollView) -> Bool {
    if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
      return true
    }
    return false
  }
  
  func loadMoreDataForTable(table: UITableView) {
    if (table.contentOffset.y + table.frame.size.height) >= (table.contentSize.height-200) {
      self.getDeliveries()
    }
  }
}
