//
//  ElectronicDeviceCheckViewController.swift
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

protocol ElectronicDeviceCheckDisplayLogic: AnyObject
{
    func displaySomething(viewModel: ElectronicDeviceCheck.Something.ViewModel)
}

class ElectronicDeviceCheckViewController: ViewController, ElectronicDeviceCheckDisplayLogic
{
    var interactor: ElectronicDeviceCheckBusinessLogic?
    var router: (NSObjectProtocol & ElectronicDeviceCheckRoutingLogic & ElectronicDeviceCheckDataPassing)?
    
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
        let interactor = ElectronicDeviceCheckInteractor()
        let presenter = ElectronicDeviceCheckPresenter()
        let router = ElectronicDeviceCheckRouter()
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
        setCheckBox()
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var summaryElectronicDeviceTextField: MultilineTextField!
    @IBOutlet weak var noteTextField: CustomTextField!
    
    @IBOutlet weak var frontLightCheckBox: CheckBoxUIButton!
    @IBOutlet weak var turnLightCheckBox: CheckBoxUIButton!
    @IBOutlet weak var backLightCheckBox: CheckBoxUIButton!
    @IBOutlet weak var brakeLightCheckBox: CheckBoxUIButton!
    @IBOutlet weak var betteryCheckBox: CheckBoxUIButton!
    @IBOutlet weak var hooterCheckBox: CheckBoxUIButton!
    @IBOutlet weak var roundGaugeCheckBox: CheckBoxUIButton!
    
    @IBOutlet weak var navigatorCheckBox: CheckBoxUIButton!
    @IBOutlet weak var navigatorOnCarCheckBox: CheckBoxUIButton!
    @IBOutlet weak var cdCheckBox: CheckBoxUIButton!
    @IBOutlet weak var noSdCardCheckBox: CheckBoxUIButton!
    @IBOutlet weak var noCdCheckBox: CheckBoxUIButton!
    @IBOutlet weak var sdCardCheckBox: CheckBoxUIButton!
    
    // local strings

    @IBOutlet weak var headLightLabel: UILabel!
    @IBOutlet weak var turnLightLabel: UILabel!
    @IBOutlet weak var tailLightLabel: UILabel!
    @IBOutlet weak var brakeLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var hornLabel: UILabel!
    @IBOutlet weak var dashboardLabel: UILabel!
    @IBOutlet weak var navigatorLabel: UILabel!
    @IBOutlet weak var navigatorInLabel: UILabel!
    @IBOutlet weak var otherRemarksLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    override func initLocalString() {
        super.initLocalString()
    
        headLightLabel.text = String.localized("inspection_electrical_head_light_label")
        turnLightLabel.text = String.localized("inspection_electrical_turn_light_label")
        tailLightLabel.text = String.localized("inspection_electrical_tail_light_label")
        brakeLabel.text = String.localized("inspection_electrical_brake_light_label")
        batteryLabel.text = String.localized("inspection_electrical_battery_label")
        hornLabel.text = String.localized("inspection_electrical_horn_label")
        dashboardLabel.text = String.localized("inspection_electrical_dashboard_label")
        navigatorLabel.text = String.localized("car_interior_navigator_label")
        navigatorInLabel.text = String.localized("car_interior_navigator_in_label")
        otherRemarksLabel.text = String.localized("inspection_electrical_other_remarks_label")
        noteTextField.placeholder = otherRemarksLabel.text
        summaryLabel.text = String.localized("inspection_electrical_summary_label")
        summaryElectronicDeviceTextField.placeholder = summaryLabel.text
        noCdCheckBox.setTitle(String.localized("car_interior_no_cd_label"), for: .normal)
        noSdCardCheckBox.setTitle(String.localized("car_interior_no_cd_card_label"), for: .normal)
    }
    
    func doSomething()
    {
        let request = ElectronicDeviceCheck.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ElectronicDeviceCheck.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    //MARK: UIView
    func setUIView(){
        summaryElectronicDeviceTextField.autocorrectionType = .no
        noteTextField.autocorrectionType = .no
        
        summaryElectronicDeviceTextField.delegate = self
        noteTextField.delegate = self
        
        addTarget(from: noteTextField)
    }
    
    fileprivate func addTarget(from textfield: UITextField ){
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .editingChanged)
    }
    
    
    //MARK: CheckBox
    func setCheckBox(){
        sdCardCheckBox.typecheck = .BACKGROUND
        cdCheckBox.typecheck = .BACKGROUND
        noSdCardCheckBox.typecheck = .BACKGROUND
        noCdCheckBox.typecheck = .BACKGROUND
    }
    
