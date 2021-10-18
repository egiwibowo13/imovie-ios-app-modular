//
//  Repositories.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import Combine
import Abstract

protocol FavoriteRepository {
  func getFavoriteMovies() -> AnyPublisher<[Movie], APIError>
}
