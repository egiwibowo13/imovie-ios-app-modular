//
//  NavigationLazyView.swift
//  CommonUI
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import SwiftUI

public struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}
