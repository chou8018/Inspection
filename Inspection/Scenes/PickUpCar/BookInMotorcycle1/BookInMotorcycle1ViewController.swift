//
//  BookInMotorcycle1ViewController.swift
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
import RadioGroup


protocol BookInMotorcycle1DisplayLogic: AnyObject
{
  func displaySomething(viewModel: BookInMotorcycle1.Something.ViewModel)
}

class BookInMotorcycle1ViewController: UIViewController, BookInMotorcycle1DisplayLogic
{
  var interactor: BookInMotorcycle1BusinessLogic?
  var router: (NSObjectProtocol & BookInMotorcycle1RoutingLogic & BookInMotorcycle1DataPassing)?

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
    let interactor = BookInMotorcycle1Interactor()
    let presenter = BookInMotorcycle1Presenter()
    let router = BookInMotorcycle1Router()
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
    setUpRadio()
    setDropdown()
    setUITextField()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var frontWheelRadio: RadioGroup!
    @IBOutlet weak var frontBrakeRadio: RadioGroup!
    @IBOutlet weak var rearWheelRadio: RadioGroup!
    @IBOutlet weak var rearBrakeRadio: RadioGroup!
    
    
    @IBOutlet weak var rearTurnSignalRDropDown: DropDown!
    @IBOutlet weak var bodyCladdingRDropDown: DropDown!
    @IBOutlet weak var exhaustPipeDropDown: DropDown!
    @IBOutlet weak var rearFootRestDropDown: DropDown!
    @IBOutlet weak var starterLeverDropDown: DropDown!
    @IBOutlet weak var frontFootRestDropDown: DropDown!
    @IBOutlet weak var sideStandDropDown: DropDown!
    @IBOutlet weak var doubleStandDropDown: DropDown!
    @IBOutlet weak var windScreenRDropDown: DropDown!
    @IBOutlet weak var multiPurposeRDropDown: DropDown!
    @IBOutlet weak var mirrorRDropDown: DropDown!
    @IBOutlet weak var handBreakRDropDown: DropDown!
    @IBOutlet weak var milesDisplayDropDown: DropDown!
    @IBOutlet weak var maskDropDown: DropDown!
    @IBOutlet weak var frontLightDropDown: DropDown!
    @IBOutlet weak var frontTurnSignalRDropDown: DropDown!
    @IBOutlet weak var frontFenderDropDown: DropDown!
    @IBOutlet weak var frontTireDropDown: DropDown!
    @IBOutlet weak var frontPumpDiscBrakesDropdown: DropDown!
    @IBOutlet weak var frontOilTankDiscBrakesDropdown: DropDown!
    @IBOutlet weak var frontShockupDropdown: DropDown!
    @IBOutlet weak var chainCoverDropdown: DropDown!
    @IBOutlet weak var handBreakLDropDown: DropDown!
    @IBOutlet weak var handClutchDropDown: DropDown!
    @IBOutlet weak var frontTurnSignalLDropDown: DropDown!
    @IBOutlet weak var mirrorLDropDown: DropDown!
    @IBOutlet weak var windScreenLDropDown: DropDown!
    @IBOutlet weak var bodyCladdingLDropDown: DropDown!
    @IBOutlet weak var seatDropDown: DropDown!
    @IBOutlet weak var rearSeatRackDropDown: DropDown!
    @IBOutlet weak var rearTurnSignalLDropDown: DropDown!
    @IBOutlet weak var rearLightDropDown: DropDown!
    @IBOutlet weak var rearFenderDropDown: DropDown!
    @IBOutlet weak var multiPurposeLDropDown: DropDown!
    @IBOutlet weak var rearTireDropDown: DropDown!
    @IBOutlet weak var rearPumpDiscBrakesDropdown: DropDown!
    @IBOutlet weak var rearOilTankDiscBrakesDropdown: DropDown!
    @IBOutlet weak var rearShockupDropdown: DropDown!
    @IBOutlet weak var uboxDropdown: DropDown!
    @IBOutlet weak var oilTankDropdown: DropDown!
    @IBOutlet weak var batteryDropdown: DropDown!
    @IBOutlet weak var cdiBoxDropdown: DropDown!
    @IBOutlet weak var toolSpareDropdown: DropDown!
    @IBOutlet weak var frontWheelDropdown: DropDown!
    @IBOutlet weak var rearWheelDropdown: DropDown!
    @IBOutlet weak var frontBrakeDropdown: DropDown!
    @IBOutlet weak var rearBrakeDropdown: DropDown!
    
