//
//  APIEndpoints.swift
//  Home
//
//  Created by Egi Wibowo on 30/09/21.
//

import Foundation
import Abstract
import Combine
import Alamofire

class HomeServices: NSObject {
  
  private var apiClient: ApiClient
  private var endpoints: HomeEndpoints
  
  init(apiClient: ApiClient, endpoints: HomeEndpoints) {
    self.apiClient = apiClient
    self.endpoints = endpoints
  }
}

extension HomeServices {
  func getMoviesNowPlaying(request: MoviesRequestDTO) -> AnyPublisher<MoviesResponseDTO, APIError> {
    return self.apiClient.request(endpoint: self.endpoints.getMoviesNowPlaying(request: request))
  }
  
  func getMoviesUpcoming(request: MoviesRequestDTO) -> AnyPublisher<MoviesResponseDTO, APIError> {
    return self.apiClient.request(endpoint: self.endpoints.getMoviesNowPlaying(request: request))
  }
}
