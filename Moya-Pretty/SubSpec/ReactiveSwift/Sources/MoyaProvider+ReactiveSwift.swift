import Foundation
import Moya
import ReactiveSwift
import Result
#if canImport(Japx)
import Japx
#endif
#if canImport(ObjectMapper)
import ObjectMapper
#endif

extension Reactive where Base: MoyaProviderType, Base.Target: DecodableType  {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: SignalProducer<Base.Target.DecodableModel, MoyaError>.
  public func requestModel(_ token: Base.Target, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder? = nil, failsOnEmptyData: Bool = true, callbackQueue: DispatchQueue? = nil) -> SignalProducer<Base.Target.DecodableModel, MoyaError> {

    return request(token, callbackQueue: callbackQueue)
      .attemptMap { response -> Result<Base.Target.DecodableModel, MoyaError> in
        return Result<Base.Target.DecodableModel, MoyaError>(catching: { () -> Base.Target.DecodableModel in
          return try response.toModel(target: token, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)
        })
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
  /// - Returns: SignalProducer<Base.Target.DecodableModel, MoyaError>.
  public func requestModel(_ token: Base.Target, using decoder: JapxDecoder? = nil, includeList: String? = nil, callbackQueue: DispatchQueue? = nil) -> SignalProducer<Base.Target.DecodableModel, MoyaError> {
    return request(token, callbackQueue: callbackQueue)
      .attemptMap { response -> Result<Base.Target.DecodableModel, MoyaError> in
        Result<Base.Target.DecodableModel, MoyaError>(catching: { () -> Base.Target.DecodableModel in
          try response.toModel(target: token, using: decoder, includeList: includeList)
        })
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
  /// - Returns: SignalProducer<Base.Target.MappableResponseModel, MoyaError>.
  public func requestModel(_ token: Base.Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> SignalProducer<Base.Target.MappableResponseModel, MoyaError> {
    return request(token, callbackQueue: callbackQueue)
      .attemptMap { response -> Result<Base.Target.MappableResponseModel, MoyaError> in
        Result<Base.Target.MappableResponseModel, MoyaError>(catching: { () -> Base.Target.MappableResponseModel in
          try response.toModel(target: token, option: option)
        })
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
  /// - Returns: SignalProducer<Base.Target.MappableResponseModel, MoyaError>.
  public func requestXmlModel(_ token: Base.Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> SignalProducer<Base.Target.MappableResponseModel, MoyaError> {
    return request(token, callbackQueue: callbackQueue)
      .attemptMap { response -> Result<Base.Target.MappableResponseModel, MoyaError> in
        Result<Base.Target.MappableResponseModel, MoyaError>(catching: { () -> Base.Target.MappableResponseModel in
          try response.toXmlModel(target: token, option: option)
        })
    }
  }
}
#endif
