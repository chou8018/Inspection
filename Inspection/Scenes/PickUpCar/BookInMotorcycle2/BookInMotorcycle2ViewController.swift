//
//  BookInMotorcycle2ViewController.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 23/8/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RadioGroup

let string_key_label = String.localized("car_interior_key_label")
let string_remote_key_label = String.localized("car_interior_remote_key_label")
let string_remote_control_key_label = String.localized("car_interior_remote_control_label")
let string_immobilizer_key_label = String.localized("car_interior_key_immobilizer_label")
let string_keyless_label = String.localized("car_interior_keyless_label")

protocol BookInMotorcycle2DisplayLogic: AnyObject
{
    func displaySomething(viewModel: BookInMotorcycle2.Something.ViewModel)
    func displayValidateMileNumber(viewModel: BookInMotorcycle2.Something.ViewModel)
    func displayKeyChecked(viewModel: BookInMotorcycle2.Something.ViewModel)
    func displayRemoteChecked(viewModel: BookInMotorcycle2.Something.ViewModel)
    func displayRemoteKeyChecked(viewModel: BookInMotorcycle2.Something.ViewModel)
    func displayImmobiliserKeyChecked(viewModel: BookInMotorcycle2.Something.ViewModel)
    
    
    func displayErrorGearBoxList(viewModel: BookInMotorcycle2.Something.ViewModel)
    func displayGearBoxList(viewModel: BookInMotorcycle2.Something.ViewModel)
    func displayGearBoxText(viewModel: BookInMotorcycle2.Something.ViewModel)
}

class BookInMotorcycle2ViewController: ViewController, BookInMotorcycle2DisplayLogic
{
    var interactor: BookInMotorcycle2BusinessLogic?
    var router: (NSObjectProtocol & BookInMotorcycle2RoutingLogic & BookInMotorcycle2DataPassing)?
    
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
        let interactor = BookInMotorcycle2Interactor()
        let presenter = BookInMotorcycle2Presenter()
        let router = BookInMotorcycle2Router()
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
        setUpRadio()
        setUpTextField()
        setUpDropDown()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var carConditionRadio: RadioGroup!
    @IBOutlet weak var milesRadio: RadioGroup!
    @IBOutlet weak var fuelDeliveryRadio: RadioGroup!
    @IBOutlet weak var engineConditionRadio: RadioGroup!
    @IBOutlet weak var gearConditionRadio: RadioGroup!
    @IBOutlet weak var breakConditionRadio: RadioGroup!
    
    @IBOutlet weak var milesTextFIeld: CustomTextField!
    
    @IBOutlet weak var noteMultilineTextField: MultilineTextField!
    
    @IBOutlet weak var handStartCheckBox: CheckBoxUIButton!
    @IBOutlet weak var kickStartCheckBox: CheckBoxUIButton!
    @IBOutlet weak var registrationPlateCheckBox: CheckBoxUIButton!
    
    @IBOutlet weak var keyCheckBox: CheckBoxUIButton!
    @IBOutlet weak var remoteKeyCheckBox: CheckBoxUIButton!
    @IBOutlet weak var remoteCheckBox: CheckBoxUIButton!
    @IBOutlet weak var immobilizarKeyCheckBox: CheckBoxUIButton!
    
    @IBOutlet weak var keyDropDown: DropDown!
    @IBOutlet weak var remoteDropDown: DropDown!
    @IBOutlet weak var remoteKeyDropDown: DropDown!
    @IBOutlet weak var immobilizarKeyDropDown: DropDown!
    @IBOutlet weak var gearboxDropDown: DropDown!
    @IBOutlet weak var gearboxLineView: UIView!
    @IBOutlet weak var gearboxLabel: UILabel!
    
    @IBOutlet weak var isInvalidMilesCheckBox: CheckBoxUIButton!
    @IBOutlet weak var reasonMileageTextField: CustomTextField!
    @IBOutlet weak var reasonMileageStackView: UIStackView!
    
