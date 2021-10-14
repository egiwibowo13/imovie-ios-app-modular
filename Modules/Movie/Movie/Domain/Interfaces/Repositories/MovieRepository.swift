//
//  MovieRepository.swift
//  Movie
//
//  Created by Egi Wibowo on 05/10/21.
//

import Foundation
import Combine
import Core

protocol MovieRepository {
  func getMovie(movieId: Int) -> AnyPublisher<Movie, APIError>
  
  func getMovieCast(movieId: Int) -> AnyPublisher<[CastAndCrew], APIError>
  
  func getMoviesRecommendation(movieId: Int, request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError>
  
  func getMovieReview(movieId: Int) -> AnyPublisher<Movie, APIError>
  
  func getImages(movieId: Int) -> AnyPublisher<[Photo], APIError>
  
  func saveMovieToFavorite(movie: Movie) -> AnyPublisher<Bool, APIError>
  
  func deleteMovieFromFavorite(movie: Movie) -> AnyPublisher<Bool, APIError>
  
  func checkIsMovieFavorite(movie: Movie) -> AnyPublisher<Bool, APIError>
}
