//
//  HomeUseCase.swift
//  Home
//
//  Created by Egi Wibowo on 05/10/21.
//

import Foundation
import Combine
import Abstract

protocol HomeUseCase {
  func getMoviesNowPlaying(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError>
  func getMoviesUpcoming(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError>
}

class HomeInteractor {
  
  private let homeRepo: HomeRepository
  
  required init(homeRepo: HomeRepository) {
    self.homeRepo = homeRepo
  }
  
}

extension HomeInteractor: HomeUseCase {
  func getMoviesNowPlaying(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    self.homeRepo.getMoviesNowPlaying(request: request)
  }
  
  func getMoviesUpcoming(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    self.homeRepo.getMoviesUpcoming(request: request)
  }
}