    // local strings
    @IBOutlet weak var motorbikeConditionLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var unverifiedLabel: UILabel!
    @IBOutlet weak var gearConditionLabel: UILabel!
    @IBOutlet weak var brakeLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var engineLabel: UILabel!
    @IBOutlet weak var handStartLabel: UILabel!
    @IBOutlet weak var footStartLabel: UILabel!
    @IBOutlet weak var registrationPlateLabel: UILabel!
    @IBOutlet weak var gearTitleLabel: UILabel!
    @IBOutlet weak var gearOption1Label: UILabel!
    @IBOutlet weak var gearOption2Label: UILabel!
    @IBOutlet weak var gearOption3Label: UILabel!
    @IBOutlet weak var gearOption4Label: UILabel!
    @IBOutlet weak var othersLabel: UILabel!
    
    let strings_motorbike_engine_kilometer_mile = [String.localized("motorbike_inspection_engine_kilometer_label"), String.localized("motorbike_inspection_engine_mile_label")]
    
    let strings_motorbike_engine_fair_repair = [String.localized("car_exterior_fair_label"), String.localized("motorbike_inspection_engine_need_repair_label")]
    
    let strings_motorbike_engine_working_or_not = [String.localized("motorbike_inspection_engine_working_label"), String.localized("motorbike_inspection_engine_not_working_label")]
    
    let strings_motorbike_engine_injector_carburetor = [String.localized("car_engine_injector_label"), String.localized("car_engine_carburetor_label")]
    
    override func initLocalString() {
        super.initLocalString()
        
        motorbikeConditionLabel.text = String.localized("motorbike_inspection_engine_label")
        mileageLabel.text = String.localized("car_interior_mileage_label")
        milesTextFIeld.placeholder = String.localized("motorbike_inspection_engine_mileage_placeholder")
        unverifiedLabel.text = String.localized("motorbike_inspection_engine_unverified_label")
        gearboxLabel.text = String.localized("car_interior_gear_label")
        gearboxDropDown.placeholder = gearboxLabel.text
        gearConditionLabel.text = String.localized("inspection_gear_condition_label")
        brakeLabel.text = String.localized("inspection_brake_title")
        fuelLabel.text = String.localized("car_engine_fuel_system_label")
        engineLabel.text = String.localized("inspection_engine_title")
        handStartLabel.text = String.localized("motorbike_inspection_engine_hand_start_label")
        footStartLabel.text = String.localized("motorbike_inspection_engine_foot_start_label")
        registrationPlateLabel.text = String.localized("motorbike_inspection_engine_registration_plate_label")
        gearTitleLabel.text = String.localized("car_interior_gear_label")
        gearOption1Label.text = String.localized("car_interior_gear_label")
        gearOption2Label.text = String.localized("car_interior_remote_control_label")
        gearOption3Label.text = String.localized("car_interior_remote_key_label")
        gearOption4Label.text = String.localized("car_interior_key_immobilizer_label")
        keyDropDown.placeholder = String.localized("car_interior_key_placeholder_label")
        remoteDropDown.placeholder = String.localized("car_interior_key_placeholder_label")
        remoteKeyDropDown.placeholder = String.localized("car_interior_key_placeholder_label")
        immobilizarKeyDropDown.placeholder = String.localized("car_interior_key_placeholder_label")
        othersLabel.text = String.localized("car_interior_others_label")
        noteMultilineTextField.placeholder = othersLabel.text
    }
    
