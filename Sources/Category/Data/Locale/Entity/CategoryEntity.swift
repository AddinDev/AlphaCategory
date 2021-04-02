//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import Foundation
import RealmSwift

public class CategoryEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var desc: String = ""
  
  public override static func primaryKey() -> String? {
    return "id"
  }
}
