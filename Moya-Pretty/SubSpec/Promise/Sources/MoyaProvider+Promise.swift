//
//  MoyaProvider+RxSwift.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/6.
//

import Foundation
import Moya
import PromiseKit
#if canImport(Japx)
import Japx
#endif
#if canImport(ObjectMapper)
import ObjectMapper
#endif

extension MoyaProvider {
  /*
   Request response using PromiseKit.
   **/
  public func request(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Promise<Response> {
    return Promise<Response>.init { (seal) in
      request(token, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let response):
          seal.fulfill(response)
        case .failure(let error):
          seal.reject(error)
        }
      })
      .cauterize()
    }
  }
}

extension MoyaProvider where Target: DecodableType {
  /*
   Request deodable object using PromiseKit.
   **/
  public func requestModel(_ token: Target, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder? = nil, failsOnEmptyData: Bool = true, callbackQueue: DispatchQueue? = nil) -> Promise<Target.DecodableModel> {
    return Promise<Target.DecodableModel>.init { (seal) in
      requestModel(token, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let model):
          seal.fulfill(model)
        case .failure(let error):
          seal.reject(error)
        }
      })
        .cauterize()
    }
  }
}

#if canImport(Japx)
extension MoyaProvider where Target: JapxDecodableType {
  /*
   Request jsonapi deodable object using PromiseKit.
   **/
  public func requestModel(_ token: Target, using decoder: JapxDecoder? = nil, includeList: String? = nil, callbackQueue: DispatchQueue? = nil) -> Promise<Target.DecodableModel> {
    return Promise<Target.DecodableModel>.init { (seal) in
      requestModel(token, using: decoder, includeList: includeList, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let model):
          seal.fulfill(model)
        case .failure(let error):
          seal.reject(error)
        }
      })
      .cauterize()
    }
  }
}
#endif

#if canImport(ObjectMapper)
extension MoyaProvider where Target: MappableResponseType {
  /*
   Request mappable object using PromiseKit.
   **/
  public func requestModel(_ token: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> Promise<Target.MappableResponseModel> {
    return Promise<Target.MappableResponseModel>.init { (seal) in
      requestModel(token, option: option, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let model):
          seal.fulfill(model)
        case .failure(let error):
          seal.reject(error)
        }
      })
      .cauterize()
    }
  }
}
#endif

#if canImport(ObjectMapper) && canImport(XMLDictionary)
extension MoyaProvider where Target: MappableResponseType {
  /*
   Request mappable object using PromiseKit.
   **/
  public func requestXmlModel(_ token: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> Promise<Target.MappableResponseModel> {
    return Promise<Target.MappableResponseModel>.init { (seal) in
      requestXmlModel(token, option: option, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        switch result {
        case .success(let model):
          seal.fulfill(model)
        case .failure(let error):
          seal.reject(error)
        }
      })
      .cauterize()
    }
  }
}
#endif
