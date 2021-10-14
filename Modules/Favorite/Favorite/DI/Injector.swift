//
//  Injector.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import Core

class Injector {
  func provideFavoriteRepository() -> FavoriteRepository {
    return FavoriteRepositoryImp.sharedInstance(CoreInjector().provideRealmDatabase())
  }
  
  func provideFavoriteUseCase() -> FavoriteUseCase {
    return FavoriteInteractor(favoriteRepo: provideFavoriteRepository())
  }
}
