//
//  MovieDetailRoutes.swift
//  Movie
//
//  Created by Egi Wibowo on 27/09/21.
//

import Foundation
import SwiftUI
import CommonUI

protocol MovieDetailRoutes {
  func castAndCrew(castsAndCrews: [CastAndCrew]) -> AnyView
  func recomendation(movieId: Int) -> AnyView
  func movieDetail(movieId: Int) -> AnyView
  func photos(photos: [Photo]) -> AnyView
}

class MovieDetailRoutesImp: MovieDetailRoutes {
  func photos(photos: [Photo]) -> AnyView {
    return makeLazyView(PhotosView(photos: photos))
  }
  
  func castAndCrew(castsAndCrews: [CastAndCrew]) -> AnyView {
    return makeLazyView(CastAndCrewView(castsAndCrews: castsAndCrews))
  }
  
  func recomendation(movieId: Int) -> AnyView {
    return makeLazyView(MoviesRecommendationView(movieId: movieId))
  }
  
  func movieDetail(movieId: Int) -> AnyView {
    return makeLazyView(MovieDetailView(movieId: movieId))
  }
}
