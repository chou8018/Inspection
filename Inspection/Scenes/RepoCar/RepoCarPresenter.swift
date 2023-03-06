//
//  RepoCarPresenter.swift
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

protocol RepoCarPresentationLogic
{
    func presentSomething(response: RepoCar.Something.Response)
    func presentDeliveryPersonList(response: RepoCar.Something.Response)
    func presentReceiverDayTimeInspection(response: RepoCar.Something.Response)
    func presentDataDateTimeInspection(response: RepoCar.Something.Response)
    func presentWarehouseTimeInspection(response: RepoCar.Something.Response)
    func presentSendToRepo(response: RepoCar.Something.Response)

}

class RepoCarPresenter: RepoCarPresentationLogic
{
    weak var viewController: RepoCarDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: RepoCar.Something.Response)
    {
        let viewModel = RepoCar.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentDeliveryPersonList(response: RepoCar.Something.Response) {        
        guard let list = response.deliveryPersonList else { return }
        let values = list.map({ $0.code ?? "" })
        let viewModel = RepoCar.Something.ViewModel(deliveryCodes: values)
        viewController?.displayDeliveryPersonDropdown(viewModel: viewModel)
    }
    
    func presentSendToRepo(response: RepoCar.Something.Response) {
        if let error = response.error {
            let viewModel = RepoCar.Something.ViewModel(errorMessage : error.message)
            viewController?.displayErrorSendRepo(viewModel: viewModel)
        }else{
            let viewModel = RepoCar.Something.ViewModel()
            viewController?.displaySuccessSendRepo(viewModel: viewModel)
        }
    }
    
    func presentReceiverDayTimeInspection(response: RepoCar.Something.Response) {
        let viewModel = RepoCar.Something.ViewModel(dayTime: response.dayTime)
        viewController?.displayReceiverDayTimeInspection(viewModel: viewModel)
    }
    
    func presentDataDateTimeInspection(response: RepoCar.Something.Response) {
        let viewModel = RepoCar.Something.ViewModel(dayTime: response.dayTime)
        viewController?.displayDataDateTimeInspection(viewModel: viewModel)
    }
    
    func presentWarehouseTimeInspection(response: RepoCar.Something.Response) {
        let viewModel = RepoCar.Something.ViewModel(dayTime: response.dayTime)
        viewController?.displayWarehouseTimeInspection(viewModel: viewModel)
    }
}
