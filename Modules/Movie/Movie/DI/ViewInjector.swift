//
//  ViewInjector.swift
//  Movie
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import SwiftUI
import CommonUI

public class MovieViewInjector {
  public init() {}
  
  public func makeMovieDetail(movieId: Int) -> AnyView {
    makeLazyView(MovieDetailView(movieId: movieId))
  }
}
