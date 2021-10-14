//
//  MockPhoto.swift
//  MovieTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import Foundation
@testable import Movie

extension Photo {
  static func getMock(id: Int) -> Photo {
    Photo(url:  "https://image.tmdb.org/t/p/w500/\(id).jpg")
  }
  
  static func getMockPhotos(num: Int) -> [Photo] {
    var photos: [Photo] = []
    for n in 1...num {
      photos.append(Photo.getMock(id: n))
    }
    return photos
  }
}
