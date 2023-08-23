//
//  DataController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/2/2564 BE.
//

import Foundation
import UIKit
import PDFKit

class DataController {
    static let shared = DataController()
    
    var receiverCarModel = ReceiverCarModel()
    var inspectionCarModel = InspectionCarModel()
    var photoCarModel = PhotoCarModel()
    
    var standardMakeList: [StandradMakeModel]?
    
    var isFromEditView = false
    
    enum BOOKIN_TYPE {
        case CAR
        case MBIKE
        case CARWRECK
        case MBIKEWRECK
        var bookInValue : [String] {
            switch self {
            case .CAR:
                return [String.localized("pick_up_deliverer_title"),String.localized("pick_up_car_details_title"),String.localized("pick_up_exterior_title"),String.localized("pick_up_trunk_title"),String.localized("pick_up_interior_title"),String.localized("pick_up_engine_room_title")]
            case .MBIKE:
                return [String.localized("pick_up_deliverer_title"),String.localized("select_inspection_motobike_label"),String.localized("pick_up_exterior_title"),String.localized("motorbike_inspection_engine_label")]
            case .CARWRECK:
                return [String.localized("pick_up_deliverer_title"),String.localized("car_salvage_details_title"),String.localized("pick_up_exterior_title"),String.localized("pick_up_trunk_title"),String.localized("pick_up_interior_title"),String.localized("pick_up_engine_room_title")]
            case .MBIKEWRECK:
                return [String.localized("pick_up_deliverer_title"),String.localized("select_inspection_motobike_salvage_label"),String.localized("pick_up_exterior_title"),String.localized("motorbike_inspection_engine_label")]
            }
        }
        var inspectionValue : [String] {
            switch self {
            case .CAR:
                return [String.localized("inspection_body_title"),
                        String.localized("inspection_engine_title"),
                        String.localized("inspection_suspension_title"),
                        String.localized("inspection_gear_box_title"),
                        String.localized("inspection_steering_title"),
                        String.localized("inspection_brake_title"),
                        String.localized("inspection_air_title"),
                        String.localized("inspection_gauges_title"),
                        String.localized("inspection_electrical_title")]
            case .MBIKE:
                return [String.localized("motorbike_inspection_exterior_label")]
            case .CARWRECK:
                return [String.localized("inspection_body_title"),
                        String.localized("inspection_engine_title"),
                        String.localized("inspection_suspension_title"),
                        String.localized("inspection_gear_box_title"),
                        String.localized("inspection_steering_title"),
                        String.localized("inspection_brake_title"),
                        String.localized("inspection_air_title"),
                        String.localized("inspection_gauges_title"),
                        String.localized("inspection_electrical_title")]
            case .MBIKEWRECK:
                return [String.localized("motorbike_inspection_exterior_label")]
                
            }
        }
        var nameValue : String {
            switch self {
            case .CAR:
                return "CAR"
            case .MBIKE:
                return "MBIKE"
            case .CARWRECK:
                return "CARWRECK"
            case .MBIKEWRECK:
                return "MBIKEWRECK"
            }
        }
    }
    
    
    var bookInType:BOOKIN_TYPE = .CAR
    
    func clear(){
        receiverCarModel = ReceiverCarModel()
        inspectionCarModel = InspectionCarModel()
        photoCarModel = PhotoCarModel()
        isFromEditView = false
        bookInType = .CAR
    }
    func clearCachePhotoUploaded(){
        photoCarModel.itemList = [:]
        
    }
    
    
    func isLogin() -> Bool {
        let firstname = KeyChainService.shared.getFirstName()?.trimWhiteSpace
        let lastname = KeyChainService.shared.getLastName()?.trimWhiteSpace
        let email = KeyChainService.shared.getEmail()?.trimWhiteSpace
        var checkValue = ""
        checkValue += (firstname != nil) ? "isfirstname" : ""
        checkValue += (lastname != nil) ? "islastname" : ""
        checkValue += (email != nil) ? "isemail" : ""
        
        return !checkValue.isEmpty
    }
    func getFullName() -> String {
        let firstname = KeyChainService.shared.getFirstName()?.trimWhiteSpace
        let lastname = KeyChainService.shared.getLastName()?.trimWhiteSpace
        
        var fullName = ""
        fullName += (firstname != nil) ? "\(firstname!) " : ""
        fullName += (lastname != nil) ? "\(lastname!)" : ""
        
        return fullName
    }
    func getUser() -> String {
        let email = KeyChainService.shared.getEmail()?.trimWhiteSpace
        guard let  user = email?.split(separator: "@").first else { return "" }
        return String(user)
    }
    
