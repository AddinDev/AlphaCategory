//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import Common

public struct CategoryTransformer: Mapper {
  
  public typealias Request = Any
  
  public typealias Response = [CategoryResponse]
  
  public typealias Entity = [CategoryEntity]
  
  public typealias Domain = [CategoryModel]
  
  public init() {}
  
  public func transformResponseToEntity(request: Any?, response: [CategoryResponse]) -> [CategoryEntity] {
    return response.map { result in
      let newCategory = CategoryEntity()
      newCategory.id = result.id ?? ""
      newCategory.title = result.title ?? ""
      newCategory.image = result.image ?? ""
      newCategory.desc = result.desc ?? ""
      return newCategory
    }
  }
  
  public func transformEntityToDomain(entity: [CategoryEntity]) -> [CategoryModel] {
    return entity.map { result in
      return CategoryModel(id: result.id,
                           title: result.title,
                           image: result.image,
                           desc: result.desc)
    }
  }
  
}
