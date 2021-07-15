//
//  CombineTest.swift
//  Moya-Pretty_Tests
//
//  Created by Arthur Kao on 2021/7/15.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Moya_Pretty
import Moya
import Combine

class CombineTest: QuickSpec {
  override func spec() {

    var bag = Set<AnyCancellable>()

    describe("Codable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPet>.default
        waitUntil(timeout: .seconds(10), action: { (done) in
          provider.requestModelPublisher(.init(body: Pet(id: 1, name: "Obi")))
            .sink(receiveCompletion: { completion in
              expect(completion.error).to(beNil())
              done()
            }, receiveValue: { _ in })
            .store(in: &bag)
        })
      }
    }

    describe("Mappable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPetMappable>.default
        waitUntil(timeout: .seconds(10), action: { (done) in
          provider.requestModelPublisher(.init(body: try! MappablePet(JSON: ["id": 1, "name":"Obi"])))
            .sink(receiveCompletion: { completion in
              expect(completion.error).to(beNil())
              done()
            }, receiveValue: { _ in })
            .store(in: &bag)
        })
      }
    }

    describe("XMLMappable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPetMappableXML>.xml
        waitUntil(timeout: .seconds(10), action: { (done) in
          provider.requestXmlModelPublisher(.init(body: try! XMLMappablePet(JSON: ["id": "1", "name":"Obi"])))
            .sink(receiveCompletion: { completion in
              expect(completion.error).to(beNil())
              done()
            }, receiveValue: { _ in })
            .store(in: &bag)
        })
      }
    }

  }
}

fileprivate extension Subscribers.Completion {
  var error: Error? {
    switch self {
    case .failure(let error):
      return error
    default:
      return nil
    }
  }
}
