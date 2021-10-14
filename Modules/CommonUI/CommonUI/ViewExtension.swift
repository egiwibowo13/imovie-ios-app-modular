//
//  ViewExtension.swift
//  CommonUI
//
//  Created by Egi Wibowo on 22/09/21.
//

import SwiftUI

public extension View {
  func fillParent(alignment: Alignment = .center) -> some View {
      return GeometryReader { geometry in
          self
              .frame(width: geometry.size.width,
                     height: geometry.size.height,
                     alignment: alignment)
      }
  }
  
  func toAnyView() -> AnyView {
      return AnyView(self)
  }
  
  func toLazyAnyView() -> AnyView {
    return makeLazyView(self).toAnyView()
  }

  func LoadingProgress(_ s: CGFloat) -> some View {
    ProgressView()
      .scaleEffect(s, anchor: .center)
      .progressViewStyle(CircularProgressViewStyle(tint: .primaryColor))
  }
  
}

public func makeLazyView<Content: View>(_ build: @autoclosure @escaping () -> Content) -> AnyView {
  return AnyView(NavigationLazyView(build()))
}
