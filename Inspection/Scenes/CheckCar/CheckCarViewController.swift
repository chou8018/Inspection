//
//  CheckCarViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 4/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

let inspectionItem0Height = 830.0
let inspectionItem0MBHeight = 1810.0
let inspectionItem1Height = 950.0
let inspectionItem2Height = 520.0
let inspectionItem3Height = 605.0
let inspectionItem4Height = 445.0
let inspectionItem5Height = 365.0
let inspectionItem6Height = 445.0
let inspectionItem7Height = 455.0
let inspectionItem8Height = 810.0

protocol CheckCarDisplayLogic: AnyObject
{
    func displaySomething(viewModel: CheckCar.Something.ViewModel)
    func displayReceiverDayTimeInspection(viewModel: CheckCar.Something.ViewModel)
}

class CheckCarViewController: ViewController, CheckCarDisplayLogic
{
    var interactor: CheckCarBusinessLogic?
    var router: (NSObjectProtocol & CheckCarRoutingLogic & CheckCarDataPassing)?
    
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
        let interactor = CheckCarInteractor()
        let presenter = CheckCarPresenter()
        let router = CheckCarRouter()
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
            
            if let dateTimePicker = segue.destination as? DateTimeViewController {
                dateTimePicker.didSelectedDateTimePicker = { [weak self] (dateInspection) in
                    
                    let request = CheckCar.Something.Request(dateInspection: dateInspection)
                    self?.interactor?.setReceiverDateTimeInspection(request: request)
                }
            }
            
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTitleName()
        setUpTab()
        segmentSetUp()
        setUpDateTime()
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var pickUpStackView: UIView!
    @IBOutlet weak var checkStackView: UIView!
    @IBOutlet weak var photoStackView: UIView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var segmentWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineview: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // local string
    @IBOutlet weak var mainButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pickupCarLabel: UILabel!
    @IBOutlet weak var inspectionLabel: UILabel!
    @IBOutlet weak var photosLabel: UILabel!
    @IBOutlet weak var inspectionDateLabel: UILabel!
    @IBOutlet weak var mainScrollview: UIScrollView!
    
    var isClickedTopItem = false
    
    var lastFrame = CGRectZero
    let item0OffsetY = 0
    let item1OffsetY = inspectionItem0Height
    let item1MBOffsetY = inspectionItem0MBHeight
    let item2OffsetY = inspectionItem0Height + inspectionItem1Height
    let item3OffsetY = inspectionItem0Height + inspectionItem1Height + inspectionItem2Height
    let item4OffsetY = inspectionItem0Height + inspectionItem1Height + inspectionItem2Height + inspectionItem3Height
    let item5OffsetY = inspectionItem0Height + inspectionItem1Height + inspectionItem2Height + inspectionItem3Height + inspectionItem4Height
    let item6OffsetY = inspectionItem0Height + inspectionItem1Height + inspectionItem2Height + inspectionItem3Height + inspectionItem4Height + inspectionItem5Height
    let item7OffsetY = inspectionItem0Height + inspectionItem1Height + inspectionItem2Height + inspectionItem3Height + inspectionItem4Height + inspectionItem5Height + inspectionItem6Height
    let item8OffsetY = inspectionItem0Height + inspectionItem1Height +  inspectionItem2Height + inspectionItem3Height + inspectionItem4Height + inspectionItem5Height + inspectionItem6Height + inspectionItem7Height
    
    override func initLocalString() {
        super.initLocalString()
        saveButton.title = String.localized("main_inspection_save_button_title")
        mainButton.title = String.localized("main_inspection_bar_button_main_title")
        pickupCarLabel.text = String.localized("main_inspection_item_book_in_title")
        inspectionLabel.text = String.localized("main_inspection_item_inspection_title")
        photosLabel.text = String.localized("main_inspection_item_photos_title")
        inspectionDateLabel.text = String.localized("inspection_date_title")

    }
    