    func doSomething()
    {
        let request = BookInMotorcycle2.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: BookInMotorcycle2.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    
    //MARK: Radio
    func setUpRadio(){
        let attributedString = [NSAttributedString.Key.foregroundColor : UIColor.appPrimaryColor]
        
        carConditionRadio.attributedTitles = [
            NSAttributedString(string: "GOOD",
                               attributes: attributedString),
            NSAttributedString(string: "AVE",
                               attributes: attributedString),
            NSAttributedString(string: "FAIR",
                               attributes: attributedString),
            NSAttributedString(string: "POOR",
                               attributes: attributedString),
            NSAttributedString(string: "SCRAP",
                               attributes: attributedString)
        ]
        
        
        milesRadio.attributedTitles = [
            NSAttributedString(string: strings_motorbike_engine_kilometer_mile[0],
                               attributes: attributedString),
            NSAttributedString(string: strings_motorbike_engine_kilometer_mile[1],
                               attributes: attributedString)
        ]
        
        fuelDeliveryRadio.attributedTitles = [
            NSAttributedString(string: strings_motorbike_engine_injector_carburetor[0], attributes: attributedString),
            NSAttributedString(string: strings_motorbike_engine_injector_carburetor[1], attributes: attributedString),
            NSAttributedString(string: "N/A", attributes: attributedString)
        ]
        
        engineConditionRadio.attributedTitles = [
            NSAttributedString(string: strings_motorbike_engine_working_or_not[0], attributes: attributedString),
            NSAttributedString(string: strings_motorbike_engine_working_or_not[1], attributes: attributedString)
        ]
        gearConditionRadio.attributedTitles = [
            NSAttributedString(string: strings_motorbike_engine_fair_repair[0], attributes: attributedString),
            NSAttributedString(string: strings_motorbike_engine_fair_repair[1], attributes: attributedString)
        ]
        breakConditionRadio.attributedTitles = [
            NSAttributedString(string: strings_motorbike_engine_fair_repair[0], attributes: attributedString),
            NSAttributedString(string: strings_motorbike_engine_fair_repair[1], attributes: attributedString)
        ]
    }
    
    //MARK: condition
    @IBAction func conditionValueChange(_ sender: Any) {
        
        var redBookCondition : (String,String)  = ("","")
        switch carConditionRadio.selectedIndex {
        case 0:
            redBookCondition = ("G", "GOOD")
        case 1:
            redBookCondition = ("A", "AVE")
        case 2:
            redBookCondition = ("F", "FAIR")
        case 3:
            redBookCondition = ("P", "POOR")
        case 4:
            redBookCondition = ("Y", "SCRAP")
            
        default:
            return
        }
        print("🔸 condition: \(redBookCondition.0) ,  value: \(redBookCondition.1)")
        DataController.shared.receiverCarModel.redBookCondition = redBookCondition.0
    }
    //MARK: miles
    @IBAction func milesValueChange(_ sender: Any) {
        var selectString:String? = nil
        switch milesRadio.selectedIndex {
        case 0:
            selectString = strings_motorbike_engine_kilometer_mile[0]
        case 1:
            selectString = strings_motorbike_engine_kilometer_mile[1]
        default:
            return
        }
        print("🔸 milesValue \(selectString)")
        
        DataController.shared.receiverCarModel.typeMiles = selectString
        let typeMilesId = milesRadio.selectedIndex + 1
        DataController.shared.receiverCarModel.mileageTypeId = typeMilesId
        
        /// set enable mileage
        isInvalidMilesCheckBox.check = false
        milesTextFIeld.setEnableView(isEnable: true)
        reasonMileageStackView.isHidden = true
        reasonMileageTextField.text = ""
        
        DataController.shared.receiverCarModel.invalidMileageReason = ""
        DataController.shared.receiverCarModel.isInvalidMileage = false
    }
    @IBAction func inInValidMileTapped(_ sender: Any) {
        isInvalidMilesCheckBox.toggle { [weak self] check in
            DataController.shared.receiverCarModel.isInvalidMileage = check
            self?.reasonMileageStackView.isHidden = !check
            
            if check {
                /// set miles = 0
                self?.milesTextFIeld.setEnableView(isEnable: false)
                self?.milesTextFIeld.text = ""
                self?.milesRadio.selectedIndex = -1
                
                DataController.shared.receiverCarModel.typeMiles = nil
                DataController.shared.receiverCarModel.mileageTypeId = 0
                DataController.shared.receiverCarModel.miles = ""
            }else{
                self?.reasonMileageTextField.text = ""
                self?.milesTextFIeld.setEnableView(isEnable: true)
                DataController.shared.receiverCarModel.invalidMileageReason = ""
            }
        }
    }
    
    
    //MARK: fuel delivery
    @IBAction func fuelDeliveryValueChanged(_ sender: Any) {
        var fuelDeliveryTuple : (String,String)  = ("","")
        switch fuelDeliveryRadio.selectedIndex {
        case 0:
            fuelDeliveryTuple = ("I",strings_motorbike_engine_injector_carburetor[0])
        case 1:
            fuelDeliveryTuple = ("N",strings_motorbike_engine_injector_carburetor[1])
        case 2:
            fuelDeliveryTuple = ("1","N/A")
        default:
            fuelDeliveryTuple = ("1","N/A")
        }
        print("🔸 fuelDelivery: \(fuelDeliveryTuple.0) , value: \(fuelDeliveryTuple.1)")
        DataController.shared.receiverCarModel.fuelDeliveryName = fuelDeliveryTuple.1
        DataController.shared.receiverCarModel.fuelDelivery = fuelDeliveryTuple.0
        
        DataController.shared.inspectionCarModel.fuelDeliveryType = fuelDeliveryTuple.1
    }
    
    //MARK: engine condition
    @IBAction func engineConditionValueChanged(_ sender: Any) {
        var selectString:String? = nil
        switch engineConditionRadio.selectedIndex {
        case 0:
            selectString = strings_motorbike_engine_working_or_not[0]
        case 1:
            selectString = strings_motorbike_engine_working_or_not[1]
        default:
            selectString = nil
        }
        print("🔸 EngineCondition \(selectString)")
        
        DataController.shared.receiverCarModel.engineCondition = selectString
        
    }
    
    //MARK: gear condition
    @IBAction func gearConditionValueChanged(_ sender: Any) {
        var selectString:String? = nil
        switch gearConditionRadio.selectedIndex {
        case 0:
            selectString = strings_motorbike_engine_fair_repair[0]
        case 1:
            selectString = strings_motorbike_engine_fair_repair[1]
        default:
            selectString = nil
        }
        print("🔸 GearCondition \(selectString)")
        
        DataController.shared.receiverCarModel.gearCondition = selectString
    }
    
    //MARK: break condition
    @IBAction func breakConditionValueChanged(_ sender: Any) {
        var selectString:String? = nil
        switch breakConditionRadio.selectedIndex {
        case 0:
            selectString = strings_motorbike_engine_fair_repair[0]
        case 1:
            selectString = strings_motorbike_engine_fair_repair[1]
        default:
            selectString = nil
        }
        print("🔸 BreakCondition \(selectString)")
        
        DataController.shared.receiverCarModel.brakeCondition = selectString
        
    }
    
    //MARK: Keys
    @IBAction func keyTapped(_ sender: Any) {
        keyCheckBox.toggle { [weak self] check in
            if !check {
                DataController.shared.inspectionCarModel.isKey = false
                DataController.shared.receiverCarModel.removeKeys(type: string_key_label)
                self?.keyDropDown.text = ""
                self?.uncheckKeys()
            }else{
                DataController.shared.receiverCarModel.isKeys = true
                DataController.shared.receiverCarModel.addKeys(type: string_key_label)
            }
        }
    }
    
    @IBAction func remoteKeyTapped(_ sender: Any) {
        remoteKeyCheckBox.toggle { [weak self] check in
            if !check {
                DataController.shared.inspectionCarModel.isRemoteKey = false
                DataController.shared.receiverCarModel.removeKeys(type: string_remote_key_label)
                self?.remoteKeyDropDown.text = ""
                self?.uncheckKeys()
            }else{
                DataController.shared.receiverCarModel.isKeys = true
                DataController.shared.receiverCarModel.addKeys(type: string_remote_key_label)
            }
        }
    }
    
    @IBAction func remoteTapped(_ sender: Any) {
        remoteCheckBox.toggle { [weak self] check in
            if !check {
                DataController.shared.inspectionCarModel.isRemote = false
                DataController.shared.receiverCarModel.removeKeys(type: string_remote_control_key_label)
                self?.remoteDropDown.text = ""
                self?.uncheckKeys()
            }else{
                DataController.shared.receiverCarModel.isKeys = true
                DataController.shared.receiverCarModel.addKeys(type: string_remote_control_key_label)
            }
        }
    }
    @IBAction func immobilizerKeyTapped(_ sender: Any) {
        immobilizarKeyCheckBox.toggle { [weak self] check in
            if !check {
                DataController.shared.inspectionCarModel.isImmobilizarKey = false
                DataController.shared.receiverCarModel.removeKeys(type: string_immobilizer_key_label)
                self?.immobilizarKeyDropDown.text = ""
                self?.uncheckKeys()
            }else{
                DataController.shared.receiverCarModel.isKeys = true
                DataController.shared.receiverCarModel.addKeys(type: string_immobilizer_key_label)
            }
            
        }
    }
    
    func uncheckKeys(){
        guard !keyCheckBox.check,
              !remoteKeyCheckBox.check,
              !remoteCheckBox.check,
              !immobilizarKeyCheckBox.check else { return }
        
        DataController.shared.receiverCarModel.isKeys = false
        DataController.shared.receiverCarModel.mapKeys = nil
    }
    
    //MARK: checkbox
    @IBAction func handStartTapped(_ sender: Any) {
        handStartCheckBox.toggle { check in
            DataController.shared.receiverCarModel.isHandStart = check
            DataController.shared.inspectionCarModel.isElectricStart = check
        }
    }
    @IBAction func kickStartTapped(_ sender: Any) {
        kickStartCheckBox.toggle { check in
            DataController.shared.receiverCarModel.isKickStart = check
            DataController.shared.inspectionCarModel.isPedelStart = check
        }
    }
    @IBAction func registrationPlateTapped(_ sender: Any) {
        registrationPlateCheckBox.toggle { check in
            DataController.shared.receiverCarModel.isRegistrationPlate = check
            DataController.shared.inspectionCarModel.isPlate = check
        }
    }
    
    func setUpTextField(){
        milesTextFIeld.autocorrectionType = .no
        noteMultilineTextField.autocorrectionType = .no
        reasonMileageTextField.autocorrectionType = .no
        
        noteMultilineTextField.delegate = self
        milesTextFIeld.delegate = self
        reasonMileageTextField.delegate = self
        
        addTarget(from: milesTextFIeld)
        addTarget(from: reasonMileageTextField)
    }
    
    fileprivate func addTarget(from textfield: UITextField ){
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .editingChanged)
    }
    
