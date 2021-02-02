//
//  CombineTests.swift
//  Moya-Pretty_Tests
//
//  Created by Arthur Kao on 2021/2/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Moya_Pretty
import Moya
import Combine

class CombineTests: QuickSpec {

  var bag = Set<AnyCancellable>()

  override func spec() {

    beforeSuite {
      Nimble.AsyncDefaults.Timeout = 10
    }

    describe("Codable") {
      it("Can Add Pet") {
        waitUntil { done in
          let provider = MoyaProvider<PetService.AddPet>.default
          provider
            .requestModelPublisher(.init(body: Pet(id: 1, name: "Obi")))
            .sink {
              if case let Subscribers.Completion.failure(error) = $0 {
                fail(error.localizedDescription)
              } else {
                done()
              }
            } receiveValue: { pet in
              expect(pet).notTo(beNil())
            }
            .store(in: &self.bag)
        }
      }
    }

    describe("Mappable") {
      it("Can Add Pet") {
        waitUntil { done in
          let provider = MoyaProvider<PetService.AddPetMappable>.default
          provider
            .requestModelPublisher(.init(body: MappablePet(JSON: ["id": 1, "name":"Obi"])!))
            .sink {
              if case let Subscribers.Completion.failure(error) = $0 {
                fail(error.localizedDescription)
              } else {
                done()
              }
            } receiveValue: { pet in
              expect(pet).notTo(beNil())
            }
            .store(in: &self.bag)
        }
      }
    }

    describe("XMLMappable") {
      it("Can Add Pet") {
        waitUntil { done in
          let provider = MoyaProvider<PetService.AddPetMappableXML>.xml
          provider.requestXmlModelPublisher(.init(body: XMLMappablePet(JSON: ["id": "1", "name":"Obi"])!))
            .sink {
              if case let Subscribers.Completion.failure(error) = $0 {
                fail(error.localizedDescription)
              } else {
                done()
              }
            } receiveValue: { pet in
              expect(pet).notTo(beNil())
            }
            .store(in: &self.bag)
        }
      }
    }
  }
}
