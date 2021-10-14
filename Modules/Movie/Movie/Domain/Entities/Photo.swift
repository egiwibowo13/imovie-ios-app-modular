//
//  File.swift
//  Movie
//
//  Created by Egi Wibowo on 02/10/21.
//

import Foundation

struct Photo: Identifiable {
  let id = UUID()
  let url: String
  
  static var examples: [Photo] {
    let photo = Photo(
      url: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg"
    )
    return [photo, photo, photo, photo, photo, photo, photo, photo]
  }
}
