//
//  StringExt.swift
//  Core
//
//  Created by Egi Wibowo on 03/10/21.
//

import Foundation
import CommonCrypto

extension String {
  public func sha512() -> Data? {
    let stringData = data(using: String.Encoding.utf8)!
    var result = Data(count: Int(CC_SHA512_DIGEST_LENGTH))
    _ = result.withUnsafeMutableBytes { rawMutableBufferPointer in
      stringData.withUnsafeBytes { stringBytes in
        CC_SHA512(
          stringBytes.baseAddress,
          CC_LONG(stringData.count),
          rawMutableBufferPointer.bindMemory(to: UInt8.self).baseAddress)
      }
    }
    
    return result
  }
}
