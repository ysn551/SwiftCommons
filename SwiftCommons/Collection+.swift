//
//  Collection+.swift
//  SwiftCommons
//
//  Created by Kosuke Yoshimoto on 2017/02/12.
//  Copyright © 2017 Yusuke. All rights reserved.
//

public extension Collection where Iterator.Element: Equatable, IndexDistance == Int {
    
    /**
     Searchs for the value of which type is the same as the receiver.
     
     - parameter searchContents: the value adapted the collection to search for.
     */
    public func search<C: Collection>(forContentsOf searchContents: C) -> Range<Index>?
        where C.Iterator.Element == Iterator.Element, C.IndexDistance == IndexDistance {
            let mcount = self.count
            let scount = searchContents.count
            guard mcount >= scount else {
                return nil
            }
            
            var hit: Range<Index>? = nil
            next: for i in 0..<(mcount - (scount - 1)) {
                for j in 0..<scount {
                    let melm = self[self.index(self.startIndex, offsetBy: (i+j))]
                    let selm = searchContents[searchContents.index(searchContents.startIndex, offsetBy: j)]
                    
                    guard melm == selm else {
                        continue next
                    }
                    
                    if j == searchContents.count - 1 {
                        let lower = self.index(self.startIndex, offsetBy: i)
                        let upper = self.index(lower, offsetBy: scount)
                        hit = Range(uncheckedBounds: (lower: lower, upper: upper))
                        break next
                    }
                }
            }
            return hit
    }
    
    /// Command failed due to signal: Segmentation fault: 11
    /*
    public func search<T: Equatable>(forContentsOf value: T) -> Iterator.Element? where T == Iterator.Element  {
        
        for content in self {
            if content == value {
                return content
            }
        }
        return nil
    }
    */
}


