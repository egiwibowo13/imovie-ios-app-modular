//
//  ImageManager.swift
//  CommonUI
//
//  Created by Egi Wibowo on 28/09/21.
//

import Foundation
import SwiftUI

public extension View {
  
  func MyIcon(systemName: String) -> some View {
    Image(systemName: systemName)
      .frame(alignment: .center)
      .padding(0)
  }
}
