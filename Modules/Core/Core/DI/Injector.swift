//
//  Injector.swift
//  Core
//
//  Created by Egi Wibowo on 09/10/21.
//

import Foundation
import RealmSwift

public class CoreInjector {
  
  public init() {}
  
  public func provideRealm() -> Realm? {
    var config = Realm.Configuration.defaultConfiguration
    config.objectTypes = [MovieDB.self]
    let realm = try? Realm(configuration: config)
    return realm
  }
  
  public func provideRealmDatabase() -> RealmDataSource {
    return RealmDataSourceImp.sharedInstance(provideRealm())
  }
}
