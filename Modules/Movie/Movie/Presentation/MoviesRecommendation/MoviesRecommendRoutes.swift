//
//  MoviesRecommendRoutes.swift
//  Movie
//
//  Created by Egi Wibowo on 07/10/21.
//

import Foundation
import SwiftUI
import CommonUI

protocol MoviesRecommendRoutes {
  func movieDetail(movieId: Int) -> AnyView
}

class MoviesRecommendRoutesImp: MoviesRecommendRoutes {
  func movieDetail(movieId: Int) -> AnyView {
    return makeLazyView(MovieDetailView(movieId: movieId))
  }
}
