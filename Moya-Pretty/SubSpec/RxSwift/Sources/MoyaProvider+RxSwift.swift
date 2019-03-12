//
//  MoyaProvider+RxSwift.swift
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/7/6.
//

import Foundation
import Moya
import RxSwift
#if canImport(Japx)
import Japx
#endif
#if canImport(ObjectMapper)
import ObjectMapper
#endif

public extension Reactive where Base: MoyaProviderType, Base.Target: DecodableType {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: Single decodable object.
  public func requestModel(_ token: Base.Target, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder? = nil, failsOnEmptyData: Bool = true, callbackQueue: DispatchQueue? = nil) -> Single<Base.Target.DecodableModel> {
    return request(token, callbackQueue: callbackQueue)
      .map {try $0.toModel(target: token, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)}
  }
}

#if canImport(Japx)
public extension Reactive where Base: MoyaProviderType, Base.Target: JapxDecodableType {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: Single decodable object.
  public func requestModel(_ token: Base.Target, using decoder: JapxDecoder? = nil, includeList: String? = nil, callbackQueue: DispatchQueue? = nil) -> Single<Base.Target.DecodableModel> {
    return request(token, callbackQueue: callbackQueue)
      .map {try $0.toModel(target: token, using: decoder, includeList: includeList)}
  }
}
#endif

#if canImport(ObjectMapper)
public extension Reactive where Base: MoyaProviderType, Base.Target: MappableResponseType {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: Single mappable object.
  public func requestModel(_ token: Base.Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> Single<Base.Target.MappableResponseModel> {
    return request(token, callbackQueue: callbackQueue)
      .map {try $0.toModel(target: token, option: option)}    
  }
}
#endif

#if canImport(ObjectMapper) && canImport(XMLDictionary)
public extension Reactive where Base: MoyaProviderType, Base.Target: MappableResponseType {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: Single mappable object.
  public func requestXmlModel(_ token: Base.Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> Single<Base.Target.MappableResponseModel> {
    return request(token, callbackQueue: callbackQueue)
      .map {try $0.toXmlModel(target: token, option: option)}    
  }
}
#endif
