//
//  FavoriteMoviesRoutes.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import SwiftUI
import CommonUI

public protocol FavoriteMoviesRoutes {
  func movie(id: Int) -> AnyView
}

class FavoriteMoviesSampleRoutes: FavoriteMoviesRoutes {
  func movie(id: Int) -> AnyView {
    makeLazyView(Text("movie \(id)"))
  }
}
