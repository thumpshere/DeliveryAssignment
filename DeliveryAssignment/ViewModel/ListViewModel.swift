//
//  ListViewModel.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 03/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import Cache
class ListViewModel: NSObject {
  
  var apiRequestManager: APIManagerProtocol = ApiManager()
  var refresh:(() -> Void)?
  var emptyData:(() -> Void)?
  var dataLoadingSuccess:(() -> Void)?
  var dataLoadingError:(() -> Void)?
  var showLoader:(() -> Void)?
  var limit: Int=20
  var offset: Int=0
  var dataModelArray = [ListObject]()
  var shouldRefresh = false
  var willLoadFirstTime = false
  var isDataLoading = false
  var dataStoreKey: String?
  
  func getDataForList() {
    
    if self.isDataLoading {
      return
    }
    if willLoadFirstTime {
      self.showLoader?()
    }
    shouldRefresh ? (offset = 0) : (offset = self.dataModelArray.count)
    print("Calling API")
    
    apiRequestManager.getDataToBeShownIntoList(offset: offset, limit: limit, success: {[weak self] (modelArray) in
      self?.processApiData(modelDataArray: modelArray)
    }, failure: {[weak self] (error) in
      self?.processFailedAPI(error: error)
    })
  }
  
  func processApiData(modelDataArray: [ListObject]) {
    print("response sucesss")
    if self.shouldRefresh {
      self.dataModelArray.removeAll()
      self.deleteDataFromCache(keyString: self.dataStoreKey ?? "")
    }
    self.dataModelArray.append(contentsOf: modelDataArray)
    self.shouldRefresh = false
    self.isDataLoading = false
    self.willLoadFirstTime = false
    self.saveDataToCache(data: self.dataModelArray, keyString: self.dataStoreKey ?? "")
    self.dataLoadingSuccess?()
  }
  
  func processFailedAPI(error: AnyObject) {
    print("response error")
    self.dataLoadingError?()
    self.isDataLoading = false
    if let err = error as? Error {
      AssignmentHelper.sharedInstance.showAlert(title: StringIdentifiers.messageHeading, message: err.localizedDescription)
    }
  }
  
  func saveDataToCache (data: [ListObject], keyString: String) {
   StorageHelper.sharedInstance.saveDataToCache(data: data, keyString: keyString)
  }
  
  func isDataEmpty () -> Bool {
    if self.dataModelArray.count == 0 {
      return true
    }
    return false
  }
  
  func getDataFromCache(keyString: String) {
    let cachedData = StorageHelper.sharedInstance.getDataFromCache(keyString: keyString)
    if cachedData.count == 0 {
      willLoadFirstTime = true
      self.getDataForList()
      return
    }
    // use the cached version
    self.dataModelArray.removeAll()
    self.dataModelArray.append(contentsOf: cachedData)
  }
  
  func deleteDataFromCache(keyString: String) {
    StorageHelper.sharedInstance.deleteDataFromCache(keyString: keyString)
  }
  
  func refreshData () {
    self.shouldRefresh = true
    self.getDataForList()
  }
  
  func getModelForIndex(index: Int) -> ListObject {
    return self.dataModelArray[index]
  }
  
  func getViewModelForIndex(index: Int) -> DetailViewModel {
    let object = self.dataModelArray[index]
    let VMObject = DetailViewModel.init(obj: object)
    return VMObject
  }
  
  func isLastCellOfTableView(tableView: UITableView, indexPath: IndexPath) -> Bool {
    let lastSectionIndex = tableView.numberOfSections - 1
    let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
    if  indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
      return true
    }
    return false
  }
 
  func loadMoreDataForTable(table: UITableView) {
    if (table.contentOffset.y + table.frame.size.height) >= (table.contentSize.height-200) {
      self.getDataForList()
    }
  }
}
