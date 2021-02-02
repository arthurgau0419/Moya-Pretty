import Foundation
import Moya
import Combine
#if canImport(Japx)
import Japx
#endif
#if canImport(ObjectMapper)
import ObjectMapper
#endif

extension MoyaProvider where Target: DecodableType {
  /*
   Request deodable object using PromiseKit.
   **/
  public func requestModelPublisher(_ token: Target, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder(), failsOnEmptyData: Bool = true, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Target.DecodableModel, MoyaError> {
    return requestPublisher(token, callbackQueue: callbackQueue)
      .map(Target.DecodableModel.self, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)
  }
}

#if canImport(Japx)
extension MoyaProvider where Target: JapxDecodableType {
  /*
   Request jsonapi deodable object using PromiseKit.
   **/
  public func requestModelPublisher(_ token: Target, using decoder: JapxDecoder? = nil, includeList: String? = nil, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Target.DecodableModel, MoyaError> {
    Future { promise in
      _ = self.requestModel(token, using: decoder, includeList: includeList, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        promise(result)
      })
    }
    .eraseToAnyPublisher()
  }
}
#endif

#if canImport(ObjectMapper)
extension MoyaProvider where Target: MappableResponseType {
  /*
   Request mappable object using PromiseKit.
   **/
  public func requestModelPublisher(_ token: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Target.MappableResponseModel, MoyaError> {
    Future { promise in
      _ = self.requestModel(token, option: option, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        promise(result)
      })
    }
    .eraseToAnyPublisher()
  }
}
#endif

#if canImport(ObjectMapper) && canImport(XMLDictionary)
extension MoyaProvider where Target: MappableResponseType {
  /*
   Request mappable object using PromiseKit.
   **/
  public func requestXmlModelPublisher(_ token: Target, option: MapperOption? = nil, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Target.MappableResponseModel, MoyaError> {
    Future { promise in
      _ = self.requestXmlModel(token, option: option, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
        promise(result)
      })
    }
    .eraseToAnyPublisher()
  }
}
#endif
