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
    return Single<Base.Target.DecodableModel>.create { [weak base] single in
      let cancellableToken = (base as? MoyaProvider<Base.Target>)?.requestModel(token, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData, callbackQueue: callbackQueue, progress: nil, completion: { result in
        switch result {
        case .success(let model):
          single(.success(model))
        case .failure(let error):
          single(.error(error))
        }
      })
      return Disposables.create {
        cancellableToken?.cancel()
      }
    }
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
    return Single<Base.Target.DecodableModel>.create { [weak base] single in
      let cancellableToken = (base as? MoyaProvider<Base.Target>)?.requestModel(token, using: decoder, includeList: includeList, callbackQueue: callbackQueue, progress: nil, completion: { result in
        switch result {
        case .success(let model):
          single(.success(model))
        case .failure(let error):
          single(.error(error))
        }
      })
      return Disposables.create {
        cancellableToken?.cancel()
      }
    }
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
    return Single<Base.Target.MappableResponseModel>.create { [weak base] single in
      let cancellableToken = (base as? MoyaProvider<Base.Target>)?.requestModel(token, option: option, callbackQueue: callbackQueue, progress: nil, completion: { result in
        switch result {
        case .success(let model):
          single(.success(model))
        case .failure(let error):
          single(.error(error))
        }
      })
      return Disposables.create {
        cancellableToken?.cancel()
      }
    }
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
    return Single<Base.Target.MappableResponseModel>.create { [weak base] single in
      let cancellableToken = (base as? MoyaProvider<Base.Target>)?.requestXmlModel(token, option: option, callbackQueue: callbackQueue, progress: nil, completion: { result in
        switch result {
        case .success(let model):
          single(.success(model))
        case .failure(let error):
          single(.error(error))
        }
      })
      return Disposables.create {
        cancellableToken?.cancel()
      }
    }
  }
}
#endif
