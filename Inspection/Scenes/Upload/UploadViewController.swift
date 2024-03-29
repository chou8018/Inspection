//
//  UploadViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 9/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UploadDisplayLogic: AnyObject
{
  func displayUploaded(viewModel: Upload.Something.ViewModel)
    func displayErrorMessage(viewModel: Upload.Something.ViewModel)
    func displayProgressUploads(viewModel: Upload.Something.ViewModel)
    func displayCreateProgressView(viewModel: Upload.Something.ViewModel)
    func displayUploadSuccessByItem(viewModel: Upload.Something.ViewModel)
    func displayUploadSuccess(viewModel: Upload.Something.ViewModel)
    
    func displayErrorUpdateStatus(viewModel: Upload.Something.ViewModel)
}

class UploadViewController: UIViewController, UploadDisplayLogic
{
  var interactor: UploadBusinessLogic?
  var router: (NSObjectProtocol & UploadRoutingLogic & UploadDataPassing)?

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
    let interactor = UploadInteractor()
    let presenter = UploadPresenter()
    let router = UploadRouter()
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
    deinit {
        print("🔸🐶 deinit UploadViewController ")
    }
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    upload()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var stackView : UIStackView!
    
    var lastIndex:Int {
        return self.stackView.arrangedSubviews.count
    }
    
  func upload()
  {
    let request = Upload.Something.Request()
    interactor?.uploadPhoto(request: request)
  }
  
  func displayUploaded(viewModel: Upload.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    //MARK: displayErrorMessage
    func displayErrorMessage(viewModel: Upload.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage,
              let name = viewModel.modelPhotoImage?.name else { return }

        guard let progressView = stackView.arrangedSubviews
                .filter({ ($0 as? CustomProgressView) != nil })
                .map({ $0 as! CustomProgressView })
                .filter({ ($0.model?.name ?? "") == name  }).first else { return }
        
        DispatchQueue.main.async {
            progressView.error = errorMessage
        }
        
        titleLabel.text = "อัพโหลดไฟล์ล้มเหลว ลองใหม่อีกครั้ง"
        titleLabel.textColor = .errorColor
    }
    
    func displayCreateProgressView(viewModel: Upload.Something.ViewModel) {
        guard let lists = viewModel.uploadList else { return }
        print("create progress view")
        print("progress view count = \(lists.count)")
        
        lists.forEach { [weak self] (itemPhoto) in
            guard let weakself = self else { return }
            
            if let view = UIView.loadNib(name: "CustomProgressView")?.first as? CustomProgressView {
                view.model = itemPhoto
                view.retryCallback = { [weak self] model in
                    guard let weakself = self else { return }
                    let request = Upload.Something.Request(uploadItem: model)
                    weakself.interactor?.uploadPhotoByItem(request: request)
                }
                
                weakself.stackView.insertArrangedSubview(view, at: weakself.lastIndex)
            }
        }
        
    }
    func displayProgressUploads(viewModel: Upload.Something.ViewModel) {
        guard let progressModel = viewModel.progressModel else { return }
        let name = progressModel.name
        let progress = progressModel.progress
        print("\(name) \(progress)")
        
        guard let progressView = stackView.arrangedSubviews
                .filter({ ($0 as? CustomProgressView) != nil })
                .map({ $0 as! CustomProgressView })
                .filter({ ($0.model?.name ?? "") == name  }).first else { return }
        
        DispatchQueue.main.async {
            progressView.progress = progress
            progressView.success = progress >= 1.00
        }
        
    }
    //MARK: displayUploadSuccess
    func displayUploadSuccessByItem(viewModel: Upload.Something.ViewModel) {
        let request = Upload.Something.Request()
        interactor?.uploadSuccessCount(request: request)
    }
    
    func displayUploadSuccess(viewModel: Upload.Something.ViewModel) {
        guard let message = viewModel.uploadSuccessMessage else { return }
        titleLabel.text = message
        titleLabel.textColor = .appPrimaryColor
        
        DataController.shared.clearCachePhotoUploaded()
        //self.popToRootViewController(title: message, confirm: true)
        alert(message: message) {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

    }
    
    func displayErrorUpdateStatus(viewModel: Upload.Something.ViewModel) {
        guard let message = viewModel.errorMessage else { return }
        alertErrorMessage(message: message) { [weak self] in
            self?.updateStatus()
        }
    }
    
    func updateStatus(){
        let request = Upload.Something.Request()
        interactor?.updateStatus(request: request)
    }
}
