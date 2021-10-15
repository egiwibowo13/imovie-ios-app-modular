//
//  HomeRoutes.swift
//  Home
//
//  Created by Egi Wibowo on 28/09/21.
//

import Foundation
import SwiftUI
import CommonUI

public protocol HomeRoutes {
  func movie(id: Int) -> AnyView
  func account() -> AnyView
}

class HomeRoutesSampleImp: HomeRoutes {
  
  func movie(id: Int) -> AnyView {
    return Text("movie").toAnyView()
  }
  
  func account() -> AnyView {
    return Text("account").toAnyView()
  }
  
}
