//
//  ViewExtension.swift
//  CommonUI
//
//  Created by Egi Wibowo on 21/09/21.
//

import SwiftUI

public struct ButtonSelectionItem: Identifiable {
  public var id = 0
  public let title: String
  public init(id: Int, title: String) {
    self.id = id
    self.title = title
  }
}

public struct ButtonSelection: View {
  let data: [ButtonSelectionItem]
  let activeId: Int
  let action: (_ _id: Int) -> Void
  
  private let WIDTH: CGFloat = 360
  private let HEIGHT: CGFloat = 40
  private let SPACE: CGFloat = 8
  private let RADIUS: CGFloat = 20
  
  public init(data: [ButtonSelectionItem], activeId: Int, action: @escaping (_ _id: Int) -> Void) {
    self.data = data
    self.activeId = activeId
    self.action = action
  }

  public var body: some View {
    HStack(alignment: .center, spacing: 0) {
      ForEach(data) { item in
          Button(action: {
            action(item.id)
          }, label: {
              VStack(alignment: .center, spacing: 0) {
                      Text(item.title).foregroundColor(
                        item.id == activeId ? .white : .gray
                      ).font(.headlineFont)
              }
          })
          .frame(width: (WIDTH - SPACE) / CGFloat(data.count), height: (HEIGHT - SPACE), alignment: .center)
          .background(
           item.id == activeId ? Color.primaryColor : Color.white)
          .cornerRadius(RADIUS - (SPACE / CGFloat(data.count)))
      }
  }
    .frame(width: WIDTH, height: HEIGHT, alignment: .center)
    .background(Color.white)
    .overlay(
      RoundedRectangle(cornerRadius: RADIUS)
        .stroke(Color.gray, lineWidth: 1))
  }
}

struct ViewExtension: View {
  @State private var activeId = 0
  var options: [ButtonSelectionItem] = [
    ButtonSelectionItem(id: 0, title: "hai"),
    ButtonSelectionItem(id: 1, title: "hai"),
    ButtonSelectionItem(id: 2, title: "hai juga"),
    ButtonSelectionItem(id: 3, title: "hai juga")
  ]

  var body: some View {
    ButtonSelection(data: options, activeId: activeId, action: { id in
      self.activeId = id
    })
  }
}

struct ViewExtension_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        ViewExtension()
      }
    }
}
