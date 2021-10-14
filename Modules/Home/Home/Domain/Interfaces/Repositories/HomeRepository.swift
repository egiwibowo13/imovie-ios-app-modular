//
//  HomeRepository.swift
//  Home
//
//  Created by Egi Wibowo on 05/10/21.
//

import Foundation
import Combine
import Core

protocol HomeRepository {
  func getMoviesNowPlaying(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError>
  func getMoviesUpcoming(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError>
}
