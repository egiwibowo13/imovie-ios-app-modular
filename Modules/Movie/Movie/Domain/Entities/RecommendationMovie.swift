//
//  RecommendMovie.swift
//  Movie
//
//  Created by Egi Wibowo on 02/10/21.
//

import Foundation

struct RecommendationMovie: Identifiable {
  let id: Int
  let title: String
  let description: String
  let poster: String
  
  static var examples: [RecommendationMovie] {
    let movie = RecommendationMovie(
      id: 436969,
      title: "hai",
      description: "hai juga",
      poster: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg"
    )
    return [movie, movie, movie, movie, movie, movie, movie, movie]
  }
}