    func clearLogin() {
        KeyChainService.shared.clearData()
        UserDefaults.removeCurrentLanguage()
    }
    
    func getVersion() -> String {
        return "\(Bundle.main.appName) v \(Bundle.main.versionNumber) (Build \(Bundle.main.buildNumber))"
    }
    
    func isThaiLanguage() -> Bool {
        
        if let language = UserDefaults.getCurrentLanguage() {
            if language == "TH" {
                return true
            }
            return false
        } else {
            if let languageCode = Locale.current.languageCode, languageCode == "thai" {
                return true
            }
            return false
        }
    }
}

func getStandardMake1ID(from makeValue:String) -> StandradMakeModel? {
    guard let standardMakeList = DataController.shared.standardMakeList else { return nil }
    return standardMakeList.filter { $0.desc_BU?.lowercased().contains(makeValue.lowercased()) ?? false }.first
}

func getRadioValue(from arrayOption : [String] , selectIndex : Int) -> String {
    return arrayOption[selectIndex]
}
func getRadioIndexByValue(from arrayOption : [String] , value : String?) -> Int {
    guard let value = value else { return -1 }
    return arrayOption.firstIndex(of: value) ?? -1
}


func createPDFName(_ title:String) -> String {
    let bookinNo = DataController.shared.receiverCarModel.bookinNo?.trimWhiteSpace ?? "0"
    return "\(title)_\(bookinNo)_\(Date().DateToServerFormatString(format: "yyyyMMddHHmmss"))"
}

func pdfDataToImage(documentData: Data?) -> UIImage? {
    if let data = documentData, let pdfData = PDFDocument(data: data) {
        if let page = pdfData.page(at: 0) {
            let pageSize = page.bounds(for: .mediaBox)
            let pageScale = 480 / pageSize.width
            let scale = UIScreen.main.scale * pageScale
            let screenSize = CGSize(width: pageSize.width * scale,
                                    height: pageSize.height * scale)
            let image = page.thumbnail(of: screenSize, for: .mediaBox)
            
            return image
        }
    }
    return nil
}


func getEnableView() -> Bool {
    let model = DataController.shared.receiverCarModel
    //let modelInspec = DataController.shared.inspectionCarModel
    
    var enable = true
    
    if model.bookinNo == nil {
        enable = true
    }
    if !model.vehicleId.trimWhiteSpace.isEmpty {
        enable = false
    }
    //    if !modelInspec.vehicleId.trimWhiteSpace.isEmpty {
    //        enable = true
    //    }
    return true //enable
}

func getSendIMATView() -> Bool {
    let model = DataController.shared.receiverCarModel
    //let modelInspec = DataController.shared.inspectionCarModel
    
    var enable = false
    
    if model.bookinNo != nil {
        enable = true
    }
    if !model.vehicleId.trimWhiteSpace.isEmpty {
        enable = false
    }
    //    if !modelInspec.vehicleId.trimWhiteSpace.isEmpty {
    //        enable = true
    //    }
    return enable
}

func getDataBookInType(type:String?) -> DataController.BOOKIN_TYPE {
    guard let type = type else { return .CAR }
    switch type.trimWhiteSpace.uppercased() {
    case "CAR":
        return .CAR
    case "MBIKE":
        return .MBIKE
    case "CARWRECK":
        return .CARWRECK
    case "MBIKEWRECK":
        return .MBIKEWRECK
    default:
        return .CAR
    }
}



