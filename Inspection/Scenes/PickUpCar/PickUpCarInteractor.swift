//
//  PickUpCarInteractor.swift
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

protocol PickUpCarBusinessLogic
{
  func doSomething(request: PickUpCar.Something.Request)
    func setReceiverDateTime(request: PickUpCar.Something.Request, isEdit:Bool)
    func confirmSendDataReceiverCar(request: PickUpCar.Something.Request)
    
    func generatePdfBookIN(request: PickUpCar.Something.Request)
    func validateRequiteField(request: PickUpCar.Something.Request)
    
    func validateActionSendToIMAT(request: PickUpCar.Something.Request)
    func confirmSendToIMAT(request: PickUpCar.Something.Request)
    
    func generateIMATQRCode(request: PickUpCar.Something.Request)
}

protocol PickUpCarDataStore
{
  //var name: String { get set }
    var currentDate: Date? { get set }
    var documentData : Data? { get set }
    var pdfName : String? { get set }
}

class PickUpCarInteractor: PickUpCarBusinessLogic, PickUpCarDataStore
{
  var presenter: PickUpCarPresentationLogic?
  var worker: PickUpCarWorker?
    var pdfWorker : PickUpCarPDFWorker?
    var pdfQRCodeWorker : IMatQRCodePDFWorker?
    var imatWorker : IMatBookInWorker?
    
  //var name: String = ""
    var currentDate: Date?
    var documentData : Data?
    var isBookinNo = false
    
    var pdfName: String?
    var imatInspection : IMatInspectionWorker?
  // MARK: Do something
  
  func doSomething(request: PickUpCar.Something.Request)
  {
//    worker = PickUpCarWorker()
//    worker?.doSomeWork()
//    
//    let response = PickUpCar.Something.Response()
//    presenter?.presentSomething(response: response)
  }
    
    
    func setReceiverDateTime(request: PickUpCar.Something.Request, isEdit:Bool) {
         let date = request.dateReceiver ?? Date()
        
        currentDate = date

        let day = DateFormatter().dateFormat(from: date, dateFormat: "dd-MM-yyyy")
        let time = DateFormatter().dateFormat(from: date, dateFormat: "HH:mm")
        
        let dateTuple = (day , time)
       
        if !isEdit {
            DataController.shared.receiverCarModel.date = date
            DataController.shared.receiverCarModel.dayString = day
            DataController.shared.receiverCarModel.timeString = time
        }
        
        let response = PickUpCar.Something.Response(dayTime: dateTuple)
        presenter?.presentReceiverDayTime(response: response)
       
    }
    
    //MARK: Send TO IMAT
    func validateActionSendToIMAT(request: PickUpCar.Something.Request) {
        let bookinNo = DataController.shared.receiverCarModel.bookinNo
    
        let isEnableSendToIMAP = (bookinNo != nil)//getSendIMATView()
        let isEnableSave = (bookinNo == nil) || isEnableSendToIMAP
        
        let response = PickUpCar.Something.Response(isEnableSendToIMAP: isEnableSendToIMAP,
                                                    isEnableSave: isEnableSave)
        presenter?.presentValidateSendToIMAT(response: response)
    }
    
    func confirmSendToIMAT(request: PickUpCar.Something.Request) {
        print("🔸🐶 confirmSendToIMAT")
        // after send to imat
        // update vihicleId -> BookInType
        // vehicleId = IMAT

        let isEnableSave = getSendIMATView()
        let method  = isEnableSave ? "POST" : "UPDATE"
        switch method {
        case "UPDATE":
            print("{UPDATE}")
            
            imatWorker = IMatBookInWorker()
            imatWorker?.updateIMATBookIn(completion: {[weak self] response in
                if let makeVehicle = response.makeVehicleResponseModel {
                    DataController.shared.receiverCarModel.vehicleId = makeVehicle.vehicleId ?? ""
                }
                
                if let _ = response.error {
                    self?.presenter?.presentSendToIMAT(response: response)
                }else{
                    self?.createPdfBookIN()
                }
                
            })
        case "POST":
            print("{POST}")
            imatWorker = IMatBookInWorker()
            imatWorker?.sendIMAPBookIn(completion: { [weak self] response in
    
                if let makeVehicle = response.makeVehicleResponseModel {
                    DataController.shared.receiverCarModel.vehicleId = makeVehicle.vehicleId ?? ""
                }
    
                if let _ = response.error {
                    self?.presenter?.presentSendToIMAT(response: response)
                }else{
                    self?.createPdfBookIN()
                }
                
                
            })
        default:
            break
        }

        
    }
    var workerPDF : PickUpCarPDFWorker?
    var motorbikeWorker : MotorBikePDFWorker?
    
