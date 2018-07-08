//
//  TargetType+Codable.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/4.
//

import Foundation
import Moya

public protocol DecodableType {
  /// Decodable model type for requestModel() output.
  associatedtype DecodableModel: Decodable
}

public protocol EncodableType {
  /// Encodable model type for JSON request body.
  associatedtype EncodableModel: Encodable
  /// Encodable model for JSON request body.
  var body: EncodableModel {get}
}

open class EncodableTarget<InputModel: Encodable>: EncodableType {
  public var body: InputModel
  public typealias EncodableModel = InputModel
  public init(body: InputModel) {
    self.body = body
  }
}

open class DecodableTarget<OutputModel: Decodable>: DecodableType {
  public typealias DecodableModel = OutputModel
  public init() {}
}

open class CodableTarget<InputModel: Encodable, OutputModel: Decodable>: EncodableType, DecodableType {
  public var body: InputModel
  public typealias EncodableModel = InputModel
  public typealias DecodableModel = OutputModel
  public init(body: InputModel) {
    self.body = body
  }
}

extension TargetType where Self: EncodableType {
  public var task: Task {    
    return .requestJSONEncodable(body)
  }
}





