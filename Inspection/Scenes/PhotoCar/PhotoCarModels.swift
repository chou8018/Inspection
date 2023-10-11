//
//  PhotoCarModels.swift
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

enum PhotoCar
{
  // MARK: Use cases
    struct PhotoImage {
        var image : UIImage?
        var url: URL?
        var name: String?
        var base64String: String?
        var idPhoto : Int?

        var damageDesc: String?
        var damageSize: String?
        var damageType: String?
        
        init(image:UIImage?, url:URL? , name: String?, base64String: String? = nil, idPhoto: Int? = nil, damageDesc: String?, damageSize: String?, damageType: String?) {
            
            self.image = image
            self.url = url
            self.name = name
            self.base64String = base64String
            self.idPhoto = idPhoto
            self.damageDesc = damageDesc
            self.damageSize = damageSize
            self.damageType = damageType
            
        }
    }
    
  enum Something
  {
    struct Request
    {
        var dateInspection: Date?
        var image : UIImage?
        var url: URL?
        var sectionName:String?
        var deleteModel : PhotoImage?
        
        var imageViewerModel : PhotoImage?
        
        var isSkip:Bool?
        var damageModel: Damage.DamageImage?
    }
    struct Response
    {
        var dayTime : (day:String, time:String)?
        var imageList : [PhotoImage]?
        var isPhoto : Bool?
        
        var inspectionImageList: [InspectionImageListResponse]?
        
        var hasSection:[(String,Int)]?
        var updateSection:Int?
        var isSkip:Bool?
        var isCheck:Bool?
        
        var isEnableSendToIMAP : Bool?
        var error: KErrorMessage?
    }
    struct ViewModel
    {
        var dayTime : (day:String, time:String)?
        var imageList : [PhotoImage]?
        var alertPhotoMessage: String?
        var requiredSection:[Int]?
        var updateSection:Int?
        var isSkip:Bool?
        var isCheck:Bool?
        
        var isEnableSendToIMAP : Bool?
        var errorMessage:String?
    }
  }
}
