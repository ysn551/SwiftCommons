//
//  Collection+Tests.swift
//  SwiftCommons
//
//  Created by Kosuke Yoshimoto on 2017/02/12.
//  Copyright © 2017 Yusuke. All rights reserved.
//

import XCTest
import Foundation
@testable import SwiftCommons

class Collection_Tests: XCTestCase {
    func test_CharacterView_search() {
        var str = "H"
        var range = str.characters.search(forContentsOf: "H".characters)
        XCTAssertNotNil(range)
        XCTAssertEqual(str[range!], "H")
        
        str = "HE"
        range = str.characters.search(forContentsOf: "HE".characters)
        XCTAssertNotNil(range)
        XCTAssertEqual(str[range!], "HE")
        
        str = "HELLO WORLD"
        range = str.characters.search(forContentsOf: "WORLD".characters)
        XCTAssertNotNil(range)
        XCTAssertEqual(str[range!], "WORLD")
        
        str = "H"
        range = str.characters.search(forContentsOf: "".characters)
        XCTAssertNil(range)
        
        str = ""
        range = str.characters.search(forContentsOf: "W".characters)
        XCTAssertNil(range)
        
        str = "HELLO WORLD"
        range = str.characters.search(forContentsOf: "WORD".characters)
        XCTAssertNil(range)
    }
    
    func test_UTF16View_search() {
        let str = "\"PPAP\", \"✑\", \"🍍\", \"🍎\", \"✒\", \"PPAP\""
        let range = str.utf16.search(forContentsOf: "🍎".utf16)
        XCTAssertNotNil(range)
        XCTAssertEqual(String(str.utf16[range!]), "🍎")
    }
    
    func test_Data_search() {
        let data = "\"PPAP\", \"✑\", \"🍍\", \"🍎\", \"✒\", \"PPAP\"".data(using: .utf8)!
        let range = data.search(forContentsOf: "✒".data(using: .utf8)!)
        XCTAssertNotNil(range)
        
        let str = String(data: Data(data[range!]), encoding: .utf8)
        XCTAssertEqual(str, "✒")
    }
    
    
    let testBundle = Bundle(path: URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("Resources").path)!
    
    func filePath(name: String) -> String {
        return testBundle.path(forResource: name, ofType: nil)!
    }
    
    func test_measure_characters_search() {
        let content = try! String(contentsOfFile: filePath(name: "emoji_list.txt"))
        self.measure {
            _ = content.characters.search(forContentsOf: "".characters)
        }
    }
    
    func test_measure_utf16_search() {
        let content = try! String(contentsOfFile: filePath(name: "emoji_list.txt"))
        self.measure {
            _ = content.utf16.search(forContentsOf: "".utf16)
        }
    }
    
    
    func test_measure_data_search() {
        let content = try! Data(contentsOf: URL(fileURLWithPath: filePath(name: "emoji_list.txt")))
        self.measure {
            _ = content.search(forContentsOf: "".data(using: .utf8)!)
        }
    }
}
