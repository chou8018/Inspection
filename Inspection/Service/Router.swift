//
//  Router.swift
//  iOSTest
//
//  Created by thnawat on 14/12/2563 BE.
//

import Foundation
import Alamofire

enum Router {
    case Login(_ parameter:Parameters)
    case getSeller(_ parameter:Parameters)
    case getSellerByCode(_ parameter:Parameters ,_ sellerCode:String)
    case getMake(_ parameter:Parameters)
    case getModel(_ parameter:Parameters , _ make:String)
    case searchModelCode(_ parameter:Parameters, _ year:String, _ make:String, _ model:String)
    case getModelByModelCode(_ parameter:Parameters , _ modelCode:String)
    case getBodyType(_ parameter:Parameters)
    case getStandardMakeList(_ parameter:Parameters)
    case getStandardColorList(_ parameter:Parameters)
    case getStandardColorByCode(_ parameter:Parameters , _ cid : String)
    
    case getStandardProvinceList(_ parameter:Parameters)
    case getStandardBodyList(_ parameter:Parameters)
    case getStandardStorage(_ parameter:Parameters)
    
    /// book-in create  update
    case receiversBookin(_ parameter:Parameters)
    case receiversBookinUpdate(_ parameter:Parameters , _ bookinNo:String)
    
    /// book-in list
    case bookInDetail(_ parameter:Parameters , _ bookInNumber:String)
    case bookInList(_ parameter:Parameters)
    case bookInListSearch(_ parameter:Parameters )
    
    /// pending
    case bookInPendingList(_ parameter:Parameters, email:String)
    
    
    /// inspection create / update / get
    case inspection(_ parameter:Parameters)
    case inspectionDetail(_ parameter:Parameters, _ bookInNumber:String)
    case inspectionUpdate(_ parameter:Parameters, _ bookInNumber:String)
    
    /// grade create / update / get
    case grade(_ parameter:Parameters)
    case gradeDetail(_ parameter:Parameters, _ bookinNo:String)
    case gradeUpdate(_ parameter:Parameters, _ bookinNo:String)
    
    /// upload
    case uploadInspectionImage(_ parameter:Parameters)
    
    // inspection image
    case listInspectionImage(_ parameter:Parameters,_  bookInNumber:String)
    case deleteInspectionImage(_ parameter:Parameters)
    
    // imat
    case createVehicle(_ parameter:Parameters)
    case updateVehicle(_ parameter:Parameters)
    case vehicleDocument(_ parameter:Parameters)
    case getVehicleDocument(_ parameter:Parameters)
    case deleteVehicleDocument(_ parameter:Parameters)
    
    // plant
    case plantLocation(_ parameter:Parameters)
    
    // sellcategory
    case sellcategory(_ parameter:Parameters)
    
    //standard modelcode
    case getDrive(_ parameter:Parameters)
    case getGearBox(_ parameter:Parameters)
    case getFueldelivery(_ parameter:Parameters)
    case getFueltype(_ parameter:Parameters)
    case searchModelCodeTemplate(_ parameter:Parameters)
    case searchModelCodeTemplateByChassis(_ parameter:Parameters)
    case searchModelCodeTemplateByDisplay(_ parameter:Parameters)
    case createModelCode(_ parameter:Parameters)
    case updateModelCode(_ parameter:Parameters)
    
    //jato
    case getJatoVaraints(_ parameter:Parameters, _ model_BU:String)
    case getJatoModel(_ parameter:Parameters)
    
    
    //motorbike
    case bookInMotorBike(_ parameter:Parameters)
    case updateBookInMotorBike(_ parameter:Parameters, _ bookInNumber:String)
    case getInspecMotorBike(_ bookInNumber:String)
    case createInspecMotorBike(_ parameter:Parameters)
    case updateInspecMotorBike(_ parameter:Parameters, _ bookInNumber:String)
    
