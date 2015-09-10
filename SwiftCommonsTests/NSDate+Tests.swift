//
//  NSDate+Tests.swift
//  SwiftCommons
//
//  Created by Yusuke on 9/10/15.
//  Copyright © 2015 Yusuke. All rights reserved.
//

import XCTest
@testable import SwiftCommons

class NSDate_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_fromRFC3339String() {

        let dc = NSDateComponents()
        dc.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        dc.year   = 2015
        dc.month  = 09
        dc.day    = 10
        dc.hour   = 23
        dc.minute = 37
        dc.second = 05
        
        
        // GMT
        
        dc.timeZone = NSTimeZone(name: "GMT")
        let dateGmt = dc.date!
        
        // string -> date
        XCTAssertEqual(
            dateGmt,
            NSDate.fromRFC3339String("2015-09-10T23:37:05Z")!)
        
        // date -> string
        XCTAssertEqual(
            "2015-09-11T08:37:05+09:00",
            NSDate.toRFC3339String(dateGmt)!)
        
        
        // GMT+09:00(Asia)
        
        dc.timeZone = NSTimeZone(name: "Asia/Tokyo")
        let dateAsia = dc.date!
        
        // string -> date
        XCTAssertEqual(
            dateAsia,
            NSDate.fromRFC3339String("2015-09-10T23:37:05+09:00")!)
        
        // date -> string
        XCTAssertEqual(
            "2015-09-10T23:37:05+09:00",
            NSDate.toRFC3339String(dateAsia)!)
    }
}