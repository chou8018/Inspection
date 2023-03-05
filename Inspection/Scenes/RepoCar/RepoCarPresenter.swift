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
        let viewModel = RepoCar.Something.ViewModel(deliveryPersonList: list)
        viewController?.displayDeliveryPersonDropdown(viewModel: viewModel)
    }
    
}
