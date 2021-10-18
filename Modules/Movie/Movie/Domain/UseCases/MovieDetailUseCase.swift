//
//  GetMovieDetailUseCase.swift
//  Movie
//
//  Created by Egi Wibowo on 05/10/21.
//

import Foundation
import Combine
import Abstract

protocol MovieDetailUseCase {
  
  func getMovieDetail(movieId: Int) -> AnyPublisher<Movie, APIError>
  
  func getCastsAndCrews(movieId: Int) -> AnyPublisher<[CastAndCrew], APIError>
  
  func getMoviesRecommendation(movieId: Int, request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError>
  
  func getImages(movieId: Int) -> AnyPublisher<[Photo], APIError>
  
  func saveMovieToFavorite(movie: Movie) -> AnyPublisher<Bool, APIError>
  
  func deleteMovieFromFavorite(movie: Movie) -> AnyPublisher<Bool, APIError>
  
  func checkIsMovieFavorite(movie: Movie) -> AnyPublisher<Bool, APIError>
  
}

class MovieDetailInteractor {
  
  private let movieRepo: MovieRepository
  
  required init(movieRepo: MovieRepository) {
    self.movieRepo = movieRepo
  }
  
}

extension MovieDetailInteractor: MovieDetailUseCase {
  
  func getMoviesRecommendation(movieId: Int, request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    self.movieRepo.getMoviesRecommendation(movieId: movieId, request: request)
  }
  
  func getCastsAndCrews(movieId: Int) -> AnyPublisher<[CastAndCrew], APIError> {
    self.movieRepo.getMovieCast(movieId: movieId)
  }
  
  func checkIsMovieFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    self.movieRepo.checkIsMovieFavorite(movie: movie)
  }
  
  func getMovieDetail(movieId: Int) -> AnyPublisher<Movie, APIError> {
    self.movieRepo.getMovie(movieId: movieId)
  }
  
  func getImages(movieId: Int) -> AnyPublisher<[Photo], APIError> {
    self.movieRepo.getImages(movieId: movieId)
  }
  
  func saveMovieToFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    self.movieRepo.saveMovieToFavorite(movie: movie)
  }
  
  func deleteMovieFromFavorite(movie: Movie) -> AnyPublisher<Bool, APIError> {
    self.movieRepo.deleteMovieFromFavorite(movie: movie)
  }
}