    //MARK: Dropdown
    func setUpDropDown(){
        let keyValue = ["1","2","3","4","5","6","7","8","9","10"]
        keyDropDown.optionArray = keyValue
        keyDropDown.didSelect { [weak self] (selected, _, _) in
            
            DataController.shared.receiverCarModel.isKeys = true
            DataController.shared.receiverCarModel.addKeys(type: string_key_label, amount: selected)
            DataController.shared.inspectionCarModel.isKey = true
            
            self?.keyDropDown.text = selected
            
            let request = BookInMotorcycle2.Something.Request(keyCheck : selected)
            self?.interactor?.keyCheck(request: request)
        }
        remoteDropDown.optionArray = keyValue
        remoteDropDown.didSelect { [weak self] (selected, _, _) in
            
            
            DataController.shared.receiverCarModel.isKeys = true
            DataController.shared.receiverCarModel.addKeys(type: string_remote_control_key_label, amount: selected)
            DataController.shared.inspectionCarModel.isRemote = true
            
            self?.remoteDropDown.text = selected
            
            let request = BookInMotorcycle2.Something.Request(remoteCheck : selected)
            self?.interactor?.remoteCheck(request: request)
        }
        
        remoteKeyDropDown.optionArray = keyValue
        remoteKeyDropDown.didSelect { [weak self] (selected, _, _) in
            
            DataController.shared.receiverCarModel.isKeys = true
            DataController.shared.receiverCarModel.addKeys(type: string_remote_key_label, amount: selected)
            DataController.shared.inspectionCarModel.isRemoteKey = true
            
            self?.remoteKeyDropDown.text = selected
            
            let request = BookInMotorcycle2.Something.Request(remoteKeyCheck : selected)
            self?.interactor?.remoteKeyCheck(request: request)
        }
        
        
        immobilizarKeyDropDown.optionArray = keyValue
        immobilizarKeyDropDown.didSelect { [weak self] (selected, _, _) in
            
            DataController.shared.receiverCarModel.isKeys = true
            DataController.shared.receiverCarModel.addKeys(type: string_immobilizer_key_label, amount: selected)
            DataController.shared.inspectionCarModel.isImmobilizarKey = true
            
            self?.immobilizarKeyDropDown.text = selected
            
            let request = BookInMotorcycle2.Something.Request(immobilizerKeyCheck : selected)
            self?.interactor?.immobilizerKeyCheck(request: request)
        }
    }
    
