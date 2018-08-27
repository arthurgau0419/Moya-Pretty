//
//  JsonApiHeaderPlugin.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/8/27.
//

import Foundation
import Moya

public struct JsonApiAcceptHeaderPlugin: PluginType {
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var newRequest = request
    newRequest.allHTTPHeaderFields?.updateValue("application/vnd.api+json", forKey: "Accept")
    return newRequest
  }
}

public struct JsonApiContentTypeHeaderPlugin: PluginType {
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var newRequest = request
    newRequest.allHTTPHeaderFields?.updateValue("application/vnd.api+json", forKey: "Content-Type")
    return newRequest
  }
}