    @IBOutlet weak var otherNoteTextField: MultilineTextField!
    
  func doSomething()
  {
    let request = BookInMotorcycle1.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: BookInMotorcycle1.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
   
    //MARK:Dropdown
    func setDropdown(){
        let values = ["พอใช้", "ครูด", "แตก", "ไม่มี"]

        setValue(to: rearTurnSignalRDropDown, values: values) {[weak self] (selectValue)  in
            self?.rearTurnSignalRDropDown.text = selectValue
            DataController.shared.receiverCarModel.rearTurnSignalR = selectValue
        }
        setValue(to: bodyCladdingRDropDown, values: values) {[weak self] (selectValue)  in
            self?.bodyCladdingRDropDown.text = selectValue
            DataController.shared.receiverCarModel.bodyCladdingR = selectValue
        }
        setValue(to: exhaustPipeDropDown, values: values) {[weak self] (selectValue)  in
            self?.exhaustPipeDropDown.text = selectValue
            DataController.shared.receiverCarModel.exhaustPipe = selectValue
        }
        setValue(to: rearFootRestDropDown, values: values) {[weak self] (selectValue)  in
            self?.rearFootRestDropDown.text = selectValue
            DataController.shared.receiverCarModel.rearFootRest = selectValue
        }
        setValue(to: starterLeverDropDown, values: values) {[weak self] (selectValue)  in
            self?.starterLeverDropDown.text = selectValue
            DataController.shared.receiverCarModel.starterLever = selectValue
        }
        setValue(to: frontFootRestDropDown, values: values) {[weak self] (selectValue)  in
            self?.frontFootRestDropDown.text = selectValue
            DataController.shared.receiverCarModel.frontFootRest = selectValue
        }
        setValue(to: sideStandDropDown, values: values) {[weak self] (selectValue)  in
            self?.sideStandDropDown.text = selectValue
            DataController.shared.receiverCarModel.sideStand = selectValue
        }
        setValue(to: doubleStandDropDown, values: values) {[weak self] (selectValue)  in
            self?.doubleStandDropDown.text = selectValue
            DataController.shared.receiverCarModel.doubleStand = selectValue
        }
        setValue(to: windScreenRDropDown, values: values) {[weak self] (selectValue)  in
            self?.windScreenRDropDown.text = selectValue
            DataController.shared.receiverCarModel.windScreenR = selectValue
        }
        setValue(to: multiPurposeRDropDown, values: values) {[weak self] (selectValue)  in
            self?.multiPurposeRDropDown.text = selectValue
            DataController.shared.receiverCarModel.multiPurposeR = selectValue
        }
        setValue(to: mirrorRDropDown, values: values) {[weak self] (selectValue)  in
            self?.mirrorRDropDown.text = selectValue
            DataController.shared.receiverCarModel.mirrorR = selectValue
        }
        setValue(to: handBreakRDropDown, values: values) {[weak self] (selectValue)  in
            self?.handBreakRDropDown.text = selectValue
            DataController.shared.receiverCarModel.handBreakR = selectValue
        }
        setValue(to: milesDisplayDropDown, values: values) {[weak self] (selectValue)  in
            self?.milesDisplayDropDown.text = selectValue
            DataController.shared.receiverCarModel.milesDisplay = selectValue
        }
        setValue(to: maskDropDown, values: values) {[weak self] (selectValue)  in
            self?.maskDropDown.text = selectValue
            DataController.shared.receiverCarModel.mask = selectValue
        }
        setValue(to: frontLightDropDown, values: values) {[weak self] (selectValue)  in
            self?.frontLightDropDown.text = selectValue
            DataController.shared.receiverCarModel.frontLight = selectValue
        }
        setValue(to: frontTurnSignalRDropDown, values: values) {[weak self] (selectValue)  in
            self?.frontTurnSignalRDropDown.text = selectValue
            DataController.shared.receiverCarModel.frontTurnSignalR = selectValue
        }
        setValue(to: frontFenderDropDown, values: values) {[weak self] (selectValue)  in
            self?.frontFenderDropDown.text = selectValue
            DataController.shared.receiverCarModel.frontFender = selectValue
        }
        setValue(to: frontTireDropDown, values: values) {[weak self] (selectValue)  in
            self?.frontTireDropDown.text = selectValue
            DataController.shared.receiverCarModel.frontTire = selectValue
        }
        setValue(to: frontPumpDiscBrakesDropdown, values: values) {[weak self] (selectValue)  in
            self?.frontPumpDiscBrakesDropdown.text = selectValue
            DataController.shared.receiverCarModel.frontPumpDiscBrakes = selectValue
        }
        setValue(to: frontOilTankDiscBrakesDropdown, values: values) {[weak self] (selectValue)  in
            self?.frontOilTankDiscBrakesDropdown.text = selectValue
            DataController.shared.receiverCarModel.frontOilTankDiscBrakes = selectValue
        }
        setValue(to: frontShockupDropdown, values: values) {[weak self] (selectValue)  in
            self?.frontShockupDropdown.text = selectValue
            DataController.shared.receiverCarModel.frontShockup = selectValue
        }
        setValue(to: chainCoverDropdown, values: values) {[weak self] (selectValue)  in
            self?.chainCoverDropdown.text = selectValue
            DataController.shared.receiverCarModel.chainCover = selectValue
        }
        setValue(to: handBreakLDropDown, values: values) {[weak self] (selectValue)  in
            self?.handBreakLDropDown.text = selectValue
            DataController.shared.receiverCarModel.handBreakL = selectValue
        }
        setValue(to: handClutchDropDown, values: values) {[weak self] (selectValue)  in
            self?.handClutchDropDown.text = selectValue
            DataController.shared.receiverCarModel.handClutch = selectValue
        }
        setValue(to: frontTurnSignalLDropDown, values: values) {[weak self] (selectValue)  in
            self?.frontTurnSignalLDropDown.text = selectValue
            DataController.shared.receiverCarModel.frontTurnSignalL = selectValue
        }
        setValue(to: mirrorLDropDown, values: values) {[weak self] (selectValue)  in
            self?.mirrorLDropDown.text = selectValue
            DataController.shared.receiverCarModel.mirrorL = selectValue
        }
        setValue(to: windScreenLDropDown, values: values) {[weak self] (selectValue)  in
            self?.windScreenLDropDown.text = selectValue
            DataController.shared.receiverCarModel.windScreenL = selectValue
        }
        setValue(to: bodyCladdingLDropDown, values: values) {[weak self] (selectValue)  in
            self?.bodyCladdingLDropDown.text = selectValue
            DataController.shared.receiverCarModel.bodyCladdingL = selectValue
        }
        setValue(to: seatDropDown, values: values) {[weak self] (selectValue)  in
            self?.seatDropDown.text = selectValue
            DataController.shared.receiverCarModel.seat = selectValue
        }
        setValue(to: rearSeatRackDropDown, values: values) {[weak self] (selectValue)  in
            self?.rearSeatRackDropDown.text = selectValue
            DataController.shared.receiverCarModel.rearSeatRack = selectValue
        }
        setValue(to: rearTurnSignalLDropDown, values: values) {[weak self] (selectValue)  in
            self?.rearTurnSignalLDropDown.text = selectValue
            DataController.shared.receiverCarModel.rearTurnSignalL = selectValue
        }
        setValue(to: rearLightDropDown, values: values) {[weak self] (selectValue)  in
            self?.rearLightDropDown.text = selectValue
            DataController.shared.receiverCarModel.rearLight = selectValue
        }
        setValue(to: rearFenderDropDown, values: values) {[weak self] (selectValue)  in
            self?.rearFenderDropDown.text = selectValue
            DataController.shared.receiverCarModel.rearFender = selectValue
        }
        setValue(to: multiPurposeLDropDown, values: values) {[weak self] (selectValue)  in
            self?.multiPurposeLDropDown.text = selectValue
            DataController.shared.receiverCarModel.multiPurposeL = selectValue
        }
        setValue(to: rearTireDropDown, values: values) {[weak self] (selectValue)  in
            self?.rearTireDropDown.text = selectValue
            DataController.shared.receiverCarModel.rearTire = selectValue
        }
        setValue(to: rearPumpDiscBrakesDropdown, values: values) {[weak self] (selectValue)  in
            self?.rearPumpDiscBrakesDropdown.text = selectValue
            DataController.shared.receiverCarModel.rearPumpDiscBrakes = selectValue
        }
        setValue(to: rearOilTankDiscBrakesDropdown, values: values) {[weak self] (selectValue)  in
            self?.rearOilTankDiscBrakesDropdown.text = selectValue
            DataController.shared.receiverCarModel.rearOilTankDiscBrakes = selectValue
        }
        setValue(to: rearShockupDropdown, values: values) {[weak self] (selectValue)  in
            self?.rearShockupDropdown.text = selectValue
            DataController.shared.receiverCarModel.rearShockup = selectValue
        }
        setValue(to: uboxDropdown, values: values) {[weak self] (selectValue)  in
            self?.uboxDropdown.text = selectValue
            DataController.shared.receiverCarModel.ubox = selectValue
        }
        setValue(to: oilTankDropdown, values: values) {[weak self] (selectValue)  in
            self?.oilTankDropdown.text = selectValue
            DataController.shared.receiverCarModel.oilTank = selectValue
        }
        setValue(to: batteryDropdown, values: values) {[weak self] (selectValue)  in
            self?.batteryDropdown.text = selectValue
            DataController.shared.receiverCarModel.battery = selectValue
        }
        setValue(to: cdiBoxDropdown, values: values) {[weak self] (selectValue)  in
            self?.cdiBoxDropdown.text = selectValue
            DataController.shared.receiverCarModel.cdiBox = selectValue
        }
        setValue(to: toolSpareDropdown, values: values) {[weak self] (selectValue)  in
            self?.toolSpareDropdown.text = selectValue
            DataController.shared.receiverCarModel.toolSpare = selectValue
        }
        setValue(to: frontWheelDropdown, values: values) {[weak self] (selectValue)  in
            self?.frontWheelDropdown.text = selectValue
            DataController.shared.receiverCarModel.frontWheel = selectValue
        }
        setValue(to: rearWheelDropdown, values: values) {[weak self] (selectValue)  in
            self?.rearWheelDropdown.text = selectValue
            DataController.shared.receiverCarModel.rearWheel = selectValue
        }
        setValue(to: frontBrakeDropdown, values: values) {[weak self] (selectValue)  in
            self?.frontBrakeDropdown.text = selectValue
            DataController.shared.receiverCarModel.frontBrake = selectValue
        }
        setValue(to: rearBrakeDropdown, values: values) {[weak self] (selectValue)  in
            self?.rearBrakeDropdown.text = selectValue
            DataController.shared.receiverCarModel.rearBrake = selectValue
        }
        
        
    }
    
    
    func setValue(to dropdown:DropDown, values: [String], didSelected:@escaping (_ selectedText: String)->() ){
        dropdown.optionArray = values
        dropdown.didSelect { selectedText, index, id in
            didSelected(selectedText)
        }
    }
    
    
    //MARK: RADIO
    func setUpRadio(){
        let attributedString = [NSAttributedString.Key.foregroundColor : UIColor.appPrimaryColor]
        
        frontWheelRadio.attributedTitles = [
            NSAttributedString(string: "ซี่ลวด",
                               attributes: attributedString),
            NSAttributedString(string: "แม็กซ์",
                               attributes: attributedString)
        ]
     
        frontBrakeRadio.attributedTitles = [
            NSAttributedString(string: "ดิส",
                               attributes: attributedString),
            NSAttributedString(string: "ดรั้ม",
                               attributes: attributedString)
        ]
        rearWheelRadio.attributedTitles = [
            NSAttributedString(string: "ซี่ลวด",
                               attributes: attributedString),
            NSAttributedString(string: "แม็กซ์",
                               attributes: attributedString)
        ]
        rearBrakeRadio.attributedTitles = [
            NSAttributedString(string: "ดิส",
                               attributes: attributedString),
            NSAttributedString(string: "ดรั้ม",
                               attributes: attributedString)
        ]
    }
    @IBAction func frontWheelValueChange(_ sender: Any) {
        var selectString:String? = nil
        switch frontWheelRadio.selectedIndex {
        case 0:
            selectString = "ซี่ลวด"
        case 1:
            selectString = "แม็กซ์"
        
        default:
            return
        }
        print("🔸 frontWheel \(selectString)")
        DataController.shared.receiverCarModel.frontWheelType = selectString
    }
      
    @IBAction func frontBrakeValueChange(_ sender: Any) {
        var selectString:String? = nil
        switch frontBrakeRadio.selectedIndex {
        case 0:
            selectString = "ดิส"
        case 1:
            selectString = "ดรั้ม"
        
        default:
            return
        }
        print("🔸 frontBrake \(selectString)")
        DataController.shared.receiverCarModel.frontBrakeType = selectString
    }
    
    @IBAction func rearWheelValueChange(_ sender: Any) {
        var selectString:String? = nil
        switch rearWheelRadio.selectedIndex {
        case 0:
            selectString = "ซี่ลวด"
        case 1:
            selectString = "แม็กซ์"
        
        default:
            return
        }
        print("🔸 rearWheel \(selectString)")
        DataController.shared.receiverCarModel.rearWheelType = selectString
    }
    
    @IBAction func rearBrakeValueChange(_ sender: Any) {
        var selectString:String? = nil
        switch rearBrakeRadio.selectedIndex {
        case 0:
            selectString = "ดิส"
        case 1:
            selectString = "ดรั้ม"
        
        default:
            return
        }
        print("🔸 rearBrake \(selectString)")
        DataController.shared.receiverCarModel.rearBrakeType = selectString
    }
    
    
     //MARK:UITextField
     func setUITextField(){
        otherNoteTextField.autocorrectionType = .no
        otherNoteTextField.delegate = self
     }
    
    func prepareData(){
        let wheelValue = ["ซี่ลวด", "แม็กซ์"]
        let brakeValue = ["ดิส", "ดรั้ม"]
        let model = DataController.shared.receiverCarModel
        frontWheelRadio.selectedIndex = getRadioIndexByValue(from: wheelValue, value: model.frontWheelType)
        
        frontBrakeRadio.selectedIndex = getRadioIndexByValue(from: brakeValue, value: model.frontBrakeType)
        
        rearWheelRadio.selectedIndex = getRadioIndexByValue(from: wheelValue, value: model.rearWheelType)
        
        rearBrakeRadio.selectedIndex = getRadioIndexByValue(from: brakeValue, value: model.rearBrakeType)
        

        rearTurnSignalRDropDown.text = model.rearTurnSignalR
        bodyCladdingRDropDown.text = model.bodyCladdingR
        exhaustPipeDropDown.text = model.exhaustPipe
        rearFootRestDropDown.text = model.rearFootRest
        starterLeverDropDown.text = model.starterLever
        frontFootRestDropDown.text = model.frontFootRest
        sideStandDropDown.text = model.sideStand
        doubleStandDropDown.text = model.doubleStand
        windScreenRDropDown.text = model.windScreenR
        multiPurposeRDropDown.text = model.multiPurposeR
        mirrorRDropDown.text = model.mirrorR
        handBreakRDropDown.text = model.handBreakR
        milesDisplayDropDown.text = model.milesDisplay
        maskDropDown.text = model.mask
        frontLightDropDown.text = model.frontLight
        frontTurnSignalRDropDown.text = model.frontTurnSignalR
        frontFenderDropDown.text = model.frontFender
        frontTireDropDown.text = model.frontTire
        frontPumpDiscBrakesDropdown.text = model.frontPumpDiscBrakes
        frontOilTankDiscBrakesDropdown.text = model.frontOilTankDiscBrakes
        frontShockupDropdown.text = model.frontShockup
        chainCoverDropdown.text = model.chainCover
        handBreakLDropDown.text = model.handBreakL
        handClutchDropDown.text = model.handClutch
        frontTurnSignalLDropDown.text = model.frontTurnSignalL
        mirrorLDropDown.text = model.mirrorL
        windScreenLDropDown.text = model.windScreenL
        bodyCladdingLDropDown.text = model.bodyCladdingL
        seatDropDown.text = model.seat
        rearSeatRackDropDown.text = model.rearSeatRack
        rearTurnSignalLDropDown.text = model.rearTurnSignalL
        rearLightDropDown.text = model.rearLight
        rearFenderDropDown.text = model.rearFender
        multiPurposeLDropDown.text = model.multiPurposeL
        rearTireDropDown.text = model.rearTire
        rearPumpDiscBrakesDropdown.text = model.rearPumpDiscBrakes
        rearOilTankDiscBrakesDropdown.text = model.rearOilTankDiscBrakes
        rearShockupDropdown.text = model.rearShockup
        uboxDropdown.text = model.ubox
        oilTankDropdown.text = model.oilTank
        batteryDropdown.text = model.battery
        cdiBoxDropdown.text = model.cdiBox
        toolSpareDropdown.text = model.toolSpare
        frontWheelDropdown.text = model.frontWheel
        rearWheelDropdown.text = model.rearWheel
        frontBrakeDropdown.text = model.frontBrake
        rearBrakeDropdown.text = model.rearBrake
        otherNoteTextField.text = model.otherNote
    }
    
}

//MARK: keyboard
extension BookInMotorcycle1ViewController {
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

//MARK: TextView Delegate
extension BookInMotorcycle1ViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("note textfield: \(textView.text)")
        DataController.shared.receiverCarModel.otherNote = textView.text
        DataController.shared.inspectionCarModel.exteriorDamage = textView.text
    }
    
