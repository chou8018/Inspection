/*
 Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
import ObjectMapper

struct VehicleType : Mappable {
    var vehicleId : Int?
    var seller : String = ""
    var sellingCategory : String = ""
    var logisticsStatus : String = ""
    var inspectionDate : String = ""
    var salesStatus : String = ""
    var plant : String = ""
    var storageLocation : String = ""
    var receiverLocation : String = ""
    var bookedDate : String = ""
    var make : String = ""
    var modelCode : String = ""
    var modelCodeId: Int?
    var model_BU : String = ""
    var model_LO : String = ""
    var buildYear : String = ""
    var vin : String = ""
    var chasisNumber : String = ""
    var colour : String = ""
    var colourDesc : String = ""
    var fuelDelivery : String = ""
    var fuelType : String = ""
    var gearbox : String = ""
    var gears : String = ""
    var drive : String = ""
    var body : String = ""
    var redBookCondition : String = ""
    var isGasTank : Bool = false
    var gasTankNumber : String = ""
    var vehicleDeleted : Bool = false
    var vehicleDeletedDate : String = ""
    var createUser : String = ""
    var createDate : String = ""
    //add-on
    var make_BU : String = ""
    var make_LO : String = ""
    var bodyDesc_BU : String = ""
    var bodyDesc_LO : String = ""
    var engineNumber : String = ""
    var engineCapacity : Int = 0
    var engineCapacityUnit : String = ""
    var regisration : String = ""
    var registrationYear : String = ""
    var registrationProvince : String = ""
    var variants : String = ""
    
    //add-on  5/04/2021
    var isInValidEngineNumber : Bool = false
    var isInValidVinNumber : Bool = false
    var isInValidGasNumber : Bool = false
    
    //add-on 17/8/2021
    var reasonInValidEngineNumber : String = ""
    var reasonInValidVinNumber : String = ""
    var reasonInValidGasNumber : String = ""
    
    var registrationPlate : String = ""
    var isRegistrationMismatch : Bool = false
    var registrationNote : String = ""
    
    // add-on 26/10/2023
    var isRegistrationAuction : Bool = false
    var gasOption : String = ""
    var gasOptionId : Int?
    
    // add-on 02/02/2024
    var isInValidRegistrationYear : Bool = false
    
    init?(map: Map) {
        
    }
    
    init(
        seller : String?,
        sellingCategory : String?,
        logisticsStatus : String?,
        inspectionDate : String?,
        salesStatus : String?,
        plant : String?,
        storageLocation : String?,
        receiverLocation : String?,
        bookedDate : String?,
        make : String?,
        modelCode : String?,
        modelCodeId : Int?,
        model_BU : String?,
        model_LO : String?,
        buildYear : String?,
        vin : String?,
        chasisNumber : String?,
        colour : String?,
        colourDesc: String?,
        fuelDelivery : String?,
        fuelType : String?,
        gearbox : String?,
        gears : String?,
        drive : String?,
        body : String?,
        redBookCondition : String?,
        isGasTank : Bool?,
        gasTankNumber : String?,
        vehicleDeleted : Bool?,
        vehicleDeletedDate : String?,
        createUser : String?,
        createDate : String?,
        make_BU : String?,
        make_LO : String?,
        bodyDesc_BU : String?,
        bodyDesc_LO : String?,
        engineNumber : String?,
        engineCapacity : Int?,
        engineCapacityUnit : String?,
        regisration : String?,
        registrationYear : String?,
        registrationProvince : String?,
        variants : String?,
        isInValidEngineNumber : Bool?,
        isInValidVinNumber : Bool?,
        isInValidGasNumber : Bool?,
        reasonInValidEngineNumber : String?,
        reasonInValidVinNumber : String?,
        reasonInValidGasNumber : String?,
        registrationPlate : String?,
        isRegistrationMismatch : Bool?,
        registrationNote : String?,
        isRegistrationAuction : Bool?,
        gasOption: String?,
        gasOptionId: Int?,
        isInValidRegistrationYear: Bool?) {
            
            
            self.seller = seller ?? ""
            self.sellingCategory = sellingCategory ?? ""
            self.logisticsStatus = logisticsStatus ?? ""
            self.inspectionDate = inspectionDate ?? ""
            self.salesStatus = salesStatus ?? ""
            self.plant = plant ?? ""
            self.storageLocation = storageLocation ?? ""
            self.receiverLocation = receiverLocation ?? ""
            self.bookedDate = bookedDate ?? ""
            self.make = make ?? ""
            self.modelCode = modelCode ?? ""
            self.modelCodeId  = modelCodeId ?? 0
            
            self.model_BU = model_BU ?? ""
            self.model_LO = model_LO ?? ""
            self.buildYear = buildYear ?? ""
            self.vin = vin ?? ""
            self.chasisNumber = chasisNumber ?? ""
            self.colour = colour ?? ""
            self.colourDesc = colourDesc ?? ""
            self.fuelDelivery = fuelDelivery ?? ""
            self.fuelType = fuelType ?? ""
            self.gearbox = gearbox ?? ""
            self.gears = gears ?? ""
            self.drive = drive ?? ""
            self.body = body ?? ""
            self.redBookCondition = redBookCondition ?? ""
            self.isGasTank = isGasTank ?? false
            self.gasTankNumber = gasTankNumber ?? ""
            self.vehicleDeleted = vehicleDeleted ?? false
            self.vehicleDeletedDate = vehicleDeletedDate ?? ""
            self.createUser = createUser ?? ""
            self.createDate = createDate ?? ""
            
            self.make_BU = make_BU ?? ""
            self.make_LO = make_LO ?? ""
            self.bodyDesc_BU = bodyDesc_BU ?? ""
            self.bodyDesc_LO = bodyDesc_LO ?? ""
            self.engineNumber = engineNumber ?? ""
            self.engineCapacity = engineCapacity ?? 0
            self.engineCapacityUnit = engineCapacityUnit ?? ""
            self.regisration = regisration ?? ""
            self.registrationYear = registrationYear ?? ""
            self.registrationProvince = registrationProvince ?? ""
            self.variants = variants ?? ""
            
            
            self.isInValidEngineNumber = isInValidEngineNumber ?? false
            self.isInValidVinNumber = isInValidVinNumber ?? false
            self.isInValidGasNumber = isInValidGasNumber ?? false
            
            self.reasonInValidEngineNumber = reasonInValidEngineNumber ?? ""
            self.reasonInValidVinNumber = reasonInValidVinNumber ?? ""
            self.reasonInValidGasNumber = reasonInValidGasNumber ?? ""
            
            self.registrationPlate = registrationPlate ?? ""
            self.isRegistrationMismatch = isRegistrationMismatch ?? false
            self.registrationNote = registrationNote ?? ""
            
            self.isRegistrationAuction = isRegistrationAuction ?? false
            self.gasOption = gasOption ?? ""
            self.gasOptionId = gasOptionId
            self.isInValidRegistrationYear = isInValidRegistrationYear ?? false
        }
    
    mutating func mapping(map: Map) {
        
        vehicleId <- map["vehicleId"]
        seller <- map["seller"]
        sellingCategory <- map["sellingCategory"]
        logisticsStatus <- map["logisticsStatus"]
        inspectionDate <- map["inspectionDate"]
        salesStatus <- map["salesStatus"]
        plant <- map["plant"]
        storageLocation <- map["storageLocation"]
        receiverLocation <- map["receiverLocation"]
        bookedDate <- map["bookedDate"]
        make <- map["make"]
        modelCode <- map["modelCode"]
        modelCodeId <- map["modelCodeId"]
        
        model_BU <- map["model_BU"]
        model_LO <- map["model_LO"]
        buildYear <- map["buildYear"]
        vin <- map["vin"]
        chasisNumber <- map["chasisNumber"]
        colour <- map["colour"]
        colourDesc <- map["colourDesc"]
        fuelDelivery <- map["fuelDelivery"]
        fuelType <- map["fuelType"]
        gearbox <- map["gearbox"]
        gears <- map["gears"]
        drive <- map["drive"]
        body <- map["body"]
        redBookCondition <- map["redBookCondition"]
        isGasTank <- map["isGasTank"]
        gasTankNumber <- map["gasTankNumber"]
        vehicleDeleted <- map["vehicleDeleted"]
        vehicleDeletedDate <- map["vehicleDeletedDate"]
        createUser <- map["createUser"]
        createDate <- map["createDate"]
        
        make_BU <- map["make_BU"]
        make_LO <- map["make_LO"]
        bodyDesc_BU <- map["bodyDesc_BU"]
        bodyDesc_LO <- map["bodyDesc_LO"]
        engineNumber <- map["engineNumber"]
        engineCapacity <- map["engineCapacity"]
        engineCapacityUnit <- map["engineCapacityUnit"]
        regisration <- map["regisration"]
        registrationYear <- map["registrationYear"]
        registrationProvince <- map["registrationProvince"]
        variants <- map["variants"]
        
        
        isInValidEngineNumber <- map["isInValidEngineNumber"]
        isInValidVinNumber <- map["isInValidVinNumber"]
        isInValidGasNumber <- map["isInValidGasNumber"]
        
        reasonInValidEngineNumber <- map["reasonInValidEngineNumber"]
        reasonInValidVinNumber <- map["reasonInValidVinNumber"]
        reasonInValidGasNumber <- map["reasonInValidGasNumber"]
        
        registrationPlate <- map["registrationPlate"]
        isRegistrationMismatch <- map["isRegistrationMismatch"]
        registrationNote <- map["registrationNote"]
        
        isRegistrationAuction <- map["isRegistrationAuction"]
        gasOption <- map["gasNote"]
        gasOptionId <- map["gasType"]
        
        isInValidRegistrationYear <- map["IsNohaveBuildYear"]
    }
    
}
