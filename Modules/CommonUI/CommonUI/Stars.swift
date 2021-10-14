//
//  Stars.swift
//  CommonUI
//
//  Created by Egi Wibowo on 01/10/21.
//

import SwiftUI

public struct Stars: View {
  let num: Int
  let size: CGFloat
  public init(num: Int, size: CGFloat = 14) {
    self.num = num
    self.size = size
  }
  public var body: some View {
      HStack(spacing: 1) {
        ForEach(1...5, id: \.self) { i in
          Image(systemName: i <= num ? "star.fill" : "star")
            .resizable()
            .frame(width: size, height: size)
            .padding(.horizontal, 0)
            .foregroundColor(.goldColor)
          
        }
      }
    }
}

struct Stars_Previews: PreviewProvider {
    static var previews: some View {
      Stars(num: 4, size: 14)
    }
}
