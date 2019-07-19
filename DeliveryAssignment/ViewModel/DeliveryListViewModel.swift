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
  var stopRefreshing:(() -> Void)?
  var dataEmpty:(() -> Void)?
  var dataLoadingSuccess:(() -> Void)?
  var showLoader:(() -> Void)?
  var hideLoader:(() -> Void)?
  var showLoadMoreSpinner:(() -> Void)?
  var hideLoadMoreSpinner:(() -> Void)?
  var showAlert:((_ message: String) -> Void)?
  var limit: Int = 20
  var offset: Int = 0
  var deliveries = [DeliveryObject]()
  var shouldRefresh = false
  var isLoadingMoreData = false
  var willLoadFirstTime = false
  var isDataLoading = false
  var dataStoreKey: String?
  
  // MARK: API calling
  func getDeliveries() {
    
    if self.isDataLoading {
      return
    } else if !AssignmentHelper.isConnectedToInternet() {
      self.doRequiredOperationsForNoInternet()
      return
    }
    
    if willLoadFirstTime {
      self.showLoader?()
    }
    
    shouldRefresh ? (offset = 0) : (offset = self.deliveries.count)
    
    if isLoadingMoreData {
      self.showLoadMoreSpinner?()
    }
    
    print("Calling API")
    self.isDataLoading = true
    
    apiRequestManager.fetchDeliveries(offset: offset, limit: limit,
                                      success: {[weak self] (deliveryResponse) in
                                        
                                        print("response sucesss")
                                        self?.isDataLoading = false
                                        
                                        if deliveryResponse.isEmpty {
                                          self?.hideLoadMoreSpinner?()
                                        } else {
                                          self?.processApiData(deliveryArray: deliveryResponse)
                                        }},
                                      
                                      failure: {[weak self] (error) in
                                        print("response error")
                                        self?.isDataLoading = false
                                        self?.processFailedAPI(error: error)
    })
  }
  
  // MARK: Response Handling
  func processApiData(deliveryArray: [DeliveryObject]) {
    
    if self.shouldRefresh {
      self.deliveries.removeAll()
      self.deleteDataFromCache(keyString: self.dataStoreKey ?? Constants.cachedObjectKey)
      self.stopRefreshing?()
    } else if isLoadingMoreData {
      self.hideLoadMoreSpinner?()
      self.isLoadingMoreData = false
    } else if willLoadFirstTime {
      self.hideLoader?()
    }
    
    self.deliveries.append(contentsOf: deliveryArray)
    self.shouldRefresh = false
    self.willLoadFirstTime = false
    self.dataLoadingSuccess?()
    self.saveDataToCache(data: self.deliveries, keyString: self.dataStoreKey ?? Constants.cachedObjectKey)
  }
  
  func processFailedAPI(error: AnyObject) {
    
    if self.shouldRefresh {
      self.stopRefreshing?()
    } else if isLoadingMoreData {
      self.hideLoadMoreSpinner?()
      self.isLoadingMoreData = false
    } else if willLoadFirstTime {
      self.hideLoader?()
    }
    self.checkIfDataIsEmpty()
    self.showAlert?(self.getErrorString(error: error))
  }
  
  func getErrorString (error: AnyObject) -> String {
    if let err = error as? Error {
      return err.localizedDescription
    } else if let err = error as? String {
      return err
    }
    return ""
  }
  
  // MARK: Memory Operations
  func saveDataToCache (data: [DeliveryObject], keyString: String) {
    StorageHelper.sharedInstance.saveDataToCache(data: data, keyString: keyString)
  }
  
  func getDataFromCache() {
    let cachedData = StorageHelper.sharedInstance.getDataFromCache(keyString: dataStoreKey ?? Constants.cachedObjectKey)
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
      self.dataEmpty?()
      return
    }
  }
  
  // MARK: Handling UI updation logic
  func refreshData () {
    if !AssignmentHelper.isConnectedToInternet() {
      return
    }
    self.shouldRefresh = true
    self.getDeliveries()
  }
  
  func doRequiredOperationsForNoInternet () {
    self.checkIfDataIsEmpty()
    self.showAlert?(LocalizedKeys.noInternet)
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
      self.isLoadingMoreData = true
      self.getDeliveries()
    }
  }
}
