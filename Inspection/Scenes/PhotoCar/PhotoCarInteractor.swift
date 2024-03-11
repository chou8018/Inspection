//
//  PhotoCarInteractor.swift
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

typealias PhotoCarResponse = [String : [PhotoCar.PhotoImage]]
protocol PhotoCarBusinessLogic
{
  func doSomething(request: PhotoCar.Something.Request)
    func setReceiverDateTimeInspection(request: PhotoCar.Something.Request)
    func addPhoto(request: PhotoCar.Something.Request)
    func loadListBySection(request: PhotoCar.Something.Request)
    func prepareDataSection(request: PhotoCar.Something.Request)
    func deletePhotoModel(request: PhotoCar.Something.Request)
    func confirmPhotoInspection(request: PhotoCar.Something.Request)
    
    
    func fetchPhotoList(request: PhotoCar.Something.Request)
    
    func ignoredSection(request: PhotoCar.Something.Request)
    
    func confirmSendToInspectionIMAT(request: PhotoCar.Something.Request)
    func validateActionSendToInspectionIMAT(request: PhotoCar.Something.Request)
    
    func showImageViewer(request: PhotoCar.Something.Request)
    func showImageBySection()
    
    // add on 11/03/2024
    func fetchPhotoDetail(request: PhotoCar.Something.Request)

}

protocol PhotoCarDataStore
{
  //var name: String { get set }
    var currentDate: Date? { get set }
    var itemList : PhotoCarResponse { get set }
    var imageViewer:UIImage? { get set }
}

class PhotoCarInteractor: PhotoCarBusinessLogic, PhotoCarDataStore
{
  var presenter: PhotoCarPresentationLogic?
  var worker: PhotoCarWorker?
  //var name: String = ""
    var currentDate: Date?
  // MARK: Do something
    var itemList : PhotoCarResponse = [:]
    
    var imageViewer:UIImage?
    
    var sectionName = ""
    var hasSection:[(String,Int)] = []
    var hasCheckSection:[String:Bool] = [:]
    let sn = ["Front_B", "Engine_B", "Plate_B", "Chassis_B", "Interior_B",
              "Tray_B", "Side_B", "Back_B", "Gas_B", "Asset", "Damage", "Roof_B", "Dashboard_B", "Catalytic_B"]
    
    func getSectionNumbe(_ name:String) -> Int {
        return sn.firstIndex(of: name) ?? 0
    }


  
    deinit {
        itemList = [:]
        print("🔸🐶 deinit photocar PhotoCarInteractor")
    }
   
    


  func doSomething(request: PhotoCar.Something.Request)
  {
    let response = PhotoCar.Something.Response()
    presenter?.presentSomething(response: response)
  }
    
    func setReceiverDateTimeInspection(request: PhotoCar.Something.Request) {
        let date = request.dateInspection ?? Date()
        
        currentDate = date

       
        let day = DateFormatter().dateFormat(from: date, dateFormat: "dd-MM-yyyy")
        let time = DateFormatter().dateFormat(from: date, dateFormat: "HH:mm")
       
        DataController.shared.inspectionCarModel.date = date
        DataController.shared.inspectionCarModel.dayString = day
        DataController.shared.inspectionCarModel.timeString = time
        
        let dateTuple = (day , time)
        
        let response = PhotoCar.Something.Response(dayTime: dateTuple)
        presenter?.presentReceiverDayTimeInspection(response: response)
    }
    
    
    func addPhoto(request: PhotoCar.Something.Request) {
        DispatchQueue.global().sync { [weak self] in
            guard let weakself = self else { return }
            guard  let image = request.image else { return }
            var imageResized = image
            if var size = imageResized.getFileSize() {
                print("🔸 filesize \(size), \(type(of: size))")
                let maxSize = 3 * (1024 * 1024)
                while size > maxSize {

                    imageResized = imageResized.resized(withPercentage: 0.65)!
                    size = imageResized.getFileSize()!

                    print("🔻 resize \(size), \(type(of: size))")
                }
                let sectionName = weakself.sectionName

                //result
                #if DEBUG
                print("✅ sectionName = \(sectionName) ✅ ")
                print("✅ fileName =  \(request.url?.lastPathComponent ?? "-") ✅ ")
//                print("✅ image size =  \(size), \(type(of: size)) ✅ ")
                print("✅ image =  \(imageResized) ✅ ")
                 #endif
                
                weakself.hasSection.append((sectionName, weakself.getSectionNumbe(sectionName)))
            
                let damageModel = request.damageModel
                var damageDesc = "\(damageModel?.damageDetail ?? ""), "
                damageDesc += "\(damageModel?.damagePosition ?? "")"
                weakself.addItem(itemList: &weakself.itemList,
                                 sectionName: sectionName,
                                 image: imageResized,
                                 url: request.url,
                                 name: nil,
                                 base64String: nil,
                                 idPhoto: nil,
                                 damageDesc: damageDesc,
                                 damageSize: damageModel?.damageSize,
                                 damageType: damageModel?.typeOfDamage)
                
                DataController.shared.photoCarModel.itemList = weakself.itemList
                DataController.shared.photoCarModel.hasSection = weakself.hasSection
                
//                let response = PhotoCar.Something.Response(imageList: weakself.itemList[sectionName])
//                weakself.presenter?.presentImageBySection(response: response)
            }
        }
      
    }
    
