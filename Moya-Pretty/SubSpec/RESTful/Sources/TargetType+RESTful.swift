//
//  TargetType+RESTful.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//

import Foundation
import Moya
import Alamofire

public protocol FilterableTarget {
  /// Filter fields in RESTful url query.
  var filter: [String: Any] {get}
}

extension TargetType where Self: FilterableTarget {
  public var task: Task {
    return .requestParameters(parameters: filter, encoding: URLEncoding(destination: .queryString))
  }
}

public protocol FormPostableTarget {
  /// Form post fields.
  var form: [String: Any] {get}
}

extension TargetType where Self:FormPostableTarget {
  public var task: Task {
    return .requestParameters(parameters: form, encoding: URLEncoding(destination: .httpBody))
  }
}

extension TargetType where Self:FormPostableTarget, Self: FilterableTarget {
  public var task: Task {
    return Task.requestCompositeParameters(bodyParameters: form, bodyEncoding: URLEncoding(destination: .httpBody), urlParameters: filter)
  }
}
