//
//  ListView.swift
//  CommonUI
//
//  Created by Egi Wibowo on 02/10/21.
//

import SwiftUI

public struct ListView: View {
  var title: String
  public init(title: String) {
    self.title = title
  }
    public var body: some View {
      VStack {
        HStack {
          Text(title)
          Spacer()
          Text("View All").padding(.trailing, 16)
        }
      }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
       ListView(title: "hallo")
    }
}

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