    func doSomething()
    {
        let request = CheckCar.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CheckCar.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    @IBAction func toBackView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func toRootView(_ sender: Any) {
        popToRootViewController(confirm: true)
    }
    @IBAction func saveTapped(_ sender: Any){
        switch DataController.shared.bookInType {
            
        case .CAR, .CARWRECK:
            showGradeCar()
        case .MBIKE, .MBIKEWRECK:
            showSummaryCar()
            
        }
        
    }
    func showGradeCar(){
        performSegue(withIdentifier: "showGradeCar", sender: nil)
    }
    
    func showSummaryCar(){
        performSegue(withIdentifier: "showSummaryCar", sender: nil)
    }
    
    //MARK: DateTime
    func setUpDateTime(){
        dateTimeView.isUserInteractionEnabled = true
        dateTimeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDateTime)))
        
    }
    
    func displayReceiverDayTimeInspection(viewModel: CheckCar.Something.ViewModel) {
        guard let dayTime = viewModel.dayTime else { return }
        self.dateLabel.text = dayTime.day
        self.timeLabel.text = dayTime.time
    }
    @objc func showDateTime(){
        performSegue(withIdentifier: "showDateTime", sender: nil)
    }
    
    
    func segmentSetUp(){
        
        segmentView.addSubview(codeSegmented)
        codeSegmented.delegate = self
        
//        updateUIView(from: 0)
        
        switch DataController.shared.bookInType {
        case .CAR, .CARWRECK:
            for i in 0..<9 {
                updateUIView(from: i)
            }
        case .MBIKE, .MBIKEWRECK:
            updateUIView(from: 0)
        }
        self.mainScrollview.delegate = self
    }
    
    
    lazy var codeSegmented:SegmentControlCustom  =  {
        let value = DataController.shared.bookInType.inspectionValue
        let codeSegmented = SegmentControlCustom(buttonTitle: value, fontSize: 25.0)
        
        codeSegmented.bgColor = .clear
        codeSegmented.selectorTextColor = UIColor.orangeColor
        codeSegmented.selectorViewColor = UIColor.orangeColor
        codeSegmented.textColor = UIColor.lightGray
        
        return codeSegmented
    }()
    
    
    func setUpTab(){
        fullName.text = "\(String.localized("select_inspection_inspector_label")) \(DataController.shared.getFullName())"
        
        pickUpStackView.isUserInteractionEnabled = true
        pickUpStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toPickUpCar)))
        
        checkStackView.isUserInteractionEnabled = true
        checkStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toCheckCar)))
        
        photoStackView.isUserInteractionEnabled = true
        photoStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toPhotoCar)))
        
        
    }
    
    //MARK: Title
    func setTitleName(){
        switch DataController.shared.bookInType {
        case .CAR:
            title = String.localized("main_inspection_item_inspection_title")
        case .MBIKE:
            title = String.localized("motorbike_inspection_navigation_title")
        case  .CARWRECK:
            title = String.localized("car_salvage_inspection_navigation_title")
        case .MBIKEWRECK:
            title = String.localized("motorbike_salvage_inspection_navigation_title")
        }
    }
    
    //MARK: ViewController
    private lazy var bodyCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "BodyCheckViewController") as! BodyCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var engineCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "EngineCheckViewController") as! EngineCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var underCarCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "UnderCarCheckViewController") as! UnderCarCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var gearCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "GearCheckViewController") as! GearCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var steerWheelCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "SteerWheelCheckViewController") as! SteerWheelCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var brakeCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "BrakeCheckViewController") as! BrakeCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var airCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "AirCheckViewController") as! AirCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var gaugeCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "GaugeCheckViewController") as! GaugeCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var electronicDeviceCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "ElectronicDeviceCheckViewController") as! ElectronicDeviceCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var motorcycleCheck: UIViewController? = {
        
        var viewController = getViewCOntroller(identifier: "MotorcycleCheckViewController") as! MotorcycleCheckViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    deinit {
        print("🔸🐶 deinit CheckCarViewController")
        bodyCheck = nil
        engineCheck = nil
        underCarCheck = nil
        gearCheck = nil
        steerWheelCheck = nil
        brakeCheck = nil
        airCheck = nil
        gaugeCheck = nil
        electronicDeviceCheck = nil
        motorcycleCheck = nil
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: View Life Cycle
extension CheckCarViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [unowned self] in
            self.segmentWidthConstraint.constant = self.codeSegmented.widthContent
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateInspection = DataController.shared.inspectionCarModel.date
        let request = CheckCar.Something.Request(dateInspection: dateInspection)
        interactor?.setReceiverDateTimeInspection(request: request)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
}



extension CheckCarViewController  {
    @objc func toPickUpCar() {
        navigationController?.popToViewController(withType: PickUpCarViewController.self, animated: false)
    }
    
    @objc func toCheckCar() {
    }
    
    @objc func toPhotoCar() {
        guard let nav = navigationController else { return }
        let foundPhotoCar = nav.viewControllers.filter({ $0 is PhotoCarViewController})
        if foundPhotoCar.count > 0 {
            navigationController?.popViewController(animated: false)
        }else{
            navigationController?.pushViewController(CarInspectionPage.PHOTO_CAR.VC, animated: false)
        }
        
    }
    
    
}

extension CheckCarViewController : CustomSegmentedControlDelegate  {
    
    func change(to index: Int , button : UIButton) {
//        updateUIView(from: index)
//        scrollView.scrollToView(view: button, animated: true)
        isClickedTopItem = true
        var offsetY = 0.0
        switch index {
        case 0:
            offsetY = 0
        case 1:
            switch DataController.shared.bookInType {
            case .CAR, .CARWRECK:
                offsetY = item1OffsetY
            case .MBIKE, .MBIKEWRECK:
                offsetY = item1MBOffsetY
            }
        case 2:
            offsetY = item2OffsetY
        case 3:
            offsetY = item3OffsetY
        case 4:
            offsetY = item4OffsetY
        case 5:
            offsetY = item5OffsetY
        case 6:
            offsetY = item6OffsetY
        case 7:
            offsetY = item7OffsetY
        case 8:
            offsetY = item8OffsetY

        default:
            return
            
        }
        
        mainScrollview.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    }
    
    private func updateUIView(from index: Int){
        switch index {
        case 0:
            switch DataController.shared.bookInType {
            case .CAR, .CARWRECK:
                add(asChildViewController: bodyCheck)
            case .MBIKE, .MBIKEWRECK:
                add(asChildViewController: motorcycleCheck)
            }
            
            
        case 1:
            add(asChildViewController: engineCheck)
            
        case 2:
            add(asChildViewController: underCarCheck)
            
        case 3:
            add(asChildViewController: gearCheck)
            
        case 4:
            add(asChildViewController: steerWheelCheck)
            
        case 5:
            add(asChildViewController: brakeCheck)
            
        case 6:
            add(asChildViewController: airCheck)
            
        case 7:
            add(asChildViewController: gaugeCheck)
            
        case 8:
            add(asChildViewController: electronicDeviceCheck)
        default:
            return
            
        }
    }
    
    private func add(asChildViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        
//        if let last = children.last {
//            last.willMove(toParent: nil)
//            last.view.removeFromSuperview()
//            last.removeFromParent()
//        }
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        mainScrollview.addSubview(viewController.view)
        let spaceHeight = 0.0
        if viewController is BodyCheckViewController {
            lastFrame = CGRect(x: 0, y: 0, width: mainScrollview.width, height: inspectionItem0Height - spaceHeight)
        } else if viewController is MotorcycleCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem0MBHeight - spaceHeight)
        } else if viewController is EngineCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem1Height - spaceHeight)
        } else if viewController is UnderCarCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem2Height - spaceHeight)
        } else if viewController is GearCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem3Height - spaceHeight)
        } else if viewController is SteerWheelCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem4Height - spaceHeight)
        } else if viewController is BrakeCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem5Height - spaceHeight)
        } else if viewController is AirCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem6Height - spaceHeight)
        } else if viewController is GaugeCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem7Height - spaceHeight)
        } else if viewController is ElectronicDeviceCheckViewController {
            lastFrame = CGRect(x: 0, y: lastFrame.maxY, width: mainScrollview.width, height: inspectionItem8Height - spaceHeight)
        }
        mainScrollview.contentSize = CGSize(width: containerView.width, height: lastFrame.maxY)
        // Configure Child View
