//
//  PickUpCarWorker.swift
//  Inspection
//
//  Created by Thanawat prathumset on 4/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

typealias responseHandler = (_ response:PickUpCar.Something.Response) -> ()

class PickUpCarWorker
{
    
    //MARK: UPDATE Vehicle
    func receiverBookInVehicleUpdate(to bookinNO:String?, model:ReceiverCarModel,
                              completion: @escaping responseHandler){
        guard let bookinNO = bookinNO else { return }
        let typeModelTuple = createReceiverModelRequest(model: model)
        
        var request: ReceiverModelRequest!
        request = ReceiverModelRequest()
        request.bookinNo = bookinNO
        request.vehicleType = typeModelTuple.vehicleType
        request.bookInType = typeModelTuple.bookInType
        
        print("❤️  \(request.toJSON())")
        
        
        showLoading()

        ReceiverUpdateService().callServiceObject(request: request) { (result) in

            hideLoading()

            switch result {
            case .success(let response):
                print("❤️🐶 receiverBookINUpdate response= \(response) ")
                let response = PickUpCar.Something.Response(receiverModelResponse: response)
                completion(response)

            case .failure(let error):
                let response = PickUpCar.Something.Response(error: error.getMessage)
                completion(response)

            }
        }
        
    }
    //MARK: UPDATE
    func receiverBookInUpdate(to bookinNO:String?, model:ReceiverCarModel,
                              completion: @escaping responseHandler){
        
        guard let bookinNO = bookinNO else { return }
        
        switch DataController.shared.bookInType {
        
        case .CAR, .CARWRECK:
            //MARK: 🚗
            print("🚗 UPDATE BOOKIN CAR, CARWRECK")
            
            let typeModelTuple = createReceiverModelRequest(model: model)
            
            var request: ReceiverModelRequest!
            let fromEdit = DataController.shared.isFromEditView
            if fromEdit {
                request = ReceiverModelRequest()
                request.bookinNo = bookinNO
                request.bookInType = typeModelTuple.bookInType
                request.vehicleType = typeModelTuple.vehicleType
                request.externalType = model.isEditExternal ? typeModelTuple.externalType : nil
                request.spareType = model.isEditSpare ? typeModelTuple.spareType : nil
                request.cabinType = model.isEditCabin ? typeModelTuple.cabinType : nil
                request.engineType = model.isEditEngine ? typeModelTuple.engineType : nil
                request.keyOptionType = model.isEditKeyOption ? typeModelTuple.keyOptionType : nil
            }else{
                request = ReceiverModelRequest(bookInType: typeModelTuple.bookInType,
                                               vehicleType: typeModelTuple.vehicleType,
                                               externalType: typeModelTuple.externalType,
                                               spareType: typeModelTuple.spareType,
                                               cabinType: typeModelTuple.cabinType,
                                               engineType: typeModelTuple.engineType,
                                               keyOptionType: typeModelTuple.keyOptionType,
                                               bookinNo: bookinNO)
            }
    
            //print(request.toJSON())
    
            if request.toJSON().isEmpty {
                let response = PickUpCar.Something.Response()
                completion(response)
    
                return
            }
            //print(request.vehicleType?.toJSON() ?? "")
    
            showLoading()
    
            ReceiverUpdateService().callServiceObject(request: request) { (result) in
    
                hideLoading()
    
                switch result {
                case .success(let response):
                    print("❤️🐶 receiverBookINUpdate response= \(response) ")
                    let response = PickUpCar.Something.Response(receiverModelResponse: response)
                    completion(response)
    
                case .failure(let error):
                    let response = PickUpCar.Something.Response(error: error.getMessage)
                    completion(response)
    
                }
            }
        case .MBIKE, .MBIKEWRECK:
            //MARK: 🛵
            print("🛵 UPDATE BOOKIN MBIKE, MBIKEWRECK")
        
            let typeModelTuple = createReceiverModelRequest(model: model)
            
            var request: BookInMotorBikeModelRequest!
            let fromEdit = DataController.shared.isFromEditView
            if fromEdit {
                request = BookInMotorBikeModelRequest()
                request.bookinNo = bookinNO
                request.bookInType = typeModelTuple.bookInType
                request.vehicleType = typeModelTuple.vehicleType
                request.externalType = model.isEditExternal ? typeModelTuple.externalType : nil
                request.spareType = model.isEditSpare ? typeModelTuple.spareType : nil
                request.cabinType = model.isEditCabin ? typeModelTuple.cabinType : nil
                request.engineType = model.isEditEngine ? typeModelTuple.engineType : nil
                request.keyOptionType = model.isEditKeyOption ? typeModelTuple.keyOptionType : nil
                request.motorbikeBookInType = model.isEditMotorbikeOption ? typeModelTuple.motorbikeBookInType : nil
            }else{
                request = BookInMotorBikeModelRequest(bookInType: typeModelTuple.bookInType,
                                               vehicleType: typeModelTuple.vehicleType,
                                               externalType: typeModelTuple.externalType,
                                               spareType: typeModelTuple.spareType,
                                               cabinType: typeModelTuple.cabinType,
                                               engineType: typeModelTuple.engineType,
                                               keyOptionType: typeModelTuple.keyOptionType,
                                               motorbikeBookInType: typeModelTuple.motorbikeBookInType,
                                               bookinNo: bookinNO)
            }
    
            print("🛵 \(request.toJSON())")
    
            if request.toJSON().isEmpty {
                let response = PickUpCar.Something.Response()
                completion(response)
    
                return
            }
            
            showLoading()
            
            UpdateBookInMotorBikeService().callServiceObject(request: request) { results in
                
                hideLoading()
                
                switch results {
                
                case .success(_):
                    let modelResp = ReceiverModelResponse(bookinNo: bookinNO)
                    let response = PickUpCar.Something.Response(receiverModelResponse: modelResp)
                    completion(response)
                case .failure(let error):
                    let response = PickUpCar.Something.Response(error: error.getMessage)
                    completion(response)
                }
            }
    
        }
        
    }
    
