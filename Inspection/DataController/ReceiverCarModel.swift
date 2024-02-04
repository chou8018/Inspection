//
//  ReceiverCar.swift
//  Inspection
//
//  Created by Thanawat prathumset on 17/2/2564 BE.
//

import Foundation
import UIKit


class ReceiverCarModel {
    var isEditReceiver = false {
        didSet{
            if oldValue == true {
                isEditReceiver = true
            }
        }
    }
    var isEditVehicle = false {
        didSet{
            if oldValue == true {
                isEditVehicle = true
            }
        }
    }
    var isEditExternal = false {
        didSet{
            if oldValue == true {
                isEditExternal = true
            }
        }
    }
    var isEditSpare = false {
        didSet{
            if oldValue == true {
                isEditSpare = true
            }
        }
    }
    var isEditCabin = false {
        didSet{
            if oldValue == true {
                isEditCabin = true
            }
        }
    }
    var isEditEngine = false {
        didSet{
            if oldValue == true {
                isEditEngine = true
            }
        }
    }
    var isEditKeyOption = false {
        didSet{
            if oldValue == true {
                isEditKeyOption = true
            }
        }
    }
    
    var isEditMotorbikeOption = false {
        didSet{
            if oldValue == true {
                isEditKeyOption = true
            }
        }
    }
    
    fileprivate func setEdit<T>(_ oldValue:T?, value:inout Bool) {
        value = (oldValue != nil) || DataController.shared.isFromEditView
    }
    
    //MARK: receiver date time
    var date : Date? { didSet { setEdit(oldValue, value: &isEditReceiver) }}
    var latestUpdatedDate : Date?
    var dayString : String?
    var timeString : String?
    
    //MARK: receiver car
    var nameSender : String? { didSet { setEdit(oldValue, value: &isEditReceiver) }}
    var nameReceiver : String? { didSet { setEdit(oldValue, value: &isEditReceiver) }}
    var bookinNo : String?
    var contractNumber : String? { didSet { setEdit(oldValue, value: &isEditReceiver) }}
    var phoneNumber : String? { didSet { setEdit(oldValue, value: &isEditReceiver) }}
    var companyName : String?
    var companyNameEn : String?
    var senderSignatureImage : UIImage? { didSet { setEdit(oldValue, value: &isEditReceiver) }}
    var receiverSignatureImage : UIImage? { didSet { setEdit(oldValue, value: &isEditReceiver) }}
    var sellerCode : String? { didSet {
        setEdit(oldValue, value: &isEditReceiver)
        setEdit(oldValue, value: &isEditVehicle)
    }}
    
