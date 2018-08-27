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
      
      let modelResult = result.flatMap({ (response) -> Result<Target.DecodableModel, MoyaError> in
        do {
          let decoder = decoder ?? target.japxDecoder ?? JapxDecoder()
          let model = try decoder.decode(Target.DecodableModel.self, from: response.data, includeList: includeList)
          return Result.success(model)
        } catch let moyaError as MoyaError {
          return Result.failure(moyaError)
        } catch {
          return Result.failure(MoyaError.underlying(error, response))
        }
      })
      completion(modelResult)
    })
  }
}