    //MARK: Presenter
    func displayValidateMileNumber(viewModel: BookInMotorcycle2.Something.ViewModel) {
        milesTextFIeld.text = viewModel.validateMilesNumber
        
        DataController.shared.receiverCarModel.miles = viewModel.validateMilesNumber
    }
    
    func displayKeyChecked(viewModel: BookInMotorcycle2.Something.ViewModel) {
        keyCheckBox.check = viewModel.isKeyCheck ?? false
    }
    func displayRemoteChecked(viewModel: BookInMotorcycle2.Something.ViewModel) {
        remoteCheckBox.check = viewModel.isRemoteCheck ?? false
    }
    func displayRemoteKeyChecked(viewModel: BookInMotorcycle2.Something.ViewModel) {
        remoteKeyCheckBox.check = viewModel.isRemoteKeyCheck ?? false
    }
    
    func displayImmobiliserKeyChecked(viewModel: BookInMotorcycle2.Something.ViewModel) {
        immobilizarKeyCheckBox.check = viewModel.isImmobilizerKeyCheck ?? false
    }
    
    
    //MARK: fetch GearBox
    var isGearBox = false
    
    func fetchGearBox(){
        interactor?.fetchGearBox(request: BookInMotorcycle2.Something.Request())
    }
    func displayErrorGearBoxList(viewModel: BookInMotorcycle2.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessageOKAction(message: errorMessage) {
            //ignhred
        }
    }
    
