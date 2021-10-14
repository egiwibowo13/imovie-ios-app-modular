//
//  MovieDB.swift
//  Core
//
//  Created by Egi Wibowo on 08/10/21.
//

import Foundation
import RealmSwift

public class MovieDB: Object {
  @Persisted(primaryKey: true) public dynamic var id: Int = 0
  @Persisted public dynamic var title: String = ""
  @Persisted public dynamic var posterUrl: String = ""
  @Persisted public dynamic var backdropUrl: String = ""
  @Persisted public dynamic var overview: String = ""
  @Persisted public dynamic var voteAverage: Double = 0.0
  @Persisted public dynamic var totalVote: Int = 0
  @Persisted public dynamic var releaseDate: String = ""
  @Persisted public dynamic var genres: String = ""
  @Persisted public dynamic var runtime: Int = 0

//  public override static func primaryKey() -> String? {
//    return "id"
//  }
}
