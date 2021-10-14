//
//  NavApp.swift
//  imovie
//
//  Created by Egi Wibowo on 27/09/21.
//

import Foundation
import SwiftUI
import Home
import Movie
import CommonUI
import Account
import Favorite

class FavoriteMoviesRoutesImp: FavoriteMoviesRoutes {
  func movie(id: Int) -> AnyView {
    MovieViewInjector().makeMovieDetail(movieId: id)
  }
}

class AccountRoutesImp: AccountRoutes {
  func favoriteMovies() -> AnyView {
    FavoriteViewInjector().makeFovoriteMoviesView(nav: FavoriteMoviesRoutesImp())
  }
}

class HomeRoutesImp: HomeRoutes {
  func search() -> AnyView {
    return MyView().toAnyView()
  }
  
  func movie(id: Int) -> AnyView {
    MovieViewInjector().makeMovieDetail(movieId: id)
  }
  
  func account() -> AnyView {
    AccountViewInjector().makeAccountView(nav: AccountRoutesImp())
  }
}

class LandingRoutesImp: LandingRoutes {
  func home() -> AnyView {
    let nav = HomeRoutesImp()
    return HomeViewInjector().makehomeView(nav: nav)
  }
}
