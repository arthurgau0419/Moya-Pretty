//
//  TargetType+Codable.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/4.
//

import Foundation
import Moya

public protocol DecodableMixin {
  /// Decodable model type for requestModel() output.
  associatedtype DecodableModel: Decodable
}

public protocol EncodableMixin {
  /// Encodable model type for JSON request body.
  associatedtype EncodableModel: Encodable
  /// Encodable model for JSON request body.
  var body: EncodableModel {get}
}

open class JSONEncodableTarget<InputModel: Encodable>: EncodableMixin {
  public var body: InputModel
  public typealias EncodableModel = InputModel
  public init(body: InputModel) {
    self.body = body
  }
}

open class JSONDecodableTarget<OutputModel: Decodable>: DecodableMixin {
  public typealias DecodableModel = OutputModel
  public init() {}
}

open class JSONCodableTarget<InputModel: Encodable, OutputModel: Decodable>: EncodableMixin, DecodableMixin {
  public var body: InputModel
  public typealias EncodableModel = InputModel
  public typealias DecodableModel = OutputModel
  public init(body: InputModel) {
    self.body = body
  }
}

extension TargetType where Self: EncodableMixin {
  public var task: Task {    
    return .requestJSONEncodable(body)
  }
}





