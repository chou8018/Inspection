//
//  DateTimeViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 17/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DateTimeDisplayLogic: AnyObject
{
  func displaySomething(viewModel: DateTime.Something.ViewModel)
    func displayDateFormatOnValueChanged(viewModel: DateTime.Something.ViewModel)
    func displayCurrentDateToPicker(viewModel: DateTime.Something.ViewModel)
    var didSelectedDateTimePicker : ( (Date) -> Void)? { get set }
}


class DateTimeViewController: UIViewController, DateTimeDisplayLogic
{
    var didSelectedDateTimePicker: ((Date) -> Void)?
    
  var interactor: DateTimeBusinessLogic?
  var router: (NSObjectProtocol & DateTimeRoutingLogic & DateTimeDataPassing)?

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
    let interactor = DateTimeInteractor()
    let presenter = DateTimePresenter()
    let router = DateTimeRouter()
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
    setDateTime()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
  func doSomething()
  {
    let request = DateTime.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: DateTime.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    func setDateTime(){
        datePicker.calendar = Calendar(identifier: .buddhist)
        
        let request = DateTime.Something.Request()
        interactor?.setDatePicker(request: request)
    }
    
    
    func displayDateFormatOnValueChanged(viewModel: DateTime.Something.ViewModel) {
        print(viewModel.dateString ?? "")
    }
    
   
    
    
    
    func displayCurrentDateToPicker(viewModel: DateTime.Something.ViewModel) {
        guard let date = viewModel.currentDate else { return }
        datePicker.date = date

        print(date)
    }
    
    
    
    
    
    @IBAction func dateTimeValueChanged(_ sender: Any) {
        let request = DateTime.Something.Request(date: datePicker.date)
        interactor?.getDateFormatOnValueChange(request: request)
    }
    @IBAction func nowTimeTapped(_ sender: Any) {
        datePicker.date = Date()
        
        let request = DateTime.Something.Request(date: datePicker.date)
        interactor?.getDateFormatOnValueChange(request: request)
    }
    @IBAction func confirmTapped(_ sender: Any) {
        didSelectedDateTimePicker?(datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
