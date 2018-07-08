//
//  AcceptHeader.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//

import Foundation
import Moya

public enum AcceptType: String {
  case textPlain = "text/plain"
  case json = "application/json"
  case xml = "application/xml"
  case yaml = "application/yaml"
}

public struct AcceptHeaderPlugin: PluginType {
  public let accepts: [String]
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var req = request
    req.addValue(accepts.joined(separator: ","), forHTTPHeaderField: "Accept")
    return req
  }
  
  public init(accepts: [AcceptType]) {
    self.accepts = accepts.map {$0.rawValue}
  }
  
  public init(accepts: [String]) {
    self.accepts = accepts
  }
}
