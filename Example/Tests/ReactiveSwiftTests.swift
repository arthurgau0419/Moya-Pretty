import Quick
import Nimble
import Moya_Pretty
import Moya
import ReactiveSwift

class ReactiveSwiftSpec: QuickSpec {
  override func spec() {

    describe("Codable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPet>.default
        waitUntil(timeout: 10, action: { (done) in
          provider.reactive
            .requestModel(.init(body: Pet(id: 1, name: "Obi")))
            .start {
              switch $0 {
              case .failed(let error):
                fail(error.localizedDescription)
                done()
              case .value:
                done()
              default:
                break
              }
          }
        })
      }
    }

    describe("Mappable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPetMappable>.default
        waitUntil(timeout: 10, action: { (done) in
          provider.reactive
            .requestModel(.init(body: MappablePet(JSON: ["id": 1, "name":"Obi"])!))
            .start {
              switch $0 {
              case .failed(let error):
                fail(error.localizedDescription)
                done()
              case .value:
                done()
              default:
                break
              }
          }
        })
      }
    }

    describe("XMLMappable") {
      it("Can Add Pet") {
        let provider = MoyaProvider<PetService.AddPetMappableXML>.xml
        waitUntil(timeout: 10, action: { (done) in
          provider.reactive
            .requestXmlModel(.init(body: XMLMappablePet(JSON: ["id": "1", "name":"Obi"])!))
            .start {
              switch $0 {
              case .failed(let error):
                fail(error.localizedDescription)
                done()
              case .value:
                done()
              default:
                break
              }
          }
        })
      }
    }

  }
}
