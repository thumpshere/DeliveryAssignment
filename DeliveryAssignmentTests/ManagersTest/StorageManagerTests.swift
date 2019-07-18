//
//  StorageManagerTests.swift
//  DeliveryAssignmentTests
//
//  Created by Arpit Tripathi on 16/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import XCTest
@testable import DeliveryAssignment

class StorageManagerTests: XCTestCase {
  
  let dataStoreKey = "dummyDataForCache"
  let dummyFileName = "DummyApiResponse"
  let dummyFileType = "plist"
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  func testIfDataIsWrittenAndDeletedFromCache() {
    if  let ary = self.getDataFromPlist() {
      StorageHelper.sharedInstance.saveDataToCache(data: ary, keyString: dataStoreKey)
    let data = StorageHelper.sharedInstance.getDataFromCache(keyString: dataStoreKey)
      XCTAssertTrue(data.count>0)
    }
  }
  
  func testIfDataIsDeletedfromCache () {
    if  let ary = self.getDataFromPlist() {
      StorageHelper.sharedInstance.saveDataToCache(data: ary, keyString: dataStoreKey)
      StorageHelper.sharedInstance.deleteDataFromCache(keyString: dataStoreKey)
      let data = StorageHelper.sharedInstance.getDataFromCache(keyString: dataStoreKey)
      XCTAssertFalse(data.count>0)
    }
  }
  
  private func getDataFromPlist () -> [DeliveryObject]? {
    if let path = Bundle.main.path(forResource: dummyFileName, ofType: "plist") {
      if let ary = NSArray(contentsOfFile: path) {
        return self.createParsedArray(array: ary)
      }
    }
    return nil
  }
  
  private func createParsedArray(array: NSArray) -> [DeliveryObject]? {
    do {
      let decoder = JSONDecoder()
      let data = try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
      let parsedArray = try decoder.decode([DeliveryObject].self, from: data!)
      return parsedArray
    } catch let err {
      print("Err", err)
      return nil
    }
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    StorageHelper.sharedInstance.deleteDataFromCache(keyString: dataStoreKey)
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
}
