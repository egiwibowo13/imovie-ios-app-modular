//
//  ModuleMovieDI.swift
//  imovie
//
//  Created by Egi Wibowo on 22/09/21.
//

import Resolver
import Navigator
import Movie
import Home

extension Resolver {
  static func registerMovieRoutes() {
//    register { MovieRoutes() }.implements(MovieRoutesContract.self).scope(.shared)
    register { HomeRoutes() }.implements(HomeRoutesContract.self).scope(.shared)
    register { ImovieApp() }.scope(.application)
    register { ContentView() }.scope(.application)
//    register {
//      MovieDetailView()
//    }.scope(.application)
    register { HomeView() }.scope(.application)
  }
}