    func showImageBySection() {
        let response = PhotoCar.Something.Response(imageList: self.itemList[sectionName])
        self.presenter?.presentImageBySection(response: response)
    }
    
    func ignoredSection(request: PhotoCar.Something.Request) {
        guard let isSkip = request.isSkip else { return }
        
        hasCheckSection[sectionName] = isSkip
        DataController.shared.photoCarModel.hasCheckSection = hasCheckSection
        
        if isSkip {
            hasSection.append((sectionName, getSectionNumbe(sectionName)))
            
            
            DataController.shared.photoCarModel.hasSection = hasSection
            
            
            let response = PhotoCar.Something.Response(updateSection: getSectionNumbe(sectionName), isSkip: isSkip)
            presenter?.presentUpdateRequireSection(response: response)
        }else{
            let filter = hasSection.filter {  $0.0 == sectionName }
            for model in filter {
                if let atIndex = hasSection.firstIndex(where: { $0 == model }) {
                    print("🔸section name \(hasSection[atIndex])")
                    
                    if let sectionCount = itemList[hasSection[atIndex].0]?.count , sectionCount > 0 {
                        print("🔸sectionCount \(sectionCount)")
                    }else{
                        print("🔸remove section \(sectionName)")
                        hasSection.remove(at: atIndex)

                        DataController.shared.photoCarModel.hasSection = hasSection
                        
                        let response = PhotoCar.Something.Response(updateSection: getSectionNumbe(sectionName), isSkip: isSkip)
                        presenter?.presentUpdateRequireSection(response: response)
                    }
                    
                }
            }
        }
        
        

    }
    
    func loadListBySection(request: PhotoCar.Something.Request) {
        guard let sectionName = request.sectionName else { return }
        self.sectionName = sectionName
        DataController.shared.photoCarModel.sectionName = sectionName
        
        let responseCheck = PhotoCar.Something.Response(isCheck: hasCheckSection[sectionName])
        presenter?.presentUpdateCheckBox(response: responseCheck)
        
        
        let imageList = itemList[sectionName]?.sorted { [weak self] in
            guard let weakself = self else { return false }
            return weakself.lastSection($0.name) < weakself.lastSection($1.name)
        }
        
        let response = PhotoCar.Something.Response(imageList: imageList)
        presenter?.presentImageBySection(response: response)
    }
    
    func prepareDataSection(request: PhotoCar.Something.Request) {
        self.sectionName = DataController.shared.photoCarModel.sectionName
        self.itemList = DataController.shared.photoCarModel.itemList
        self.hasSection = DataController.shared.photoCarModel.hasSection
        self.hasCheckSection = DataController.shared.photoCarModel.hasCheckSection
        
        let response = PhotoCar.Something.Response(imageList: itemList[sectionName])
        presenter?.presentImageBySection(response: response)
        
        let responseCheck = PhotoCar.Something.Response(isCheck: hasCheckSection[sectionName])
        presenter?.presentUpdateCheckBox(response: responseCheck)
    }
    
