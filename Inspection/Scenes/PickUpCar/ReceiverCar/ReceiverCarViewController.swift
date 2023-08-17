//
//  ReceiverCarViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 8/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ReceiverCarDisplayLogic: AnyObject
{
    func displaySomething(viewModel: ReceiverCar.Something.ViewModel)
    func displaySignatureViewModal(viewModel: ReceiverCar.Something.ViewModel)
    func displaySignatureToImageView(viewModel: ReceiverCar.Something.ViewModel)
    func displayPhoneNummber(viewModel: ReceiverCar.Something.ViewModel)
    func displayMessageErrorValidatePhoneNummber(viewModel: ReceiverCar.Something.ViewModel)
    func displayMessageErrorNotMatchCompany(viewModel: ReceiverCar.Something.ViewModel)
    func displayCompany(viewModel: ReceiverCar.Something.ViewModel)
    func displayShowError(viewModel: ReceiverCar.Something.ViewModel)
    
    func displayLocation(viewModel: ReceiverCar.Something.ViewModel)
    func displayLocationError(viewModel: ReceiverCar.Something.ViewModel)
    
    func displayPlantLocation(viewModel: ReceiverCar.Something.ViewModel)
    func displayPlantLocationError(viewModel: ReceiverCar.Something.ViewModel)
    func displaySetPlantTextField(viewModel: ReceiverCar.Something.ViewModel)
    
    func displaySellCate(viewModel: ReceiverCar.Something.ViewModel)
    func displaySellCateError(viewModel: ReceiverCar.Something.ViewModel)
    func displaySetSellCategoryTextField(viewModel: ReceiverCar.Something.ViewModel)
}

class ReceiverCarViewController: ViewController, ReceiverCarDisplayLogic
{
    var interactor: ReceiverCarBusinessLogic?
    var router: (NSObjectProtocol & ReceiverCarRoutingLogic & ReceiverCarDataPassing)?
    
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
        let interactor = ReceiverCarInteractor()
        let presenter = ReceiverCarPresenter()
        let router = ReceiverCarRouter()
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
            
