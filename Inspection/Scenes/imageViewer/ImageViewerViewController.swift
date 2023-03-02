//
//  ImageViewerViewController.swift
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

protocol ImageViewerDisplayLogic: AnyObject
{
  func displaySomething(viewModel: ImageViewer.Something.ViewModel)
    func displayImageViewer(viewModel: ImageViewer.Something.ViewModel)
}

class ImageViewerViewController: UIViewController, ImageViewerDisplayLogic
{
  var interactor: ImageViewerBusinessLogic?
  var router: (NSObjectProtocol & ImageViewerRoutingLogic & ImageViewerDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ImageViewerInteractor()
    let presenter = ImageViewerPresenter()
    let router = ImageViewerRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    setUp()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
  
  func doSomething()
  {
    let request = ImageViewer.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: ImageViewer.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    
    
    func setUp(){
        imageView.backgroundColor = .galleryColor
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    
    @objc func dismissView(){
        dismiss(animated: true, completion: nil)
    }
    
    func displayImageViewer(viewModel: ImageViewer.Something.ViewModel) {
        imageView.image = viewModel.image
    }
}


extension ImageViewerViewController  {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = ImageViewer.Something.Request()
        interactor?.showImageViewer(request: request)
    }
}
