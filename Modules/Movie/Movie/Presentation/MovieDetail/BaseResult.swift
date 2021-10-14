//
//  BaseResult.swift
//  Movie
//
//  Created by Egi Wibowo on 13/10/21.
//

import Foundation
import Core

//struct BaseResultaa<T> {
//  var data: T?
//  var loading: Bool = false
//  var error: APIError?
//  var isError: Bool = false
//  var isSuccess: Bool = false
//  
//  static func loading(_ isLoading: Bool = true) -> BaseResult {
//    BaseResult(data: nil, loading: isLoading, error: nil)
//  }
//  
//  static func success(data: T) -> BaseResult<T> {
//    var result = BaseResult(data: data, loading: false, error: nil)
//    result.isSuccess = true
//    return result
//  }
//  
//  static func error(error: APIError) -> BaseResult {
//    var result = BaseResult(data: nil, loading: false, error: error)
//    result.isError = true
//    return result
//  }
//  
//  func getErrorDesc() -> String {
//    return error?.localizedDescription ?? ""
//  }
//}
