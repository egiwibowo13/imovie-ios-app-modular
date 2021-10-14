//
//  CastItemView.swift
//  CommonUI
//
//  Created by Egi Wibowo on 06/10/21.
//

import SwiftUI

public struct CastItemView: View {
  let name: String
  let character: String
  let url: String
  public init(name: String, character: String, url: String) {
    self.name = name
    self.character = character
    self.url = url
  }
    public var body: some View {
      HStack {
        ImageAsync(url, type: .circle, size: .small)
        Text(name).font(.subheadlineFont).foregroundColor(.black)
        Spacer()
        Text(character).font(.subheadlineFont).foregroundColor(.gray)
      }
    }
}

struct CastItemView_Previews: PreviewProvider {
    static var previews: some View {
      CastItemView(name: "Jodie Cornor", character: "Millie", url: "path")
    }
}
