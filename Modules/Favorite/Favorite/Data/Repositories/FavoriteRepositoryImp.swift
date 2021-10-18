//
//  FavoriteRepositoryImp.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import Combine
import Abstract
import Core

final class FavoriteRepositoryImp: NSObject {
  typealias FavoriteInstance = (RealmDataSource) -> FavoriteRepository

  fileprivate let services: RealmDataSource

  private init(services: RealmDataSource) {
    self.services = services
  }

  static let sharedInstance: FavoriteInstance = { relmDataSource in
    FavoriteRepositoryImp(services: relmDataSource)
  }
}

extension FavoriteRepositoryImp: FavoriteRepository {
  func getFavoriteMovies() -> AnyPublisher<[Movie], APIError> {
    self.services.getMovies().map { movies in
      movies.map { movie in
        movie.toDomain()
      }
    }.eraseToAnyPublisher()
  }
}
