//
//  Internationalization.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
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
