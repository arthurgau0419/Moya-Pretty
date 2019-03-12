//
//  Moya+Pretty.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//

import Foundation
import Moya

extension TargetType {
  public var task: Task {
    return .requestPlain
  }

  public var sampleData: Data {
    return "You should implement your own sample data if needed.".data(using: .utf8)!
  }

  var headers: [String : String]? {
    return nil
  }
}

extension Cancellable {
  /// Finish the function chain and avoid warnings.
  public func cauterize() {}
}
