//
//  NetworkConfig.swift
//  Core
//
//  Created by Egi Wibowo on 03/10/21.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: URL { get }
  var apiKey: String { get }
    var headers: [String: String] { get }
}

public struct ApiDataNetworkConfig: NetworkConfigurable {
    public let baseURL: URL
    public var apiKey: String
    public let headers: [String: String]
    
  public init(baseURL: URL,
              apiKey: String,
              headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.headers = headers
    }
}
