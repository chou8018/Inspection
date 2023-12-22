//
//  AboutCarModels.swift
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

enum AboutCar
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
        var starterYear : Int?
        var gasNumber : String?
        var capacityNumber : String?
        
        var searchCodeModel:ModelCodeTemplateModel?
        var make: String?
        var colorCar: String?
        var province: String?
        var typeCar: String?
        var typeCarCode:String?
        
        var modelCar: String?
        var makeCode: String?
        
        var varaints_bu: String?
        
        var registration: String?
    }
    struct Response
    {
        var yearLists : [String]?
        var isGasNumber : Bool?
        var validateResult : String?
        var makeList : [StandradMakeModel]?
        //var modelList : [ModelCarModel]?
        var modelList : [JatoCarModelsModel]?
        var varaintsList: [JatoVaraintsModel]?
        
        var colorList : [StandardColorModel]?
        var provinceList : [ProvinceModel]?
        
        var bodyList : [BodyCarModel]?
//        var bodyList : [BodyTypeModel]?
        
        var body_bu:String?
        var make_bu:String?
        
        var searchCodeModel:ModelCodeTemplateModel?
        var error : KErrorMessage?
        
        var resultRegistration: String?
        
        var gasOption : [GasTypeModel]?

    }
    struct ViewModel
    {
        var makeList : [String]?
        var modelList : [String]?
        var varaintsList : [String]?
        var yearLists : [String]?
        var colorList : [String]?
        var provinceList : [String]?
        var bodyList : [String]?
        var isGasNumber : Bool?
        var validateResult : String?
        
        var discriptionModelSelect : String?
        var modelCode : String?
        var make : String?
        var variants: String?
        var model: String?
        var buildYear: String?
        var engineCapacity: Int?
        
//        var carType_BU: String?
//        var carType_LO: String?
        var errorMessage: String?
        
        var model_BU : String?
        var model_LO : String?
        
        var body : String?
        var gearbox : String?
        var gear : String?
        var fuelType : String?
        var fuelDelivery : String?
        var drive : String?
        
        var body_bu:String?
        var make_bu:String?
        var chassisNumber:String?
        var modelCodeId:Int?
        
        var resultRegistration: String?
        var gasOption : [String]?

    }
  }
}
