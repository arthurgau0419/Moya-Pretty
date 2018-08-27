//
//  TargetType+Japx.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/8/27.
//

import Foundation
import Moya
import Japx

open class JapxEncodableTarget<InputModel: Encodable>: JapxEncodableType {
  public var body: InputModel
  public var encoder: JSONEncoder?
  public var japxEncoder: JapxEncoder?
  public typealias EncodableModel = InputModel
  public init(body: InputModel) {
    self.body = body
  }
}

open class JapxDecodableTarget<OutputModel: Decodable>: JapxDecodableType {
  public typealias DecodableModel = OutputModel
  public var decoder: JSONDecoder?
  public var japxDecoder: JapxDecoder?
  public init() {}
}

open class JapxCodableTarget<InputModel: Encodable, OutputModel: Decodable>: JapxEncodableType, JapxDecodableType {
  public var body: InputModel
  public var encoder: JSONEncoder?
  public var decoder: JSONDecoder?
  public var japxEncoder: JapxEncoder?
  public var japxDecoder: JapxDecoder?
  public typealias EncodableModel = InputModel
  public typealias DecodableModel = OutputModel
  public init(body: InputModel) {
    self.body = body
  }
}

public protocol JapxDecodableType: DecodableType  {
  var japxDecoder: JapxDecoder? {get}
}

public protocol JapxEncodableType: EncodableType {
  var japxEncoder: JapxEncoder? {get}
}

extension TargetType where Self: JapxEncodableType {
  public var task: Task {
    let japxEncoder = self.japxEncoder ?? JapxEncoder()
    let data = (try? japxEncoder.encode(body)) ?? [String: Any]()
    return Task.requestParameters(parameters: data, encoding: JSONEncoding.default)
  }
}
