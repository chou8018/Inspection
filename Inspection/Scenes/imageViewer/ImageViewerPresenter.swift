//
//  ImageViewerPresenter.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 4/8/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ImageViewerPresentationLogic
{
  func presentSomething(response: ImageViewer.Something.Response)
    func presentImageViewer(response: ImageViewer.Something.Response)
}

class ImageViewerPresenter: ImageViewerPresentationLogic
{
  weak var viewController: ImageViewerDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ImageViewer.Something.Response)
  {
    let viewModel = ImageViewer.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    func presentImageViewer(response: ImageViewer.Something.Response) {
        let viewModel = ImageViewer.Something.ViewModel(image: response.image)
        viewController?.displayImageViewer(viewModel: viewModel)
    }
}
