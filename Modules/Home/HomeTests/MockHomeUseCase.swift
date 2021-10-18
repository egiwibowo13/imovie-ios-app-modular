//
//  MockHomeUseCase.swift
//  HomeTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import Foundation
import Combine
import Abstract
@testable import Home

final class MockHomeUseCase: HomeUseCase {
  
  var getMoviesResult: Result<MoviesPage, APIError> = .success(MoviesPage(page: 1, totalPages: 1, movies: []))
  
  func getMoviesNowPlaying(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    return Future<MoviesPage, APIError> { completion in
      completion(self.getMoviesResult)
    }.eraseToAnyPublisher()
  }
  
  func getMoviesUpcoming(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    return Future<MoviesPage, APIError> { completion in
      completion(self.getMoviesResult)
    }.eraseToAnyPublisher()
  }
}
