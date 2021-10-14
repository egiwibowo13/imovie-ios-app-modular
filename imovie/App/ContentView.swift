//
//  ContentView.swift
//  imovie
//
//  Created by Egi Wibowo on 20/09/21.
//

import SwiftUI
import Home

struct ContentView: View {
  
  var body: some View {
    NavigationView {
      LandingView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
