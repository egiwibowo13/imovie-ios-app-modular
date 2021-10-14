//
//  FavoriteviewInjector.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import SwiftUI
import CommonUI

public class FavoriteViewInjector {
  public init() {}
  
  public func makeFovoriteMoviesView(nav: FavoriteMoviesRoutes) -> AnyView {
    makeLazyView(FavoriteMoviesView(nav: nav))
  }
}