    fileprivate func createPdfBookIN(){
        let model = DataController.shared.receiverCarModel
        
        switch DataController.shared.bookInType {
       
        case .CAR, .CARWRECK:
            workerPDF = PickUpCarPDFWorker()
            workerPDF?.generatePDFForReceiver(receiverCarModel: model, completion: {
                [weak self] (response) in

                if let documentData = response.documentData ,
                   let image = pdfDataToImage(documentData: documentData) {
                    self?.sendDocumentFile(image)
                }
                
            })
        case .MBIKE, .MBIKEWRECK:
            print("🛵PDF MOTORBIKE BOOKIN")
            motorbikeWorker = MotorBikePDFWorker()
            motorbikeWorker?.generateMotorBikePDFForBookIn(model: model, completion: { [weak self] response in
                
                if let documentData = response.documentData ,
                   let image = pdfDataToImage(documentData: documentData) {
                    self?.sendDocumentFile(image)
                }
                
            })
        }
        
    }
    
    //MARK: send documentfile
    fileprivate func sendDocumentFile(_ pdfImage: UIImage){
        imatInspection = IMatInspectionWorker()
        imatInspection?.retriveDocument(pdfImage, dType: .BOOKIN, completion: { [weak self] responseDocument in
            
            if let error = responseDocument.error {
                let response = PickUpCar.Something.Response(error : error)
                self?.presenter?.presentSendToIMAT(response: response)
            }else{
                let response = PickUpCar.Something.Response()
                self?.presenter?.presentSendToIMAT(response: response)
            }
        })
        
    }
    
    func confirmSendDataReceiverCar(request: PickUpCar.Something.Request) {
        guard var method =  request.methodReceiver else { return }
        
        method = isBookinNo ? .UPDATE : .POST
        
        let fromEdit = DataController.shared.isFromEditView
        if fromEdit == true { method = .UPDATE }
        
        switch method {
        case .UPDATE:
            print("UPDATE")
            worker = PickUpCarWorker()
            let model = DataController.shared.receiverCarModel

            let bookinNo = DataController.shared.receiverCarModel.bookinNo
            worker?.receiverBookInUpdate(to: bookinNo?.trimWhiteSpace, model: model, completion: {[weak self] (response) in
                if let model = response.receiverModelResponse {
                    self?.isBookinNo = true
                    DataController.shared.receiverCarModel.bookinNo = model.bookinNo
                }
                self?.presenter?.presentReceiverBookIN(response: response)
            })
        case .POST:
            worker = PickUpCarWorker()
            let model = DataController.shared.receiverCarModel
            model.nameReceiver = DataController.shared.getFullName()
            worker?.receiverBookIN(model: model, completion: {[weak self] (response) in
                if let model = response.receiverModelResponse {
                    self?.isBookinNo = true
                    DataController.shared.receiverCarModel.bookinNo = model.bookinNo
                }
                self?.presenter?.presentReceiverBookIN(response: response)
            })
        }
        
    }
    
    func generatePdfBookIN(request: PickUpCar.Something.Request) {
       
        let model = DataController.shared.receiverCarModel
        
        switch DataController.shared.bookInType {
       
        case .CAR, .CARWRECK:
            pdfWorker = PickUpCarPDFWorker()
            pdfWorker?.generatePDFForReceiver(receiverCarModel: model, completion: { [weak self] (response) in
                self?.documentData = response.documentData
                self?.pdfName = createPDFName("BookIn")
                self?.presenter?.presentDPF(response: response)
            })
        case .MBIKE, .MBIKEWRECK:
            print("🛵PDF MOTORBIKE BOOKIN")
            motorbikeWorker = MotorBikePDFWorker()
            motorbikeWorker?.generateMotorBikePDFForBookIn(model: model, completion: { [weak self] response in
                
                self?.documentData = response.documentData
                self?.pdfName = createPDFName("MotorBikeBookIn")
                self?.presenter?.presentDPF(response: response)
            })
        }
        
    }
    
    //MARK: QRCODE
    func generateIMATQRCode(request: PickUpCar.Something.Request) {
        pdfQRCodeWorker = IMatQRCodePDFWorker()
        let model = DataController.shared.receiverCarModel
        pdfQRCodeWorker?.generateIMATQRCodePDF(receiverCarModel: model, completion: { [weak self] (response) in
            self?.documentData = response.documentData
            self?.pdfName = createPDFName("IMATQR")
            self?.presenter?.presentDPF(response: response)
        })
    }
    
