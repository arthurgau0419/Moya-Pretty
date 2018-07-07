// https://github.com/Quick/Quick

import Quick
import Nimble
import Moya_Pretty
import Moya
import RxSwift
import RxNimble
import PromiseKit

class TableOfContentsSpec: QuickSpec {
  
  let newPet = Pet(id: 1, name: "Obi")
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
          }).cauterize()
        })
      }
      
      it ("Can add pet using RxSwift") {
        let addPet = MoyaProvider.default.requestModel(PetService.AddPetMappable(body: self.newMappablePet))
        expect(addPet).notTo(beNil())
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
    
    describe("Codable") {
      
      it ("Can add pet using RxSwift") {
        let addPet = MoyaProvider<PetService.AddPet>.default.rx
          .requestModel(PetService.AddPet(body: Pet(id: 123, name: "123")))
        expect(addPet).to(beNil())
      }
      
      it ("Can add pet") {
        waitUntil(timeout: 10, action: { (done) in
          MoyaProvider<PetService.GetPet>.default.requestModel(PetService.GetPet(id: 2), completion: { (result) in
            switch result {
            case .success(let pet):
              print(pet)
              break
            case .failure(let error):
              fail(error.localizedDescription)
            }
            done()
          }).cauterize()
          
        })
      }
      
      it ("Can add pet using PromiseKit") {
        waitUntil(timeout: 10, action: { (done) in
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
      
      it("can parse model") {
        waitUntil(timeout: 10, action: { (done) in
          
          MoyaProvider<PetService.AddPet>().requestModel(PetService.AddPet(body: Pet(id: 123, name: "123")), completion: { (result) in
            switch result {
            case .success(let pet):
              expect(pet.id).to(equal(123))
              print(pet)
              break
            case .failure(let error):
              fail(error.localizedDescription)
              break
            }
            done()
          }).cauterize()
          
          
        })
      }
    }
  }
}
