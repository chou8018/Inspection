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

protocol CheckCarDisplayLogic: AnyObject
{
  func displaySomething(viewModel: CheckCar.Something.ViewModel)
    func displayReceiverDayTimeInspection(viewModel: CheckCar.Something.ViewModel)
}

class CheckCarViewController: UIViewController, CheckCarDisplayLogic
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
    @IBOutlet weak var repoStackView: UIView!
    
    @IBOutlet weak var segmentView: UIView!
    
    @IBOutlet weak var segmentWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lineview: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
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
        
        updateUIView(from: 0)
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
        fullName.text = "ผู้ตรวจสภาพ \(DataController.shared.getFullName())"
        
        
        pickUpStackView.isUserInteractionEnabled = true
        pickUpStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toPickUpCar)))
        
        checkStackView.isUserInteractionEnabled = true
        checkStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toCheckCar)))
        
        photoStackView.isUserInteractionEnabled = true
        photoStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toPhotoCar)))
        
        repoStackView.isUserInteractionEnabled = true
        repoStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toRepoCar)))
        
    }

    //MARK: Title
    func setTitleName(){
        switch DataController.shared.bookInType {
        case .CAR:
            title = "ตรวจสภาพ - รถยนต์"
        case .MBIKE:
            title = "ตรวจสภาพ - รถจักรยานยนต์"
        case  .CARWRECK:
            title = "ตรวจสภาพ - ซากรถยนต์"
        case .MBIKEWRECK:
            title = "ตรวจสภาพ - ซากรถจักรยานยนต์"
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
    
    @objc func toRepoCar() {
        navigationController?.pushViewController(CarInspectionPage.REPO_CAR.VC,  animated: false)
    }
    
}

extension CheckCarViewController : CustomSegmentedControlDelegate  {

    func change(to index: Int , button : UIButton) {
        updateUIView(from: index)
        
        scrollView.scrollToView(view: button, animated: true)
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
        
        if let last = children.last {
            last.willMove(toParent: nil)
            last.view.removeFromSuperview()
            last.removeFromParent()
        }
       
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
//    private func remove(asChildViewController viewController: UIViewController) {
//        guard let viewController = viewController else { return }
//        // Notify Child View Controller
//        viewController.willMove(toParent: nil)
//
//        // Remove Child View From Superview
//        viewController.view.removeFromSuperview()
//
//        // Notify Child View Controller
//        viewController.removeFromParent()
//    }

    private func getViewCOntroller(identifier : String) -> UIViewController {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "CheckCar", bundle: Bundle.main)
        // Instantiate View Controller
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
