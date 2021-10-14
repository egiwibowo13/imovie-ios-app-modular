//
//  HomeViewInjector.swift
//  Home
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import SwiftUI
import CommonUI

public class HomeViewInjector {
  public init() {}
  
  public func makehomeView(nav: HomeRoutes) -> AnyView {
    makeLazyView(HomeView(nav: nav))
  }
}
