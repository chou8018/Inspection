//
//  PickUpCarViewController.swift
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

protocol PickUpCarDisplayLogic: AnyObject
{
  func displaySomething(viewModel: PickUpCar.Something.ViewModel)
    func displayReceiverDayTime(viewModel: PickUpCar.Something.ViewModel)
    func displayDPF(viewModel: PickUpCar.Something.ViewModel)
   
    func displayErrorReceiverBookIn(viewModel: PickUpCar.Something.ViewModel)
    func displaySuccessReceiverBookIn(viewModel: PickUpCar.Something.ViewModel)
    func displayRequiteFieldSuccess(viewModel: PickUpCar.Something.ViewModel)
    func displayRequiteFieldError(viewModel: PickUpCar.Something.ViewModel)
    
    func displayActionEventSuccess(viewModel: PickUpCar.Something.ViewModel)
    
    func displayIMATError(viewModel: PickUpCar.Something.ViewModel)
    func displayIMATSuccess(viewModel: PickUpCar.Something.ViewModel)
    

}

class PickUpCarViewController: UIViewController, PickUpCarDisplayLogic
{
  var interactor: PickUpCarBusinessLogic?
  var router: (NSObjectProtocol & PickUpCarRoutingLogic & PickUpCarDataPassing)?

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
    let interactor = PickUpCarInteractor()
    let presenter = PickUpCarPresenter()
    let router = PickUpCarRouter()
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
            dateTimePicker.didSelectedDateTimePicker = { [weak self] (dateReceiver) in
                let request = PickUpCar.Something.Request(dateReceiver: dateReceiver)
                self?.interactor?.setReceiverDateTime(request: request, isEdit: false)
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
    @IBOutlet weak var fullName:UILabel!
    @IBOutlet weak var pickUpStackView: UIView!
    @IBOutlet weak var checkStackView: UIView!
    @IBOutlet weak var photoStackView: UIView!
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
    let request = PickUpCar.Something.Request()
    interactor?.doSomething(request: request)
  }
    
  //MARK: Presenter
  func displaySomething(viewModel: PickUpCar.Something.ViewModel)
  {
    
  }
    func displayRequiteFieldError(viewModel: PickUpCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessageOKAction(message: errorMessage) {
            print("alertErrorMessage", "OKAction")
        }
    }
    func displayRequiteFieldSuccess(viewModel: PickUpCar.Something.ViewModel) {
        let fromEdit = DataController.shared.isFromEditView
        let message = fromEdit ? "คุณต้องการแก้ไขรายการไหม" : "คุณต้องการบันทึกรายการรับมอบรถไหม"
        alert(message: message) { [weak self] in
            //send to server
            self?.confirmSendDataReceiver()
        }
    }
    func displaySuccessReceiverBookIn(viewModel: PickUpCar.Something.ViewModel) {
        let request = PickUpCar.Something.Request()
        interactor?.generatePdfBookIN(request: request)
    }
    
