//
//  HomeRepositoryImp.swift
//  Movie
//
//  Created by Egi Wibowo on 06/10/21.
//

import Foundation
import Combine
import Abstract
import Core

final class MovieRepositoryImp: NSObject {

  typealias MovieInstance = (MovieServices, RealmDataSource) -> MovieRepositoryImp

  fileprivate let services: MovieServices
  fileprivate let local: RealmDataSource

  private init(services: MovieServices, local: RealmDataSource) {
    self.services = services
    self.local = local
  }

  static let sharedInstance: MovieInstance = { serviceMovie, localMovie in
    return MovieRepositoryImp(services: serviceMovie, local: localMovie)
  }
}

extension MovieRepositoryImp: MovieRepository {
  func saveMovieToFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    self.local.addMovie(from: movie.toDB())
  }
  
  func deleteMovieFromFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    self.local.deleteMovie(from: movie.toDB())
  }
  
  func checkIsMovieFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    self.local.checkHaveMovie(from: movie.id)
  }
  
  func getImages(movieId: Int) -> AnyPublisher<[Photo], APIError> {
    self.services.getImagesById(id: movieId).map { images in
      images.toDomain()
    }.eraseToAnyPublisher()
  }
  
  func getMoviesRecommendation(movieId: Int, request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    self.services.getMoviesRecommendation(id: movieId, request: request).map { movie in
      movie.toDomain()
    }.eraseToAnyPublisher()
  }
  
  func getMovieCast(movieId: Int) -> AnyPublisher<[CastAndCrew], APIError> {
    self.services.getMovieCastAndCrew(id: movieId).map { castAndCrew in
      castAndCrew.toDomain()
    }.eraseToAnyPublisher()
  }
  
  func getMoviesRecommendation(movieId: Int) -> AnyPublisher<Movie, APIError> {
    self.services.getMovie(id: movieId).map { movie in
      movie.toDomain()
    }.eraseToAnyPublisher()
  }
  
  func getMovieReview(movieId: Int) -> AnyPublisher<Movie, APIError> {
    self.services.getMovie(id: movieId).map { movie in
      movie.toDomain()
    }.eraseToAnyPublisher()
  }
  
  func getMovie(movieId: Int) -> AnyPublisher<Movie, APIError> {
    self.local.getMovieById(from: movieId).map { movieDb in
      movieDb.toDomain()
    }.catch { _ in
      self.services.getMovie(id: movieId).map { movieDTO in
        movieDTO.toDomain()
      }
    }
    .eraseToAnyPublisher()
  }
}
