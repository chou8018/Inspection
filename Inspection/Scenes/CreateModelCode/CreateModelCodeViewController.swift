//
//  CreateModelCodeViewController.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 23/6/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateModelCodeDisplayLogic: AnyObject
{
  func displaySomething(viewModel: CreateModelCode.Something.ViewModel)
    func displayMakeList(viewModel: CreateModelCode.Something.ViewModel)
    func displayErrorMakeList(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayBodyList(viewModel: CreateModelCode.Something.ViewModel)
    func displayErrorBodyList(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayDriveList(viewModel: CreateModelCode.Something.ViewModel)
    func displayErrorDriveList(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayGearList(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayGearBoxList(viewModel: CreateModelCode.Something.ViewModel)
    func displayErrorGearBoxList(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayFuelTypeList(viewModel: CreateModelCode.Something.ViewModel)
    func displayErrorFuelTypeList(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayFuelDeliveryList(viewModel: CreateModelCode.Something.ViewModel)
    func displayErrorFuelDeliveryList(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayMottoModelCode(viewModel: CreateModelCode.Something.ViewModel)
    func displayBuildYear(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayValidateError(viewModel: CreateModelCode.Something.ViewModel)
    func displayValidateSuccess(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayCreateModelError(viewModel: CreateModelCode.Something.ViewModel)
    func displayCreateModelSuccess(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayUpdateModelError(viewModel: CreateModelCode.Something.ViewModel)
    func displayUpdateModelSuccess(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayJatoCarModelList(viewModel: CreateModelCode.Something.ViewModel)
    func displayJatoCarModelError(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayJatoCarVaraintslList(viewModel: CreateModelCode.Something.ViewModel)
    func displayJatoCarVaraintsError(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayJatoCarModelLo(viewModel: CreateModelCode.Something.ViewModel)
    
    func displayFillDataFromEditModel(viewModel: CreateModelCode.Something.ViewModel)
}

class CreateModelCodeViewController: UIViewController, CreateModelCodeDisplayLogic
{
  var interactor: CreateModelCodeBusinessLogic?
  var router: (NSObjectProtocol & CreateModelCodeRoutingLogic & CreateModelCodeDataPassing)?

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
    let interactor = CreateModelCodeInteractor()
    let presenter = CreateModelCodePresenter()
    let router = CreateModelCodeRouter()
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
    setUpTextField()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var modelCodeTextField:CustomTextField!
    @IBOutlet weak var modelBUTextField:DropDown!
    @IBOutlet weak var modelLOTextField:CustomTextField!
    @IBOutlet weak var varaintsTextField:DropDown!
    @IBOutlet weak var engineCapacityTextField:CustomTextField!
    @IBOutlet weak var chassisTextField:CustomTextField!
    
    @IBOutlet weak var fuelDeliveryDropdown:DropDown!
    @IBOutlet weak var fuelTypeDropdown:DropDown!
    @IBOutlet weak var gearBoxDropdown:DropDown!
    @IBOutlet weak var gearDropdown:DropDown!
    @IBOutlet weak var driveDropdown:DropDown!
    @IBOutlet weak var makeDropdown:DropDown!
    @IBOutlet weak var bodyDropdown:DropDown!
    @IBOutlet weak var buildYearDropdown:DropDown!
    
    @IBOutlet weak var resultMottoModelCodeLabel:UILabel!
    
    @IBOutlet weak var createBtn:CustomUIButton!
    @IBOutlet weak var updateBtn:CustomUIButton!
  
  func doSomething()
  {
    let request = CreateModelCode.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: CreateModelCode.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    
    
    func setUpTextField(){
        modelCodeTextField.autocorrectionType = .no
        modelBUTextField.autocorrectionType = .no
        modelLOTextField.autocorrectionType = .no
        varaintsTextField.autocorrectionType = .no
        engineCapacityTextField.autocorrectionType = .no
        chassisTextField.autocorrectionType = .no
        
        modelCodeTextField.delegate = self
        engineCapacityTextField.delegate = self
        chassisTextField.delegate = self
        modelLOTextField.delegate = self
        
        
        //dropdown
        fuelDeliveryDropdown.autocorrectionType = .no
        fuelTypeDropdown.autocorrectionType = .no
        gearBoxDropdown.autocorrectionType = .no
        gearDropdown.autocorrectionType = .no
        driveDropdown.autocorrectionType = .no
        makeDropdown.autocorrectionType = .no
        bodyDropdown.autocorrectionType = .no
        buildYearDropdown.autocorrectionType = .no
        
        addTarget(from: modelCodeTextField)
        addTarget(from: modelBUTextField)
        addTarget(from: modelLOTextField)
        addTarget(from: varaintsTextField)
        addTarget(from: engineCapacityTextField)
        addTarget(from: chassisTextField)
        addTarget(from: bodyDropdown)
        
        createMode()
    }
    func createMode(){
        createBtn.isHidden = false
        updateBtn.isHidden = true
    }
    func updateMode(){
        createBtn.isHidden = true
        updateBtn.isHidden = false
    }
    
    //MARK: Validate
    @IBAction func createTapped(_ sender: Any){
        let request = CreateModelCode.Something.Request(modelCodeType : .CREATE)
        interactor?.validateField(request: request)
    }
    
    //MARK: Validate update
    @IBAction func updateTapped(_ sender: Any){
        let request = CreateModelCode.Something.Request(modelCodeType : .UPDATE)
        interactor?.validateField(request: request)
    }
    
    func displayValidateError(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessageOKAction(message: errorMessage) {
            //ignhred
        }
    }
    func displayValidateSuccess(viewModel: CreateModelCode.Something.ViewModel) {
        print("🔸 displayValidateSuccess")
        guard let modelCodeType = viewModel.modelCodeType else { return }
        switch modelCodeType {

        case .CREATE:
            print("🔸 create model code")
            self.createModelCode()
        case .UPDATE:
            print("🔸 update model code")
            self.updateModelCode()
        }

    }
    
    
    //MARK: Make
    func fetchMakeCar(){
        let request = CreateModelCode.Something.Request()
        interactor?.getMake(request: request)
    }
    
    func displayMakeList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let makeList_bu = viewModel.makeList_bu else { return }
        
        isFetchMakeCar = true
        
        setValue(to: makeDropdown, values: makeList_bu) { [weak self] (selectValue, _, _) in
            self?.makeDropdown.text = selectValue
            
            let request = CreateModelCode.Something.Request(makeValue: selectValue)
            self?.interactor?.selectMale(request: request)
        }
        checkLoadFinish()
    }
    
    func displayErrorMakeList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchAPI()
        }
    }
    
    //MARK: Body
    func fetchBodyCar(){
        let request = CreateModelCode.Something.Request()
        interactor?.getBody(request: request)
    }
    
    func displayBodyList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let bodyList_bu = viewModel.bodyList_bu else { return }
        
        isFetchBodyCar = true

        setValue(to: bodyDropdown, values: bodyList_bu) { [weak self] (selectValue, _, _) in
            self?.bodyDropdown.text = selectValue
            
            let request = CreateModelCode.Something.Request(bodyValue: selectValue)
            self?.interactor?.selectBody(request: request)
        }
        
        checkLoadFinish()
    }
    
    func displayErrorBodyList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchAPI()
        }
    }
  
    
    
    //MARK: Drive
    func fetchDrive(){
        let request = CreateModelCode.Something.Request()
        interactor?.getDrive(request: request)
    }
    func displayErrorDriveList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchAPI()
        }
    }
    func displayDriveList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let driveList_bu = viewModel.driveList_bu else { return }
        isFetchDrive = true
       
        setValue(to: driveDropdown, values: driveList_bu) { [weak self] (selectValue, _, _) in
            self?.driveDropdown.text = selectValue
            
            let request = CreateModelCode.Something.Request(driveValue: selectValue)
            self?.interactor?.selectDrive(request: request)
        }
        
        checkLoadFinish()
    }
    
    //MARK: Gear
    func fetchGear(){
        let request = CreateModelCode.Something.Request()
        interactor?.getGear(request: request)
    }
    
    func displayGearList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let gearList_bu = viewModel.gearList_bu else { return }
        
        setValue(to: gearDropdown, values: gearList_bu) { [weak self] (selectValue, _, _) in
            self?.gearDropdown.text = selectValue
            
            let request = CreateModelCode.Something.Request(gearValue: selectValue)
            self?.interactor?.selectGear(request: request)
        }
        checkLoadFinish()
    }
    
    
    //MARK: GearBox
    func fetchGearBox(){
        let request = CreateModelCode.Something.Request()
        interactor?.getGearBox(request: request)
    }
    func displayErrorGearBoxList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchAPI()
        }
    }
    func displayGearBoxList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let gearBoxList_bu = viewModel.gearBoxList_bu else { return }
        isFetchGearBox = true
        
        setValue(to: gearBoxDropdown, values: gearBoxList_bu) { [weak self] (selectValue, _, _) in
            self?.gearBoxDropdown.text = selectValue
            
            let request = CreateModelCode.Something.Request(gearBoxValue: selectValue)
            self?.interactor?.selectGearBox(request: request)
        }
        
        checkLoadFinish()
    }
    
    
    
    
    //MARK: FuelType
    func fetchFuelType(){
        let request = CreateModelCode.Something.Request()
        interactor?.getFuelType(request: request)
    }
    func displayErrorFuelTypeList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchAPI()
        }
    }
    func displayFuelTypeList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let fuelTypeList_bu = viewModel.fuelTypeList_bu else { return }
        isFetchFuelType = true
      
        setValue(to: fuelTypeDropdown, values: fuelTypeList_bu) { [weak self] (selectValue, _, _) in
            self?.fuelTypeDropdown.text = selectValue
            
            let request = CreateModelCode.Something.Request(fuelTypeValue: selectValue)
            self?.interactor?.selectFuelType(request: request)
        }
        
        checkLoadFinish()
    }
    
    
    
    //MARK: Fuel Delivery
    func fetchDelivery(){
        let request = CreateModelCode.Something.Request()
        interactor?.getFuelDelivery(request: request)
    }
    func displayErrorFuelDeliveryList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchAPI()
        }
    }
    func displayFuelDeliveryList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let fuelDeliveryList_bu = viewModel.fuelDeliveryList_bu else { return }
        
        isfetchDelivery = true
        
        setValue(to: fuelDeliveryDropdown, values: fuelDeliveryList_bu) { [weak self] (selectValue, _, _) in
            self?.fuelDeliveryDropdown.text = selectValue
            
            let request = CreateModelCode.Something.Request(fuelDeliveryValue: selectValue)
            self?.interactor?.selectFuelDelivery(request: request)
        }
        
        checkLoadFinish()
    }
    
    func displayMottoModelCode(viewModel: CreateModelCode.Something.ViewModel) {
        resultMottoModelCodeLabel.text = viewModel.mottoModelCode
    }
    
    //MARK: Year
    func fetchYear(){
        let request = CreateModelCode.Something.Request()
        interactor?.getBuildYear(request: request)
    }
    
    func displayBuildYear(viewModel: CreateModelCode.Something.ViewModel) {
        guard let buildYearList = viewModel.buildYearList else { return }
        
        setValue(to: buildYearDropdown, values: buildYearList) { [weak self] (selectValue, _, _) in
            self?.buildYearDropdown.text = selectValue
            
            let request = CreateModelCode.Something.Request(buildYear: selectValue)
            self?.interactor?.selectBuildYear(request: request)
        }
        
        checkLoadFinish()
    }
    
    //MARK: Create Model
    func createModelCode(){
        let request = CreateModelCode.Something.Request()
        interactor?.createModelCode(request: request)
    }
    func displayCreateModelError(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.createModelCode()
        }
    }
    func displayCreateModelSuccess(viewModel: CreateModelCode.Something.ViewModel) {
        guard let message = viewModel.message else { return }
        alertErrorMessageOKAction(message: message) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: Update Model
    func updateModelCode(){
        let request = CreateModelCode.Something.Request()
        interactor?.updateModelCode(request: request)
    }
    
    func displayUpdateModelError(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.updateModelCode()
        }
    }
    func displayUpdateModelSuccess(viewModel: CreateModelCode.Something.ViewModel) {
        guard let message = viewModel.message else { return }
        alertErrorMessageOKAction(message: message) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //MARK: Jato Model
    func fetchJatoModel(){
        interactor?.fetchJatoModel(request: CreateModelCode.Something.Request())
    }
    func displayJatoCarModelError(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchAPI()
        }
    }
    func displayJatoCarModelList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let jatoCarModelList_bu = viewModel.jatoCarModelList_bu else { return }
        isFetchjatoModelCar = true
        
        setValue(to: modelBUTextField, values: jatoCarModelList_bu) { [weak self] (selectValue, _, _) in
            self?.modelBUTextField.text = selectValue
            
            let request = CreateModelCode.Something.Request(model_Bu: selectValue)
            self?.interactor?.selectModel_BU(request: request)
            self?.fetchJatoVaraints()
        }
        
        checkLoadFinish()
    }
    func displayJatoCarModelLo(viewModel: CreateModelCode.Something.ViewModel) {
        self.modelLOTextField.text = viewModel.model_Lo
    }
    
    
    //MARK: Jato Varaints
    func fetchJatoVaraints(){
        interactor?.fetchJatoVaraints(request: CreateModelCode.Something.Request())
    }
    func displayJatoCarVaraintsError(viewModel: CreateModelCode.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchAPI()
        }
    }
    func displayJatoCarVaraintslList(viewModel: CreateModelCode.Something.ViewModel) {
        guard let jatoVaraintsList_bu = viewModel.jatoVaraintsList_bu else { return }
        isFetchjatoVaraints = true
        
        setValue(to: varaintsTextField, values: jatoVaraintsList_bu) { [weak self] (selectValue, _, _) in
            self?.varaintsTextField.text = selectValue
            
            let request = CreateModelCode.Something.Request(varaints: selectValue)
            self?.interactor?.selectVaraints(request: request)
        }
        
        checkLoadFinish()
    }
    
    
    var isFetchDrive = false
    var isFetchGearBox = false
    var isFetchFuelType = false
    var isfetchDelivery = false
    
    var isFetchMakeCar = false
    var isFetchBodyCar = false
    var isFetchjatoModelCar = false
    var isFetchjatoVaraints = false
    
    func checkLoadFinish(){
        if isFetchMakeCar  && isFetchBodyCar && isFetchjatoModelCar && isFetchjatoVaraints && isFetchDrive && isFetchGearBox && isFetchFuelType && isfetchDelivery {
      
            print("🔸 fetch data success 🔸")
            
            let reqeust = CreateModelCode.Something.Request()
            interactor?.fillDataFromEditModel(request: reqeust)
        }
      
    }
    //MARK: display EditModel
    func displayFillDataFromEditModel(viewModel: CreateModelCode.Something.ViewModel) {
        guard let model = viewModel.modelCodeTemplate else { return }
        
        
        modelCodeTextField.text = model.modelCode
        buildYearDropdown.text = model.buildYear
        modelBUTextField.text = model.model_BU
        modelLOTextField.text = model.model_LO
        varaintsTextField.text = model.variants
        engineCapacityTextField.text = model.engineCapacity?.toString()
        chassisTextField.text = model.chassisPreCode
        gearDropdown.text = model.gears
        
        
        makeDropdown.text = viewModel.editMake
        bodyDropdown.text = viewModel.editBody
        fuelDeliveryDropdown.text = viewModel.editFuelDelivery
        fuelTypeDropdown.text = viewModel.editFuelType
        gearBoxDropdown.text = viewModel.editGearBox
        driveDropdown.text = viewModel.editDrive
        
        updateMode()
        modelCodeTextField.setEnableView(isEnable: false)
        varaintsTextField.setEnableView(isEnable: false)
        
    }
    
    func fetchAPI(){
        if !isFetchMakeCar {
            fetchMakeCar()
        }
        if !isFetchBodyCar {
            fetchBodyCar()
        }
        if !isFetchjatoModelCar {
            fetchJatoModel()
        }
        if !isFetchjatoVaraints {
            fetchJatoVaraints()
        }
        if !isFetchDrive{
            fetchDrive()
        }
        
        
        
        if !isFetchGearBox{
            fetchGearBox()
        }
        if !isFetchFuelType{
            fetchFuelType()
        }
        if !isfetchDelivery{
            fetchDelivery()
        }
        
        fetchGear()
        fetchYear()
    }
    
    
    func setValue(to textfield:DropDown , values: [String], didSelected:@escaping (_ selectedText: String, _ index: Int , _ id:Int )->() ){
        textfield.text = ""
        textfield.optionArray = values
        textfield.didSelect(completion: didSelected)
    }
    fileprivate func addTarget(from textfield: UITextField ){
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .editingChanged)
    }
}