    //MARK: Delete
    func deletePhotoModel(request: PhotoCar.Something.Request) {
        guard let deleteTarget = request.deleteModel else { return }
        
        if let _ = deleteTarget.idPhoto {
            let imageName = deleteTarget.name
            
            var documentType: DocumentType =  .NORMAL
//            if let name = deleteTarget.name, name.contains("Damage") {
//                documentType = .NORMAL
//            }else{
//                documentType = .NORMAL
//            }
            if DataController.shared.bookInType == .CARWRECK ||
                DataController.shared.bookInType == .MBIKEWRECK {
                documentType = .ONLINE
            }
            print("bookInTypeName: \(DataController.shared.bookInType.nameValue)")
            print("documentTypeId: \(documentType.documentTypeId)")
            
            worker = PhotoCarWorker()
            worker?.deletePhoto(from: imageName, dType: documentType,  completion: {[weak self] (response) in
                if let error = response.error {
                    let response = PhotoCar.Something.Response(error: error)
                    self?.presenter?.presentImageDelete(response: response)
                }else{
                    self?.removeFormItemList(deleteTarget: deleteTarget)
                }
                
            })
        }else{
            removeFormItemList(deleteTarget: deleteTarget)
        }
    }
    //MARK: Delete/Update List
    func removeFormItemList(deleteTarget:PhotoCar.PhotoImage){

        removeItem(itemList: &itemList,
                   sectionName: sectionName,
                   deleteTarget: deleteTarget)

        if let count = itemList[sectionName]?.count  {
            if count == 0 {
                let filter = hasSection.filter {  $0.0 == sectionName }
                for model in filter {
                    if let atIndex = hasSection.firstIndex(where: { $0 == model }) {
                        hasSection.remove(at: atIndex)
                        hasCheckSection[sectionName] = false
                    }
                }
                
                let response = PhotoCar.Something.Response(updateSection: getSectionNumbe(sectionName), isSkip: false)
                presenter?.presentUpdateRequireSection(response: response)
            }
        }
        
        DataController.shared.photoCarModel.itemList = itemList
        DataController.shared.photoCarModel.hasSection = hasSection
        DataController.shared.photoCarModel.hasCheckSection = hasCheckSection
        
        let response = PhotoCar.Something.Response(
            imageList: itemList[sectionName],
            hasSection: hasSection)
        
        presenter?.presentImageBySection(response: response)
        
        
    }
    
    func confirmPhotoInspection(request: PhotoCar.Something.Request) {
        var isPhoto = false
        
        /// check required all section
        var dic: [String:Int] = [:]
        for item in hasSection {
            let sectionName = item.0
            let sectionPosition = item.1
            dic[sectionName] = sectionPosition
        }
        
        if dic.count >= sn.count {
            /// check new image
            isPhoto = itemList.filter({ $0.value.filter({ $0.image != nil }).count > 0 })
                .reduce(0) { $0 + $1.value.count } > 0
            
            let response = PhotoCar.Something.Response(isPhoto : isPhoto)
            presenter?.presentUpload(response: response)
        }else{
            let response = PhotoCar.Something.Response(isPhoto : false)
            presenter?.presentUpload(response: response)
        }
        
        
    }
    
    
    //MARK: Fetch Photo List
    func fetchPhotoList(request: PhotoCar.Something.Request) {
        guard let bookInNumber = DataController.shared.receiverCarModel.bookinNo else { return }
        
        worker = PhotoCarWorker()
        worker?.fetchInspectionImageList(from: bookInNumber, completion: {[weak self] (response) in
            guard let weakself = self else { return }

            if let _ = response.error {
                weakself.presenter?.presentImageBySection(response: response)
            }else{
                
                if let imageList = response.inspectionImageList {
                    print("🔸reduce image name : \(imageList.reduce("", { "\($0), \($1.imageName!)" }))")
                    imageList.forEach({ [weak self] (model) in
                        guard let weakself = self else { return }
                            
                        var spitName:String = ""
                        var section:String = ""
                        
                        if let name = model.imageName, let range = name.range(of: "_B") {
                            spitName = String(name.split(separator: ".")[0])
                            section = "\(name[..<range.lowerBound])_B"
                        }
                        
                        if let name = model.imageName, name.contains("Damage") {
                            spitName = String(name.split(separator: ".")[0])
                            section = "Damage"
                        }
                        
                        if let name = model.imageName, name.contains("Asset") {
                            spitName = String(name.split(separator: ".")[0])
                            section = "Asset"
                        }
                        
                        if !section.isEmpty {
                            weakself.hasSection.append((section, weakself.getSectionNumbe(section)))
                           
                            weakself.addItem(itemList: &weakself.itemList,
                                             sectionName: section,
                                             image: nil,
                                             url: nil,
                                             name: spitName,
                                             base64String: model.imageData,
                                             idPhoto: model.damageId,
                                             damageDesc: model.damageDesc,
                                             damageSize: model.damageSize,
                                             damageType: model.damageType)
                        }
                       
                    })
                    
                }
               
              
                let response = PhotoCar.Something.Response(
                    imageList: weakself.itemList[weakself.sectionName],
                    hasSection: weakself.hasSection)
                
                weakself.presenter?.presentImageBySection(response: response)
            }
            
        })
    }
    
