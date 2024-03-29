//
//  ExternalCarViewController.swift
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

protocol ExternalCarDisplayLogic: AnyObject
{
  func displaySomething(viewModel: ExternalCar.Something.ViewModel)
    func displayTireCheckBox(viewModel: ExternalCar.Something.ViewModel)
    func displayMagWheelCheckBox(viewModel: ExternalCar.Something.ViewModel)
    func displayValidateResultTireTextField(viewModel: ExternalCar.Something.ViewModel)
    func displayNormalWheelCheckBox(viewModel: ExternalCar.Something.ViewModel)
}

class ExternalCarViewController: UIViewController, ExternalCarDisplayLogic
{
  var interactor: ExternalCarBusinessLogic?
  var router: (NSObjectProtocol & ExternalCarRoutingLogic & ExternalCarDataPassing)?

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
    let interactor = ExternalCarInteractor()
    let presenter = ExternalCarPresenter()
    let router = ExternalCarRouter()
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
    setUpRadio()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var qualityColorRadio: RadioGroup!
    @IBOutlet weak var qualityOverallRadio: RadioGroup!
    
    
    @IBOutlet weak var spoilerCheckBox: CheckBoxUIButton!
    @IBOutlet weak var magWheelCheckBox: CheckBoxUIButton!
    @IBOutlet weak var normalWheelCheckBox: CheckBoxUIButton!
    @IBOutlet weak var tireCheckBox: CheckBoxUIButton!
    
    
    @IBOutlet weak var magWheelTextField: DropDown!
    @IBOutlet weak var normalWheelTextField: DropDown!
    
