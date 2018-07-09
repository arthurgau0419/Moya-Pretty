//
//  TargetType+ObjectMapper.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//

import Foundation
import Moya
import ObjectMapper
import Alamofire

public struct MapperOption {
  let context: MapContext?
  let shouldIncludeNilValues: Bool
  init(context: MapContext? = nil, shouldIncludeNilValues: Bool = false) {
    self.context = context
    self.shouldIncludeNilValues = shouldIncludeNilValues
  }
}

public protocol MappableBodyType {
  associatedtype MappableBodyModel: BaseMappable
  var body: MappableBodyModel {get}
  var mapperOption: MapperOption {get}
}

public protocol MappableResponseType {
  associatedtype MappableResponseModel: BaseMappable
  var mapperOption: MapperOption {get}
}

open class MappableBodyTarget<InputModel: Mappable>: MappableBodyType {
  public var body: InputModel
  public typealias MappableBodyModel = InputModel
  public var mapperOption = MapperOption()
  public init(body: InputModel) {
    self.body = body
  }
}

open class MappableResponseTarget<OutputModel: BaseMappable>: MappableResponseType {
  public typealias MappableResponseModel = OutputModel
  public var mapperOption = MapperOption()
  public init() {}
}

open class MappableTarget<InputModel: BaseMappable, OutputModel: BaseMappable>: MappableBodyType, MappableResponseType {
  public var body: InputModel
  public typealias MappableBodyModel = InputModel
  public typealias MappableResponseModel = OutputModel
  public var mapperOption = MapperOption()
  public init(body: InputModel) {
    self.body = body
  }
}

extension TargetType where Self: MappableBodyType {
  public var task: Task {
    return .requestParameters(parameters: Mapper<Self.MappableBodyModel>(context: mapperOption.context, shouldIncludeNilValues: mapperOption.shouldIncludeNilValues).toJSON(body), encoding: JSONEncoding.default)
  }
}