    //MARK: POST
    func receiverBookIN(model:ReceiverCarModel, completion: @escaping responseHandler){
       
        switch DataController.shared.bookInType {
        case .CAR, .CARWRECK:
            //MARK: 🚗
            print("🚗 BOOKIN CAR, CARWRECK")
           
            showLoading()
            let typeModelTuple = createReceiverModelRequest(model: model)
            let request = ReceiverModelRequest(bookInType: typeModelTuple.bookInType,
                                               vehicleType: typeModelTuple.vehicleType,
                                               externalType: typeModelTuple.externalType,
                                               spareType: typeModelTuple.spareType,
                                               cabinType: typeModelTuple.cabinType,
                                               engineType: typeModelTuple.engineType,
                                               keyOptionType: typeModelTuple.keyOptionType)
            print(request.toJSON())

            ReceiverService().callServiceObject(request: request) { (result) in
                
                hideLoading()
                
                switch result {
                case .success(let response):
                    print("receiverBookIN response= \(response) ")
                    let response = PickUpCar.Something.Response(receiverModelResponse: response)
                    completion(response)
                    
                case .failure(let error):
                    let response = PickUpCar.Something.Response(error: error.getMessage)
                    completion(response)

                }
            }
        case .MBIKE, .MBIKEWRECK:
            //MARK: 🛵
            print("🛵 BOOKIN MBIKE, MBIKEWRECK")
      
            showLoading()
            let typeModelTuple = createReceiverModelRequest(model: model)
            let request = BookInMotorBikeModelRequest(bookInType: typeModelTuple.bookInType,
                                               vehicleType: typeModelTuple.vehicleType,
                                               externalType: typeModelTuple.externalType,
                                               spareType: typeModelTuple.spareType,
                                               cabinType: typeModelTuple.cabinType,
                                               engineType: typeModelTuple.engineType,
                                               keyOptionType: typeModelTuple.keyOptionType,
                                               motorbikeBookInType: typeModelTuple.motorbikeBookInType)
            print(request.toJSON())

            BookInMotorBikeService().callServiceObject(request: request) { (result) in
                
                hideLoading()
                
                switch result {
                case .success(let response):
                    print("receiverBookIN response= \(response) ")
                    let response = PickUpCar.Something.Response(receiverModelResponse: response)
                    completion(response)
                    
                case .failure(let error):
                    let response = PickUpCar.Something.Response(error: error.getMessage)
                    completion(response)

                }
            }

        }
        
    }
    
