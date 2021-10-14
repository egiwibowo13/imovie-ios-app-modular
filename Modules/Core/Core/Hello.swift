//
//  Hello.swift
//  Core
//
//  Created by Egi Wibowo on 20/09/21.
//

import Foundation
import SwiftUI
 
public var hello: String {
  "Hello from Common asd as"
}

public struct HelloText: View {
  public init() {}
  public var body: some View {
        Text("hai")
            .padding()
    }
}

public struct HelloText_Previews: PreviewProvider {
  public static var previews: some View {
      HelloText()
    }
}
