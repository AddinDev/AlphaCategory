//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import Common
import Combine
import RealmSwift
import Foundation

public struct GetCategoriesLocaleDataSource: LocaleDataSource {
  
  public typealias Request = Any
  public typealias Response = CategoryEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Any?) -> AnyPublisher<[CategoryEntity], Error> {
    return Future<[CategoryEntity], Error> { completion in
      let categories: Results<CategoryEntity> = {
      _realm.objects(CategoryEntity.self)
        .sorted(byKeyPath: "title", ascending: true)
      }()
      completion(.success(categories.toArray(ofType: CategoryEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [CategoryEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for category in entities {
          _realm.add(category)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  public func get(id: String) -> AnyPublisher<CategoryEntity, Error> {
    fatalError()
  }
  
  public func update(id: String, entity: CategoryEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
}
