//
//  Plugins.swift
//  ObiMoyaExtension
//
//  Created by Kao Ming-Hsiu on 2018/7/5.
//

import Foundation
import Moya

public struct InternationalizationPlugin: PluginType {
  public let languageCode: String
  public let httpHeaderField: String
  public init(languageCode: String, httpHeaderField: String = "Accept-Language ") {
    self.languageCode = languageCode
    self.httpHeaderField = httpHeaderField
  }
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    request.addValue(languageCode, forHTTPHeaderField: httpHeaderField)
    return request
  }
}

public struct FlexibleAccessTokenPlugin: PluginType {
  
  public let httpHeaderField: String
  public let httpHeaderValueFormat: String
  
  /// A closure returning the access token to be applied in the header.
  public let tokenClosure: () -> String
  
  /**
   Initialize a new `FlexibleAccessTokenPlugin`.
   
   - parameters:
   - tokenClosure: A closure returning the token to be applied in the pattern `Authorization: <AuthorizationType> <token>`
   - httpHeaderField: A closure returning the token to be applied in the pattern `Authorization: <AuthorizationType> <token>`
   - httpHeaderValueFormat: A closure returning the token to be applied in the pattern `Authorization: <AuthorizationType> <token>`
   */
  public init(tokenClosure: @escaping @autoclosure () -> String, httpHeaderField: String = "Authorization", httpHeaderValueFormat: String = "%@") {
    self.tokenClosure = tokenClosure
    self.httpHeaderField = httpHeaderField
    self.httpHeaderValueFormat = httpHeaderValueFormat
  }
  
  /**
   Prepare a request by adding an authorization header if necessary.
   
   - parameters:
   - request: The request to modify.
   - target: The target of the request.
   - returns: The modified `URLRequest`.
   */
  public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    let authValue = String(format: httpHeaderValueFormat, tokenClosure())
    request.addValue(authValue, forHTTPHeaderField: httpHeaderField)
    return request
  }
}