func mapSellerList(from sellerList:[String]) -> [String] {
    let sellerActiveList:[String] = ["Arcadia Transport Co., Ltd.",
                                     "Arcadia Transport Lanna Co., Ltd.",
                                     "Bangkok Auto Lease Co,. Ltd",
                                     "Bangkok Mitsubishi HC Capital Co.,Ltd.",
                                     "Bell Car Rental & Leasing Co., Ltd.",
                                     "Bell Transport Co., Ltd.",
                                     "Car Go (Thailand) Co.,Ltd",
                                     "Expert Car Rental Co.,Ltd.",
                                     "Krung Thai IBJ Leasing Co., Ltd.",
                                     "Krungthai Car Rent & Lease Public Co., Ltd.",
                                     "Paragon Car Rental Co., Ltd.",
                                     "Patana Thai Borikarn Co., Ltd.",
                                     "Phatra Leasing Public Co., Ltd.",
                                     "Prime Car Rent Co.,Ltd.",
                                     "Q.C. Leasing Company Limited.",
                                     "Quality Rent A Car Co.,Ltd.",
                                     "Rod Dee Det Auto Co., Ltd.",
                                     "S.M.T. Rent A Car Co., Ltd.",
                                     "Southeast Capital Co.,Ltd.",
                                     "Sumitomo Mitsui Auto Leasing & Service (Thailand) Co.,Ltd.",
                                     "TC Car Solutions (Thailand) Co., Ltd.",
                                     "THAI ORIX LEASING CO., LTD",
                                     "Thai Prestige Rent-A-Car Co.,Ltd.",
                                     "Tisco Tokyo Leasing Co., Ltd.",
                                     "True Leasing Co., Ltd.",
                                     "VIG Car Rent Co., Ltd.",
                                     "AEON THANA SINSAP (THAILAND) PCL.",
                                     "Petchaboon Eakyokaya",
                                     "Beautiful Car Center Limited Partnership",
                                     "Phongsak Lueangsiphet",
                                     "BMW (Thailand) Co., Ltd.",
                                     "Prapas Sutassanasaung",
                                     "BOT Lease (Thailand) Co., Ltd.",
                                     "Rachot Bunyongponglert",
                                     "Ch.Erawan Motors Nakhonpathom Co., Ltd.",
                                     "Sabay Sabay Leasing  Co., Ltd.",
                                     "Chatchai Chinvetkitvanit",
                                     "Sakakan Manatrakul",
                                     "Chayapak Company Limited.",
                                     "Sarawut Khomkhai",
                                     "Danachod Janthawong",
                                     "Siam Nissan Body Co., Ltd.",
                                     "Ford Motor Company (Thailand) Limited.",
                                     "Sirot Changsan",
                                     "Ford Sales & Service (Thailand) Co., Ltd.",
                                     "SNN Leasing Co., Ltd.",
                                     "Ford Services (Thailand) Company Limited.",
                                     "Sompong Limpitheep",
                                     "Guardforce Cash Solutions  Security (Thailand) Company  Limited.",
                                     "Sriwat Leasing CO.,LTD",
                                     "IST Farm Machinery Co., Ltd.",
                                     "Sumittra Rueangkitsophon",
                                     "Jiraboon Charnpattanakij",
                                     "Sutham Kottanawadee",
                                     "Jirayut Piromnet",
                                     "Suthima Myhill",
                                     "Joseph Lyons",
                                     "Synergetic Auto Performance Plc.",
                                     "K.S. Sale And Service Co., Ltd.",
                                     "Tanawat Tasanapimol",
                                     "Kanthaphon Rampai",
                                     "Thai V.P. Corporation Limited.",
                                     "Kim Tingwan",
                                     "Thitikorn Public Company Limited.",
                                     "Komsan Pichetkitjawat",
                                     "Toyota Buzz Co., Ltd.",
                                     "Kumphol Wanwang",
                                     "Toyota Libra Co., Ltd.",
                                     "Manat Jetwisetpaisan",
                                     "Orico Auto Leasing (Thailand) Ltd.",
                                     "Ford Operations (Thailand) Co., Ltd.",
                                     "Tokio Marine Safety Insurance (Thailand) PCL.",
                                     "Krungthai Mizuho Leasing Co., Ltd."]
    
    let newArray = sellerList.map { sellerName -> String in
        let findItems = sellerActiveList.filter({ sellerName.contains($0) })
        return findItems.count > 0 ?  "✔︎ \(sellerName)" : sellerName
    }
    return newArray
}
