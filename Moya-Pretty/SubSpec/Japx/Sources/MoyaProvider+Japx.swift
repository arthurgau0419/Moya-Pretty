//
//  MoyaProvider+Japx
//  Moya-Pretty
//
//  Created by Kao Ming-Hsiu on 2018/8/27.
//

import Foundation
import Moya
import Japx
import Result

extension MoyaProvider where MoyaProvider.Target: JapxDecodableType {
  open func requestModel(_ target: Target, using decoder: JapxDecoder? = nil, includeList: String? = nil, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping ((_ result: Result<Target.DecodableModel, MoyaError>) -> Void)) -> Cancellable {

    return self.request(target, callbackQueue: callbackQueue, progress: progress, completion: { (result) in

      let modelResult = result
        .flatMap { response in
          Result<Target.DecodableModel, MoyaError>(attempt: {
            try response.toModel(target: target, using: decoder, includeList: includeList)
          })
      }

      completion(modelResult)
    })
  }
}

extension Response {
  internal func toModel<Target: JapxDecodableType>(target: Target, using decoder: JapxDecoder?, includeList: String?) throws -> Target.DecodableModel {
    do {
      let decoder = decoder ?? target.japxDecoder ?? JapxDecoder()
      return try decoder.decode(Target.DecodableModel.self, from: data, includeList: includeList)
    } catch let moyaError as MoyaError {
      throw moyaError
    } catch {
      throw MoyaError.underlying(error, self)
    }
  }
}
