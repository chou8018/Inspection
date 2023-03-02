//
//  PlaceInteractor.swift
//  Inspection
//
//  Created by Thanawat prathumset on 2/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PlaceBusinessLogic
{
  func fetchDataPicker(request: Place.Picker.Request)
    func confirmSelectPlace(request: Place.Picker.Request)
    
    func searchReceiverName(request: Place.Picker.Request)
    func searchStorageName(request: Place.Picker.Request)
}

protocol PlaceDataStore
{
  //var name: String { get set }
    var defaultSelectReceiveName : PlantResponse? { get set }
    var defaultSelectStoreName : StorageLocationModel? { get set }
    
    var locationList : [StorageLocationModel]? { get set }
    var plantLocationList : [PlantResponse]? { get set }
}

class PlaceInteractor: PlaceBusinessLogic, PlaceDataStore
{
    
  var presenter: PlacePresentationLogic?
  var worker: PlaceWorker?
  //var name: String = ""
    var defaultSelectReceiveName: PlantResponse?
    var defaultSelectStoreName: StorageLocationModel?
  
    var locationList : [StorageLocationModel]?
    var plantLocationList : [PlantResponse]?
    
  // MARK: Do something 
  
  func fetchDataPicker(request: Place.Picker.Request)
  {
    
    let receiverValue = plantLocationList?.firstIndex(where: { $0.plant1 ==  defaultSelectReceiveName?.plant1})
    
    let storageValue = locationList?.firstIndex(where: { $0.locationId ==  defaultSelectStoreName?.locationId})
    
    let response = Place.Picker.Response(plantLocationList: plantLocationList ,
                                         locationList: locationList ,
                                         selectReceiveValue: receiverValue ,
                                         selectStoreValue: storageValue)
    
    presenter?.presentDataPicker(response: response)
  }
    
    func confirmSelectPlace(request: Place.Picker.Request) {
         let selectReceiveName = request.selectReceiveRow
        let selectStoreName = request.selectStoreRow
       
        let response = Place.Picker.Response(
            selectReceiveName: selectReceiveName ?? defaultSelectReceiveName,
            selectStoreName: selectStoreName ?? defaultSelectStoreName)

        presenter?.selectReceiveAndStore(response: response)
    }
    
    func searchReceiverName(request: Place.Picker.Request) {
        guard let filterName  = request.filterName else { return }
        
        var filterLocation : [PlantResponse]?
        
        if filterName.isEmpty {
            filterLocation = plantLocationList
        }else{
            filterLocation = plantLocationList?.filter({ ($0.desc_BU?.lowercased().contains(filterName.lowercased()))! })
        }
        
        let locationPresent = (filterLocation?.count ?? 0) > 0 ? filterLocation : nil
        
        if let value = filterLocation?.first {
            defaultSelectReceiveName = value
        }else{
            defaultSelectReceiveName = nil
        }
        
        let response = Place.Picker.Response(plantLocationList: locationPresent)
        presenter?.presentReceiverDataPicker(response: response)
    }
    func searchStorageName(request: Place.Picker.Request) {
        guard let filterName  = request.filterName else { return }
        
        var filterLocation : [StorageLocationModel]?
        
        if filterName.isEmpty {
            filterLocation = locationList
        }else{
            filterLocation = locationList?.filter({ ($0.location?.lowercased().contains(filterName.lowercased()))! })
        }
        
        let locationPresent = (filterLocation?.count ?? 0) > 0 ? filterLocation : nil
       
        if let value = filterLocation?.first {
            defaultSelectStoreName = value
        }else{
            defaultSelectStoreName = nil
        }
        
        let response = Place.Picker.Response(locationList: locationPresent)
        presenter?.presentStorageDataPicker(response: response)
        
    }
    
    
    func getProvinceModel(from row : Int?) -> StorageLocationModel? {
        guard let selectRow = row else { return nil }
        return locationList?[selectRow]
    }
}
