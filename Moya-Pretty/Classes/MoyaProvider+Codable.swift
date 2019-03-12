//
//  MoyaProvider+Codable.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/4.
//

import Foundation
import Moya
import Result

extension MoyaProvider where Target: DecodableType {
  open func requestModel(_ target: Target, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder? = nil, failsOnEmptyData: Bool = true, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping ((_ result: Result<Target.DecodableModel, MoyaError>) -> Void)) -> Cancellable {
    
    return request(target, callbackQueue: callbackQueue, progress: progress, completion: { (result) in
      
      let modelResult = result
        .flatMap { response -> Result<Target.DecodableModel, MoyaError> in
          Result<Target.DecodableModel, MoyaError>(attempt: {
            try response.toModel(target: target, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)
          })
      }
      
      completion(modelResult)
    })
  }
}

extension Response {
  internal func toModel<Target: DecodableType>(target: Target, atKeyPath keyPath: String?, using decoder: JSONDecoder?, failsOnEmptyData: Bool) throws -> Target.DecodableModel {
    do {
      let decoder = decoder ?? target.decoder ?? JSONDecoder()
      return try map(Target.DecodableModel.self, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)
    } catch let moyaError as MoyaError {
      throw moyaError
    } catch {
      throw MoyaError.underlying(error, self)
    }
  }
}
