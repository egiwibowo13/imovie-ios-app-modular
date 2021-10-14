//
//  CastAndCrewResponseDTO+Mapping.swift
//  Movie
//
//  Created by Egi Wibowo on 06/10/21.
//

import Foundation
import Core

struct CastAndCrewResponseDTO: Decodable {
  private enum CodingKeys: String, CodingKey {
      case id
      case casts = "cast"
      case crews = "crew"
    }
  let id: Int
  let casts: [Cast]
  let crews: [Crew]
}

extension CastAndCrewResponseDTO {
  struct Cast: Decodable {
     private enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
     }
    let id: Int
    let name: String?
    let profilePath: String?
    let character: String?
  }
  
  struct Crew: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case job
      }
    let id: Int
    let name: String?
    let profilePath: String?
    let job: String?
  }
}

extension CastAndCrewResponseDTO {
    func toDomain() -> [CastAndCrew] {
      let newCasts: [CastAndCrew] = casts
        .map { cast in
        cast.toDomain()
        }
      let newCrews: [CastAndCrew] = crews.map { crew in
        crew.toDomain()
      }
      return newCasts + newCrews
    }
}

extension CastAndCrewResponseDTO.Cast {
    func toDomain() -> CastAndCrew {
      CastAndCrew(
        id: id,
        name: name ?? "unnamed",
        character: character ?? "",
        profileUrl: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")"
      )
    }
}

extension CastAndCrewResponseDTO.Crew {
    func toDomain() -> CastAndCrew {
      CastAndCrew(
        id: id,
        name: name ?? "unnamed",
        character: job ?? "",
        profileUrl: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")"
      )
    }
}
