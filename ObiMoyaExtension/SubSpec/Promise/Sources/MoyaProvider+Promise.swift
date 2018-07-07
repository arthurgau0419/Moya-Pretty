//
//  MoyaProvider+RxSwift.swift
//  ObiMoyaExtension
//
//  Created by Kao Ming-Hsiu on 2018/7/6.
//

import Foundation
import Moya
import PromiseKit

extension MoyaProvider {
  /*
   Request response using PromiseKit.
   **/
  func request(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Promise<Response>  {
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

extension MoyaProvider where Target: DecodableMixin {
  /*
   Request deodable object using PromiseKit.
   **/
  func requestModel(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Promise<Target.DecodableModel>  {
    return Promise<Target.DecodableModel>.init { (seal) in
      _ = self.requestModel(token, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
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
  func requestModel(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Promise<Target.MappableResponseModel>  {
    return Promise<Target.MappableResponseModel>.init { (seal) in
      _ = self.requestModel(token, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
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
