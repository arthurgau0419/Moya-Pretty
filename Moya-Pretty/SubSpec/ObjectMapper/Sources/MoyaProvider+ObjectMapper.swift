//
//  MoyaProvider+ObjectMapper.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/6.
//

import Foundation
import Moya
import ObjectMapper
import Result

extension MoyaProvider where MoyaProvider.Target: MappableResponseType {
  open func requestModel(_ target: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping ((_ result: Result<Target.MappableResponseModel, MoyaError>) -> Void)) -> Cancellable {
    return self.request(target, callbackQueue: callbackQueue, progress: progress, completion: { (result) in
      let modelResult = result.flatMap {response in
        Result<Target.MappableResponseModel, MoyaError>(catching: {
          try response.toModel(target: target, option: option)
        })
      }
      completion(modelResult)
    })
  }
}

extension Response {
  internal func toModel<Target: MappableResponseType>(target: Target, option: MapperOption?) throws -> Target.MappableResponseModel {
    let option = option ?? target.mapperOption
    let mapper = Mapper<Target.MappableResponseModel>(context: option.context, shouldIncludeNilValues: option.shouldIncludeNilValues)
    do {
      guard let mappable = mapper.map(JSONString: try mapString()) else {throw MoyaError.jsonMapping(self)}
      return mappable
    } catch let moyaError as MoyaError {
      throw moyaError
    } catch {
      throw MoyaError.underlying(error, self)
    }
  }
}
