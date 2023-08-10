//
//  SteerWheelCheckViewController.swift
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
import RadioGroup

protocol SteerWheelCheckDisplayLogic: AnyObject
{
    func displaySomething(viewModel: SteerWheelCheck.Something.ViewModel)
}

class SteerWheelCheckViewController: ViewController, SteerWheelCheckDisplayLogic
{
    var interactor: SteerWheelCheckBusinessLogic?
    var router: (NSObjectProtocol & SteerWheelCheckRoutingLogic & SteerWheelCheckDataPassing)?
    
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
        let interactor = SteerWheelCheckInteractor()
        let presenter = SteerWheelCheckPresenter()
        let router = SteerWheelCheckRouter()
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
        setRadio()
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var steerWheelPowerCheckBox: CheckBoxUIButton!
    @IBOutlet weak var steerWheelSystemRadio: RadioGroup!
    @IBOutlet weak var summarysteerWheelSystemTextField: MultilineTextField!
    
    // local strings
    @IBOutlet weak var steeringSystemLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    override func initLocalString() {
        super.initLocalString()
        
        steeringSystemLabel.text = String.localized("inspection_steering_system_label")
        powerLabel.text = String.localized("inspection_steering_power_label")
        summaryLabel.text = String.localized("inspection_steering_summary_label")
        summarysteerWheelSystemTextField.placeholder = summaryLabel.text
    }
    
    func doSomething()
    {
        let request = SteerWheelCheck.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: SteerWheelCheck.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    //MARK: UIView
    func setUIView(){
        summarysteerWheelSystemTextField.autocorrectionType = .no
        summarysteerWheelSystemTextField.delegate = self
        
    }
    
    
    //MARK: Checkbox
    @IBAction func steerWheelPowerTapped(_ sender: Any) {
        steerWheelPowerCheckBox.toggle { check in
            DataController.shared.inspectionCarModel.isSteerWheelPower = check
        }
    }
    
    //MARK: Radio
    func setRadio(){
        let attributedString = [NSAttributedString.Key.foregroundColor : UIColor.appPrimaryColor]
        
        steerWheelSystemRadio.attributedTitles = [
            NSAttributedString(
                string: string_inspection_engine_working, attributes: attributedString),
            NSAttributedString(
                string: string_inspection_engine_not_working, attributes: attributedString)
        ]
    }
    @IBAction func steerWheelSystemValueChanged(_ sender: Any) {
        let value = getRadioValue(from: [string_inspection_engine_working, string_inspection_engine_not_working],
                                  selectIndex: steerWheelSystemRadio.selectedIndex)
        
        DataController.shared.inspectionCarModel.steerWheelSystem = value
        
        let isUseableSteerWheel = steerWheelSystemRadio.selectedIndex == 0 ? true : false
        DataController.shared.inspectionCarModel.isUseableSteerWheel = isUseableSteerWheel
    }
    
    func prepareData(){
        let model = DataController.shared.inspectionCarModel
        summarysteerWheelSystemTextField.text = model.summarySteerWheelSystem
        steerWheelPowerCheckBox.check = model.isSteerWheelPower
        steerWheelSystemRadio.selectedIndex = getRadioIndexByValue(from: [string_inspection_engine_working, string_inspection_engine_not_working],
                                                                   value: model.steerWheelSystem)
        
    }
}




//MARK: TextView Delegate
extension SteerWheelCheckViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //print(textView.text)
        
        DataController.shared.inspectionCarModel.summarySteerWheelSystem = textView.text
    }
}

extension SteerWheelCheckViewController {
    
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
