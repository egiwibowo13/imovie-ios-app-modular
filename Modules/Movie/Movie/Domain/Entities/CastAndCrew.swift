//
//  CastAndCrew.swift
//  Movie
//
//  Created by Egi Wibowo on 02/10/21.
//

import Foundation

struct CastAndCrew: Identifiable {
  let id: Int
  let name: String
  let character: String
  let profileUrl: String
  
  static var examples: [CastAndCrew] {
    let cast = CastAndCrew(
      id: 1,
      name: "margon",
      character: "jeli",
      profileUrl: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg"
    )
    return [cast, cast, cast, cast, cast]
  }
}