    func validateRequiteField(request: PickUpCar.Something.Request) {
        let model = DataController.shared.receiverCarModel
        
        let senderName = model.nameSender
        let contractNumber = model.contractNumber
        let sellerCode = model.sellerCode
//        let mobileNumber = model.phoneNumber

        let plant = model.plant
        let sellCate = model.sellingCategory

        let makeCar = model.make_BU
        let modelCar = model.modelCar
        let variantsCar = model.variants
        let typeCar = model.body
        let capacityCar = model.engineCapacity
        let yearMake = model.year
        let yearRegister = model.registrationYear
        let registration = model.registration
        let province = model.province
        let colorCar = model.colorCar
        
        let gearbox = model.gearbox
        let fuelType = model.fuelType
        
        let modelCode = model.codeModelCar
        
        let receiverPlace = model.receiverPlace
        let storePlace = model.storePlace
        
        let noteRegistration = model.registrationNote ?? ""
        
        let gasNumber = model.gasNumber
        let roofTypeId = model.roofTypeId
        let gasOption = model.gasOption
        let briefConditionId = model.briefConditionOptionId

        print(receiverPlace)
        print(storePlace)
        
        let validNoteRegistration = noteRegistration.unicodeScalars.count < 99
    
        let validContractNumber = contractNumber != nil && !(contractNumber?.isEmpty ?? false)
        let validSenderName = senderName != nil && !(senderName?.isEmpty ?? false)
//        let validMobile = mobileNumber?.isValidMobile10Digit() ?? false
        let validSellerCode = sellerCode != nil
        
        let validReceiver = receiverPlace != nil && !(receiverPlace?.isEmpty ?? false)
        let validStore = storePlace != nil && !(storePlace?.isEmpty ?? false)
        let validPlant = plant != nil && !(plant?.isEmpty ?? false)
        let validSellCate = sellCate != nil && !(sellCate?.isEmpty ?? false)
        
        let validMake = makeCar != nil && !(makeCar?.isEmpty ?? false)
        let validTypeCar = typeCar != nil && !(typeCar?.isEmpty ?? false)
        let validModelCar = modelCar != nil && !(modelCar?.isEmpty ?? false)
        let validVariantsCar = variantsCar != nil && !(variantsCar?.isEmpty ?? false)
        let validCapacityCar = capacityCar != nil && !(capacityCar?.isEmpty ?? false)
        var validYearMake = yearMake != nil && !(yearMake?.isEmpty ?? false)
        if DataController.shared.receiverCarModel.isInValidManuYear == true {
            validYearMake = true
        }
        var validYearRegister = yearRegister != nil && !(yearRegister?.isEmpty ?? false)
        if DataController.shared.receiverCarModel.isInValidRegistrationYear == true {
            validYearRegister = true
        }
        let validRegistration = registration != nil && !(registration?.isEmpty ?? false)
        let validProvince = province != nil && !(province?.isEmpty ?? false)
        let validColorCar = colorCar != nil && !(colorCar?.isEmpty ?? false)
        
        let validGearBox = gearbox != nil && !(gearbox?.isEmpty ?? false)
        let validFuelType = fuelType != nil && !(fuelType?.isEmpty ?? false)
        
        let validModelCode = modelCode != nil && !(modelCode?.isEmpty ?? false)
        
        var validGasOption = true
        if DataController.shared.isCarType() {
            validGasOption = gasOption != nil && !(gasOption?.isEmpty ?? false)
        }
        
        var validGasNumber = true
        if model.isGasTank == true {
            validGasNumber = gasNumber != nil && !(gasNumber?.isEmpty ?? false)
        }
        
        var validRoofType = true
        if DataController.shared.hasRoofType() == true {
            validRoofType = roofTypeId != nil && (roofTypeId ?? 0 > 0)
        }
        
        var validBriefCondition = true
        if DataController.shared.isCarType() ==  true {
            validBriefCondition = briefConditionId != nil && (briefConditionId ?? 0 > 0)
        }
        
        let string_not_correct = String.localized("login_not_correct_label")
        
        var message : String = ""
        message += validSenderName ? "" : "\(String.localized("car_pick_up_valid_field_sender_name_label")) \(string_not_correct)\n"
        message += validContractNumber ? "" : "\(String.localized("receiver_car_contract_number_label")) \(string_not_correct)\n"
//        message += validMobile ? "" : "หมายเลขโทรศัพท์ \(string_not_correct)\n"
        message += validSellerCode ? "" : "\(String.localized("receiver_car_seller_name_placeholder_label")) \(string_not_correct)\n"
        message += validPlant ? "" : "\(String.localized("receiver_car_plant_location_label")) \(string_not_correct)\n"
        message += validReceiver ? "" : "\(String.localized("receiver_car_receive_location_label")) \(string_not_correct)\n"
        message += validStore ? "" : "\(String.localized("receiver_car_storage_location_label")) \(string_not_correct)\n"
        message += validSellCate ? "" : "sell. category \(string_not_correct)\n"
        message += validModelCode ? "" : "Model Code \(string_not_correct)\n"
        message += validMake ? "" : "\(String.localized("car_pick_up_valid_field_brand_label")) \(string_not_correct)\n"
        message += validTypeCar ? "" : "\(String.localized("car_pick_up_valid_field_type_label")) \(string_not_correct)\n"
        message += validModelCar ? "" : "\(String.localized("car_pick_up_valid_field_model_label")) \(string_not_correct)\n"
        message += validVariantsCar ? "" : "\(String.localized("car_pick_up_valid_field_submodel_label")) \(string_not_correct)\n"
        message += validCapacityCar ? "" : "\(String.localized("create_model_engine_capacity_label")) \(string_not_correct)\n"
        message += validYearMake ? "" : "\(String.localized("car_detail_year_manu_label")) \(string_not_correct)\n"
        message += validYearRegister ? "" : "\(String.localized("car_detail_year_regis_label")) \(string_not_correct)\n"
        message += validRegistration ? "" : "\(String.localized("inspection_list_registration_number_label")) \(string_not_correct)\n"
        message += validProvince ? "" : "\(String.localized("car_detail_province_label")) \(string_not_correct)\n"
        message += validColorCar ? "" : "\(String.localized("car_pick_up_valid_field_color_label")) \(string_not_correct)\n"
        message += validGearBox ? "" : "\(String.localized("create_model_gearbox_label")) \(string_not_correct)\n"
        message += validFuelType ? "" : "\(String.localized("create_model_fuel_delivery_label")) \(string_not_correct)\n"
        message += validNoteRegistration ? "" : "\(String.localized("car_pick_up_valid_field_remark_tips_label")) \(string_not_correct)\n"
        
        message += validGasOption ? "" : "\(String.localized("car_detail_gas_title_label")) \(string_not_correct)\n"
        message += validGasNumber ? "" : "\(String.localized("car_detail_gas_number_placeholder")) \(string_not_correct)\n"
        
        message += validRoofType ? "" : "\(String.localized("car_exterior_roof_type_label")) \(string_not_correct)\n"
        
        message += validBriefCondition ? "" : "\(String.localized("car_detail_brief_condition_title_label")) \(string_not_correct)"
        
        DataController.shared.receiverCarModel.validReceiver = validReceiver
        DataController.shared.receiverCarModel.validStore = validStore
        DataController.shared.receiverCarModel.validSellCate = validSellCate
        DataController.shared.receiverCarModel.validPlant = validPlant
        DataController.shared.receiverCarModel.validContractNumber = validContractNumber
        DataController.shared.receiverCarModel.validSenderName = validSenderName
//        DataController.shared.receiverCarModel.validMobile = validMobile
        DataController.shared.receiverCarModel.validSellerCode = validSellerCode
        
        DataController.shared.receiverCarModel.validModelCode = validModelCode
        DataController.shared.receiverCarModel.validMake = validMake
        DataController.shared.receiverCarModel.validTypeCar = validTypeCar
        DataController.shared.receiverCarModel.validModelCar = validModelCar
        DataController.shared.receiverCarModel.validVariantsCar = validVariantsCar
        DataController.shared.receiverCarModel.validCapacityCar = validCapacityCar
        DataController.shared.receiverCarModel.validYearMake = validYearMake
        DataController.shared.receiverCarModel.validYearRegister = validYearRegister
        DataController.shared.receiverCarModel.validRegistration = validRegistration
        DataController.shared.receiverCarModel.validProvince = validProvince
        DataController.shared.receiverCarModel.validColorCar = validColorCar
        
        DataController.shared.receiverCarModel.validGearBox = validGearBox
        DataController.shared.receiverCarModel.validFuelType = validFuelType
        DataController.shared.receiverCarModel.validNoteRegistration = validNoteRegistration
        DataController.shared.receiverCarModel.validGasNumber = validGasNumber
        DataController.shared.receiverCarModel.validRoofType = validRoofType
        DataController.shared.receiverCarModel.validGasOption = validGasOption
        DataController.shared.receiverCarModel.validBriefCondition = validBriefCondition

        NotificationCenter.default.post(name: NSNotification.Name("updateUI"), object: nil)
        
        let validateRequiteFieldError = message.isEmpty ? nil : message
        let response = PickUpCar.Something.Response(validateRequiteFieldError : validateRequiteFieldError)
        
        presenter?.presentRequiteField(response: response)
    }
}