    func displayErrorReceiverBookIn(viewModel: PickUpCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.confirmSendDataReceiver()
        }
    }
    
    func displayReceiverDayTime(viewModel: PickUpCar.Something.ViewModel) {
        guard let dayTime = viewModel.dayTime else { return }
        self.dateLabel.text = dayTime.day
        self.timeLabel.text = dayTime.time
    }
    
    func displayDPF(viewModel: PickUpCar.Something.ViewModel) {
        performSegue(withIdentifier: "pdfviewer", sender: nil)
    }
    
    //MARK: IBAction
    
    @IBAction func toBackView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func toRootView(_ sender: Any) {
        popToRootViewController(confirm: true)
    }
    @IBAction func saveReceiverCarTapped(_ sender: Any) {
        //validate requite field
        let request = PickUpCar.Something.Request()
        interactor?.validateRequiteField(request: request)
        
        print("🔸Book-in Type: (\(DataController.shared.bookInType.nameValue))🔸")

    }
   
    @IBAction func saveToIMAT(_ sender: Any){
        print("🔶 save to IMAT")
        alert(message: "คุณต้องการส่ง\nBook-In to IMAT ไหม") { [weak self] in
            self?.sendToIMAT()
        }
       
    }
     
    func displayActionEventSuccess(viewModel: PickUpCar.Something.ViewModel) {
        sendButton.isEnabled = viewModel.isEnableSendToIMAP ?? false
        saveButton.isEnabled = viewModel.isEnableSave ?? false
    }
    
    //MARK: Send To IMAT
    func validateSendIMAT(){
        let request = PickUpCar.Something.Request()
        interactor?.validateActionSendToIMAT(request: request)
    }
    
    func sendToIMAT(){
        let request = PickUpCar.Something.Request()
        interactor?.confirmSendToIMAT(request: request)
    }
    
    func displayIMATError(viewModel: PickUpCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.sendToIMAT()
        }
    }
    
    //MARK: create IMAT QRCode
    func createIMATQRCode(){
        interactor?.generateIMATQRCode(request: PickUpCar.Something.Request())
    }
    func displayIMATSuccess(viewModel: PickUpCar.Something.ViewModel) {
        print("❤️🐶 displayIMATSuccess for updateUI")
        alert(message: "ต้องการปริ้น IMAT QRCode ไหม", title: "Book-In สำเร็จ") { [weak self] in
            self?.createIMATQRCode()
        } cancel: {
            // cacel
        }


        validateSendIMAT()
        NotificationCenter.default.post(name: NSNotification.Name("updateUI"), object: nil)

    }
    
  
    
    
    
    
    
    
    
    func confirmSendDataReceiver(){
        let request = PickUpCar.Something.Request(methodReceiver: .POST)
        self.interactor?.confirmSendDataReceiverCar(request: request)
    }
    
    
    func segmentSetUp(){

        segmentView.addSubview(codeSegmented)
        codeSegmented.delegate = self
        updateUIView(from: 0)
    }
    

    lazy var codeSegmented:SegmentControlCustom  =  {

        let value = DataController.shared.bookInType.bookInValue
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
    
    
    //MARK: CAR
    private lazy var receiverCarViewController: ReceiverCarViewController? = {
        
        var viewController = getViewCOntroller(identifier: "ReceiverCarViewController") as! ReceiverCarViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var aboutCarViewController: AboutCarViewController? = {
        
        var viewController = getViewCOntroller(identifier: "AboutCarViewController") as! AboutCarViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var externalCarViewController: ExternalCarViewController? = {
        
        var viewController = getViewCOntroller(identifier: "ExternalCarViewController") as! ExternalCarViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var sparePartsCarViewController: SparePartsCarViewController? = {
        
        var viewController = getViewCOntroller(identifier: "SparePartsCarViewController") as! SparePartsCarViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var cabinCarViewController: CabinCarViewController? = {
        
        var viewController = getViewCOntroller(identifier: "CabinCarViewController") as! CabinCarViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var engineCarViewController: EngineCarViewController? = {
        
        var viewController = getViewCOntroller(identifier: "EngineCarViewController") as! EngineCarViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    
    //MARK: MOTORBILE
    private lazy var bookInMotorcycle1ViewController: BookInMotorcycle1ViewController? = {
        
        var viewController = getViewCOntroller(identifier: "BookInMotorcycle1ViewController") as! BookInMotorcycle1ViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var bookInMotorcycle2ViewController: BookInMotorcycle2ViewController? = {
        
        var viewController = getViewCOntroller(identifier: "BookInMotorcycle2ViewController") as! BookInMotorcycle2ViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    
    //MARK: Title
    func setTitleName(){
        switch DataController.shared.bookInType {
        case .CAR:
            title = "รับมอบ - รถยนต์"
        case .MBIKE:
            title = "รับมอบ - รถจักรยานยนต์"
        case  .CARWRECK:
            title = "รับมอบ - ซากรถยนต์"
        case  .MBIKEWRECK:
            title = "รับมอบ - ซากรถจักรยานต์"
        }
    }
    
    
    //MARK: DateTime
    func setUpDateTime(){
        dateTimeView.isUserInteractionEnabled = true
        dateTimeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDateTime)))
        
       
    }
    
    @objc func showDateTime(){
        performSegue(withIdentifier: "showDateTime", sender: nil)
    }
    
    
    deinit {
        print("🔸🐶 deinit PickUpCarViewController ")
        receiverCarViewController = nil
        aboutCarViewController = nil
        externalCarViewController = nil
        sparePartsCarViewController = nil
        cabinCarViewController = nil
        engineCarViewController = nil
    }
}
//MARK: ViewCOntroller Lift Cycle

extension PickUpCarViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [unowned self] in
            self.segmentWidthConstraint.constant = self.codeSegmented.widthContent
            
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateReceiver = DataController.shared.receiverCarModel.date
        let request = PickUpCar.Something.Request(dateReceiver: dateReceiver)
        let isFromEditView = DataController.shared.isFromEditView
        interactor?.setReceiverDateTime(request: request, isEdit: isFromEditView)
        
        
        validateSendIMAT()
    }
   
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    
        
    }
    
    
}


extension PickUpCarViewController {
    @objc func toPickUpCar() {
    }
    
    @objc func toCheckCar() {
        navigationController?.pushViewController(CarInspectionPage.CHECK_CAR.VC,  animated: false)
    }
    
    @objc func toPhotoCar() {
        navigationController?.pushViewController(CarInspectionPage.PHOTO_CAR.VC, animated: false)
    }
    
    
}



extension PickUpCarViewController : CustomSegmentedControlDelegate  {
    func change(to index: Int , button : UIButton) {
        updateUIView(from: index)
        
        scrollView.scrollToView(view: button, animated: true)
    }
    
    
    private func updateUIView(from index: Int){
        switch index {
        case 0:
            add(asChildViewController: receiverCarViewController)
            
        case 1:
            add(asChildViewController: aboutCarViewController)
            
        case 2:
            switch DataController.shared.bookInType {
            case .CAR, .CARWRECK:
                add(asChildViewController: externalCarViewController)
            case .MBIKE, .MBIKEWRECK:
                add(asChildViewController: bookInMotorcycle1ViewController)

            }
           
        case 3:
            switch DataController.shared.bookInType {
            case .CAR, .CARWRECK:
                add(asChildViewController: sparePartsCarViewController)
            case .MBIKE, .MBIKEWRECK:
                add(asChildViewController: bookInMotorcycle2ViewController)

            }
            
        case 4:
            add(asChildViewController: cabinCarViewController)
            
        case 5:
            add(asChildViewController: engineCarViewController)
            
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
        let storyboard = UIStoryboard(name: "PickUpCar", bundle: Bundle.main)
        // Instantiate View Controller
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