    func displayGearBoxList(viewModel: BookInMotorcycle2.Something.ViewModel) {
        guard let gearBoxList_bu = viewModel.gearBoxList_bu else { return }
        isGearBox = true
        
        setValue(to: gearboxDropDown, values: gearBoxList_bu) { [weak self] (selectValue, _, _) in
            self?.gearboxDropDown.text = selectValue
            
            let request = BookInMotorcycle2.Something.Request(selectGearbox: selectValue)
            self?.interactor?.selectGearBox(request: request)
            
            self?.gearboxLabel.validateLabel(true)
            self?.gearboxLineView.validateLineView(true)
        }
        
        self.prepareGearBox()
    }
    
    func displayGearBoxText(viewModel: BookInMotorcycle2.Something.ViewModel) {
        gearboxDropDown.text = viewModel.gearBox_BU
        
    }
    
    func setValue(to textfield:DropDown , values: [String], didSelected:@escaping (_ selectedText: String, _ index: Int , _ id:Int )->() ){
        textfield.text = ""
        textfield.optionArray = values
        textfield.didSelect(completion: didSelected)
    }
    
    func fetchAPI(){
        if !isGearBox {
            fetchGearBox()
        }
    }
    
    func prepareGearBox(){
        let request = BookInMotorcycle2.Something.Request(codeGearBox: DataController.shared.receiverCarModel.gearbox)
        interactor?.prepareGearBox(request: request)
    }
    
    
    
