//
//  BaseScreen.swift
//  Dev
//
//  Created by Egi Wibowo on 30/12/21.
//

import Foundation
import SwiftUI

struct BaseScreen<Content>: View where Content: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

  public func showModal() {

  }

    var body : some View {
      VStack {
        content
      }
    }
}

struct BaseView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
      HStack {
            Image("iosAppTemplates-logo-icon")
          }.padding(.top, 60)
          Spacer()
          Text("iOS App Templates")
      content
    }
}
