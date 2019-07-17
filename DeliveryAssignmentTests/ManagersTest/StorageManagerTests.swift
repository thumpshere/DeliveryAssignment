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
var listVM = ListViewModel()
  let dataStoreKey = "dummyDataForCache"
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

  }

  func testIfDataIsWrittenAndDeletedFromCache() {
    if  let ary = self.getDataFromPlist() {
      let listVM = ListViewModel()
      listVM.saveDataToCache(data: ary, keyString: dataStoreKey)
      listVM.getDataFromCache(keyString: dataStoreKey)
      XCTAssertTrue(listVM.deliveries.count>0)
    }
  }
  
  func testIfDataIsDeletedfromCache () {
    if  let ary = self.getDataFromPlist() {
      listVM.saveDataToCache(data: ary, keyString: dataStoreKey)
      listVM.deleteDataFromCache(keyString: dataStoreKey)
      listVM.getDataFromCache(keyString: dataStoreKey)
      XCTAssertFalse(listVM.deliveries.count>0)
    }
  }
  
 private func getDataFromPlist () -> [ListObject]? {
    if let path = Bundle.main.path(forResource: "DummyApiResponse", ofType: "plist") {
      if let ary = NSArray(contentsOfFile: path) {
        return self.createParsedArray(array: ary)
      }
    }
    return nil
  }
  
private func createParsedArray(array: NSArray) -> [ListObject]? {
    do {
      let decoder = JSONDecoder()
      let data = try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
      let parsedArray = try decoder.decode([ListObject].self, from: data!)
      return parsedArray
      
    } catch let err {
      print("Err", err)
      return nil
    }
  }
  
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      
      listVM.deleteDataFromCache(keyString: "dummyDataForCache")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
