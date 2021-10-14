//
//  HomeRepositories.swift
//  Home
//
//  Created by Egi Wibowo on 03/10/21.
//

import Foundation
import Combine
import Core

final class HomeRepositoryImp: NSObject {

  typealias HomeInstance = (HomeServices) -> HomeRepositoryImp

  fileprivate let services: HomeServices

  private init(services: HomeServices) {
    self.services = services
  }

  static let sharedInstance: HomeInstance = { serviceHome in
    return HomeRepositoryImp(services: serviceHome)
  }
}

extension HomeRepositoryImp: HomeRepository {
  func getMoviesNowPlaying(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    let publisher = self.services.getMoviesNowPlaying(request: request).map { data in
      data.toDomain()
    }.eraseToAnyPublisher()
    return publisher
  }
  
  func getMoviesUpcoming(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
    let publisher = self.services.getMoviesUpcoming(request: request).map { data in
      data.toDomain()
    }.eraseToAnyPublisher()
    return publisher
  }
}
