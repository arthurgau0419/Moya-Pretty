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
import RxSwift
import RxNimble

class ObjectMapperSpec: QuickSpec {
  let newMappablePet = MappablePet(JSON: ["id": 1, "name":"Obi"])!
  override func spec() {
    describe("ObjectMapper") {

      it ("Can add pet") {
        waitUntil(timeout: 10, action: { (done) in
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

      it ("Can add pet using RxSwift") {
        let provider = MoyaProvider<PetService.AddPetMappable>.default
        let addPet = provider.rx.requestModel(PetService.AddPetMappable(body: self.newMappablePet))
        expect(addPet.asObservable()).first.notTo(beNil())
      }

      it ("Can add pet using PromiseKit") {
        waitUntil(timeout: 10, action: { (done) in
          firstly {
            MoyaProvider.default.requestModel(PetService.AddPetMappable(body: self.newMappablePet))
            }.done({ (pet) in
              expect(pet.id).to(equal(self.newMappablePet.id))
              expect(pet.name).to(equal(self.newMappablePet.name))
            }).catch({ (error) in
              fail(error.localizedDescription)
            }).finally {
              done()
          }
        })
      }

    }
  }
}
