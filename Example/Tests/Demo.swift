//
//  Demo.swift
//  Moya-Pretty_Tests
//
//  Created by Kao Ming-Hsiu on 2018/7/4.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import Moya_Pretty
import Moya

struct Pet: Decodable, Encodable {
  let id: Int
  let name: String
}

protocol Service {
  var baseURL: URL {get}
  var headers: [String : String]? {get}
}

extension Service {
  var baseURL: URL {
    return URL(string: "http://petstore.swagger.io/v2")!
  }
  var headers: [String : String]? {
    return nil
  }
}

struct PetService {
  // Generic Provider
  static func provider<Target: TargetType>(_ type: Target.Type) -> MoyaProvider<Target> {
    return MoyaProvider<Target>(
      plugins: [
        FlexibleAccessTokenPlugin(tokenClosure: "some token", httpHeaderField: "Authorization", httpHeaderValueFormat: "Auth %@")
      ]
    )
  }
  
  // POST api/pet
  class AddPet: JSONCodableTarget<Pet, Pet>, TargetType, Service {
    var method = Moya.Method.post
    var path = "pet/"
  }
      
  // GET api/pet/{id}
  class GetPet: JSONDecodableTarget<Pet>, TargetType, Service {
    var method = Moya.Method.get
    var path: String { return "/pet/\(id)/"}
    let id: Int
    
    init(id: Int) {
      self.id = id
      super.init()
    }
  }
  
  // GET api/pet
  class GetPetList: JSONDecodableTarget<[Pet]>, TargetType, Service {
    var method = Moya.Method.get
    var path = "pet/"
    var task = Task.requestPlain
  }
  
  // GET api/pet/?filterField=filterValue
  class GetPetsWithFilter: JSONDecodableTarget<Pet>, TargetType, Service, FilterableTarget {
    var method = Moya.Method.get
    var path = "pet/"
    var sampleData: Data {
      return try! JSONEncoder().encode([Pet(id: 1, name: "")])
    }
    var filter: [String : Any]
    init(filter: [String : Any]) {
      self.filter = filter
      super.init()
    }
  }
  
}

extension MoyaProvider {
  class var `default`: MoyaProvider<Target> {
    return MoyaProvider<Target>.init(plugins: [NetworkLoggerPlugin()])
  }
  convenience init(log: Bool) {
    var plugins: [PluginType] = []
    if log {
      plugins.append(NetworkLoggerPlugin())
    }
    self.init(plugins: plugins)
  }
}