    var apiModel : ApiModel {
        switch self {
        
        case .Login(let param):
            return ApiModel(path: "inspection/api/userlogin/value", method: .post, param: param)
        
        case .getSeller( _):
            return ApiModel(path: "auction/api/seller/all", method: .get )
        
        case .getSellerByCode(_ ,let sellerCode):
            return ApiModel(path: "auction/api/seller/bycode/\(sellerCode)", method: .get )
            
        case .getMake( _):
            return ApiModel(path: "auction/api/modeltemplates/make", method: .get)
        
        case .getModel( _, let make):
            return ApiModel(path: "auction/api/modeltemplates/model/\(make)", method: .get)
        
        case .searchModelCode( _, let year, let make, let model):
            return ApiModel(path: "auction/api/modeltemplates/search/\(year)/\(make)/\(model)", method: .get)
        
        case .getModelByModelCode( _, let modelCode):
            return ApiModel(path: "auction/api/modeltemplates/template/\(modelCode)", method: .get)
            
        case .getBodyType( _):
            return ApiModel(path: "auction/api/standard/bodytype/en", method: .get)
        
        case .getStandardMakeList( _):
            return ApiModel(path: "auction/api/standard/make/list", method: .get)
            
        case .getStandardColorList( _):
            return ApiModel(path: "auction/api/standard/coloursset/list", method: .get)
            
        case .getStandardColorByCode(_ ,let cid):
            return ApiModel(path: "auction/api/standard/coloursset/bycode/\(cid)", method: .get)
            
        case .getStandardProvinceList( _):
            return ApiModel(path: "auction/api/standard/state/list", method: .get)
        
        case .getStandardBodyList( _):
            return ApiModel(path: "auction/api/standard/body/list", method: .get)
            
        case .getStandardStorage( _):
            return ApiModel(path: "auction/api/standard/storage", method: .get)
        
        //MARK:Book-in
        case .receiversBookin(let param):
            return ApiModel(path: "inspection/api/bookin/create/model", method: .post, param: param)
            
        case .receiversBookinUpdate(let param, let bookinNo):
            return ApiModel(path: "inspection/api/bookin/update/\(bookinNo)/model",
                            method: .put, param: param)
        
        case .bookInDetail(_, let bookInNumber):
            return ApiModel(path: "inspection/api/MotorbikeBookIn/BookinSingle/\(bookInNumber)", method: .get)
        ///inspection/api/MotorbikeBookIn/BookinSingle/
        ///inspection/api/bookin/single/
        
        //MARK: List
        case .bookInList(_ ):
            return ApiModel(path: "inspection/api/bookin/list", method: .get)
            
        //MARK: Pending
        case .bookInPendingList(_ , let email):
            return ApiModel(path: "inspection/api/bookin/pending/\(email)/", method: .get)
            
        case .bookInListSearch(let param):
            return ApiModel(path: "inspection/api/bookIn/find/", method: .get , param: param)
         
        //MARK:Inspection
        case .inspection(let param):
            return ApiModel(path: "inspection/api/inspection/create/model", method: .post, param: param)
        
        case .inspectionDetail(_ , let bookinNo):
            return ApiModel(path: "inspection/api/inspection/find/\(bookinNo)", method: .get)
        
        case .inspectionUpdate(let params, let bookinNo):
            return ApiModel(path: "inspection/api/inspection/update/\(bookinNo)/model",
                            method: .put, param: params)
        //MARK:Grade
        case .grade(let params):
            return ApiModel(path: "inspection/api/inspection/grade/create/model",
                            method: .post, param: params)

        case .gradeDetail(_ , let bookinNo):
            return ApiModel(path: "inspection/api/inspection/grade/find/\(bookinNo)", method: .get)
            
        case .gradeUpdate(let params, let bookinNo):
            return ApiModel(path: "inspection/api/inspection/grade/update/\(bookinNo)/model", method: .put , param: params)
            
        //MARK: Upload
        case .uploadInspectionImage(let params):
            return ApiModel(path: "inspection/api/inspectionimage/create/model", method: .post, param: params)
            
        //MARK: Image list
        case .listInspectionImage(_ , let bookinNo):
            return ApiModel(path: "inspection/api/inspectionimage/images/\(bookinNo)", method: .post)
            
        case .deleteInspectionImage(let params):
            return ApiModel(path: "inspection/api/inspectionimage/delete/model", method: .delete, param: params)
        
        case .createVehicle(let param):
            return ApiModel(path: "auction/api/vehicle/createvehicle/model", method: .post, param: param)
        
        case .updateVehicle(let param):
            return ApiModel(path: "auction/api/vehicle/updatevehicle/model", method: .post, param: param)
        
        case .vehicleDocument(let param):
            return ApiModel(path: "auction/api/vehicle/createdocument/model", method: .post, param: param)
        case .getVehicleDocument(let param):
            return ApiModel(path: "auction/api/vehicle/getdocument/model", method: .post, param: param)
            
            
        case .deleteVehicleDocument(let param):
            return ApiModel(path: "auction/api/vehicle/deletedocument/model", method: .post, param: param)
        
        case .plantLocation(_ ):
            return ApiModel(path: "auction/api/standard/plant", method: .get)
        
        case .sellcategory(_ ):
            return ApiModel(path: "auction/api/standard/sellingcategory", method: .get)

        case .getDrive(_ ):
            return ApiModel(path: "auction/api/standard/drive", method: .get)
            
        case .getGearBox(_ ):
            return ApiModel(path: "auction/api/standard/gearbox", method: .get)
            
        case .getFueldelivery(_ ):
            return ApiModel(path: "auction/api/standard/fueldelivery", method: .get)
        
        case .getFueltype(_ ):
            return ApiModel(path: "auction/api/standard/fueltype", method: .get)
            
        case .searchModelCodeTemplate(let param):
            return ApiModel(path: "auction/api/standard/modeltemplate/modelcode/code",
                            method: .post, param: param)
            
        case .searchModelCodeTemplateByChassis(let param):
            return ApiModel(path: "auction/api/standard/modeltemplate/chassisprecode/code", method: .post, param: param)
            
        case .searchModelCodeTemplateByDisplay(let param):
            return ApiModel(path: "auction/api/standard/modeltemplate/modeldisplay/code", method: .post, param: param)
            
            
        case .createModelCode(let param):
            return ApiModel(path: "auction/api/standard/modeltemplate/modelcreate/model", method: .post, param: param)
            
        case .updateModelCode(let param):
            return ApiModel(path: "auction/api/standard/modeltemplate/modelupdate/model", method: .put, param: param)
            
        case .getJatoVaraints(_ , let model_BU):
            return ApiModel(path: "auction/api/standard/jatoVariant/\(model_BU)", method: .get)
            
        case .getJatoModel(_ ):
            return ApiModel(path: "auction/api/standard/jatomodel", method: .get)
            
        case .bookInMotorBike(let param):
            return ApiModel(path: "inspection/api/MotorbikeBookIns/Create/model", method: .post, param: param)
            
        case .updateBookInMotorBike(let param, let bookinNo):
            return ApiModel(path: "inspection/api/MotorbikeBookIns/Edit/\(bookinNo)/model", method: .put, param: param)
        
        case .getInspecMotorBike(let bookinNo):
            return ApiModel(path: "inspection/api/MotorBikeInspections/DetailsByBookinNo/\(bookinNo)", method: .get)
        
        case .createInspecMotorBike(let param):
            return ApiModel(path: "inspection/api/MotorBikeInspections/Create/model", method: .post, param: param)
         
        case .updateInspecMotorBike(let param, let bookinNo):
            return ApiModel(path: "inspection/api/MotorBikeInspections/Edit/\(bookinNo)/model", method: .put, param: param)
            
        }
        
    
        
    }

}