    //MARK: Update Stauts BookIN=2
    func updateStatusBookINType(bookinNO:String?, completion: @escaping responseHandler){
        guard let bookinNO = bookinNO?.trimWhiteSpace else { return }
        
        let inspectionModel = DataController.shared.inspectionCarModel
        
        let isCreateInspection = inspectionModel.isCreate
        
        if isCreateInspection  {
            print("❤️🐶 Update Status ❤️🐶")

            let inspector = DataController.shared.getUser()
            
            let bookInType = BookInType(status: 2, inspector: inspector)
            
            var request = ReceiverModelRequest()
            request.bookinNo = bookinNO
            request.bookInType = bookInType
            
            print("❤️🐶 \(request.toJSON()) ❤️🐶")
            
            showLoading()

            ReceiverUpdateService().callServiceObject(request: request) { (result) in

                hideLoading()

                switch result {
                case .success(let response):
                    print("❤️🐶 receiverBookINUpdate response= \(response) ")
                    let response = PickUpCar.Something.Response()
                    completion(response)

                case .failure(let error):
                    let response = PickUpCar.Something.Response(error: error.getMessage)
                    completion(response)

                }
            }
            
        }else{
            print("❤️🐶 Not Validate Value ❤️🐶")
            let response = PickUpCar.Something.Response()
            completion(response)
        }
        
 
    }

    
}
typealias typeModelHandler = (bookInType:BookInType, cabinType:CabinType, engineType:EngineType, externalType:ExternalType, spareType:SpareType, vehicleType:VehicleType, keyOptionType:KeyOptionType , motorbikeBookInType:MotorbikeBookInType)

