//
//  Sha1Security.swift
//  Coalbox
//
//  Created by Mahesh Parab on 18/06/16.
//  Copyright © 2016 Coalbox Ironing Services. All rights reserved.
//

import Foundation

extension String {
    func sha1() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joinWithSeparator("")
    }
}
