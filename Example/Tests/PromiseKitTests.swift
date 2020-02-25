import Quick
import Nimble
import Moya_Pretty
import Moya
import PromiseKit

class PromiseKitSpec: QuickSpec {
  override func spec() {

    describe("Codable") {
      it ("Can Add Pet") {
        waitUntil(timeout: 10, action: { (done) in
          firstly {
            MoyaProvider.default
              .requestModel(PetService.AddPet(body: Pet(id: 1, name: "Obi")))
            }.catch { (error) in
              fail(error.localizedDescription)
            }.finally {
              done()
          }
        })
      }
    }

    describe("Mappable") {
      it ("Can Add Pet") {
        waitUntil(timeout: 10, action: { (done) in
          firstly {
            try MoyaProvider.default
              .requestModel(PetService.AddPetMappable(body: MappablePet(JSON: ["id": 1, "name":"Obi"])))
            }.catch { (error) in
              fail(error.localizedDescription)
            }.finally {
              done()
          }
        })
      }
    }

    describe("XMLMappable") {
      it ("Can Add Pet") {
        waitUntil(timeout: 10, action: { (done) in
          firstly {
            try MoyaProvider.xml
              .requestXmlModel(PetService.AddPetMappableXML(body: XMLMappablePet(JSON: ["id": "1", "name":"Obi"])))
            }.catch { (error) in
              fail(error.localizedDescription)
            }.finally {
              done()
          }
        })
      }
    }

  }
}
