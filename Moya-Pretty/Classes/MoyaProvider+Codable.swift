//
//  MoyaProvider+Codable.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/4.
//

import Foundation
import Moya
import Result

extension MoyaProvider where MoyaProvider.Target: DecodableType {
  open func requestModel(_ target: Target, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder? = nil, failsOnEmptyData: Bool = true, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping ((_ result: Result<Target.DecodableModel, MoyaError>) -> Void)) -> Cancellable {
    
    return self.request(target, callbackQueue: callbackQueue, progress: progress, completion: { (result) in
      
      let modelResult = result.flatMap({ (response) -> Result<Target.DecodableModel, MoyaError> in
        do {
          let decoder = decoder ?? target.decoder ?? JSONDecoder()
          return try Result.success(response.map(Target.DecodableModel.self, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData))
        } catch let moyaError as MoyaError {
          return Result.failure(moyaError)
        } catch {
          return Result.failure(MoyaError.underlying(error, response))
        }
      })
      completion(modelResult)
    })
  }
}