    func fetchPhotoDetail(request: PhotoCar.Something.Request) {
        guard let bookInNumber = DataController.shared.receiverCarModel.bookinNo else { return }
        guard let photoId = request.idphoto else { return }
        
        worker = PhotoCarWorker()
        worker?.fetchInspectionImageDetail(from: bookInNumber, imageId: photoId, completion: {[weak self] (response) in
            guard let weakself = self else { return }

            weakself.presenter?.presentDetailImage(response: response)
            
        })
    }
    
    //MARK: Send Inspection
    var photoWorker:PhotoCarWorker?
    var iMatWorker:IMatInspectionWorker?
    var workerPDF:SummaryCarPDFWorker?
    var workerSummary:SummaryCarWorker?
    
    func inspectionUpdateDataBeforeSendIMAT(callback: @escaping ()->() ) {
        let model = DataController.shared.inspectionCarModel
        workerSummary = SummaryCarWorker()
        workerSummary?.inspectionUpdate(model: model, completion: { (response) in
            callback()
        })
    }
    
    func confirmSendToInspectionIMAT(request: PhotoCar.Something.Request) {
        inspectionUpdateDataBeforeSendIMAT { [weak self] in
            let bookinNo = DataController.shared.receiverCarModel.bookinNo?.trimWhiteSpace
            self?.photoWorker = PhotoCarWorker()
            self?.photoWorker?.fetchInspectionImageList(from: bookinNo, completion: {[weak self] photoResponse in
            
                self?.createPDF({[weak self] pdfResponse in
                    if let documentData = pdfResponse.documentData ,
                       let image = pdfDataToImage(documentData: documentData) {
                        
                        var imageResized = image
                        if var size = image.getFileSize() {
                            print("🔸 filesize \(size), \(type(of: size))")
                            let maxSize = 2 * (1000 * 1000)
                            while size > maxSize {

                                imageResized = imageResized.resized(withPercentage: 0.9)!
                                size = imageResized.getFileSize()!

                                print("🔻 resize \(size), \(type(of: size))")
                            }
                        }
                        self?.sendToInspection(imageResized)
                    }
                })

            })

        }
    }
    
    //MARK: Retrive, Delete, ReCreate
    fileprivate func sendToInspection(_ pdfImage:UIImage){
        iMatWorker = IMatInspectionWorker()
        iMatWorker?.retriveDocument(pdfImage, dType: .INSPECTION,  completion: {[weak self] response in
            
            let photoResponse = PhotoCar.Something.Response(error: response.error)
            self?.presenter?.presentSendToIMAT(response: photoResponse)
        })
    }
    
    var mbInspecWorkerPDF : MotorbikeInspecPDFWorker?
    