    @IBOutlet weak var tireTextField: UITextField!
    @IBOutlet weak var tireQualityTextField: UITextField!
    @IBOutlet weak var damageDetailTextField: MultilineTextField!
    
    
    
    
    func doSomething()
  {
    let request = ExternalCar.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: ExternalCar.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    //MARK: UIVIEW
    func setUIView() {
        
        //DropDown
        magWheelTextField.autocorrectionType = .no
        normalWheelTextField.autocorrectionType = .no
        
        //UITextField
        tireTextField.autocorrectionType = .no
        tireQualityTextField.autocorrectionType = .no
        damageDetailTextField.autocorrectionType = .no
        
        tireTextField.delegate = self
        tireQualityTextField.delegate = self
        damageDetailTextField.delegate = self
        
        addTarget(from: magWheelTextField)
        addTarget(from: normalWheelTextField)
        
        addTarget(from: tireTextField)
        addTarget(from: tireQualityTextField)
        
    }
    fileprivate func addTarget(from textfield: UITextField ){
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .editingChanged)
    }
    
    
    //MARK: RADIO
    func setUpRadio(){
        let attributedString = [NSAttributedString.Key.foregroundColor : UIColor.appPrimaryColor]
        
        //Color
        qualityColorRadio.attributedTitles = [
            NSAttributedString(string: "ดี",
                               attributes: attributedString),
            NSAttributedString(string: "ปานกลาง",
                               attributes: attributedString),
            NSAttributedString(string: "พอใช้",
                               attributes: attributedString),
            NSAttributedString(string: "แย่",
                               attributes: attributedString)
        ]
        
        //overall
        qualityOverallRadio.attributedTitles = [
            NSAttributedString(string: "เยี่ยม",
                               attributes: attributedString),
            NSAttributedString(string: "ดีมาก",
                               attributes: attributedString),
            NSAttributedString(string: "ปานกลาง",
                               attributes: attributedString),
            NSAttributedString(string: "พอใช้",
                               attributes: attributedString),
            NSAttributedString(string: "แย่",
                               attributes: attributedString),
            NSAttributedString(string: "ตามสภาพ",
                               attributes: attributedString),
            NSAttributedString(string: "ซาก",
                               attributes: attributedString)
        ]
    }
    @IBAction func overallValueChange(_ sender: Any) {
        var selectString:String? = nil
        switch qualityOverallRadio.selectedIndex {
        case 0:
            selectString = "เยี่ยม"
        case 1:
            selectString = "ดีมาก"
        case 2:
            selectString = "ปานกลาง"
        case 3:
            selectString = "พอใช้"
        case 4:
            selectString = "แย่"
        case 5:
            selectString = "ตามสภาพ"
        case 6:
            selectString = "ซาก"
        default:
            return
        }
        DataController.shared.receiverCarModel.externalOverall = selectString
        let gradeOverallId = qualityOverallRadio.selectedIndex + 1
        DataController.shared.receiverCarModel.gradeOverallId = gradeOverallId
        
        
        
        // redbookCondition for salvage
        if DataController.shared.bookInType == .CARWRECK {
            
            switch qualityOverallRadio.selectedIndex {
            case 0:
                DataController.shared.receiverCarModel.redBookCondition = "E"
            case 1:
                DataController.shared.receiverCarModel.redBookCondition = "G"
            case 2:
                DataController.shared.receiverCarModel.redBookCondition = "A"
            case 3:
                DataController.shared.receiverCarModel.redBookCondition = "F"
            case 4:
                DataController.shared.receiverCarModel.redBookCondition = "P"
            case 5:
                DataController.shared.receiverCarModel.redBookCondition = "X"
            case 6:
                DataController.shared.receiverCarModel.redBookCondition = "Y"
            default:
                return
            }
        }
        
    }
    @IBAction func qualityColorValueChange(_ sender: Any) {
        var selectString:String? = nil
        switch qualityColorRadio.selectedIndex {
        case 0:
            selectString = "ดี"
        case 1:
            selectString = "ปานกลาง"
        case 2:
            selectString = "พอใช้"
        case 3:
            selectString = "แย่"
        default:
            return
        }
        DataController.shared.receiverCarModel.colorOverall = selectString
        let colorOverallId = qualityColorRadio.selectedIndex + 1
        DataController.shared.receiverCarModel.colorOverallId = colorOverallId
    }
    
    
    //MARK: Dropdown
    func setUpDropdown(){
        magWheelTextField.optionArray = ["1", "2", "3", "4"]
        magWheelTextField.didSelect { [weak self] (selected, _, _) in
            
            DataController.shared.receiverCarModel.magWheelAmount = selected
            DataController.shared.receiverCarModel.isMagWheel = true
            
            self?.magWheelTextField.text = selected
            
            let request = ExternalCar.Something.Request(validateWheel: selected)
            self?.interactor?.validateWheel(request: request)
        }
        
        normalWheelTextField.optionArray = ["1", "2", "3", "4"]
        normalWheelTextField.didSelect { [weak self] (selected, _, _) in
            
            DataController.shared.receiverCarModel.normalWheelAmount = selected
            DataController.shared.receiverCarModel.isNormalWheel = true
            
            self?.normalWheelTextField.text = selected
            
            let request = ExternalCar.Something.Request(validateNormalWheel: selected)
            self?.interactor?.validateNormalWheel(request: request)
        }
    }
    
    //MARK: CheckBox
    @IBAction func spoilerTapped(_ sender: Any) {
        spoilerCheckBox.toggle { check in
            DataController.shared.receiverCarModel.isSpoiler = check
            
        }
    }
    @IBAction func magWheelTapped(_ sender: Any) {
        magWheelCheckBox.toggle { [weak self] check in
            if !check {
                self?.magWheelTextField.text = ""
                DataController.shared.receiverCarModel.magWheelAmount = nil
            }
            DataController.shared.receiverCarModel.isMagWheel = check
        }
    }
    @IBAction func normalWheelTapped(_ sender: Any){
        normalWheelCheckBox.toggle { [weak self] check in
            if !check {
                self?.normalWheelTextField.text = ""
                DataController.shared.receiverCarModel.normalWheelAmount = nil
            }
            DataController.shared.receiverCarModel.isNormalWheel = check
        }
    }
    
    @IBAction func tireTapped(_ sender: Any) {
        tireCheckBox.toggle { [weak self] check in
            if !check {
                self?.tireTextField.text = ""
                self?.tireQualityTextField.text = ""
                DataController.shared.receiverCarModel.tireQuality = nil
                DataController.shared.receiverCarModel.brandTire = nil
            }
            DataController.shared.receiverCarModel.isTire = check
        }
    }
    