//MARK: keyboard
extension CreateModelCodeViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registKeyboardNotification()
        
        fetchAPI()
   }
   
   override func viewDidDisappear(_ animated: Bool) {
       super.viewDidDisappear(animated)
       scrollView.resignKeyboardNotification()
    
   }
}

extension CreateModelCodeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension  CreateModelCodeViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        //print(textField.text)
        switch textField {
        case modelCodeTextField:
            interactor?.selectModelCode(request: CreateModelCode.Something.Request(modelCode: textField.text))
        case modelBUTextField:
            interactor?.selectModel_BU2(request: CreateModelCode.Something.Request(model_Bu: textField.text))
        case modelLOTextField:
            interactor?.selectModel_LO2(request: CreateModelCode.Something.Request(model_Lo: textField.text))
            
        case varaintsTextField:
            interactor?.selectVaraints(request: CreateModelCode.Something.Request(varaints: textField.text))
            
        case engineCapacityTextField:
            interactor?.selectEngineCapacity(request: CreateModelCode.Something.Request(engineCapacity: textField.text))
            
        case chassisTextField:
            interactor?.selectChassisno(request: CreateModelCode.Something.Request(chassisno: textField.text))
            
        case bodyDropdown:
            interactor?.selectBodyTextChange(request: CreateModelCode.Something.Request())
            
        default:
            break
        }
    }
    
}