    func createPDF(_ pdfResponse:@escaping (SummaryCar.Something.Response)->()){
        let model = DataController.shared.inspectionCarModel
        let inspector = DataController.shared.getUser()
        
    
        switch DataController.shared.bookInType {
       
        case .CAR, .CARWRECK:
            workerPDF = SummaryCarPDFWorker()
            workerPDF?.generatePDFForInspection(model: model, inspector: inspector,  completion: {(response) in
                
                pdfResponse(response)
            })
        case .MBIKE, .MBIKEWRECK:
            print("🛵 CREATE PDF MOTORBIKE INSPECTION")
            mbInspecWorkerPDF = MotorbikeInspecPDFWorker()
            mbInspecWorkerPDF?.generateMBPDFForInspection(model: model, inspector: inspector,  completion: {(response) in
                
                pdfResponse(response)
            })
        
            
        }
    }
    func validateActionSendToInspectionIMAT(request: PhotoCar.Something.Request) {
        let isCreate = DataController.shared.inspectionCarModel.isCreate
        let vehicleId = DataController.shared.receiverCarModel.vehicleId.trimWhiteSpace
        
        let isEnableSendToIMAP = isCreate && !vehicleId.isEmpty

        
        let response = PhotoCar.Something.Response(isEnableSendToIMAP: isEnableSendToIMAP)
        presenter?.presentValidateSendToIMAT(response: response)
    }
    
    func showImageViewer(request: PhotoCar.Something.Request) {
        guard let imageViewerModel = request.imageViewerModel else { return }
        
       
        if let image = imageViewerModel.image {
            imageViewer = image
        }else{
            imageViewer = imageViewerModel.base64String?.base64StringToImage()
        }
 
        let response = PhotoCar.Something.Response(image:imageViewer)
        presenter?.presentDisplayImageView(response: response)
    }
    
}




//MARK: extension
extension PhotoCarInteractor {

    fileprivate func lastSection(_ name:String?) -> Int {
        if let  namel = name ,
           let rangeSectionNumber = namel.range(of: sectionName) {
            let number = "\(namel[rangeSectionNumber.upperBound...])"
            return number.toInt()
        }
        return 0
    }
    func addItem(itemList: inout PhotoCarResponse, sectionName: String ,
                 image: UIImage?,
                 url: URL?,
                 name:String?,
                 base64String : String?,
                 idPhoto:Int?,
                 damageDesc: String?,
                 damageSize: String?,
                 damageType: String?) {
        
        //itemList[sectionName] = model
        guard var modelList = itemList[sectionName] , modelList.count > 0 else{
            //not found
            var modelList = [PhotoCar.PhotoImage]()
            let newName = (idPhoto != nil) ? name : "\(sectionName)\(modelList.count + 1)"
            modelList.append(PhotoCar.PhotoImage(image: image,
                                                 url: url,
                                                 name: newName,
                                                 base64String: base64String,
                                                 idPhoto: idPhoto,
                                                 damageDesc: damageDesc,
                                                 damageSize: damageSize,
                                                 damageType: damageType))
            
           
            itemList[sectionName] = modelList
            return
        }

        modelList = modelList.filter({ $0.name != name })
       
        var newPhotoName = "\(sectionName)\(modelList.count + 1)"
        var lessNumber: [Int] = []

        if idPhoto == nil {
            //add new photo
            modelList.forEach { [weak self] in
                guard let weakself = self else { return }
                lessNumber.append(weakself.lastSection($0.name))
            }
            lessNumber = lessNumber.sorted(by: { $0 < $1 })
           
            print(lessNumber)
            
            let n = lessNumber.last ?? 0
            newPhotoName = "\(sectionName)\(n + 1)"
        }
        
        
        let newName = (idPhoto != nil) ? name : newPhotoName
        modelList.append(PhotoCar.PhotoImage(image: image,
                                             url: url,
                                             name: newName,
                                             base64String: base64String,
                                             idPhoto: idPhoto,
                                             damageDesc: damageDesc,
                                             damageSize: damageSize,
                                             damageType: damageType))
        
        itemList[sectionName] = modelList.sorted { [weak self] in
            guard let weakself = self else { return false }
            return weakself.lastSection($0.name) < weakself.lastSection($1.name)
            
        }

    }
    
    func removeItem(itemList: inout PhotoCarResponse,
                    sectionName: String, deleteTarget: PhotoCar.PhotoImage) {
        
        guard var modelList = itemList[sectionName] else{
            //not found
            return
        }
        if let target = modelList.firstIndex(where: { $0.name == deleteTarget.name }) {
         
            modelList.remove(at: target)
            itemList[sectionName] = modelList
            
        }
       
    }
}
