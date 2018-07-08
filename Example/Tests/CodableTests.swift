// https://github.com/Quick/Quick

import Quick
import Nimble
import Moya_Pretty
import Moya
import RxSwift
import RxNimble
import PromiseKit

class CodableSpec: QuickSpec {
  let newPet = Pet(id: 1, name: "Obi")
  
  override func spec() {
        
    describe("Codable") {
      
      it ("Can add pet") {
        waitUntil(timeout: 10, action: { (done) in
          MoyaProvider.default.requestModel(PetService.AddPet(body: self.newPet), completion: { (result) in
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
      
      it ("Can get pet") {
        waitUntil(timeout: 10, action: { (done) in
          MoyaProvider<PetService.GetPet>.default.requestModel(PetService.GetPet(id: 2), completion: { (result) in
            switch result {
            case .success(let pet):
              expect(pet).notTo(beNil())
            case .failure(let error):
              fail(error.localizedDescription)
            }
            done()
          }).cauterize()
          
        })
      }
      
      it ("Can add pet using RxSwift") {
        let provider = MoyaProvider<PetService.AddPet>.default
        let addPet = provider.rx
          .requestModel(PetService.AddPet(body: self.newPet)).timeout(RxTimeInterval(10), scheduler: MainScheduler.instance)
        _ = addPet.subscribe()
        expect(addPet.asObservable()).first.notTo(beNil())
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
      
      it("can get pet list") {
        waitUntil(timeout: 10, action: { (done) in
          
          MoyaProvider.default.requestModel(PetService.GetPetList(status: .pending), completion: { (result) in
            switch result {
            case .success(let pets):
              expect(pets).notTo(beEmpty())
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
