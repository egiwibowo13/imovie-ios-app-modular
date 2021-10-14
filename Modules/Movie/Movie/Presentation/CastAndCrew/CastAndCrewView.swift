//
//  CastAndCrewView.swift
//  Movie
//
//  Created by Egi Wibowo on 22/09/21.
//

import SwiftUI
import CommonUI

struct CastAndCrewView: View {
  var castsAndCrews: [CastAndCrew]
  init(castsAndCrews: [CastAndCrew]) {
    self.castsAndCrews = castsAndCrews
  }
  
  public var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        ForEach(castsAndCrews) { cast in
          CastItemView(name: cast.name, character: cast.character, url: cast.profileUrl)
        }
      }.padding(.all, 16)
    }.frame(alignment: .leading)
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Cast & Crew")
  }
}

struct CastAndCrewView_Previews: PreviewProvider {
    static var previews: some View {
        CastAndCrewView(castsAndCrews: CastAndCrew.examples)
    }
}
