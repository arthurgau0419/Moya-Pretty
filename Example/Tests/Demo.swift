//
//  Demo.swift
//  Moya-Pretty_Tests
//
//  Created by Kao Ming-Hsiu on 2018/7/4.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

//import Foundation
import Moya_Pretty
import Moya

protocol Service {
  var baseURL: URL {get}
  var headers: [String : String]? {get}
}

extension Service {
  var baseURL: URL {
    return URL(string: "https://virtserver.swaggerhub.com/arthurgau0419/Moya-Pretty-SampleAPI/1.0.0")!
  }
  var headers: [String : String]? {
    return nil
  }
}

struct PetService {
  
  // POST api/pet
  class AddPet: CodableTarget<Pet, Pet>, TargetType, Service {
    var method = Method.post
    var path = "pet/"    
  }
  
  // GET api/pet/{id}
  class GetPet: DecodableTarget<Pet>, TargetType, Service {
    var method = Method.get
    var path: String { return "/pet/\(id)/"}
    let id: Int
    
    init(id: Int) {
      self.id = id
      super.init()
    }
  }
  
  // GET api/pet
  class GetPetList: DecodableTarget<[Pet]>, TargetType, Service, FilterableTarget {
    var method = Method.get
    var path = "pet/findByStatus"
    var task = Task.requestPlain
    enum Status: String {
      case available = "available"
      case pending = "pending"
      case sold = "sold"
    }
    let status: Status
    var filter: [String : Any] {
      return ["status": status.rawValue]
    }
    init(status: Status = .available) {
      self.status = status
      super.init()
    }
  }
  
  // GET api/pet/?filterField=filterValue
  class GetPetsWithFilter: DecodableTarget<Pet>, TargetType, Service, FilterableTarget {
    var method = Method.get
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

extension PetService {
  // POST api/pet
  class AddPetMappable: MappableTarget<MappablePet, MappablePet>, TargetType, Service {
    var method = Method.post
    var path = "pet/"
  }
  // POST api/pet
  class AddPetMappableXML: MappableTarget<XMLMappablePet, XMLMappablePet>, XMLTargetType, Service {
    var method = Method.post
    var path = "pet/"
  }
}

extension MoyaProvider {
  class var `default`: MoyaProvider<Target> {
    return MoyaProvider<Target>.init(plugins: [
      NetworkLoggerPlugin(),
      AcceptHeaderPlugin.init(accepts: [.json])
      ])
  }
  class var xml: MoyaProvider<Target> {
    return MoyaProvider<Target>.init(plugins: [
      NetworkLoggerPlugin(),
      AcceptHeaderPlugin.init(accepts: [.xml])
      ])
  }  
}

