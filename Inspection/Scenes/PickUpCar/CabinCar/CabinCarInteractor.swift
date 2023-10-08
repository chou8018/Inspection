//
//  CabinCarInteractor.swift
//  Inspection
//
//  Created by Thanawat prathumset on 8/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CabinCarBusinessLogic
{
  func doSomething(request: CabinCar.Something.Request)
    func validateMileNumber(request: CabinCar.Something.Request)
    func keyCheck(request: CabinCar.Something.Request)
    func remoteCheck(request: CabinCar.Something.Request)
    func remoteKeyCheck(request: CabinCar.Something.Request)
    func immobilizerKeyCheck(request: CabinCar.Something.Request)
    func keylessKeyCheck(request: CabinCar.Something.Request)
    func setExpiredDateTime(request: CabinCar.Something.Request)
    
    func fetchGearBox(request: CabinCar.Something.Request)
    func selectGearBox(request: CabinCar.Something.Request)
    func prepareGearBox(request: CabinCar.Something.Request)
}


protocol CabinCarDataStore
{
  //var name: String { get set }
    var currentDate: Date? { get set }
}

class CabinCarInteractor: CabinCarBusinessLogic, CabinCarDataStore
{
   
  var presenter: CabinCarPresentationLogic?
  var worker: CabinCarWorker?
  //var name: String = ""
    var currentDate: Date?
  // MARK: Do something
  
  func doSomething(request: CabinCar.Something.Request)
  {
    worker = CabinCarWorker()
    worker?.doSomeWork()
    
    let response = CabinCar.Something.Response()
    presenter?.presentSomething(response: response)
  }
    
    
    var oldValue = ""
    func validateMileNumber(request: CabinCar.Something.Request) {
        guard let miles = request.miles  else { return }
        let newValue = miles.replacingOccurrences(of: ",", with: "")
        let isValid = newValue.isValidNumber()
        var validateResult = isValid ? newValue.decimal : oldValue
        validateResult  = validateResult == "0" ? "" : validateResult
        
        oldValue = validateResult
        
        let response = CabinCar.Something.Response(validateMilesNumber: validateResult)
        presenter?.presentValidateMilesNumber(response: response)
        
    }
    
    func keyCheck(request: CabinCar.Something.Request) {
        let value = request.keyCheck
        let isValue = value?.trimWhiteSpace.isEmpty ?? false
        let response = CabinCar.Something.Response(isKeyCheck : !isValue)
        presenter?.presentKeyChecked(response: response)
        
    }
    
    func remoteCheck(request: CabinCar.Something.Request) {
        let value = request.remoteCheck
        let isValue = value?.trimWhiteSpace.isEmpty ?? false
        let response = CabinCar.Something.Response(isRemoteCheck : !isValue)
        presenter?.presentRemoteChecked(response: response)
    }
    
    func remoteKeyCheck(request: CabinCar.Something.Request) {
        let value = request.remoteKeyCheck
        let isValue = value?.trimWhiteSpace.isEmpty ?? false
        let response = CabinCar.Something.Response(isRemoteKeyCheck : !isValue)
        presenter?.presentRemoteKeyChecked(response: response)
    }
    
    func immobilizerKeyCheck(request: CabinCar.Something.Request) {
        let value = request.immobilizerKeyCheck
        let isValue = value?.trimWhiteSpace.isEmpty ?? false
        let response = CabinCar.Something.Response(isImmobilizerKeyCheck : !isValue)
        presenter?.presentImmobilizerKeyChecked(response: response)
    }
    
    func keylessKeyCheck(request: CabinCar.Something.Request) {
        let value = request.keylessKeyCheck
        let isValue = value?.trimWhiteSpace.isEmpty ?? false
        let response = CabinCar.Something.Response(isKeylessKeyCheck : !isValue)
        presenter?.presentKeylessKeyChecked(response: response)
    }
    
    
    
    
    //MARK: GearBox
    var workerModelCode:CreateModelCodeWorker?
    var gearBoxList: [GearBoxModel]?
    
    
    func fetchGearBox(request: CabinCar.Something.Request) {
        workerModelCode = CreateModelCodeWorker()
        workerModelCode?.getGearBox(completion: { [weak self] response in
            if let modelList = response.gearBoxList {
                self?.gearBoxList = modelList
            }
            
            let responseCabin = CabinCar.Something.Response(gearBoxList: response.gearBoxList,
                                                            error: response.error)
            
            self?.presenter?.presentGearBoxList(response: responseCabin)
        })
//        fetchLocalGearBox(request: request)
    }
    
    func fetchLocalGearBox(request: CabinCar.Something.Request) {
        let gearBoxList: [GearBoxModel] = JSONUtils.shared.getCodableResponseFromJson(fileName: "gearbox_details", bundle: .getBundle(for: self))
        let responseCabin = CabinCar.Something.Response(gearBoxList: gearBoxList)
        self.presenter?.presentGearBoxList(response: responseCabin)
    }
    
    func prepareGearBox(request: CabinCar.Something.Request) {
        ///prepare gearbox value
        guard let gearbox = request.codeGearBox else { return }

        let editGearBox = self.gearBoxList?.first(where: { $0.gearBox1?.trimWhiteSpace == gearbox.trimWhiteSpace })?.desc_BU
        
        let response = CabinCar.Something.Response(gearBox_BU: editGearBox)
        self.presenter?.presentGearBoxText(response: response)
    }
    
    func selectGearBox(request: CabinCar.Something.Request) {
        guard let value = request.selectGearbox else { return }
        if let selectModel = self.gearBoxList?.first(where: { $0.desc_BU == value}) {
            print("🧀 gearbox = \(selectModel)")
 
            DataController.shared.receiverCarModel.gearbox = selectModel.gearBox1
        }
    }
    
    
    
    func setExpiredDateTime(request: CabinCar.Something.Request) {
        let date = request.dateExpired ?? Date()
       
        
        currentDate = date
        let monthString = DateFormatter().dateFormat(from: date, dateFormat: " MM ")
        let day = DateFormatter().dateFormat(from: date, dateFormat: "dd MM yyyy")
        let time = DateFormatter().dateFormat(from: date, dateFormat: "HH:mm")

        let monthTH = getMonthTH(month: date.month)
        let dayTh = day.replacingOccurrences(of: monthString, with: monthTH)
        let dateTuple = (dayTh , time)

        let response = CabinCar.Something.Response(dayTime: dateTuple)
        presenter?.presentExpiredDayTime(response: response)
    }
    
    func getMonthTH(month :Int ) -> String {
        let months = ["","ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.",
                      "ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
        
        return " \(months[month]) "
    }
}