            if let destination = segue.destination as? SignatureViewController {
                destination.confirmSignature =  { [weak self]  (signatureImage , userType) in
                    let request = ReceiverCar.Something.Request(signatureImage: signatureImage,
                                                                userType: userType)
                    self?.interactor?.getSignature(request: request)
                }
            }
            
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
        setUpUIView()
        
    }
    
    // MARK: Do something
    @IBOutlet weak var plantLocationTextField: DropDown!
    @IBOutlet weak var receiverLocationTextField: DropDown!
    @IBOutlet weak var storageLocationTextField: DropDown!
    
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var senderNameTextField: CustomTextField!
    @IBOutlet weak var contractNumberTextField: CustomTextField!
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    @IBOutlet weak var companyNumberTextField: DropDown!
    
    @IBOutlet weak var senderSignatureUIView: CustomUIView!
    @IBOutlet weak var receiverSignatureUIView: CustomUIView!
    
    @IBOutlet weak var senderUIImageView: UIImageView!
    @IBOutlet weak var receiverUIImageView: UIImageView!
    
    @IBOutlet weak var errorPhoneNumberLabel: UILabel!
    
    @IBOutlet weak var errorCompanyLabel: UILabel!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var receiverLineView: UIView!
    @IBOutlet weak var storeLineView: UIView!
    
    @IBOutlet weak var plantLineView: UIView!
    @IBOutlet weak var senderNameLineView: UIView!
    @IBOutlet weak var contractLineView: UIView!
    @IBOutlet weak var phoneNumberLineView: UIView!
    @IBOutlet weak var companyNameLineView: UIView!
    
    @IBOutlet weak var receiverTitleLabel: UILabel!
    @IBOutlet weak var storeTitleLabel: UILabel!
    
    @IBOutlet weak var plantTitleLabel: UILabel!
    @IBOutlet weak var senderNameTitleLabel: UILabel!
    @IBOutlet weak var contractTitleLabel: UILabel!
    @IBOutlet weak var phoneNumberTitleLabel: UILabel!
    @IBOutlet weak var companyNameTitleLabel: UILabel!
    
    @IBOutlet weak var sellCateTextField: DropDown!
    @IBOutlet weak var sellCateLineView: UIView!
    @IBOutlet weak var sellCateTitleLabel: UILabel!
    
    // local strings
    @IBOutlet weak var deliveredByLabel: UILabel!
    @IBOutlet weak var bookedInByLabel: UILabel!
    @IBOutlet weak var deliveredByPlacehoderLabel: UILabel!
    @IBOutlet weak var bookedInByPlacehoderLabel: UILabel!

    var isSellerLunch = false
    var isFetchLocation = false
    var isPlantLocation = false
    var isFetchSellCate = false
    
    override func initLocalString() {
        super.initLocalString()
        senderNameTitleLabel.text = String.localized("receiver_car_deliverer_name_label")
        senderNameTextField.placeholder = String.localized("receiver_car_deliverer_name_placeholder_label")
        contractTitleLabel.text = String.localized("receiver_car_contract_number_label")
        contractNumberTextField.placeholder = String.localized("receiver_car_contract_number_label")
        phoneNumberTitleLabel.text = String.localized("receiver_car_phone_label")
        companyNameTitleLabel.text = String.localized("receiver_car_seller_name_label")
        companyNumberTextField.placeholder = String.localized("receiver_car_seller_name_label")
        plantTitleLabel.text = String.localized("receiver_car_plant_location_label")
        receiverTitleLabel.text = String.localized("receiver_car_receive_location_label")
        storeTitleLabel.text = String.localized("receiver_car_storage_location_label")
        deliveredByLabel.text = String.localized("receiver_car_delivered_by_label")
        deliveredByPlacehoderLabel.text = String.localized("receiver_car_booked_in_by_placeholder_label")
        bookedInByLabel.text = String.localized("receiver_car_booked_in_by_label")
        bookedInByPlacehoderLabel.text = String.localized("receiver_car_booked_in_by_placeholder_label")

    }
    
    func doSomething()
    {
        let request = ReceiverCar.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    //MARK: Presenter
    func displaySomething(viewModel: ReceiverCar.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    func displaySignatureViewModal(viewModel: ReceiverCar.Something.ViewModel) {
        performSegue(withIdentifier: "signatureSegue", sender: nil)
    }
    
    func displaySignatureToImageView(viewModel: ReceiverCar.Something.ViewModel) {
        
        guard let userType = viewModel.userType else { return }
        switch userType {
            
        case .SENDER:
            DataController.shared.receiverCarModel.senderSignatureImage = viewModel.signatureImage
            senderUIImageView.image = viewModel.signatureImage
        case .RECEIVER:
            DataController.shared.receiverCarModel.receiverSignatureImage = viewModel.signatureImage
            receiverUIImageView.image = viewModel.signatureImage
        }
        
    }
    func displayPhoneNummber(viewModel: ReceiverCar.Something.ViewModel) {
        DataController.shared.receiverCarModel.phoneNumber = viewModel.validatePhoneNumber
        self.phoneNumberTextField.text = viewModel.validatePhoneNumber
    }
    func displayMessageErrorValidatePhoneNummber(viewModel: ReceiverCar.Something.ViewModel) {
        guard let errorValidatePhoneNumber = viewModel.errorValidatePhoneNumber,
              let valid = viewModel.validPhoneNumber10Digit else { return }
        
        errorPhoneNumberLabel.isHidden = valid ? true : false
        errorPhoneNumberLabel.text = errorValidatePhoneNumber
    }
    
    func displayMessageErrorNotMatchCompany(viewModel: ReceiverCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorNotMatchCompanyName,
              let match = viewModel.isMatchCompany else { return }
        
        errorCompanyLabel.isHidden = match ? true : false
        errorCompanyLabel.text = errorMessage
    }
    
    
    
    @objc func receiverTapped(){
        let request = ReceiverCar.Something.Request(titleName: String.localized("receiver_car_booked_in_by_label"),
                                                    signatureImage: receiverUIImageView.image ,
                                                    userType: .RECEIVER)
        interactor?.signatureViewTap(request: request)
    }
    @objc func senderTapped(){
        let request = ReceiverCar.Something.Request(titleName: String.localized("receiver_car_delivered_by_label"),
                                                    signatureImage: senderUIImageView.image ,
                                                    userType: .SENDER)
        interactor?.signatureViewTap(request: request)
    }
    
    
    //MARK: UIView
    func setUpUIView(){
        let nameReceiver = DataController.shared.receiverCarModel.nameReceiver ?? ""
        let bookinNo = DataController.shared.receiverCarModel.bookinNo ?? ""
        let name = bookinNo.isEmpty ? DataController.shared.getFullName() : nameReceiver
        fullNameLabel.text = "(\(name))"
        
        errorPhoneNumberLabel.isHidden = true
        errorCompanyLabel.isHidden = true
        
        senderNameTextField.autocorrectionType = .no
        contractNumberTextField.autocorrectionType = .no
        phoneNumberTextField.autocorrectionType = .no
        companyNumberTextField.autocorrectionType = .no
        plantLocationTextField.autocorrectionType = .no
        sellCateTextField.autocorrectionType = .no
        
        receiverLocationTextField.autocorrectionType = .no
        storageLocationTextField.autocorrectionType = .no
        
        senderNameTextField.delegate = self
        contractNumberTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        
        senderNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        contractNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        companyNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        plantLocationTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        sellCateTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        receiverLocationTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        storageLocationTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        senderSignatureUIView.isUserInteractionEnabled = true
        senderSignatureUIView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(senderTapped)))
        
        receiverSignatureUIView.isUserInteractionEnabled = true
        receiverSignatureUIView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(receiverTapped)))
        
        
        /// bookInType word
        switch DataController.shared.bookInType {
            
        case .CAR, .MBIKE:
            contractTitleLabel.text = String.localized("receiver_car_contract_number_label")
            contractNumberTextField.placeholder = String.localized("receiver_car_contract_number_label")
            
        case .CARWRECK, .MBIKEWRECK:
            contractTitleLabel.text = String.localized("car_salvage_deliverer_contract_number")
            contractNumberTextField.placeholder = contractTitleLabel.text
        }
        
    }
    
    //MARK: Dropdown Location
    func fetchLocationView(){
        let request = ReceiverCar.Something.Request()
        interactor?.fetchLocation(request: request)
    }
    
    func displayLocation(viewModel: ReceiverCar.Something.ViewModel) {
        guard let locationList = viewModel.locationList else { return }
        
        setValue(to: receiverLocationTextField, values: locationList) { [weak self] (selectValue, _, _)  in
            DataController.shared.receiverCarModel.receiverPlace = selectValue
            self?.receiverLocationTextField.text = selectValue
        }
        
        setValue(to: storageLocationTextField, values: locationList) { [weak self] (selectValue, _, _)  in
            DataController.shared.receiverCarModel.storePlace = selectValue
            self?.storageLocationTextField.text = selectValue
        }
        
        
        isFetchLocation = true
    }
    func displayLocationError(viewModel: ReceiverCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchLocationView()
        }
    }
    
    //MARK: Plant
    func fetchPlantLocation(){
        let request = ReceiverCar.Something.Request()
        interactor?.fetchPlantLocation(request: request)
    }
    
    func prepatePlantLocation(){
        let plant = DataController.shared.receiverCarModel.plant
        let request = ReceiverCar.Something.Request(plantCode: plant)
        interactor?.preparePlantLocation(request: request)
    }
    
    func displaySetPlantTextField(viewModel: ReceiverCar.Something.ViewModel) {
        plantLocationTextField.text = viewModel.plant_BU
    }
    func displayPlantLocation(viewModel: ReceiverCar.Something.ViewModel) {
        guard let plantList = viewModel.plantList else { return }
        
        self.prepatePlantLocation()
        
        setValue(to: plantLocationTextField, values: plantList) { [weak self] (selectValue, _, _)  in
            
            let request = ReceiverCar.Something.Request(plantLocationName: selectValue)
            self?.interactor?.selectPlantLocation(request: request)
            
            self?.plantLocationTextField.text = selectValue
        }
        isPlantLocation = true
    }
    func displayPlantLocationError(viewModel: ReceiverCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchPlantLocation()
        }
    }
    
    func setValue(to textfield:DropDown , values: [String], didSelected:@escaping (_ selectedText: String, _ index: Int , _ id:Int )->() ){
        textfield.optionArray = values
        textfield.didSelect(completion: didSelected)
    }
    
    //MARK: Dropdown company
    func fetchSellerPickerView() {
        
        let request = ReceiverCar.Something.Request()
        interactor?.fetchCompany(request: request)
    }
    
    func displayCompany(viewModel: ReceiverCar.Something.ViewModel) {
        
        guard let companyList = viewModel.companyList else { return }
        
        isSellerLunch = true
        companyNumberTextField.optionArray = companyList
        companyNumberTextField.didSelect { [weak self] (selectedText , _ ,_) in
            
            let request = ReceiverCar.Something.Request(companyNameDidChange: selectedText)
            self?.interactor?.verifyCompany(request: request)
            
            self?.companyNumberTextField.text = selectedText
        }
    }
    //MARK: Error
    func displayShowError(viewModel: ReceiverCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchSellerPickerView()
        }
        
    }
    
    //MARK: Sell Category
    func fetchSellCate(){
        let request = ReceiverCar.Something.Request()
        interactor?.fetchSellCategory(request: request)
    }
    func prepateSellCate(){
        let sellingCategory = DataController.shared.receiverCarModel.sellingCategory
        let request = ReceiverCar.Something.Request(sellCategoryCode: sellingCategory)
        interactor?.prepareSellCategory(request: request)
    }
    
    func displaySellCate(viewModel: ReceiverCar.Something.ViewModel) {
        guard let sellCateList = viewModel.sellCateList else { return }
        
        isFetchSellCate = true
        
        prepateSellCate()
        
        sellCateTextField.optionArray = sellCateList
        sellCateTextField.didSelect { [weak self] (selectedText , _ ,_) in
            
            let request = ReceiverCar.Something.Request(sellCategory: selectedText)
            self?.interactor?.selectSellCategory(request: request)
            
            self?.sellCateTextField.text = selectedText
        }
    }
    func displaySellCateError(viewModel: ReceiverCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchSellCate()
        }
    }
    func displaySetSellCategoryTextField(viewModel: ReceiverCar.Something.ViewModel) {
        sellCateTextField.text = viewModel.sellCategory_BU
    }
    
    
}

