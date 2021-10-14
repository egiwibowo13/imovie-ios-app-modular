//
//  BaseState.swift
//  Core
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation

public struct BaseResult<T> {
  public var data: T?
  public var loading: Bool = false
  public var error: APIError?
  public var isError: Bool = false
  public var isSuccess: Bool = false
  
  public init() {}
  
  public init(data: T?) {
    self.data = data
  }
  
  public init(data: T?, loading: Bool, error: APIError?) {
    self.data = data
    self.loading = loading
    self.error = error
  }
  
  public static func loading(_ isLoading: Bool = true) -> BaseResult {
    BaseResult(data: nil, loading: isLoading, error: nil)
  }
  
  public static func success(data: T) -> BaseResult<T> {
    var result = BaseResult(data: data, loading: false, error: nil)
    result.isSuccess = true
    return result
  }
  
  public static func error(error: APIError) -> BaseResult {
    var result = BaseResult(data: nil, loading: false, error: error)
    result.isError = true
    return result
  }
  
  func getErrorDesc() -> String {
    return error?.localizedDescription ?? ""
  }
}