    //MARK: about car
    var sellingCategory:String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var vehicleId : String = ""
    var receiverPlace : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var storePlace : String?  { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var plant: String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    
    var make1 : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var cid : Int? { didSet { setEdit(oldValue, value: &isEditVehicle) }} //color
    var colour_BU:String?
    var colour_LO:String?
    
    var state1 : String?
//    var codeModelTemplete : Int?
    var model_BU : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var model_LO : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var isGasTank : Bool? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    
    var modelCodeId: Int? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var codeModelCar : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var detailModel : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var make_BU : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var make_LO : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var body : String?
    var redBookCondition : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var bodyDesc_BU : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var bodyDesc_LO : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var modelCar : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var variants : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var engineCapacity : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var engineCapacityUnit : String?
    var year : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var registrationYear : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    
    var registration: String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var province : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var colorCar : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var engineNumber : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var vinNumber : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var gasNumber : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    // add-on 02/02/2024
    var isInValidRegistrationYear : Bool? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var isInValidManuYear : Bool? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    
    var isInValidEngineNumber : Bool? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var isInValidVinNumber : Bool? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var isInValidGasNumber : Bool? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var isRegistrationMismatch : Bool? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    
    // add-on 26/10/2023
    var isRegistrationAuction : Bool? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    
    var reasonInValidEngineNumber : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var reasonInValidVinNumber : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var reasonInValidGasNumber : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var gasOption : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var gasOptionId : Int? { didSet { setEdit(oldValue, value: &isEditVehicle) }}

    var registrationNote : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var registrationPlate : String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    
    var gearbox:String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}//require
    var gear:String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var gearboxListPart:[String] = [String]() { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var gearboxListAll:[String] = [String]() { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var fuelType:String?  { didSet { setEdit(oldValue, value: &isEditVehicle) }}//require
    var fuelDelivery:String?  { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var fuelDeliveryName:String? { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    var drive:String?  { didSet { setEdit(oldValue, value: &isEditVehicle) }}
    
    //MARK: External Car
    var gradeOverallId : Int? { didSet { setEdit(oldValue, value: &isEditExternal) }}
    var colorOverallId : Int? { didSet { setEdit(oldValue, value: &isEditExternal) }}
    
    var externalOverall : String?
    var colorOverall : String?
    var isSpoiler : Bool? { didSet { setEdit(oldValue, value: &isEditExternal) }}
    var isMagWheel = false
    var magWheelAmount : String? { didSet { setEdit(oldValue, value: &isEditExternal)}}
    var isNormalWheel = false
    var normalWheelAmount : String? { didSet { setEdit(oldValue, value: &isEditExternal) }}
    var isTire : Bool? { didSet { setEdit(oldValue, value: &isEditExternal) }}
    var tireQuality : String?  { didSet { setEdit(oldValue, value: &isEditExternal) }}
    var brandTire : String? { didSet { setEdit(oldValue, value: &isEditExternal) }}
    var damageDetail : String? { didSet { setEdit(oldValue, value: &isEditExternal) }}
    var roofType: String? { didSet { setEdit(oldValue, value: &isEditExternal) }}
    var roofTypeId: Int? { didSet { setEdit(oldValue, value: &isEditExternal) }}

    //MARK: Cabin
    var cabinOverAllId : Int? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var mileageTypeId : Int? { didSet { isEditCabin = (mileageTypeId==1) ? false : (oldValue != nil) }}
    var fuelVolumn : Int? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var gearSystemId : Int? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    
    var cabinOverall : String?
    var typeGear : String?
    var typeMiles : String?
    var miles : String? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var oilAmount : String?
    var isPlayer = false
    var isPlayerRadio : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isPlayerTape : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isPlayerCD : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isPlayerUSB : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}

    var brandPlayer : String? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isNavigator : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isNavigatorOnCar : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isCd : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isSDCard : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isNoSdCard : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isNoCd : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}

    var isHeadGear : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isLockGear : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isAirback : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isPowerAmp : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isPreAmp : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isBookService : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isSpeaker : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isManual : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isCigaretteLighter : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var isTaxPlate : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var dateExpiredTaxPlate : String? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var noteCabin : String? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    
    var isInvalidMileage : Bool? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    var invalidMileageReason : String? { didSet { setEdit(oldValue, value: &isEditCabin) }}
    
    //MARK: KeyOption
    var isKeys  : Bool? { didSet { setEdit(oldValue, value: &isEditKeyOption) }}
    var mapKeys : [String: Any]?

    //MARK: SpareParts
    var spareOverAllId : Int? { didSet { setEdit(oldValue, value: &isEditSpare) }}
    
    var spareOverAll: String?
    var spareOverAllNote: String? { didSet { setEdit(oldValue, value: &isEditSpare) }}
    var isSpareTire : Bool?  { didSet { setEdit(oldValue, value: &isEditSpare) }}
    var isHandTool : Bool?  { didSet { setEdit(oldValue, value: &isEditSpare) }}
    var isMaxliner : Bool?  { didSet { setEdit(oldValue, value: &isEditSpare) }}
    var isRoofrack : Bool?  { didSet { setEdit(oldValue, value: &isEditSpare) }}
    var isJackCar : Bool?  { didSet { setEdit(oldValue, value: &isEditSpare) }}
    var isCableChargeEV : Bool?  { didSet { setEdit(oldValue, value: &isEditSpare) }}
    var accessoriesNote : String?  { didSet { setEdit(oldValue, value: &isEditSpare) }}
    //Note 120 charactor in 1 line

    
    
    //MARK: Engine
    var engineOverAllId : Int? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    var driverSystemId : Int? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    var fuelSystemId : Int? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    var gasTypeId : Int? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    
    var engineOverAll : String?
    var betteryBrand : String? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    var betteryColor : String? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    var isEcu  : Bool? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    var isCompressor : Bool? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    var driverSystem : String?
    var oilSystem: String?
    var isGas : Bool? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    var gasSystem: String?
    var assetInCar: String? { didSet { setEdit(oldValue, value: &isEditEngine) }}
    
    
    
    //MARK: MotorCycle
    var frontWheelType: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontBrakeType: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearWheelType: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearBrakeType: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearTurnSignalR: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var bodyCladdingR: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var exhaustPipe: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearFootRest: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var starterLever: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontFootRest: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var sideStand: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var doubleStand: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var windScreenR: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var multiPurposeR: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var mirrorR: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var handBreakR: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var milesDisplay: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var mask: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontLight: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontTurnSignalR: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontFender: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontTire: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontPumpDiscBrakes: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontOilTankDiscBrakes: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontShockup: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var chainCover: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var handBreakL: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var handClutch: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontTurnSignalL: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var mirrorL: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var windScreenL: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var bodyCladdingL: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var seat: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearSeatRack: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearTurnSignalL: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearLight: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearFender: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var multiPurposeL: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearTire: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearPumpDiscBrakes: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearOilTankDiscBrakes: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearShockup: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var ubox: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var oilTank: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var battery: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var cdiBox: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var toolSpare: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontWheel: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearWheel: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var frontBrake: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var rearBrake: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var otherNote: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var engineCondition: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var gearCondition: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var brakeCondition: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var isHandStart: Bool? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var isKickStart: Bool? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var isRegistrationPlate: Bool? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    var annotation: String? { didSet { setEdit(oldValue, value: &isEditMotorbikeOption)}}
    
    var validSellCate:Bool?
    var validPlant:Bool?
    var validContractNumber:Bool?
    var validSenderName:Bool?
    var validMobile:Bool?
    var validSellerCode:Bool?
    var validMake:Bool?
    var validTypeCar:Bool?
    var validModelCar:Bool?
    var validVariantsCar:Bool?
    var validCapacityCar:Bool?
    var validYearMake:Bool?
    var validYearRegister:Bool?
    var validRegistration:Bool?
    var validProvince:Bool?
    var validColorCar:Bool?
    var validGearBox:Bool?
    var validFuelType:Bool?
    var validModelCode:Bool?
    
    var validReceiver:Bool?
    var validStore:Bool?
    
    var validNoteRegistration:Bool?
    
    var validGasNumber:Bool?
    var validRoofType:Bool?
    var validGasOption:Bool?

    var description : [String : Any] {
        return [:]
    }
    
}


extension ReceiverCarModel {
    //MARK: Keys
    func addKeys(type:String , amount : String = "0"){
        if mapKeys == nil {
            mapKeys = [:]
        }
        mapKeys?[type] = amount
    }
    func removeKeys(type:String){
        guard let _ = mapKeys else { return }
        mapKeys?.removeValue(forKey: type)
    }
    var itemKeys : String {
        guard let item = mapKeys, item.count > 0 else { return "" }
        return item.reduce("", { (result, item) -> String in
            if let value = item.value as? String , value.toInt() > 0{
                return result + "  • \(item.key) \(item.value) \(String.localized("motorbike_pdf_flower_label"))"
            }else{
                return result
            }
            
        })
    }
    var itemKeys2 : String {
        guard let item = mapKeys, item.count > 0 else { return "" }
        return item.reduce("", { (result, item) -> String in
            if let value = item.value as? String , value.toInt() > 0{
                return result + "\(item.key) \(item.value)"
            }else{
                return result
            }
            
        })
    }
    
    
}
