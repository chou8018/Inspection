//
//  EngineCarViewController.swift
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
import RadioGroup

protocol EngineCarDisplayLogic: AnyObject
{
    func displaySomething(viewModel: EngineCar.Something.ViewModel)
    
    // add on 2/21/2024
    func displayFuelDeliveryList(viewModel: EngineCar.Something.ViewModel)
    func displayFuelDeliveryListError(viewModel: EngineCar.Something.ViewModel)
}

class EngineCarViewController: ViewController, EngineCarDisplayLogic
{
    var interactor: EngineCarBusinessLogic?
    var router: (NSObjectProtocol & EngineCarRoutingLogic & EngineCarDataPassing)?
    
    var isGetFuelSystem = false
    var fuelDeliveryList : [String]?
    var localFuelDeliveryList: [String] = [string_direct_injection, string_injector,
                                           string_naturally, string_turbo, "N/A", string_electric]
    
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
        let interactor = EngineCarInteractor()
        let presenter = EngineCarPresenter()
        let router = EngineCarRouter()
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
    
    func loadRetryApi() {
         if !isGetFuelSystem {
             getFuelSystem()
        }
    }
    
    //MARK: catalyticOption
    func getFuelSystem(){
        let request = EngineCar.Something.Request()
        interactor?.getFuelSystem(request: request)
    }
    
