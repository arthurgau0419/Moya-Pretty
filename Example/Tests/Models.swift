//
//  Models.swift
//  Moya-Pretty_Tests
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper

struct Pet: Decodable, Encodable {
  enum Status: String {
    case available = "available"
    case pending = "pending"
    case sold = "sold"
  }
  let id: Int
  let name: String
}

class MappablePet: ImmutableMappable {
  let id: Int
  let name: String?

  required init(map: Map) throws {
    id = try map.value("id")
    name = try? map.value("name")
  }

  func mapping(map: Map) {
    id >>> map["id"]
    name >>> map["name"]
  }
}

class XMLMappablePet: ImmutableMappable {
  // XML 沒有辦法區分 int, string ... ?
  let id: String
  let name: String?

  required init(map: Map) throws {
    id = try map.value("id")
    name = try? map.value("name")
  }

  func mapping(map: Map) {
    id >>> map["id"]
    name >>> map["name"]
  }
}
