//
//  MockMovieUseCase.swift
//  MovieTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import Foundation
import Combine
import Abstract
@testable import Movie

final class MockMovieDetailUseCase: MovieDetailUseCase {
  
  var getMovieResult: Result<Movie, APIError> = .success(Movie.getMock(id: 1))
  var getCastAndCrewsResult: Result<[CastAndCrew], APIError> = .success(CastAndCrew.getMockCastAndCrews(num: 10))
  var getMoviesRecommendResult: Result<MoviesPage, APIError> = .success(MoviesPage.getMock())
  var getPhotosResult: Result<[Photo], APIError> = .success(Photo.getMockPhotos(num: 10))
  var favoriteResult: Result<Bool, APIError> = .success(true)
  
  func getMovieDetail(movieId: Int) -> AnyPublisher<Movie, APIError> {
    return Future<Movie, APIError> { completion in
      completion(self.getMovieResult)
    }.eraseToAnyPublisher()
  }
  
  func getCastsAndCrews(movieId: Int) -> AnyPublisher<[CastAndCrew], APIError> {
    return Future<[CastAndCrew], APIError> { completion in
      completion(self.getCastAndCrewsResult)
    }.eraseToAnyPublisher()
  }
  
  func getMoviesRecommendation(movieId: Int, request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    return Future<MoviesPage, APIError> { completion in
      completion(self.getMoviesRecommendResult)
    }.eraseToAnyPublisher()
  }
  
  func getImages(movieId: Int) -> AnyPublisher<[Photo], APIError> {
    return Future<[Photo], APIError> { completion in
      completion(self.getPhotosResult)
    }.eraseToAnyPublisher()
  }
  
  func saveMovieToFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    return Future<Bool, APIError> { completion in
      completion(self.favoriteResult)
    }.eraseToAnyPublisher()
  }
  
  func deleteMovieFromFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    return Future<Bool, APIError> { completion in
      completion(self.favoriteResult)
    }.eraseToAnyPublisher()
  }
  
  func checkIsMovieFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    return Future<Bool, APIError> { completion in
      completion(self.favoriteResult)
    }.eraseToAnyPublisher()
  }
}