//        viewController.view.frame = containerView.bounds
        viewController.view.frame = CGRect(x: 0, y: lastFrame.minY, width: containerView.width, height: lastFrame.height)
        
        // Add Child View as Subview
//        containerView.addSubview(viewController.view)
//
//        // Configure Child View
//        viewController.view.frame = containerView.bounds
//        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        // Notify Child View Controller
//        viewController.didMove(toParent: self)
    }
    
    private func getViewCOntroller(identifier : String) -> UIViewController {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "CheckCar", bundle: Bundle.main)
        // Instantiate View Controller
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

extension CheckCarViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isClickedTopItem = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isClickedTopItem {
            return
        }
        
        if DataController.shared.bookInType == .MBIKE || DataController.shared.bookInType == .MBIKEWRECK {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            return
        }
        var index = 0
  
        if offsetY >= 0 ,offsetY < item1OffsetY {
            index = 0
        } else if offsetY >= item1OffsetY , offsetY < item2OffsetY {
            index = 1
        } else if offsetY >= item2OffsetY , offsetY < item3OffsetY {
            index = 2
        } else if offsetY >= item3OffsetY , offsetY < item4OffsetY {
            index = 3
        } else if offsetY >= item4OffsetY , offsetY < item5OffsetY {
            index = 4
        } else if offsetY >= item5OffsetY , offsetY < item6OffsetY {
            index = 5
        } else if offsetY >= item6OffsetY , offsetY < item7OffsetY {
            index = 6
        } else if offsetY >= item7OffsetY , offsetY < item8OffsetY {
            index = 7
        } else {
            index = 8
        }
  
        let button = self.codeSegmented.buttons[index]
        self.codeSegmented.buttonAction(sender: button , isCombine: true)
    }
}
