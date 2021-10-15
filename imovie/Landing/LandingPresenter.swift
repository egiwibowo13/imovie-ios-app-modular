//
//  LandingPresenter.swift
//  imovie
//
//  Created by Egi Wibowo on 27/09/21.
//

import Foundation
import SwiftUI

class LandingPresenter: ObservableObject {
  @Published var isActive = false
  
  init() {
    goToAppWithDelay()
  }
  
  func goToAppWithDelay() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
       // Code you want to be delayed
      self.isActive = true
    }
  }
}
