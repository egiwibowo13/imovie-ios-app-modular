//
//  ApiClient.swift
//  Core
//
//  Created by Egi Wibowo on 03/10/21.
//

import Foundation
import Alamofire
import Combine

public struct ApiClient {
  public var config: NetworkConfigurable
  
  public init(config: NetworkConfigurable) {
    self.config = config
  }
  
  public func request<T: Decodable>(endpoint: Endpoint<T>) -> AnyPublisher<T, APIError> {
    return Future<T, APIError> { completion in
      var parameters: [String: Any] = endpoint.parameters
      parameters.updateValue(self.config.apiKey, forKey: "api_key")
      let api =  AF.request(
        self.config.baseURL.appendingPathComponent(endpoint.path),
        method: endpoint.method,
        parameters: parameters
      )
        .validate()
        .responseDecodable(completionHandler: { (response: DataResponse<T, AFError>) in
                              switch response.result {
                              case .success(let value):
                                    completion(.success(value))
                              case .failure(let error):
                                    completion(.failure(APIError.error(message: error.localizedDescription)))
                              }
        })
            api.resume()
    }.mapError { error in APIError.error(message: error.localizedDescription)  }.eraseToAnyPublisher()

    }
  
}
