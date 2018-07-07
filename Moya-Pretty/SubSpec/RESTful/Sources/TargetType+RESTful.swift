//
//  TargetType+RESTful.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//

import Foundation
import Moya

public protocol FilterableTarget {
  /// Filter fields in RESTful url query.
  var filter: [String: Any] {get}
}

extension TargetType where Self: FilterableTarget {
  public var task: Task {
    return .requestParameters(parameters: filter, encoding: URLEncoding.default)
  }
}
