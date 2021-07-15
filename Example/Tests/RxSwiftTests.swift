import Quick
import Nimble
import Moya_Pretty
import Moya
import RxSwift
import RxNimble

class RxSwiftSpec: QuickSpec {
  override func spec() {

    describe("Codable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPet>.default
        let addPet = provider.rx
          .requestModel(.init(body: Pet(id: 1, name: "Obi")))
          .asObservable()
        _ = addPet.subscribe()
        expect(addPet).first.notTo(beNil())
      }
    }

    describe("Mappable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPetMappable>.default
        let addPet = provider.rx
          .requestModel(.init(body: try! MappablePet(JSON: ["id": 1, "name":"Obi"])))
          .asObservable()
        _ = addPet.subscribe()
        expect(addPet).first.notTo(beNil())
      }
    }

    describe("XMLMappable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPetMappableXML>.xml
        let addPet = provider.rx
          .requestXmlModel(.init(body: try! XMLMappablePet(JSON: ["id": "1", "name":"Obi"])))
          .asObservable()
        _ = addPet.subscribe()
        expect(addPet).first.notTo(beNil())
      }
    }

  }
}
