//
//  InspectionTests.swift
//  InspectionTests
//
//  Created by Thanawat prathumset on 1/2/2564 BE.
//

import XCTest
@testable import Inspection

class InspectionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testKrungthaiShouldCheckMark() throws {
        let newlists = mapSellerList(from: ["Krungthai Mizuho Leasing Co., Ltd."])
        let checkkrungthai = newlists.filter( { $0.contains("Krungthai Mizuho Leasing Co., Ltd.")} ).first
        
        
        XCTAssertEqual(checkkrungthai ,"✔︎ Krungthai Mizuho Leasing Co., Ltd.")
    }
    
    func test_BookInTypeShouldbeToCar() throws {
        let bookInType = getDataBookInType(type: "CAR")
       	
        XCTAssertEqual(bookInType , .CAR)
        
    }
    
    func test_BookInTypeShouldbeToMBIKE() throws {
        let bookInType = getDataBookInType(type: "MBIKE")
       
        XCTAssertEqual(bookInType , .MBIKE)
        
    }
  
}
