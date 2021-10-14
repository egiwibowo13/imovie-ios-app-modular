//
//  MockCastAndCrews.swift
//  MovieTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import Foundation
@testable import Movie

extension CastAndCrew {
  
  static func getMock(id: Int) -> CastAndCrew {
    CastAndCrew(
      id: id,
      name: "Jhon",
      character: "Deep",
      profileUrl: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg"
    )
  }
  
  static func getMockCastAndCrews(num: Int) -> [CastAndCrew] {
    var castAndCrews: [CastAndCrew] = []
    for n in 1...num {
      castAndCrews.append(CastAndCrew.getMock(id: n))
    }
    return castAndCrews
  }
}
