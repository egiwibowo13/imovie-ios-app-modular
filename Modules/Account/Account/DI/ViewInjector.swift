//
//  ViewInjector.swift
//  Account
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import SwiftUI
import CommonUI

public class AccountViewInjector {
  public init() {}
  public func makeAccountView(nav: AccountRoutes) -> AnyView {
    makeLazyView(AccountView(nav: nav))
  }
}