extension ReceiverCarViewController : UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        //print(textField.text)
        
        switch textField {
        case phoneNumberTextField:
            let request = ReceiverCar.Something.Request(phoneNumber: textField.text)
            interactor?.validatePhoneNumber(request: request)
            
        case companyNumberTextField:
            DataController.shared.receiverCarModel.companyName = textField.text
            DataController.shared.receiverCarModel.sellerCode = nil
            errorCompanyLabel.isHidden =  false
            errorCompanyLabel.text = "ชื่อบริษัทไม่มีในรายการ"
            
        case senderNameTextField:
            DataController.shared.receiverCarModel.nameSender = textField.text
            
        case contractNumberTextField:
            DataController.shared.receiverCarModel.contractNumber = textField.text
            
        case plantLocationTextField:
            DataController.shared.receiverCarModel.plant = nil
            
        case receiverLocationTextField:
            DataController.shared.receiverCarModel.receiverPlace = nil
            
        case storageLocationTextField:
            DataController.shared.receiverCarModel.storePlace = nil
            
        case sellCateTextField:
            DataController.shared.receiverCarModel.sellingCategory = nil
            
        default:
            return
        }
    }
    //MARK: Prapare Data
    @objc func prepareData(){
        let model = DataController.shared.receiverCarModel
        
        
        senderNameTextField.text = model.nameSender
        contractNumberTextField.text = model.contractNumber
        phoneNumberTextField.text = model.phoneNumber
        let comapyName = "\(model.companyName ?? "") \(model.companyNameEn ?? "")"
        companyNumberTextField.text = comapyName.trimWhiteSpace  ///companyNumberTextField: DropDown!
        
        senderUIImageView.image = model.senderSignatureImage
        receiverUIImageView.image = model.receiverSignatureImage
        
        receiverLocationTextField.text =  model.receiverPlace
        storageLocationTextField.text =  model.storePlace
        
        
    }
    
    @objc func updateView(){
        let model = DataController.shared.receiverCarModel
        let enable = getEnableView()
        
        senderNameTextField.setEnableView(isEnable: enable)
        contractNumberTextField.setEnableView(isEnable: enable)
        phoneNumberTextField.setEnableView(isEnable: enable)
        companyNumberTextField.setEnableView(isEnable: enable)
        senderSignatureUIView.isUserInteractionEnabled = enable
        receiverSignatureUIView.isUserInteractionEnabled = enable
        
        //MARK: Validation
        sellCateLineView.validateLineView(model.validSellCate)
        plantLineView.validateLineView(model.validPlant)
        senderNameLineView.validateLineView(model.validSenderName)
        contractLineView.validateLineView(model.validContractNumber)
        companyNameLineView.validateLineView(model.validSellerCode)
        
        receiverLineView.validateLineView(model.validReceiver)
        storeLineView.validateLineView(model.validStore)
        
        //        phoneNumberLineView.validateLineView(model.validMobile)
        
        sellCateTitleLabel.validateLabel(model.validSellCate)
        plantTitleLabel.validateLabel(model.validPlant)
        senderNameTitleLabel.validateLabel(model.validSenderName)
        contractTitleLabel.validateLabel(model.validContractNumber)
        companyNameTitleLabel.validateLabel(model.validSellerCode)
        
        receiverTitleLabel.validateLabel(model.validReceiver)
        storeTitleLabel.validateLabel(model.validStore)
        //        phoneNumberTitleLabel.validateLabel(model.validMobile)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        //        switch textField {
        //        case senderNameTextField:
        //            contractNumberTextField.becomeFirstResponder()
        //
        //        case contractNumberTextField:
        //            phoneNumberTextField.becomeFirstResponder()
        //
        //
        //        default:
        //            return true
        //        }
        
        return true
    }
}

extension ReceiverCarViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registKeyboardNotification()
        
        if !isSellerLunch {
            fetchSellerPickerView()
        }
        if !isFetchLocation {
            fetchLocationView()
        }
        if !isPlantLocation {
            fetchPlantLocation()
        }
        if !isFetchSellCate {
            fetchSellCate()
        }
        
        prepareData()
        updateView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: NSNotification.Name("updateUI"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.resignKeyboardNotification()
        
        NotificationCenter.default.removeObserver(self)
    }
}
