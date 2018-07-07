// https://github.com/Quick/Quick

import Quick
import Nimble
import ObiMoyaExtension
import Moya
import Result
import RxSwift
import RxNimble

class TableOfContentsSpec: QuickSpec {
  let disposeBag = DisposeBag()
  override func spec() {
    
    describe("API Test") {
      
      it ("rx can get pet") {
        let addPet = MoyaProvider<PetService.AddPet>.default.rx
          .requestModel(PetService.AddPet(body: Pet(id: 123, name: "123")))
        expect(addPet).to(beNil())
      }
      
      it ("can get pet") {
        waitUntil(timeout: 10, action: { (done) in
          let cancelable = MoyaProvider<PetService.GetPet>.default.requestModel(PetService.GetPet(id: 2), completion: { (result) in
            switch result {
            case .success(let pet):
              print(pet)
              break
            case .failure(let error):
              fail(error.localizedDescription)
            }
            done()
          })
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
          })
          
          
        })
      }
    }
    
    
    describe("these will fail") {
      
      it("can do maths") {
        expect(1) == 2
      }
      
      it("can read") {
        expect("number") == "string"
      }
      
      it("will eventually fail") {
        expect("time").toEventually( equal("done") )
      }
      
      context("these will pass") {
        
        it("can do maths") {
          expect(23) == 23
        }
        
        it("can read") {
          expect("🐮") == "🐮"
        }
        
        it("will eventually pass") {
          var time = "passing"
          
          DispatchQueue.main.async {
            time = "done"
          }
          
          waitUntil { done in
            Thread.sleep(forTimeInterval: 0.5)
            expect(time) == "done"
            
            done()
          }
        }
      }
    }
  }
}
