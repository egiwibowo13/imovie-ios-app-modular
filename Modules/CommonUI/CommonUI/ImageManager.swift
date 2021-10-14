//
//  ImageManager.swift
//  CommonUI
//
//  Created by Egi Wibowo on 28/09/21.
//

import Foundation
import SwiftUI

public enum ImageSource: String {
  case ic_account = "ic-account"
  case ic_search = "ic-search"
  case logo = "logo"
}

public extension View {
  func MyImage(
    source: ImageSource,
    type: PictureType = PictureType.square,
    size: PictureSize = PictureSize.medium
  ) -> some View {
    return Image(source.rawValue, bundle: Constants.bundle).picture(type: type, size: size)
  }
  
  func MyIcon(systemName: String) -> some View {
    Image(systemName: systemName)
      .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .padding(0)
  }
}
