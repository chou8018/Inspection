//
//  IMatBookInWorker.swift
//  Inspection
//
//  Created by Thanawat prathumset on 17/5/2564 BE.
//

import Foundation

typealias responseIMATHandler = (_ response:PickUpCar.Something.Response) -> ()
class IMatBookInWorker {
    
    //MARK: Update IMAT Vehicle
    func updateIMATBookIn(completion: @escaping responseHandler){
        let model = DataController.shared.receiverCarModel
        
        guard let bookinNo = model.bookinNo  else { return }

        let vehicleId = model.vehicleId
        
        let request = VehicleModelRequest(bookInNumber: bookinNo.trimWhiteSpace,
                                          vehicleId: vehicleId.trimWhiteSpace)

        
        print(request.toJSON())

        UpdateVehicleService().callServiceObject(request: request) { results in

            hideLoading()

            switch results {

            case .success(let response):
                print("❤️🐶MakeVehicleService: \(response)❤️🐶")
                let response = PickUpCar.Something.Response(makeVehicleResponseModel: response)
                completion(response)
            case .failure(let error):
                let response = PickUpCar.Something.Response(error: error.getMessage)
                completion(response)
            }
        }
        
    }
    
    
    //MARK: Send IMAT Vehicle
    func sendIMAPBookIn(completion: @escaping responseHandler){
        let model = DataController.shared.receiverCarModel
        guard let bookinNo = model.bookinNo else { return }
     
        

        let request = VehicleModelRequest(bookInNumber: bookinNo.trimWhiteSpace,
                                          vehicleId: "")

        
        print(request.toJSON())

        showLoading()

        MakeVehicleService().callServiceObject(request: request) { results in

            hideLoading()

            switch results {

            case .success(let response):
                print("❤️🐶MakeVehicleService: \(response)❤️🐶")
                let response = PickUpCar.Something.Response(makeVehicleResponseModel: response)
                completion(response)
            case .failure(let error):
                let response = PickUpCar.Something.Response(error: error.getMessage)
                completion(response)
            }
        }
        
        
    }
}
