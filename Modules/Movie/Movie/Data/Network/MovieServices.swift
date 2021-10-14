//
//  MovieServices.swift
//  Movie
//
//  Created by Egi Wibowo on 06/10/21.
//

import Foundation
import Combine
import Core

class MovieServices: NSObject {
  
  private var apiClient: ApiClient
  private var endpoints: MovieEndpoints
  
  init(apiClient: ApiClient, endpoints: MovieEndpoints) {
    self.apiClient = apiClient
    self.endpoints = endpoints
  }
}

extension MovieServices {
  func getMovie(id: Int) -> AnyPublisher<MoviesResponseDTO.MovieDTO, APIError> {
    return self.apiClient.request(endpoint: self.endpoints.getMovie(id: id))
  }
  
  func getMovieCastAndCrew(id: Int) -> AnyPublisher<CastAndCrewResponseDTO, APIError> {
    return self.apiClient.request(endpoint: self.endpoints.getMovieCastAndCrew(id: id))
  }
  
  func getMoviesRecommendation(id: Int, request: MoviesRequestDTO) -> AnyPublisher<MoviesResponseDTO, APIError> {
    return self.apiClient.request(endpoint: self.endpoints.getMoviesRecommendation(id: id, request: request))
  }
  
  func getImagesById(id: Int) -> AnyPublisher<PhotosResponseDTO, APIError> {
    return self.apiClient.request(endpoint: self.endpoints.getImagesById(id: id))
  }
}
