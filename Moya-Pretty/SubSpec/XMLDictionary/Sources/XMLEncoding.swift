//
//  XMLEncoding.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//

import Foundation
import Alamofire

public struct XMLEncoding: ParameterEncoding {
  
  public static var `default`: XMLEncoding { return XMLEncoding() }
  
  public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    var urlRequest = try urlRequest.asURLRequest()
    guard let parameters = parameters else {
      return urlRequest
    }
    guard let xml = (parameters as NSDictionary).xmlString.data(using: .utf8) else {
      return urlRequest
    }
    urlRequest.httpBody = xml
    urlRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")
    return urlRequest
  }
}