extension PickUpCarWorker {
    func createReceiverModelRequest(model: ReceiverCarModel) -> typeModelHandler {
        
        //MARK: BookInType Model
        let type = DataController.shared.bookInType.nameValue
        
        let bookIndate = model.date?.DateToServerFormatString()
        let senderSignature = model.senderSignatureImage?.toBase64String()
        let receiptSignature = model.receiverSignatureImage?.toBase64String()
        let inspector = DataController.shared.getUser()
        
        let currentDate = Date()
        let latestUpdatedDate = currentDate.DateToServerFormatString()
        
        DataController.shared.receiverCarModel.latestUpdatedDate = currentDate
        
        let bookInType = BookInType(bookInDate: bookIndate,
                                    senderName: model.nameSender,
                                    receiverName: model.nameReceiver,
                                    contractNumber: model.contractNumber,
                                    mobileNumber: model.phoneNumber,
                                    status: 1,
                                    sellerCode: model.sellerCode,
                                    inspector: inspector, 
                                    senderSignature: senderSignature,
                                    receiverSignature: receiptSignature,
                                    latestUpdatedDate: latestUpdatedDate,
                                    bookinType: type)
            

        
        //MARK: CabinType Model
        let mileage = model.miles?.replacingOccurrences(of: ",", with: "").toInt()
        let cabinType = CabinType(cabinOverAllId: model.cabinOverAllId,
                                  mileage: mileage,
                                  mileageTypeId: model.mileageTypeId,
                                  fuelVolumn: model.fuelVolumn,
                                  gearSystemId: model.gearSystemId,
                                  isAirback: model.isAirback,
                                  isHeadGear: model.isHeadGear,
                                  isPowerAmp: model.isPowerAmp,
                                  isLockGear: model.isLockGear,
                                  isPreAmp: model.isPreAmp,
                                  isBookService: model.isBookService,
                                  isSpeaker: model.isSpeaker,
                                  isManual: model.isManual,
                                  isCigaretteLiter: model.isCigaretteLighter,
                                  isTaxPlate: model.isTaxPlate,
                                  isPlateExpireDate: model.dateExpiredTaxPlate,
                                  isNavigator: model.isNavigator,
                                  isNavigatorBuiltin: model.isNavigatorOnCar,
                                  isNavigatorCD: model.isCd,
                                  isNavigatorSDCard: model.isSDCard,
                                  isNavigatorNoCD: model.isNoCd,
                                  isNavigatorNoSDCard: model.isNoSdCard,
                                  playerBrand: model.brandPlayer,
                                  isPlayerRadio: model.isPlayerRadio,
                                  isPlayerTape: model.isPlayerTape,
                                  isPlayerCD: model.isPlayerCD,
                                  isPlayerUSB: model.isPlayerUSB,
                                  keyOptionId: 1, /// unknow
                                  cabinNote: model.noteCabin,
                                  isInvalidMileage: model.isInvalidMileage,
                                  invalidMileageReason: model.invalidMileageReason)
      
       //MARK: EngineType Model
        let engineType = EngineType(engineRoomOverAllId: model.engineOverAllId,
                                    batteryBrand: model.betteryBrand,
                                    batteryIndicatorColor: model.betteryColor,
                                    isEcu: model.isEcu,
                                    isCompressorAir: model.isCompressor,
                                    driverSystemId: model.driverSystemId,
                                    fuelSystemId: model.fuelSystemId,
                                    isFuelGas: model.isGas,
                                    gasTypeId: model.gasTypeId,
                                    insideAssetNote: model.assetInCar)
        
        //MARK: ExternalType Model
        let externalType =  ExternalType(gradeOverallId: model.gradeOverallId,
                                         colorOverallId: model.colorOverallId,
                                         isSpoiler: model.isSpoiler,
                                         magWheel: model.magWheelAmount?.toInt(),
                                         normalWheel: model.normalWheelAmount?.toInt(),
                                         isTyre: model.isTire,
                                         tyreBrand: model.brandTire,
                                         tyreQuality: model.tireQuality?.toInt(),
                                         damageDesc: model.damageDetail,
                                         roofType: model.roofType)
        
        //MARK: SpareType Model
        let spareType = SpareType(spareOverAllId: model.spareOverAllId,
                                  spareNote: model.spareOverAllNote,
                                  isSpareType: model.isSpareTire,
                                  isHandTool: model.isHandTool,
                                  isMaxliner: model.isMaxliner,
                                  isRoofRack: model.isRoofrack,
                                  isJackCar: model.isJackCar,
                                  isCableChargeEV: model.isCableChargeEV,
                                  accessoriesNote: model.accessoriesNote)
        
        //MARK: Vehicle Model
        var inspecDate = DataController.shared.inspectionCarModel.date
        inspecDate = (inspecDate == nil) ? Date() : inspecDate
        let inspectionDate = inspecDate?.DateToServerFormatString()
        
        let vehicleType = VehicleType(seller: model.sellerCode, ///unknow  char 10
                                      sellingCategory: model.sellingCategory?.trimWhiteSpace, ///unknow char 3
                                      logisticsStatus: "", ///unknow char 2
                                      inspectionDate: inspectionDate,
                                      salesStatus: "", ///char 2
                                      plant: model.plant, ///char 4
                                      storageLocation: model.storePlace,
                                      receiverLocation: model.receiverPlace,
                                      bookedDate: bookIndate,
                                      make: model.make1, /// char2
                                      modelCode: model.codeModelCar, ///
                                      modelCodeId: model.modelCodeId,
                                      model_BU: model.model_BU ,
                                      model_LO: model.model_LO,
                                      buildYear: model.year, /// char 4
                                      vin: model.vinNumber,
                                      chasisNumber: model.vinNumber,
                                      colour: model.cid?.toString(), ///   char4 จาก  (cid <- coloursset/list)
                                      colourDesc: model.colour_BU,
                                      fuelDelivery: model.fuelDelivery, /// char 1  "fuelDelivery": "8501
                                      fuelType: model.fuelType, /// char 1 "fuelType": "1",
                                      gearbox: model.gearbox, /// char 2 "gearbox": "A",
                                      gears: model.gear ?? "" , /// char 2 gears": "",
                                      drive: model.drive?.trimWhiteSpace ?? "",// /// char 3 drivenWheels": "F",
                                      body: model.body, /// char 4 "body": "SA",
                                      redBookCondition: model.redBookCondition, ///char 1
                                      isGasTank: model.isGasTank,
                                      gasTankNumber: model.gasNumber,
                                      vehicleDeleted: true, /// unknow
                                      vehicleDeletedDate: "", /// unknow
                                      createUser: "", /// unknow
                                      createDate: "", /// unknow
                                      make_BU : model.make_BU,
                                      make_LO : model.make_LO,
                                      bodyDesc_BU : model.bodyDesc_BU,
                                      bodyDesc_LO : model.bodyDesc_LO,
                                      engineNumber : model.engineNumber,
                                      engineCapacity : model.engineCapacity?.toInt(),
                                      engineCapacityUnit : "cc",
                                      regisration : model.registration,
                                      registrationYear : model.registrationYear,
                                      registrationProvince : model.province,
                                      variants : model.variants,
                                      isInValidEngineNumber : model.isInValidEngineNumber,
                                      isInValidVinNumber : model.isInValidVinNumber,
                                      isInValidGasNumber : model.isInValidGasNumber,
                                      reasonInValidEngineNumber: model.reasonInValidEngineNumber,
                                      reasonInValidVinNumber: model.reasonInValidVinNumber,
                                      reasonInValidGasNumber: model.reasonInValidGasNumber,
                                      registrationPlate: model.registrationPlate,
                                      isRegistrationMismatch: model.isRegistrationMismatch,
                                      registrationNote: model.registrationNote, isRegistrationAuction: model.isRegistrationAuction)
        print(vehicleType.toJSON())

        let numberOfKey = model.mapKeys?[String.localized("car_interior_key_label")] as? String
        let numberOfKeyRemote = model.mapKeys?[String.localized("car_interior_remote_key_label")] as? String
        let numberOfRemote = model.mapKeys?[String.localized("car_interior_remote_control_label")] as? String
        let numberOfImmobilizer = model.mapKeys?[String.localized("car_interior_key_immobilizer_label")] as? String
        let numberOfKeyless = model.mapKeys?[String.localized("car_interior_keyless_label")] as? String
        let keyOptionType = KeyOptionType(numberOfKey: numberOfKey?.toInt(),
                                          numberOfRemote: numberOfRemote?.toInt(),
                                          numberOfKeyRemote: numberOfKeyRemote?.toInt(),
                                          numberOfImmobilizer: numberOfImmobilizer?.toInt(),
                                          numberOfKeyless: numberOfKeyless?.toInt())
        
        
        print("🛵 annotation count: \(model.annotation?.trimWhiteSpace.count)")
        print("🛵 otherNote count: \(model.otherNote?.trimWhiteSpace.count)")
        
        let motorbikeBookInType = MotorbikeBookInType(frontWheelType: model.frontWheelType,
                                                      frontBrakeType: model.frontBrakeType,
                                                      rearWheelType: model.rearWheelType,
                                                      rearBrakeType: model.rearBrakeType,
                                                      rearTurnSignalR: model.rearTurnSignalR,
                                                      bodyCladdingR: model.bodyCladdingR,
                                                      exhaustPipe: model.exhaustPipe,
                                                      rearFootRest: model.rearFootRest,
                                                      starterLever: model.starterLever,
                                                      frontFootRest: model.frontFootRest,
                                                      sideStand: model.sideStand,
                                                      doubleStand: model.doubleStand,
                                                      windScreenR: model.windScreenR,
                                                      multiPurposeR: model.multiPurposeR,
                                                      mirrorR: model.mirrorR,
                                                      handBreakR: model.handBreakR,
                                                      milesDisplay: model.milesDisplay,
                                                      mask: model.mask,
                                                      frontLight: model.frontLight,
                                                      frontTurnSignalR: model.frontTurnSignalR,
                                                      frontFender: model.frontFender,
                                                      frontTire: model.frontTire,
                                                      frontPumpDiscBrake: model.frontPumpDiscBrakes,
                                                      frontOilTankDiscBrake: model.frontOilTankDiscBrakes,
                                                      frontShockup: model.frontShockup,
                                                      chainCover: model.chainCover,
                                                      handBreakL: model.handBreakL,
                                                      handClutch: model.handClutch,
                                                      frontTurnSignalL: model.frontTurnSignalL,
                                                      mirrorL: model.mirrorL,
                                                      windScreenL: model.windScreenL,
                                                      bodyCladdingL: model.bodyCladdingL,
                                                      seat: model.seat,
                                                      rearSeatRack: model.rearSeatRack,
                                                      rearTurnSignalL: model.rearTurnSignalL,
                                                      rearLight: model.rearLight,
                                                      rearFender: model.rearFender,
                                                      multiPurposeL: model.multiPurposeL,
                                                      rearTire: model.rearTire,
                                                      rearPumpDiscBrake: model.rearPumpDiscBrakes,
                                                      rearOilTankDiscBrake: model.rearOilTankDiscBrakes,
                                                      rearShockup: model.rearShockup,
                                                      ubox: model.ubox,
                                                      oilTank: model.oilTank,
                                                      battery: model.battery,
                                                      cdiBox: model.cdiBox,
                                                      toolSpare: model.toolSpare,
                                                      frontWheel: model.frontWheel,
                                                      rearWheel: model.rearWheel,
                                                      frontBrake: model.frontBrake,
                                                      rearBrake: model.rearBrake,
                                                      otherNote: model.otherNote?.trimWhiteSpace,
                                                      engineCondition: model.engineCondition,
                                                      gearCondition: model.gearCondition,
                                                      brakeCondition: model.brakeCondition,
                                                      isHandStart: model.isHandStart,
                                                      isKickStart: model.isKickStart,
                                                      isRegistrationPlate: model.isRegistrationPlate,
                                                      annotation: model.annotation?.trimWhiteSpace)
        
        
        return (bookInType, cabinType, engineType, externalType, spareType, vehicleType, keyOptionType, motorbikeBookInType)
    }
}
