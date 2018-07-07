//
//  MoyaProvider+ObjectMapper.swift
//  ObiMoyaExtension
//
//  Created by Kao Ming-Hsiu on 2018/7/6.
//

import Foundation
import Moya
import ObjectMapper
import Result

extension MoyaProvider where MoyaProvider.Target: MappableResponseType {
  open func requestModel(_ target: Target, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping ((_ result: Result<Target.MappableResponseModel, MoyaError>) -> Void)) -> Cancellable {
    return self.request(target, callbackQueue: callbackQueue, progress: progress, completion: { (result) in
      let modelResult = result.flatMap({ (response) -> Result<Target.MappableResponseModel, MoyaError> in
        do {
          guard let mappable = Target.MappableResponseModel(JSONString: try response.mapString()) else {throw MoyaError.jsonMapping(response)}
          return Result.success(mappable)
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
