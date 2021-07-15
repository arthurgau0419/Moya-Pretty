//
//  ObjectMapperTests.swift
//  Moya-Pretty_Tests
//
//  Created by Kao Ming-Hsiu on 2018/7/8.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Moya
import Moya_Pretty
import ObjectMapper
import PromiseKit

class ObjectMapperSpec: QuickSpec {
  let newMappablePet = try! MappablePet(JSON: ["id": 1, "name":"Obi"])
  override func spec() {
    describe("ObjectMapper") {

      it ("Can add pet") {
        waitUntil(timeout: .seconds(10), action: { (done) in
          MoyaProvider.default.requestModel(PetService.AddPetMappable(body: self.newMappablePet), completion: { (result) in
            switch result {
            case .success(let pet):
              expect(pet.id).to(equal(self.newMappablePet.id))
              expect(pet.name).to(equal(self.newMappablePet.name))
            case .failure(let error):
              fail(error.localizedDescription)
            }
            done()
          })
            .cauterize()
        })
      }

    }
  }
}
