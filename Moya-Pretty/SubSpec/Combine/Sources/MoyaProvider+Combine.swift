import Moya
#if canImport(Combine)
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension MoyaProvider where Target: DecodableType {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: AnyPublisher decodable object.
  func requestModelPublisher(_ token: Target, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder? = nil, failsOnEmptyData: Bool = true, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Target.DecodableModel, MoyaError> {
    self.requestPublisher(token, callbackQueue: callbackQueue)
      .flatMap { response in
        Result {
          try response.toModel(target: token, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)
        }
        .mapError { $0 as! MoyaError }
        .publisher
      }
      .eraseToAnyPublisher()
  }
}
#endif

#if canImport(Combine) && canImport(Japx)
import Combine
import Japx

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension MoyaProvider where Target: JapxDecodableType {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: AnyPublisher decodable object.
  func requestModelPublisher(_ token: Target, using decoder: JapxDecoder? = nil, includeList: String? = nil, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Target.DecodableModel, MoyaError> {
    requestPublisher(token, callbackQueue: callbackQueue)
      .flatMap { response in
        Result {
          try response.toModel(target: token, using: decoder, includeList: includeList)
        }
        .mapError { $0 as! MoyaError }
        .publisher
      }
      .eraseToAnyPublisher()
  }
}
#endif

#if canImport(Combine) && canImport(ObjectMapper)
import Combine
import ObjectMapper

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension MoyaProvider where Target: MappableResponseType {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: AnyPublisher mappable object.
  func requestModelPublisher(_ token: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Target.MappableResponseModel, MoyaError> {
    requestPublisher(token, callbackQueue: callbackQueue)
      .flatMap { response in
        Result {
          try response.toModel(target: token, option: option)
        }
        .mapError { $0 as! MoyaError }
        .publisher
      }
      .eraseToAnyPublisher()
  }
}
#endif

#if canImport(Combine) && canImport(ObjectMapper) && canImport(XMLDictionary)
import Combine
import ObjectMapper
import XMLDictionary

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension MoyaProvider where Target: MappableResponseType {
  /// Designated request-making method.
  ///
  /// - Parameters:
  ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
  ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
  /// - Returns: AnyPublisher mappable object.
  func requestXmlModelPublisher(_ token: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Target.MappableResponseModel, MoyaError> {
    requestPublisher(token, callbackQueue: callbackQueue)
      .flatMap { response in
        Result {
          try response.toXmlModel(target: token, option: option)
        }
        .mapError { $0 as! MoyaError }
        .publisher
      }
      .eraseToAnyPublisher()
  }
}
#endif
