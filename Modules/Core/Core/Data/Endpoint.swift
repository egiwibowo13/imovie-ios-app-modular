//
//  Endpoint.swift
//  Core
//
//  Created by Egi Wibowo on 03/10/21.
//

import Foundation
import Alamofire

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethod { get set }
    var body: Encodable? { get }
    var parameters: Parameters { get }
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response
}

public class Endpoint<R>: ResponseRequestable {
  public typealias Response = R
  public var method: HTTPMethod
  public var body: Encodable?
  public var parameters: Parameters
  public let path: String
  public init(path: String, method: HTTPMethod, body: Encodable? = nil) {
    self.path = path
    self.method = method
    self.body = body
    self.parameters = (try? body?.asDictionary()) ?? [:]
  }
}
