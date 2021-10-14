//
//  LandingView.swift
//  imovie
//
//  Created by Egi Wibowo on 22/09/21.
//

import SwiftUI

protocol LandingRoutes {
  func home() -> AnyView
}

struct LandingView: View {
  @ObservedObject var presenter = LandingPresenter()
  private let nav: LandingRoutes = LandingRoutesImp()
  
    var body: some View {
      VStack {
        if presenter.isActive {
          nav.home()
        } else {
          LandingViewImp()
        }
      }
    }
}

extension LandingView {
  func LandingViewImp() -> some View {
    VStack {
      Image("logo")
        .frame(width: 100, height: 100, alignment: .center)
    }.fillParent()
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .background(Color.primaryColor)
    .ignoresSafeArea()
  }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
      LandingView()
    }
}