    //MARK: set all
    func setSelectionAll(with selectValue:String){
    
        rearTurnSignalRDropDown.text = selectValue
        DataController.shared.receiverCarModel.rearTurnSignalR = selectValue
        
        bodyCladdingRDropDown.text = selectValue
        DataController.shared.receiverCarModel.bodyCladdingR = selectValue
        
        exhaustPipeDropDown.text = selectValue
        DataController.shared.receiverCarModel.exhaustPipe = selectValue
        
        rearFootRestDropDown.text = selectValue
        DataController.shared.receiverCarModel.rearFootRest = selectValue
        
        starterLeverDropDown.text = selectValue
        DataController.shared.receiverCarModel.starterLever = selectValue
        
        frontFootRestDropDown.text = selectValue
        DataController.shared.receiverCarModel.frontFootRest = selectValue
        
        sideStandDropDown.text = selectValue
        DataController.shared.receiverCarModel.sideStand = selectValue
        
        doubleStandDropDown.text = selectValue
        DataController.shared.receiverCarModel.doubleStand = selectValue
        
        windScreenRDropDown.text = selectValue
        DataController.shared.receiverCarModel.windScreenR = selectValue
        
        multiPurposeRDropDown.text = selectValue
        DataController.shared.receiverCarModel.multiPurposeR = selectValue
        
        mirrorRDropDown.text = selectValue
        DataController.shared.receiverCarModel.mirrorR = selectValue
        
        handBreakRDropDown.text = selectValue
        DataController.shared.receiverCarModel.handBreakR = selectValue
        
        milesDisplayDropDown.text = selectValue
        DataController.shared.receiverCarModel.milesDisplay = selectValue
        
        maskDropDown.text = selectValue
        DataController.shared.receiverCarModel.mask = selectValue
        
        frontLightDropDown.text = selectValue
        DataController.shared.receiverCarModel.frontLight = selectValue
        
        frontTurnSignalRDropDown.text = selectValue
        DataController.shared.receiverCarModel.frontTurnSignalR = selectValue
        
        frontFenderDropDown.text = selectValue
        DataController.shared.receiverCarModel.frontFender = selectValue
        
        frontTireDropDown.text = selectValue
        DataController.shared.receiverCarModel.frontTire = selectValue
        
        frontPumpDiscBrakesDropdown.text = selectValue
        DataController.shared.receiverCarModel.frontPumpDiscBrakes = selectValue
        
        frontOilTankDiscBrakesDropdown.text = selectValue
        DataController.shared.receiverCarModel.frontOilTankDiscBrakes = selectValue
        
        frontShockupDropdown.text = selectValue
        DataController.shared.receiverCarModel.frontShockup = selectValue
        
        chainCoverDropdown.text = selectValue
        DataController.shared.receiverCarModel.chainCover = selectValue
        
        handBreakLDropDown.text = selectValue
        DataController.shared.receiverCarModel.handBreakL = selectValue
        
        handClutchDropDown.text = selectValue
        DataController.shared.receiverCarModel.handClutch = selectValue
        
        frontTurnSignalLDropDown.text = selectValue
        DataController.shared.receiverCarModel.frontTurnSignalL = selectValue
        
        mirrorLDropDown.text = selectValue
        DataController.shared.receiverCarModel.mirrorL = selectValue
        
        windScreenLDropDown.text = selectValue
        DataController.shared.receiverCarModel.windScreenL = selectValue
        
        bodyCladdingLDropDown.text = selectValue
        DataController.shared.receiverCarModel.bodyCladdingL = selectValue
        
        seatDropDown.text = selectValue
        DataController.shared.receiverCarModel.seat = selectValue
        
        rearSeatRackDropDown.text = selectValue
        DataController.shared.receiverCarModel.rearSeatRack = selectValue
        
        rearTurnSignalLDropDown.text = selectValue
        DataController.shared.receiverCarModel.rearTurnSignalL = selectValue
        
        rearLightDropDown.text = selectValue
        DataController.shared.receiverCarModel.rearLight = selectValue
        
        rearFenderDropDown.text = selectValue
        DataController.shared.receiverCarModel.rearFender = selectValue
        
        multiPurposeLDropDown.text = selectValue
        DataController.shared.receiverCarModel.multiPurposeL = selectValue
        
        rearTireDropDown.text = selectValue
        DataController.shared.receiverCarModel.rearTire = selectValue
        
        rearPumpDiscBrakesDropdown.text = selectValue
        DataController.shared.receiverCarModel.rearPumpDiscBrakes = selectValue
        
        rearOilTankDiscBrakesDropdown.text = selectValue
        DataController.shared.receiverCarModel.rearOilTankDiscBrakes = selectValue
        
        rearShockupDropdown.text = selectValue
        DataController.shared.receiverCarModel.rearShockup = selectValue
        
        uboxDropdown.text = selectValue
        DataController.shared.receiverCarModel.ubox = selectValue
        
        oilTankDropdown.text = selectValue
        DataController.shared.receiverCarModel.oilTank = selectValue
        
        batteryDropdown.text = selectValue
        DataController.shared.receiverCarModel.battery = selectValue
        
        cdiBoxDropdown.text = selectValue
        DataController.shared.receiverCarModel.cdiBox = selectValue
        
        toolSpareDropdown.text = selectValue
        DataController.shared.receiverCarModel.toolSpare = selectValue
        
        frontWheelDropdown.text = selectValue
        DataController.shared.receiverCarModel.frontWheel = selectValue
        
        rearWheelDropdown.text = selectValue
        DataController.shared.receiverCarModel.rearWheel = selectValue
        
        frontBrakeDropdown.text = selectValue
        DataController.shared.receiverCarModel.frontBrake = selectValue
        
        rearBrakeDropdown.text = selectValue
        DataController.shared.receiverCarModel.rearBrake = selectValue
    }
    
}
