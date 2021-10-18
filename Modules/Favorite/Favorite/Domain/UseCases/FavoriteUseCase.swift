//
//  FavoriteUseCase.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import Core
import Combine
import Abstract

protocol FavoriteUseCase {
  func getFavoriteMovies() -> AnyPublisher<[Movie], APIError>
}

class FavoriteInteractor {
  
  private let favoriteRepo: FavoriteRepository
  
  required init(favoriteRepo: FavoriteRepository) {
    self.favoriteRepo = favoriteRepo
  }
}

extension FavoriteInteractor: FavoriteUseCase {
  func getFavoriteMovies() -> AnyPublisher<[Movie], APIError> {
    self.favoriteRepo.getFavoriteMovies()
  }
}
