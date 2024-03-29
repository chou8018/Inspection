//
//  BodyCheckViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 15/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BodyCheckDisplayLogic: AnyObject
{
  func displaySomething(viewModel: BodyCheck.Something.ViewModel)
    func displayProvinceDropdown(viewModel: BodyCheck.Something.ViewModel)
    func displayShowProvinceError(viewModel: BodyCheck.Something.ViewModel)
    
}

class BodyCheckViewController: UIViewController, BodyCheckDisplayLogic
{
  var interactor: BodyCheckBusinessLogic?
  var router: (NSObjectProtocol & BodyCheckRoutingLogic & BodyCheckDataPassing)?

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
    let interactor = BodyCheckInteractor()
    let presenter = BodyCheckPresenter()
    let router = BodyCheckRouter()
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
    setUIView()
    setUpDropdown()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    @IBOutlet weak var chessisDropdown: DropDown!
    @IBOutlet weak var frontSideDropdown: DropDown!
    @IBOutlet weak var backSideDropdown: DropDown!
    @IBOutlet weak var rightSideDriverDropdown: DropDown!
    @IBOutlet weak var leftSideDropdown: DropDown!
    @IBOutlet weak var roofDropdown: DropDown!
    
    @IBOutlet weak var drownedCheckBox: CheckBoxUIButton!
    @IBOutlet weak var bodySummaryTextField: MultilineTextField!
    
    
    @IBOutlet weak var provinceTextField: DropDown!
    @IBOutlet weak var registrationTextField: CustomTextField!
    
    var isGetProvinceLunch = false
    
  func doSomething()
  {
    let request = BodyCheck.Something.Request()
    interactor?.doSomething(request: request)
  }
  
    //MARK: Display Presenter
    
  func displaySomething(viewModel: BodyCheck.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    
    //MARK:UIView
    func setUIView(){
        bodySummaryTextField.autocorrectionType = .no
        bodySummaryTextField.delegate = self
        
        registrationTextField.autocorrectionType = .no
        registrationTextField.delegate = self
        
        provinceTextField.autocorrectionType = .no
        
        addTarget(from: registrationTextField)
        addTarget(from: provinceTextField)
    }
    
    fileprivate func addTarget(from textfield: UITextField ){
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .editingChanged)
    }
    
    //MARK: Dropdown
    func setUpDropdown(){
        let values = ["ปกติ","ซ่อมมาเล็กน้อย","ซ่อมมาปานกลาง","ซ่อมมาหนัก","ผุ"]
        
        setValue(to: chessisDropdown, values: values) { [weak self] (selectValue, _, _)  in
            DataController.shared.inspectionCarModel.chessis = selectValue
            self?.chessisDropdown.text = selectValue
        }
        setValue(to: frontSideDropdown, values: values) { [weak self] (selectValue, _, _)  in
            DataController.shared.inspectionCarModel.frontSide = selectValue
            self?.frontSideDropdown.text = selectValue
        }
        setValue(to: backSideDropdown, values: values) { [weak self] (selectValue, _, _)  in
            DataController.shared.inspectionCarModel.backSide = selectValue
            self?.backSideDropdown.text = selectValue
        }
        setValue(to: rightSideDriverDropdown, values: values) { [weak self] (selectValue, _, _)  in
            DataController.shared.inspectionCarModel.rightSideDriver = selectValue
            self?.rightSideDriverDropdown.text = selectValue
        }
        setValue(to: leftSideDropdown, values: values) { [weak self] (selectValue, _, _)  in
            DataController.shared.inspectionCarModel.leftSide = selectValue
            self?.leftSideDropdown.text = selectValue
        }
        setValue(to: roofDropdown, values: values) { [weak self] (selectValue, _, _)  in
            DataController.shared.inspectionCarModel.roof = selectValue
            self?.roofDropdown.text = selectValue
        }
    }
    
    func setValue(to textfield:DropDown , values: [String], didSelected:@escaping (_ selectedText: String, _ index: Int , _ id:Int )->() ){
        textfield.optionArray = values
        textfield.didSelect(completion: didSelected)
    }
    
    deinit {
        print("🔸🐶 deinit bodycheck ")
    }
    //MARK: CheckBox
    
    @IBAction func drownedTapped(_ sender: Any) {
        drownedCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isDrowned = check
        }
    }
    
    func prepareData(){
        let model = DataController.shared.inspectionCarModel
        bodySummaryTextField.text = model.bodySummary
        drownedCheckBox.check = model.isDrowned
        roofDropdown.selectedByOption = model.roof
        leftSideDropdown.selectedByOption = model.leftSide
        rightSideDriverDropdown.selectedByOption = model.rightSideDriver
        backSideDropdown.selectedByOption = model.backSide
        frontSideDropdown.selectedByOption = model.frontSide
        chessisDropdown.selectedByOption = model.chessis
        
        
        
        /// Mapping Data Book-In
        if let province = model.registrationProvince ,
           let registration = model.registration {
            
            registrationTextField.text = registration
            provinceTextField.text = province
        }else{
            let provinceBookIn = DataController.shared.receiverCarModel.province
            let registrationBookIn = DataController.shared.receiverCarModel.registration
            
            registrationTextField.text = registrationBookIn
            provinceTextField.text = provinceBookIn
            
            
            model.registrationProvince = provinceBookIn
            model.registration = registrationBookIn
        }
        
        
    }
    
    
    //MARK: Province
    func getProvince(){
        let request = BodyCheck.Something.Request()
        interactor?.getProvince(request: request)
    }
    func displayShowProvinceError(viewModel: BodyCheck.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.getProvince()
        }
    }
    func displayProvinceDropdown(viewModel: BodyCheck.Something.ViewModel) {
        
        guard let values = viewModel.provinceList else { return }
        isGetProvinceLunch = true
        
        setValue(to: provinceTextField, values: values) { [weak self] (selectValue, _, _) in
            
            self?.provinceTextField.text = selectValue
            
            print("🔸 Province : \(selectValue)")
            DataController.shared.inspectionCarModel.registrationProvince = selectValue
        }
    }
}


extension BodyCheckViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //print(textView.text)
        DataController.shared.inspectionCarModel.bodySummary = textView.text
    }
}
// MARK: UITextFieldDelegate
extension BodyCheckViewController : UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        //print(textField.text)
    
        switch textField {
         
        case provinceTextField:
            DataController.shared.inspectionCarModel.registrationProvince = textField.text
            print("registrationProvince: \(textField.text ?? "")")
        
        case registrationTextField:
            DataController.shared.inspectionCarModel.registration = textField.text
            print("registration: \(textField.text ?? "")")
            
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
         
      
        return true
    }
    
    
}
 
extension BodyCheckViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollview.registKeyboardNotification()
        
        
        self.prepareData()
        
        if !isGetProvinceLunch {
            getProvince()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollview.resignKeyboardNotification()
    }
}
