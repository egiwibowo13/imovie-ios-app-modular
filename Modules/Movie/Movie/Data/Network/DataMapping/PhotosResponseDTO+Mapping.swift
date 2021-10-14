//
//  PhotoResponseDTO+Mapping.swift
//  Movie
//
//  Created by Egi Wibowo on 07/10/21.
//

import Foundation

struct PhotosResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
      case photos = "posters"
    }
    let photos: [PhotoDTO]
}

extension PhotosResponseDTO {
  struct PhotoDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
      case filePath = "file_path"
      case height = "height"
      case width = "width"
    }
    let width: Int
    let height: Int
    let filePath: String
  }
}

extension PhotosResponseDTO {
  func toDomain() -> [Photo] {
    photos.map { photo in
      photo.toDomain()
    }
  }
}

extension PhotosResponseDTO.PhotoDTO {
  func toDomain() -> Photo {
    Photo(url: "https://image.tmdb.org/t/p/w500\(filePath)")
  }
}
