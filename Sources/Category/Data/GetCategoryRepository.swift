//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import Common
import Combine

public struct GetCategoryRepository<
  CategoryLocaleDataSource: LocaleDataSource,
  CategoryRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
where
  CategoryLocaleDataSource.Response == CategoryEntity,
  CategoryRemoteDataSource.Response == [CategoryResponse],
  Transformer.Response == [CategoryResponse],
  Transformer.Entity == [CategoryEntity],
  Transformer.Domain == [CategoryModel] {
    
  public typealias Request = Any
  public typealias Response = [CategoryModel]
  
  private let _localeDataSource: CategoryLocaleDataSource
  private let _remoteDataSource: CategoryRemoteDataSource
  private let _mapper: Transformer
  
  public init(localeDataSource: CategoryLocaleDataSource, remoteDataSource: CategoryRemoteDataSource, mapper: Transformer) {
    _localeDataSource = localeDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<[CategoryModel], Error> {
    return _localeDataSource.list(request: nil)
      .flatMap { result -> AnyPublisher<[CategoryModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: nil)
            .map { _mapper.transformResponseToEntity(request: nil, response: $0) }
            .catch {  _ in _localeDataSource.list(request: nil) }
            .flatMap { _localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.list(request: nil)
              .map { _mapper.transformEntityToDomain(entity: $0) }
            }.eraseToAnyPublisher()
        } else {
          return _localeDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
}