    func displayTireCheckBox(viewModel: ExternalCar.Something.ViewModel) {
        tireCheckBox.check = viewModel.isTire ?? false
        DataController.shared.receiverCarModel.isTire = viewModel.isTire ?? false
    }
    func displayMagWheelCheckBox(viewModel: ExternalCar.Something.ViewModel) {
        magWheelCheckBox.check = viewModel.isMagWheel ?? false
        DataController.shared.receiverCarModel.isMagWheel = viewModel.isMagWheel ?? false
    }
    func displayNormalWheelCheckBox(viewModel: ExternalCar.Something.ViewModel) {
        normalWheelCheckBox.check = viewModel.isNormalWheel ?? false
        DataController.shared.receiverCarModel.isNormalWheel = viewModel.isNormalWheel ?? false
    }
    
    
    //MARK: TextField
    func displayValidateResultTireTextField(viewModel: ExternalCar.Something.ViewModel) {
        tireQualityTextField.text = viewModel.validateNumberResult
        DataController.shared.receiverCarModel.tireQuality = viewModel.validateNumberResult
    }

    
    @objc func prepareData(){
        //MARK: External
        let model = DataController.shared.receiverCarModel
        let gradeOverallValue = ["เยี่ยม", "ดีมาก", "ปานกลาง", "พอใช้", "แย่", "ตามสภาพ" ,"ซาก"]
        let colorOverallValue = ["ดี", "ปานกลาง", "พอใช้" ,"แย่"]
        
       
        qualityColorRadio.selectedIndex = getRadioIndexByValue(from: colorOverallValue, value: model.colorOverall)
        
        qualityOverallRadio.selectedIndex = getRadioIndexByValue(from: gradeOverallValue, value: model.externalOverall)
        
        spoilerCheckBox.check = model.isSpoiler ?? false
        magWheelCheckBox.check = model.isMagWheel
        normalWheelCheckBox.check = model.isNormalWheel
        tireCheckBox.check = model.isTire ?? false
        
        magWheelTextField.text = model.magWheelAmount
        normalWheelTextField.text = model.normalWheelAmount

        tireTextField.text = model.brandTire
        tireQualityTextField.text = model.tireQuality
        damageDetailTextField.text = model.damageDetail
        
    }
    @objc func updateView(){
        let isEnabled = getEnableView()
        qualityColorRadio.setEnableView(isEnable: isEnabled)
        qualityOverallRadio.setEnableView(isEnable: isEnabled)
        
        spoilerCheckBox.setEnableView(isEnable: isEnabled)
        magWheelCheckBox.setEnableView(isEnable: isEnabled)
        normalWheelCheckBox.setEnableView(isEnable: isEnabled)
        tireCheckBox.setEnableView(isEnable: isEnabled)
        
        magWheelTextField.setEnableView(isEnable: isEnabled)
        normalWheelTextField.setEnableView(isEnable: isEnabled)
        tireTextField.setEnableView(isEnable: isEnabled)
        tireQualityTextField.setEnableView(isEnable: isEnabled)
        damageDetailTextField.setEnableView(isEnable: isEnabled)
        
        
    }
}

extension ExternalCarViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //print(textView.text)
        
        DataController.shared.receiverCarModel.damageDetail = textView.text
    }
}
// MARK: UITextFieldDelegate
extension ExternalCarViewController : UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        //print(textField.text)
        
        switch textField {
  
        case tireQualityTextField:
            let request = ExternalCar.Something.Request(validateNumber: textField.text)
            self.interactor?.validateNumber(request: request)
            
        case tireTextField:
            DataController.shared.receiverCarModel.brandTire = textField.text
            let request = ExternalCar.Something.Request(tire: textField.text)
            self.interactor?.checkTire(request: request)
            
        
        
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
extension ExternalCarViewController {
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       scrollView.registKeyboardNotification()
    
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