struct ApiModel:URLRequestConvertible {
    /**
        UAT  http://mapapi-uat.mottoauction.com/
        PROD https://api.mottoauction.com/
     */
    let base:String = "https://api.mottoauction.com/"
    let apiKey = "e9ab5c97-019e-4a83-ad6f-b1d571b24d5d"
    
    var path:String
    var method: Alamofire.HTTPMethod
    var param:Parameters?
  
    
   
    init (path:String?, method:Alamofire.HTTPMethod, param :Parameters? = nil)
    {
        self.path = path ?? ""
        self.method = method
        self.param = param
     
    }

    func asURLRequest() throws -> URLRequest {
        let model = self
        let isFullpath = path.contains("https://api.mottoauction.com/")
        let url = URL(string: isFullpath ? path : base + path )!
        var mutableURLRequest = URLRequest(url: url)
       
        mutableURLRequest.httpMethod = model.method.rawValue
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        mutableURLRequest.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        if let params = model.param , !params.isEmpty , model.method != .get{
            /// post raw-body json
            let jsonData = try! JSONSerialization.data(withJSONObject: params)
            mutableURLRequest.httpBody = jsonData
            return mutableURLRequest
        }else{
            return try URLEncoding.default.encode(mutableURLRequest, with: model.param)
        }

        
//
    }
}
