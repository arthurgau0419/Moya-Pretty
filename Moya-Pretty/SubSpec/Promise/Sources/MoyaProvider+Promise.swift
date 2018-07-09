//
//  MoyaProvider+RxSwift.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/6.
//

import Foundation
import Moya
import PromiseKit
#if canImport(ObjectMapper)
import ObjectMapper
#endif

extension MoyaProvider {
  /*
   Request response using PromiseKit.
   **/
  public func request(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Promise<Response>  {
    return Promise<Response>.init { (seal) in
      _ = self.request(token, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let response):
          seal.fulfill(response)
        case .failure(let error):
          seal.reject(error)
        }
      })
    }
  }
}

extension MoyaProvider where Target: DecodableType {
  /*
   Request deodable object using PromiseKit.
   **/
  public func requestModel(_ token: Target, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder? = nil, failsOnEmptyData: Bool = true, callbackQueue: DispatchQueue? = nil) -> Promise<Target.DecodableModel>  {
    return Promise<Target.DecodableModel>.init { (seal) in
      _ = self.requestModel(token, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let model):
          seal.fulfill(model)
        case .failure(let error):
          seal.reject(error)
        }
      })
    }
  }
}

#if canImport(ObjectMapper)
extension MoyaProvider where Target: MappableResponseType {
  /*
   Request mappable object using PromiseKit.
   **/
  public func requestModel(_ token: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> Promise<Target.MappableResponseModel>  {
    return Promise<Target.MappableResponseModel>.init { (seal) in
      _ = self.requestModel(token, option: option, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let model):
          seal.fulfill(model)
        case .failure(let error):
          seal.reject(error)
        }
      })
    }
  }
}
#endif

#if canImport(ObjectMapper) && canImport(XMLDictionary)
extension MoyaProvider where Target: MappableResponseType {
  /*
   Request mappable object using PromiseKit.
   **/
  public func requestXmlModel(_ token: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> Promise<Target.MappableResponseModel>  {
    return Promise<Target.MappableResponseModel>.init { (seal) in
      _ = self.requestXmlModel(token, option: option, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let model):
          seal.fulfill(model)
        case .failure(let error):
          seal.reject(error)
        }
      })
    }
  }
}
#endif

