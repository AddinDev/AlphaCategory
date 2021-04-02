//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import Foundation

public struct CategoriesResponse: Decodable {
  let categories: [CategoryResponse]
}

public struct CategoryResponse: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case id = "idCategory"
    case title = "strCategory"
    case image = "strCategoryThumb"
    case desc = "strCategoryDescription"
  }
  
  let id: String?
  let title: String?
  let image: String?
  let desc: String?
  
}