    func displayFuelDeliveryList(viewModel: EngineCar.Something.ViewModel) {
        guard let values = viewModel.fuelDeliveryList else { return }
        fuelDeliveryList = values
        fuelSystemRadio.titles = values
        isGetFuelSystem = true
        DataController.shared.receiverCarModel.fuelSystemTitles = values
    }
    func displayFuelDeliveryListError(viewModel: EngineCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.loadRetryApi()
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUIView()
        setUpRadio()
        setUpCheckBox()
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var engineOverallRadio: RadioGroup!
    @IBOutlet weak var deiverSystemRadio: RadioGroup!
    @IBOutlet weak var oilSystemRadio: RadioGroup!
    @IBOutlet weak var gasRadio: RadioGroup!
    @IBOutlet weak var colorTextField: CustomTextField!
    @IBOutlet weak var betteryBrandTextField: CustomTextField!
    @IBOutlet weak var engineOverAllTextField: MultilineTextField!
    @IBOutlet weak var ecuCheckBox: CheckBoxUIButton!
    @IBOutlet weak var compressorCheckBox: CheckBoxUIButton!
    @IBOutlet weak var gasCheckBox: CheckBoxUIButton!
    @IBOutlet weak var fuelSystemRadio: RadioGroup!
    
    // local strings
    @IBOutlet weak var engineRoomLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var ecuLabel: UILabel!
    @IBOutlet weak var compressorLabel: UILabel!
    @IBOutlet weak var driveSystemLabel: UILabel!
    @IBOutlet weak var engineTypeLabel: UILabel!
    @IBOutlet weak var fuelSystemLabel: UILabel!
    @IBOutlet weak var gasLabel: UILabel!
    @IBOutlet weak var engineOverAllLabel: UILabel!
    
    override func initLocalString() {
        super.initLocalString()
        
        engineRoomLabel.text = String.localized("car_engine_room_condition_label")
        batteryLabel.text = String.localized("car_engine_battery_label")
        betteryBrandTextField.placeholder = String.localized("car_detail_make_label")
        colorLabel.text = String.localized("car_detail_color_label")
        colorTextField.placeholder = colorLabel.text
        ecuLabel.text = String.localized("car_engine_ecu_label")
        compressorLabel.text = String.localized("car_engine_air_compressor_label")
        driveSystemLabel.text = String.localized("car_engine_drive_system_label")
        engineTypeLabel.text = String.localized("car_engine_type_label")
        fuelSystemLabel.text = String.localized("car_engine_fuel_system_label")
        gasLabel.text = String.localized("car_engine_gas_label")
        engineOverAllLabel.text = String.localized("car_interior_others_label")
        engineOverAllTextField.placeholder = String.localized("car_interior_others_label")
    }
    
    func doSomething()
    {
        let request = EngineCar.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: EngineCar.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    //MARK: UIView
    func setUIView(){
        betteryBrandTextField.autocorrectionType = .no
        colorTextField.autocorrectionType = .no
        engineOverAllTextField.autocorrectionType = .no
        
        betteryBrandTextField.delegate = self
        colorTextField.delegate = self
        engineOverAllTextField.delegate = self
        
        addTarget(from: betteryBrandTextField)
        addTarget(from: colorTextField)
        
    }
    
    fileprivate func addTarget(from textfield: UITextField ){
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .editingChanged)
    }
    
    
    //MARK: CheckBox
    func setUpCheckBox(){
        
    }
    @IBAction func ecuTapped(_ sender: Any) {
        ecuCheckBox.toggle { check in
            DataController.shared.receiverCarModel.isEcu = check
        }
    }
    @IBAction func compressorTapped(_ sender: Any) {
        compressorCheckBox.toggle { check in
            DataController.shared.receiverCarModel.isCompressor = check
        }
    }
    @IBAction func gasTapped(_ sender: Any) {
        gasCheckBox.toggle { [weak self] check in
            guard let weakself = self else { return }
            if !check {
                weakself.gasRadio.selectedIndex = -1
                DataController.shared.receiverCarModel.gasSystem = nil
                DataController.shared.receiverCarModel.gasTypeId = nil
                
                weakself.setFuelType(fuelType: weakself.oilSystemRadio.selectedIndex,
                                     gasSystem: weakself.gasRadio.selectedIndex)
            }
            DataController.shared.receiverCarModel.isGas = check
            
        }
    }
    
    //MARK: Radio
    func setUpRadio(){
        let attributedString = [NSAttributedString.Key.foregroundColor : UIColor.appPrimaryColor]
        
        //Color
        engineOverallRadio.attributedTitles = [
            NSAttributedString(string: string_good_first, attributes: attributedString),
            NSAttributedString(string: string_average, attributes: attributedString),
            NSAttributedString(string: string_fair, attributes: attributedString),
            NSAttributedString(string: string_poor, attributes: attributedString)
            
        ]
        
        deiverSystemRadio.attributedTitles = [
            NSAttributedString(string: "FWD", attributes: attributedString),
            NSAttributedString(string: "RWD", attributes: attributedString),
            NSAttributedString(string: "4WD", attributes: attributedString),
            NSAttributedString(string: "AWD", attributes: attributedString)
        ]
        
        oilSystemRadio.attributedTitles = [
            NSAttributedString(string: string_benzine, attributes: attributedString),
            NSAttributedString(string: string_diesel, attributes: attributedString),
            NSAttributedString(string: string_hybrid_benzine, attributes: attributedString),
            NSAttributedString(string: string_hybrid_diesel, attributes: attributedString),
            NSAttributedString(string: "Book-in-\(string_bev_diesel)", attributes: attributedString),
            NSAttributedString(string: "Book-in-\(string_phev_diesel)", attributes: attributedString)
        ]
                
        gasRadio.attributedTitles = [
            NSAttributedString(string: string_lpg_sequential_injection, attributes: attributedString),
            NSAttributedString(string: string_lpg_fumigation_system, attributes: attributedString),
            NSAttributedString(string: string_cng_sequential_injection, attributes: attributedString),
            NSAttributedString(string: string_cng_fumigation_system, attributes: attributedString)
        ]
        
//        fuelSystemRadio.attributedTitles = [
//            NSAttributedString(string: string_injector, attributes: attributedString),
//            NSAttributedString(string: string_carburetor, attributes: attributedString),
//            NSAttributedString(string: "Direct Injection", attributes: attributedString),
//            NSAttributedString(string: "N/A", attributes: attributedString)
//        ]
    }
    
    //MARK: Engine OverAll
    @IBAction func engineOverallRadioGroupValueChanged(_ sender: Any) {
        let value = getRadioValue(from: [string_good_first, string_average, string_fair, string_poor],
                                  selectIndex: engineOverallRadio.selectedIndex)
        
        DataController.shared.receiverCarModel.engineOverAll = value
        let engineOverAllId = engineOverallRadio.selectedIndex + 1
        DataController.shared.receiverCarModel.engineOverAllId = engineOverAllId
    }
    
    //MARK: Driver
    @IBAction func driverSystemRadioGroupValueChanged(_ sender: Any) {
        let value = getRadioValue(from: ["FWD", "RWD", "4WD", "AWD"],
                                  selectIndex: deiverSystemRadio.selectedIndex)
        
        DataController.shared.receiverCarModel.driverSystem = value
        let driverSystemId = deiverSystemRadio.selectedIndex + 1
        DataController.shared.receiverCarModel.driverSystemId = driverSystemId
        
        switch deiverSystemRadio.selectedIndex {
        case 0: //FWD
            DataController.shared.receiverCarModel.drive = "F"
        case 1: //RWD
            DataController.shared.receiverCarModel.drive = "R"
        case 2: //4WD
            DataController.shared.receiverCarModel.drive = "4"
        case 3: //AWD
            DataController.shared.receiverCarModel.drive = "A"
        default:
            DataController.shared.receiverCarModel.drive = ""
            break
        }
        
    }
    //MARK: OIL
    @IBAction func oilSystemRadioGroupValueChanged(_ sender: Any) {
        let value = getRadioValue(from: [string_benzine, string_diesel, string_hybrid_benzine, string_hybrid_diesel, string_bev_diesel, string_phev_diesel],
                                  selectIndex: oilSystemRadio.selectedIndex)
        
        DataController.shared.receiverCarModel.oilSystem = value
        let fuelSystemId = oilSystemRadio.selectedIndex + 1
        DataController.shared.receiverCarModel.fuelSystemId = fuelSystemId
        
        
        setFuelType(fuelType: oilSystemRadio.selectedIndex, gasSystem: gasRadio.selectedIndex)
        
        oilSystemRadio.setValidateView(true)
        
//        if let selectItem = oilSystemRadio.subviews.first?.subviews[oilSystemRadio.selectedIndex] {
//            if value == string_bev_diesel {
//                DataController.shared.showTipView(sender: selectItem, superView: self.view, message: String.localized("car_engine_tip_electric_elabel"))
//            }
//            
//            if value == string_phev_diesel {
//                DataController.shared.showTipView(sender: selectItem, superView: self.view, message: String.localized("car_engine_tip_electric_internal_label"))
//            }
//      yst  }
    }
    
    private func fuelSystems() -> [String] {
        if let fuelDeliveryList = fuelDeliveryList {
            return fuelDeliveryList
        } else {
            return localFuelDeliveryList
        }
    }
    
    @IBAction func fuelSystemValueChanged(_ sender: Any) {
//        let value = getRadioValue(from: [string_injector, string_carburetor, "Direct Injection", "N/A"],
//                                  selectIndex: fuelSystemRadio.selectedIndex)
        
        let value = getRadioValue(from: fuelSystems(),
                                  selectIndex: fuelSystemRadio.selectedIndex)
        DataController.shared.receiverCarModel.fuelDeliveryName = value
        
        var fuelDelivery = ""
        switch fuelSystemRadio.selectedIndex {
//        case 0:
//            fuelDelivery = "I"
//        case 1:
//            fuelDelivery = "N"
//        case 2:
//            fuelDelivery = "D"
//        case 3:
//            fuelDelivery = "1"
//        default:
//            fuelDelivery = "1"
//        }
        case 0:
            fuelDelivery = "D"
        case 1:
            fuelDelivery = "I"
        case 2:
            fuelDelivery = "N"
        case 3:
            fuelDelivery = "T"
        case 4:
            fuelDelivery = "1"
        case 5:
            fuelDelivery = "E"
        default:
            fuelDelivery = "1"
        }
        
        DataController.shared.receiverCarModel.fuelDelivery = fuelDelivery
    }
    
    //MARK: Gas
    @IBAction func gasRadioGroupValueChanged(_ sender: Any) {
        gasCheckBox.check = true
        
        let value = getRadioValue(from: [string_lpg_sequential_injection, string_lpg_fumigation_system,
                                         string_cng_sequential_injection, string_cng_fumigation_system],
                                  selectIndex: gasRadio.selectedIndex)
        
        DataController.shared.receiverCarModel.gasSystem = value
        DataController.shared.receiverCarModel.isGas = true
        
        let gasTypeId = gasRadio.selectedIndex + 1
        DataController.shared.receiverCarModel.gasTypeId = gasTypeId
        
        DataController.shared.inspectionCarModel.gasSystem = value
        
        setFuelType(fuelType: oilSystemRadio.selectedIndex, gasSystem: gasRadio.selectedIndex)
        
    }
    
    func setFuelType(fuelType:Int, gasSystem:Int){
        
        switch fuelType {
        case 0: //"เบนซิน"
            print("Petrol : P")
            DataController.shared.receiverCarModel.fuelType = "P"
        case 1: //"ดีเซล"
            print("Diesel : D")
            DataController.shared.receiverCarModel.fuelType = "D"
        case 2: //"EV"
            print("EV : E")
            DataController.shared.receiverCarModel.fuelType = "E"
        case 3: //"Hybrid / เบนซิน"
            print("Petrol : P")
            DataController.shared.receiverCarModel.fuelType = "P"
        case 4: // "Hybrid / ดีเซล"
            print("Diesel : D")
            DataController.shared.receiverCarModel.fuelType = "D"
        default:
            print("N/A : 1")
            DataController.shared.receiverCarModel.fuelType = "1"
            break
        }
        
//        switch fuelType {
//        case 0: //"เบนซิน"
//            print("Petrol : P")
//            DataController.shared.receiverCarModel.fuelType = "P"
//        case 1: //"ดีเซล"
//            print("Diesel : D")
//            DataController.shared.receiverCarModel.fuelType = "D"
//        case 2: //"EV" -> "Hybrid / Benzine"
//            print("Petrol : HP")
//            DataController.shared.receiverCarModel.fuelType = "HP"
//        case 3: //"Hybrid / Diesel"
//            print("Diesel : HD")
//            DataController.shared.receiverCarModel.fuelType = "HD"
//        case 4: // "Hybrid / ดีเซล" update -> "BEV"
//            print("BEV")
//            DataController.shared.receiverCarModel.fuelType = "BEV"
//        case 5: // "PHEV"
//            print("PHEV")
//            DataController.shared.receiverCarModel.fuelType = "PHEV"
//        default:
//            print("N/A : 1")
//            DataController.shared.receiverCarModel.fuelType = "1"
//            break
//        }
        
        //["เบนซิน", "ดีเซล", "EV", "Hybrid / เบนซิน", "Hybrid / ดีเซล"]
        //["LPG ระบบหัวฉีด", "LPG ระบบดูด", "CNG/NGV ระบบหัวฉีด", "CNG/NGV ระบบดูด"]
        switch gasSystem {
        case 0,1: // LPG
            if fuelType == 0 || fuelType == 3 {
                print("Petrol+LPG : 2")
                DataController.shared.receiverCarModel.fuelType = "2"
            }
            if fuelType == 1 || fuelType == 4 {
                print("Diesel+LPG : 5")
                DataController.shared.receiverCarModel.fuelType = "5"
            }
            
        case 2,3: // CNG/NGV
            if fuelType == 0 || fuelType == 3 {
                print("Petrol+CNG : 4")
                DataController.shared.receiverCarModel.fuelType = "4"
            }
            if fuelType == 1 || fuelType == 4 {
                print("Diesel+CNG : 6")
                DataController.shared.receiverCarModel.fuelType = "6"
            }
            
        default:
            break
        }
    }
    
    @objc func prepareData(){
        let model = DataController.shared.receiverCarModel
        let engineRoomOverAllValue = [string_good_first, string_average, string_fair, string_poor]
        let driverSystemValue = ["FWD", "RWD", "4WD", "AWD"]
//        let fuelSystemValue = [string_benzine, string_diesel, "EV", string_hybrid_benzine, string_diesel]
        let fuelSystemValue = [string_benzine, string_diesel, string_hybrid_benzine, string_hybrid_diesel, string_bev_diesel, string_phev_diesel]
        let gasTypeValue = [string_lpg_sequential_injection, string_lpg_fumigation_system,
                            string_cng_sequential_injection, string_cng_fumigation_system]
        
        engineOverallRadio.selectedIndex = getRadioIndexByValue(from: engineRoomOverAllValue, value: model.engineOverAll)
        
        deiverSystemRadio.selectedIndex = getRadioIndexByValue(from: driverSystemValue, value: model.driverSystem)
        
        oilSystemRadio.selectedIndex = getRadioIndexByValue(from: fuelSystemValue, value: model.oilSystem)
        
        gasRadio.selectedIndex = getRadioIndexByValue(from: gasTypeValue, value: model.gasSystem)
        
        colorTextField.text = model.betteryColor
        betteryBrandTextField.text = model.betteryBrand
        engineOverAllTextField.text = model.assetInCar
        ecuCheckBox.check = model.isEcu ?? false
        compressorCheckBox.check = model.isCompressor ?? false
        gasCheckBox.check = model.isGas ?? false
        
        
//        fuelSystemRadio.selectedIndex = getRadioIndexByValue(from : [string_injector, string_carburetor, "Direct Injection", "N/A"], value: DataController.shared.receiverCarModel.fuelDeliveryName)
        
   
        var driveSelectedIndex = -1
        switch model.drive?.trimWhiteSpace {
        case "F":
            driveSelectedIndex = 0
        case "R":
            driveSelectedIndex = 1
        case "4":
            driveSelectedIndex = 2
        case "A":
            driveSelectedIndex = 3
        default:
            driveSelectedIndex = -1
        }
        deiverSystemRadio.selectedIndex = driveSelectedIndex
    }
    
    @objc func updateView(){
        let model = DataController.shared.receiverCarModel
        let isEnable = getEnableView()
        
        engineOverallRadio.setEnableView(isEnable: isEnable)
        deiverSystemRadio.setEnableView(isEnable: isEnable)
        oilSystemRadio.setEnableView(isEnable: isEnable)
        gasRadio.setEnableView(isEnable: isEnable)
        
        colorTextField.setEnableView(isEnable: isEnable)
        betteryBrandTextField.setEnableView(isEnable: isEnable)
        engineOverAllTextField.setEnableView(isEnable: isEnable)
        ecuCheckBox.setEnableView(isEnable: isEnable)
        compressorCheckBox.setEnableView(isEnable: isEnable)
        gasCheckBox.setEnableView(isEnable: isEnable)
        
        oilSystemRadio.setValidateView(model.validFuelType)
    }
    
    @objc func tipButtonSelected(noti: NSNotification){
        guard let sender = noti.object as? UIButton else {
            return
        }
    
        guard let value = noti.userInfo?["text"] as? String else {
            return
        }
        
        if value == string_bev_diesel {
            DataController.shared.showTipView(sender: sender, superView: self.view, message: String.localized("car_engine_tip_electric_elabel"))
        } else if value == string_phev_diesel {
            DataController.shared.showTipView(sender: sender, superView: self.view, message: String.localized("car_engine_tip_electric_internal_label"))
        }
    }
    
    @objc func updateDataFromSelectMode(noti: NSNotification){
        prepareData()
    }
}

extension EngineCarViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //print(textView.text)
        DataController.shared.receiverCarModel.assetInCar = textView.text
    }
}

// MARK: UITextFieldDelegate
extension EngineCarViewController : UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        //print(textField.text)
        
        switch textField {
        case colorTextField:
            DataController.shared.receiverCarModel.betteryColor = textField.text
            
        case betteryBrandTextField:
            DataController.shared.receiverCarModel.betteryBrand = textField.text
            
        default:
            return
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        return true
    }
}
//MARK: keyboard
extension EngineCarViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registKeyboardNotification()
        loadRetryApi()
        prepareData()
        updateView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: NSNotification.Name("updateUI"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tipButtonSelected(noti:)), name: NSNotification.Name("tipButtondSelect"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDataFromSelectMode(noti:)), name: NSNotification.Name("modelHasSelected"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.resignKeyboardNotification()
        
        NotificationCenter.default.removeObserver(self)
    }
}
