//
//  RepoCarViewController.swift
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

protocol RepoCarDisplayLogic: AnyObject
{
    func displaySomething(viewModel: RepoCar.Something.ViewModel)
    func displayDeliveryPersonDropdown(viewModel: RepoCar.Something.ViewModel)
}

class RepoCarViewController: UIViewController, RepoCarDisplayLogic
{
    
    var interactor: RepoCarBusinessLogic?
    var router: (NSObjectProtocol & RepoCarRoutingLogic & RepoCarDataPassing)?
    
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
        let interactor = RepoCarInteractor()
        let presenter = RepoCarPresenter()
        let router = RepoCarRouter()
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
                    
//                    let request = PhotoCar.Something.Request(dateInspection: dateInspection)
//                    self?.interactor?.setReceiverDateTimeInspection(request: request)
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
        setUpDateTime()
        doSomething()
    }
    
    // MARK: Do something
    @IBOutlet weak var fullName:UILabel!
    @IBOutlet weak var pickUpStackView: UIView!
    @IBOutlet weak var checkStackView: UIView!
    @IBOutlet weak var photoStackView: UIView!
    @IBOutlet weak var repoStackView: UIView!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
        
    var sourceSectionName : [(name:String, cb: CheckBoxUIButton)] = []
    
    func doSomething()
    {
        let request = RepoCar.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: RepoCar.Something.ViewModel) {
        
    }
    
    func displayDeliveryPersonDropdown(viewModel: RepoCar.Something.ViewModel) {
        
    }
    
    //MARK: DateTime
    func setUpDateTime(){
        dateTimeView.isUserInteractionEnabled = true
        dateTimeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDateTime)))
    }
    
    func displayReceiverDayTimeInspection(viewModel: PhotoCar.Something.ViewModel) {
        guard let dayTime = viewModel.dayTime else { return }
        self.dateLabel.text = dayTime.day
        self.timeLabel.text = dayTime.time
    }
    
    @objc func showDateTime(){
        performSegue(withIdentifier: "showDateTime", sender: nil)
    }
    
    @IBAction func toRootView(_ sender: Any) {
        popToRootViewController(confirm: true)
    }
    
    func displaySendInsectionIMATError(viewModel: PhotoCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessage(message: errorMessage) { [weak self] in
        }
    }
    
    func displaySendInsectionIMATSuccess(viewModel: PhotoCar.Something.ViewModel) {
        print("🔶 photo displaySendInsectionIMATSuccess")
        //self.updateVehicleId()
        alertErrorMessageOKAction(message: "Inspection สำเร็จ") {
            //ignored
        }
    }

    func validateInspectionIMAT(){
//        let request = PhotoCar.Something.Request()
//        interactor?.validateActionSendToInspectionIMAT(request: request)
    }
    
    func displayActionEventSuccess(viewModel: PhotoCar.Something.ViewModel) {
        
    }
    
    func displayUploadProgress(viewModel: PhotoCar.Something.ViewModel) {
        performSegue(withIdentifier: "UploadProgress", sender: nil)
    }
    
    func displayAlertMessage(viewModel: PhotoCar.Something.ViewModel) {
        guard let message = viewModel.alertPhotoMessage else { return }
        alertErrorMessageOKAction(message: message) {
            // ignored
        }
    }
    
    //MARK: SetupTab
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
        title = "Repo"
    }
    
    func prepareData(){
//        let request = PhotoCar.Something.Request()
//        interactor?.prepareDataSection(request: request)
    }
    func fetchDeliveryList(){
        let request = RepoCar.Something.Request()
        interactor?.fetchDeliveryList(request: request)
    }
    
    func displayErrorFetchList(viewModel: RepoCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.alertErrorMessage(message: errorMessage) { [weak self] in
                self?.fetchDeliveryList()
            }
        }
        
    }
    func displayErrorDelete(viewModel: PhotoCar.Something.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.alertErrorMessageOKAction(message: errorMessage) {
                // ignored
            }
        }
    }

}

//MARK: ViewController Lift Cycle
extension RepoCarViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareData()
        fetchDeliveryList()
        validateInspectionIMAT()
    }
}

extension RepoCarViewController  {
    @objc func toPickUpCar() {
        navigationController?.popToViewController(withType: PickUpCarViewController.self, animated: false)
    }
    
    @objc func toCheckCar() {
        guard let nav = navigationController else { return }
        let foundCheckCar = nav.viewControllers.filter({ $0 is CheckCarViewController})
        if foundCheckCar.count > 0 {
            navigationController?.popViewController(animated: false)
        }else{
            navigationController?.pushViewController(CarInspectionPage.CHECK_CAR.VC,  animated: false)
        }
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
    }
}