    @IBAction func frontLightTapped(_ sender: Any) {
        frontLightCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isFrontLight = check
        }
    }
    
    @IBAction func turnLightTapped(_ sender: Any) {
        turnLightCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isTurnLight = check
        }
    }
    
    @IBAction func backLightTapped(_ sender: Any) {
        backLightCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isBackLight = check
        }
    }
    
    @IBAction func brakeLightTapped(_ sender: Any) {
        brakeLightCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isBrakeLight = check
        }
    }
    
    @IBAction func betteryTapped(_ sender: Any) {
        betteryCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isBettery = check
        }
    }
    
    @IBAction func hooterTapped(_ sender: Any) {
        hooterCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isHooter = check
        }
    }
    
    @IBAction func roundGaugeTapped(_ sender: Any) {
        roundGaugeCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isRoundGauge = check
        }
    }
    
    //MARK: Navigator
    @IBAction func navigatorTapped(_ sender: Any) {
        navigatorCheckBox.toggle { [weak self] check in
            guard let weakself = self else { return }
            weakself.navigationCheck(checkBox: weakself.navigatorCheckBox , check: check)
        }
    }
    
    @IBAction func navigatorOnCarTapped(_ sender: Any) {
        navigatorOnCarCheckBox.toggle { [weak self] check in
            guard let weakself = self else { return }
            weakself.navigationCheck(checkBox: weakself.navigatorOnCarCheckBox , check: check)
        }
    }
    @IBAction func cdTapped(_ sender: Any) {
        cdCheckBox.toggle { [weak self] check in
            guard let weakself = self else { return }
            weakself.navigationCheck(checkBox: weakself.cdCheckBox , check: check)
        }
    }
    @IBAction func sdCardTapped(_ sender: Any) {
        sdCardCheckBox.toggle { [weak self] check in
            guard let weakself = self else { return }
            weakself.navigationCheck(checkBox: weakself.sdCardCheckBox , check: check)
        }
    }
    @IBAction func noSdCardTapped(_ sender: Any) {
        noSdCardCheckBox.toggle { [weak self] check in
            guard let weakself = self else { return }
            weakself.navigationCheck(checkBox: weakself.noSdCardCheckBox , check: check)
        }
    }
    @IBAction func noCDTapped(_ sender: Any) {
        noCdCheckBox.toggle { [weak self] check in
            guard let weakself = self else { return }
            weakself.navigationCheck(checkBox: weakself.noCdCheckBox , check: check)
        }
    }
    
    func uncheckNavigator(){
        guard !cdCheckBox.check,
              !sdCardCheckBox.check,
              !navigatorOnCarCheckBox.check,
              !noCdCheckBox.check,
              !noSdCardCheckBox.check else { return }
        
        self.navigatorCheckBox.check = false
        
        DataController.shared.inspectionCarModel.isNavigator = false
        DataController.shared.inspectionCarModel.isNavigatorOnCar = false
        DataController.shared.inspectionCarModel.isCd = false
        DataController.shared.inspectionCarModel.isSDCard = false
        DataController.shared.inspectionCarModel.isNoSdCard = false
        DataController.shared.inspectionCarModel.isNoCd = false
    }
    
    func navigationCheck(checkBox: CheckBoxUIButton , check : Bool){
        switch checkBox {
        case navigatorCheckBox:
            if !check {
                navigatorOnCarCheckBox.check = false
                cdCheckBox.check = false
                sdCardCheckBox.check = false
                noSdCardCheckBox.check = false
                noCdCheckBox.check = false
                
                
                DataController.shared.inspectionCarModel.isNavigatorOnCar = false
                DataController.shared.inspectionCarModel.isCd = false
                DataController.shared.inspectionCarModel.isSDCard = false
                DataController.shared.inspectionCarModel.isNoSdCard = false
                DataController.shared.inspectionCarModel.isNoCd = false
            }
            DataController.shared.inspectionCarModel.isNavigator = check
            break
        case navigatorOnCarCheckBox:
            if check {
                cdCheckBox.check = false
                sdCardCheckBox.check = false
                noSdCardCheckBox.check = false
                noCdCheckBox.check = false
                
                navigatorCheckBox.check = true
                DataController.shared.inspectionCarModel.isNavigator = true
                
                DataController.shared.inspectionCarModel.isCd = false
                DataController.shared.inspectionCarModel.isSDCard = false
                DataController.shared.inspectionCarModel.isNoSdCard = false
                DataController.shared.inspectionCarModel.isNoCd = false
                
            }else{
                uncheckNavigator()
            }
            DataController.shared.inspectionCarModel.isNavigatorOnCar = check
            break
        case cdCheckBox:
            if check {
                navigatorOnCarCheckBox.check = false
                noSdCardCheckBox.check = false
                noCdCheckBox.check = false
                sdCardCheckBox.check = false
                
                navigatorCheckBox.check = true
                
                DataController.shared.inspectionCarModel.isNavigator = true
                
                DataController.shared.inspectionCarModel.isNavigatorOnCar = false
                DataController.shared.inspectionCarModel.isSDCard = false
                DataController.shared.inspectionCarModel.isNoSdCard = false
                DataController.shared.inspectionCarModel.isNoCd = false
                
            }else{
                uncheckNavigator()
            }
            DataController.shared.inspectionCarModel.isCd = check
            break
        case sdCardCheckBox:
            if check {
                navigatorOnCarCheckBox.check = false
                cdCheckBox.check = false
                noSdCardCheckBox.check = false
                noCdCheckBox.check = false
                navigatorCheckBox.check = true
                
                DataController.shared.inspectionCarModel.isNavigator = true
                
                DataController.shared.inspectionCarModel.isNavigatorOnCar = false
                DataController.shared.inspectionCarModel.isCd = false
                DataController.shared.inspectionCarModel.isNoSdCard = false
                DataController.shared.inspectionCarModel.isNoCd = false
                
            }else{
                uncheckNavigator()
            }
            DataController.shared.inspectionCarModel.isSDCard = check
            break
        case noCdCheckBox:
            if check {
                navigatorOnCarCheckBox.check = false
                cdCheckBox.check = false
                sdCardCheckBox.check = false
                noSdCardCheckBox.check = false
                navigatorCheckBox.check = true
                
                DataController.shared.inspectionCarModel.isNavigator = true
                
                DataController.shared.inspectionCarModel.isNoSdCard = false
                DataController.shared.inspectionCarModel.isCd = false
                DataController.shared.inspectionCarModel.isSDCard = false
                DataController.shared.inspectionCarModel.isNavigatorOnCar = false
                
            }else{
                uncheckNavigator()
            }
            DataController.shared.inspectionCarModel.isNoCd = check
            break
        case noSdCardCheckBox:
            if check {
                navigatorOnCarCheckBox.check = false
                cdCheckBox.check = false
                sdCardCheckBox.check = false
                noCdCheckBox.check = false
                navigatorCheckBox.check = true
                
                DataController.shared.inspectionCarModel.isNavigator = true
                
                DataController.shared.inspectionCarModel.isNoCd = false
                DataController.shared.inspectionCarModel.isCd = false
                DataController.shared.inspectionCarModel.isSDCard = false
                DataController.shared.inspectionCarModel.isNavigatorOnCar = false
                
            }else{
                uncheckNavigator()
            }
            DataController.shared.inspectionCarModel.isNoSdCard = check
            break
        default:
            break
        }
    }
    
    //MARK: PrepareData
    func prepareData(){
        let model = DataController.shared.inspectionCarModel
        frontLightCheckBox.check = model.isFrontLight
        turnLightCheckBox.check = model.isTurnLight
        backLightCheckBox.check = model.isBackLight
        brakeLightCheckBox.check = model.isBrakeLight
        betteryCheckBox.check = model.isBettery
        hooterCheckBox.check = model.isHooter
        roundGaugeCheckBox.check = model.isRoundGauge
        navigatorCheckBox.check = model.isNavigator
        navigatorOnCarCheckBox.check = model.isNavigatorOnCar
        cdCheckBox.check = model.isCd
        sdCardCheckBox.check = model.isSDCard
        noSdCardCheckBox.check = model.isNoSdCard
        noCdCheckBox.check = model.isNoCd
        summaryElectronicDeviceTextField.text = model.summaryElectronicDevice
        noteTextField.text = model.note
    }
}



//MARK: TextView Delegate
extension ElectronicDeviceCheckViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //print(textView.text)
        DataController.shared.inspectionCarModel.summaryElectronicDevice = textView.text
    }
}


extension  ElectronicDeviceCheckViewController : UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        //print(textField.text)
        switch textField {
        case noteTextField:
            DataController.shared.inspectionCarModel.note = textField.text
            
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension ElectronicDeviceCheckViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registKeyboardNotification()
        
        
        prepareData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.resignKeyboardNotification()
    }
}
