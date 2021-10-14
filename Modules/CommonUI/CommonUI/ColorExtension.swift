//
//  ColorManager.swift
//  CommonUI
//
//  Created by Egi Wibowo on 20/09/21.
//

import Foundation
import SwiftUI

let frameworkBundle = Bundle(identifier: "co.id.egiwibowo.CommonUI")!

public extension Color {
  
  static let primaryColor = Color(UIColor(named: "primaryColor", in: frameworkBundle, compatibleWith: nil)!)
  static let secondaryColor = Color(UIColor(named: "secondaryColor", in: frameworkBundle, compatibleWith: nil)!)
  static let goldColor = Color(UIColor(named: "goldColor", in: frameworkBundle, compatibleWith: nil)!)
  
}