    func prepareData(){
        let model = DataController.shared.receiverCarModel
        let typeMilesValue = strings_motorbike_engine_kilometer_mile
        let redBookValue = ["G", "A", "F", "P", "Y"]
        
        
        carConditionRadio.selectedIndex = getRadioIndexByValue(from: redBookValue, value: model.redBookCondition)
        
        milesTextFIeld.text = model.miles
        milesRadio.selectedIndex = getRadioIndexByValue(from: typeMilesValue, value: model.typeMiles)
        ///key
        let numberOfKey = model.mapKeys?[string_key_label] as? String
        let numberOfKeyRemote = model.mapKeys?[string_remote_key_label] as? String
        let numberOfRemote = model.mapKeys?[string_remote_control_key_label] as? String
        let numberOfImmobilizer = model.mapKeys?[string_immobilizer_key_label] as? String
        let numberOfKeyless = model.mapKeys?[String.localized("car_interior_keyless_label")] as? String
        
        let checkKey = (numberOfKey?.toInt() ?? 0) > 0
        let checkRemote = (numberOfRemote?.toInt() ?? 0) > 0
        let checkKeyRemote = (numberOfKeyRemote?.toInt() ?? 0) > 0
        let checkImmobilizer = (numberOfImmobilizer?.toInt() ?? 0) > 0
        let checkKeyless = (numberOfKeyless?.toInt() ?? 0) > 0
        
        keyDropDown.text = checkKey ? numberOfKey : ""
        remoteDropDown.text = checkRemote ? numberOfRemote : ""
        remoteKeyDropDown.text = checkKeyRemote ? numberOfKeyRemote : ""
        immobilizarKeyDropDown.text = checkImmobilizer ? numberOfImmobilizer : ""
        
        
        keyCheckBox.check = checkKey
        remoteCheckBox.check = checkRemote
        remoteKeyCheckBox.check = checkKeyRemote
        immobilizarKeyCheckBox.check = checkImmobilizer
        
        
        fuelDeliveryRadio.selectedIndex = getRadioIndexByValue(from : [strings_motorbike_engine_injector_carburetor[0], strings_motorbike_engine_injector_carburetor[1], "N/A"], value: DataController.shared.receiverCarModel.fuelDeliveryName)
        
        isInvalidMilesCheckBox.check = (model.isInvalidMileage ?? false)
        reasonMileageStackView.isHidden = !(model.isInvalidMileage ?? false)
        reasonMileageTextField.text = model.invalidMileageReason
        
        let engineValue = strings_motorbike_engine_working_or_not
        let conditionValue = strings_motorbike_engine_fair_repair
        engineConditionRadio.selectedIndex = getRadioIndexByValue(from: engineValue, value: model.engineCondition)
        gearConditionRadio.selectedIndex = getRadioIndexByValue(from: conditionValue, value: model.gearCondition)
        breakConditionRadio.selectedIndex = getRadioIndexByValue(from: conditionValue, value: model.brakeCondition)
        
        handStartCheckBox.check = model.isHandStart ?? false
        kickStartCheckBox.check = model.isKickStart ?? false
        registrationPlateCheckBox.check = model.isRegistrationPlate ?? false
        
        noteMultilineTextField.text = model.annotation
    }
    
    @objc func updateView(){
        let model  = DataController.shared.receiverCarModel
        
        
        gearboxLabel.validateLabel(model.validGearBox)
        gearboxLineView.validateLineView(model.validGearBox)
        //------------------------------------------------------------//
    }
}


//MARK: keyboard
extension BookInMotorcycle2ViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registKeyboardNotification()
        
        prepareData()
        updateView()
        fetchAPI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: NSNotification.Name("updateUI"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.resignKeyboardNotification()
        
        NotificationCenter.default.removeObserver(self)
    }
}

extension BookInMotorcycle2ViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("annotation : \(textView.text)")
        DataController.shared.receiverCarModel.annotation = textView.text
    }
}
extension BookInMotorcycle2ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension  BookInMotorcycle2ViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        //
        switch textField {
        case milesTextFIeld:
            print("miles : \(textField.text)")
            let request = BookInMotorcycle2.Something.Request(miles: textField.text)
            interactor?.validateMileNumber(request: request)
            
        case reasonMileageTextField:
            DataController.shared.receiverCarModel.invalidMileageReason = textField.text
        default:
            break
        }
    }
    
}
