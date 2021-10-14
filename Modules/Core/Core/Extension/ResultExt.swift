//
//  ResultExt.swift
//  Core
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import RealmSwift

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
