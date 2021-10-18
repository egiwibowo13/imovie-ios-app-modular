//
//  RealmDataSource.swift
//  Core
//
//  Created by Egi Wibowo on 08/10/21.
//

import Foundation
import RealmSwift
import Combine
import Abstract

public protocol RealmDataSource {
  
  func addMovie(from movie: MovieDB) -> AnyPublisher<Bool, APIError>
  func getMovies() -> AnyPublisher<[MovieDB], APIError>
  func getMovieById(from movieId: Int) -> AnyPublisher<MovieDB, APIError>
  func deleteMovie(from movie: MovieDB) -> AnyPublisher<Bool, APIError>
  func checkHaveMovie(from movieId: Int) -> AnyPublisher<Bool, APIError>

}

public final class RealmDataSourceImp: NSObject {

  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  public static let sharedInstance: (Realm?) -> RealmDataSourceImp = { realmDatabase in
    return RealmDataSourceImp(realm: realmDatabase)
  }
}

extension RealmDataSourceImp: RealmDataSource {
  
  public func addMovie(from movie: MovieDB) -> AnyPublisher<Bool, APIError> {
    return Future<Bool, APIError> { completion in
      if let realm = self.realm {
             do {
               try realm.write {
                   realm.add(movie, update: .all)
                 completion(.success(true))
               }
             } catch {
               completion(.failure(APIError.requestFailed))
             }
           } else {
             completion(.failure(APIError.invalidInstance))
           }
    }.eraseToAnyPublisher()
  }
  
  public func getMovies() -> AnyPublisher<[MovieDB], APIError> {
    return Future<[MovieDB], APIError> { completion in
      if let realm = self.realm {
        let movies: Results<MovieDB> = {
          realm.objects(MovieDB.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(movies.toArray(ofType: MovieDB.self)))
      } else {
        completion(.failure(APIError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func getMovieById(from movieId: Int) -> AnyPublisher<MovieDB, APIError> {
    return Future<MovieDB, APIError> { completion in
      if let realm = self.realm {
        let query = NSPredicate(format: "id == %d", movieId)
        let movies: Results<MovieDB> = realm.objects(MovieDB.self).filter(query)
        let moviesArr = movies.toArray(ofType: MovieDB.self)
        if moviesArr.count > 0 {
          completion(.success(moviesArr[0]))
        } else {
          completion(.failure(APIError.dataNotFound))
        }
      } else {
        completion(.failure(APIError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func checkHaveMovie(from movieId: Int) -> AnyPublisher<Bool, APIError> {
    return Future<Bool, APIError> { completion in
      if let realm = self.realm {
        let query = NSPredicate(format: "id == %d", movieId)
        let movies: Results<MovieDB> = realm.objects(MovieDB.self).filter(query)
          let moviesArr = movies.toArray(ofType: MovieDB.self)
          if moviesArr.count > 0 {
            completion(.success(true))
          } else {
            completion(.success(false))
          }
      } else {
        completion(.failure(APIError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  public func deleteMovie(from movie: MovieDB) -> AnyPublisher<Bool, APIError> {
    return Future<Bool, APIError> { completion in
      if let realm = self.realm {
             do {
               try realm.write {
                let query = NSPredicate(format: "id == %d", movie.id)
                  realm.delete(realm.objects(MovieDB.self).filter(query))
                 completion(.success(true))
               }
             } catch {
               completion(.failure(APIError.requestFailed))
             }
           } else {
             completion(.failure(APIError.invalidInstance))
           }
    }.eraseToAnyPublisher()
  }
}
