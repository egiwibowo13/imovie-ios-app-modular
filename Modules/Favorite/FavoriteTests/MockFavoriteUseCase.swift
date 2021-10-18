//
//  MockFavoriteUseCase.swift
//  FavoriteTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import Foundation
import Combine
import Abstract
@testable import Favorite

final class MockFavoriteUseCase: FavoriteUseCase {
  
  var getMoviesResult: Result<[Movie], APIError> = .success(Movie.getMockMovies(num: 10))
  
  func getFavoriteMovies() -> AnyPublisher<[Movie], APIError> {
    return Future<[Movie], APIError> { completion in
      completion(self.getMoviesResult)
    }.eraseToAnyPublisher()
  }
}
