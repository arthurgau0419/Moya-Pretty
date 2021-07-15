import Quick
import Nimble
import Moya_Pretty
import Moya
import PromiseKit

class CodableSpec: QuickSpec {
  let newPet = Pet(id: 1, name: "Obi")

  override func spec() {

    describe("Codable") {

      it ("Can add pet") {
        waitUntil(timeout: .seconds(10), action: { (done) in
          MoyaProvider.default.requestModel(PetService.AddPet(body: self.newPet), completion: { (result) in
            switch result {
            case .success(let pet):
              print(pet)
            case .failure(let error):
              fail(error.localizedDescription)
            }
            done()
          })
            .cauterize()
        })
      }

      it ("Can get pet") {
        waitUntil(timeout: .seconds(10), action: { (done) in
          MoyaProvider<PetService.GetPet>.default.requestModel(PetService.GetPet(id: 2), completion: { (result) in
            switch result {
            case .success(let pet):
              expect(pet).notTo(beNil())
            case .failure(let error):
              fail(error.localizedDescription)
            }
            done()
          })
            .cauterize()
        })
      }

      it ("Can add pet using PromiseKit") {
        waitUntil(timeout: .seconds(10), action: { (done) in
          firstly {
            MoyaProvider.default.requestModel(PetService.AddPet(body: self.newPet))
            }.done({ (pet) in
              expect(pet.id).to(equal(self.newPet.id))
              expect(pet.name).to(equal(self.newPet.name))
            }).catch({ (error) in
              fail(error.localizedDescription)
            }).finally {
              done()
          }
        })
      }

      it("can get pet list") {
        waitUntil(timeout: .seconds(10), action: { (done) in

          MoyaProvider.default.requestModel(PetService.GetPetList(status: .pending), completion: { (result) in
            switch result {
            case .success(let pets):
              expect(pets).notTo(beEmpty())
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
