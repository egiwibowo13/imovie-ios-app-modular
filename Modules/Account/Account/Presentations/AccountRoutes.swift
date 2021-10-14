//
//  AccountRoutes.swift
//  Account
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import SwiftUI
import CommonUI

public protocol AccountRoutes {
  func favoriteMovies() -> AnyView
}

class AccountSampleRoutes: AccountRoutes {
  func favoriteMovies() -> AnyView {
    makeLazyView(Text("My Favorite"))
  }
}
