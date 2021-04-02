//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import Foundation

public struct CategoryModel: Equatable, Identifiable {
  
  public let id: String
  public let title: String
  public let image: String
  public let desc: String
  
  public init(id: String, title: String, image: String, desc: String) {
    self.id = id
    self.title = title
    self.image = image
    self.desc = desc
  }
}
