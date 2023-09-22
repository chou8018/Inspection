//
//  GradeCarViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 11/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol GradeCarDisplayLogic: AnyObject
{
    func displaySomething(viewModel: GradeCar.Something.ViewModel)
    func displayGradeResult(viewModel: GradeCar.Something.ViewModel)
}

class GradeCarViewController: ViewController, GradeCarDisplayLogic
{
    var interactor: GradeCarBusinessLogic?
    var router: (NSObjectProtocol & GradeCarRoutingLogic & GradeCarDataPassing)?
    
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
        let interactor = GradeCarInteractor()
        let presenter = GradeCarPresenter()
        let router = GradeCarRouter()
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
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView : UIScrollView!
    
    // exellence
    @IBOutlet weak var e1Chehck : CheckBoxUIButton!
    @IBOutlet weak var e2Chehck : CheckBoxUIButton!
    @IBOutlet weak var e3Chehck : CheckBoxUIButton!
    @IBOutlet weak var e4Chehck : CheckBoxUIButton!
    @IBOutlet weak var e5Chehck : CheckBoxUIButton!
    
    // good
    @IBOutlet weak var g1Chehck : CheckBoxUIButton!
    @IBOutlet weak var g2Chehck : CheckBoxUIButton!
    @IBOutlet weak var g3Chehck : CheckBoxUIButton!
    @IBOutlet weak var g4Chehck : CheckBoxUIButton!
    
    // average
    @IBOutlet weak var a1Chehck : CheckBoxUIButton!
    @IBOutlet weak var a2Chehck : CheckBoxUIButton!
    @IBOutlet weak var a3Chehck : CheckBoxUIButton!
    @IBOutlet weak var a4Chehck : CheckBoxUIButton!
    
    // fair
    @IBOutlet weak var f1Chehck : CheckBoxUIButton!
    @IBOutlet weak var f2Chehck : CheckBoxUIButton!
    @IBOutlet weak var f3Chehck : CheckBoxUIButton!
    @IBOutlet weak var f4Chehck : CheckBoxUIButton!
    @IBOutlet weak var f5Chehck : CheckBoxUIButton!
    @IBOutlet weak var f6Chehck : CheckBoxUIButton!
    @IBOutlet weak var f7Chehck : CheckBoxUIButton!
    @IBOutlet weak var f8Chehck : CheckBoxUIButton!
    @IBOutlet weak var f9Chehck : CheckBoxUIButton!
    @IBOutlet weak var f10Chehck : CheckBoxUIButton!
    @IBOutlet weak var f11Chehck : CheckBoxUIButton!
    
    // poor
    @IBOutlet weak var p1Chehck : CheckBoxUIButton!
    @IBOutlet weak var p2Chehck : CheckBoxUIButton!
    @IBOutlet weak var p3Chehck : CheckBoxUIButton!
    @IBOutlet weak var p4Chehck : CheckBoxUIButton!
    @IBOutlet weak var p5Chehck : CheckBoxUIButton!
    @IBOutlet weak var p6Chehck : CheckBoxUIButton!
    @IBOutlet weak var p7Chehck : CheckBoxUIButton!
    @IBOutlet weak var p8Chehck : CheckBoxUIButton!
    @IBOutlet weak var p9Chehck : CheckBoxUIButton!
    
    // x
    @IBOutlet weak var x1Chehck : CheckBoxUIButton!
    
    // y
    @IBOutlet weak var y1Chehck : CheckBoxUIButton!
    
    // result
    @IBOutlet weak var gradeLabel : UILabel!
    
    // local strings
    @IBOutlet weak var eTitleLabel: UILabel!
    @IBOutlet weak var eOption1Label: UILabel!
    @IBOutlet weak var eOption2Label: UILabel!
    @IBOutlet weak var eOption3Label: UILabel!
    @IBOutlet weak var eOption4Label: UILabel!
    @IBOutlet weak var eOption5Label: UILabel!
    
    @IBOutlet weak var gTitleLabel: UILabel!
    @IBOutlet weak var gOption1Label: UILabel!
    @IBOutlet weak var gOption2Label: UILabel!
    @IBOutlet weak var gOption3Label: UILabel!
    @IBOutlet weak var gOption4Label: UILabel!
    
    @IBOutlet weak var aTitleLabel: UILabel!
    @IBOutlet weak var aOption1Label: UILabel!
    @IBOutlet weak var aOption2Label: UILabel!
    @IBOutlet weak var aOption3Label: UILabel!
    @IBOutlet weak var aOption4Label: UILabel!
    
    @IBOutlet weak var fTitleLabel: UILabel!
    @IBOutlet weak var fOption1Label: UILabel!
    @IBOutlet weak var fOption2Label: UILabel!
    @IBOutlet weak var fOption3Label: UILabel!
    @IBOutlet weak var fOption4Label: UILabel!
    @IBOutlet weak var fOption5Label: UILabel!
    @IBOutlet weak var fOption6Label: UILabel!
    @IBOutlet weak var fOption7Label: UILabel!
    @IBOutlet weak var fOption8Label: UILabel!
    @IBOutlet weak var fOption9Label: UILabel!
    @IBOutlet weak var fOption10Label: UILabel!
    @IBOutlet weak var fOption11Label: UILabel!
    
    @IBOutlet weak var pTitleLabel: UILabel!
    @IBOutlet weak var pOption1Label: UILabel!
    @IBOutlet weak var pOption2Label: UILabel!
    @IBOutlet weak var pOption3Label: UILabel!
    @IBOutlet weak var pOption4Label: UILabel!
    @IBOutlet weak var pOption5Label: UILabel!
    @IBOutlet weak var pOption6Label: UILabel!
    @IBOutlet weak var pOption7Label: UILabel!
    @IBOutlet weak var pOption8Label: UILabel!
    @IBOutlet weak var pOption9Label: UILabel!
    
    @IBOutlet weak var xOptionLabel: UILabel!
    @IBOutlet weak var yOptionLabel: UILabel!
    @IBOutlet weak var rightButtonItem: UIBarButtonItem!
    
    override func initLocalString() {
        super.initLocalString()
        self.title = String.localized("car_grade_title_label")
        rightButtonItem.title = String.localized("car_grade_next_button_title")
        eTitleLabel.text = String.localized("car_grade_excellence_label")
        eOption1Label.text = String.localized("car_grade_excellence_option1_label")
        eOption2Label.text = String.localized("car_grade_excellence_option2_label")
        eOption3Label.text = String.localized("car_grade_excellence_option3_label")
        eOption4Label.text = String.localized("car_grade_excellence_option4_label")
        eOption5Label.text = String.localized("car_grade_excellence_option5_label")

        gTitleLabel.text = String.localized("car_grade_good_label")
        gOption1Label.text = String.localized("car_grade_good_option1_label")
        gOption2Label.text = String.localized("car_grade_good_option2_label")
        gOption3Label.text = String.localized("car_grade_good_option3_label")
        gOption4Label.text = String.localized("car_grade_good_option4_label")
        
        aTitleLabel.text = String.localized("car_grade_average_label")
        aOption1Label.text = String.localized("car_grade_average_option1_label")
        aOption2Label.text = String.localized("car_grade_average_option2_label")
        aOption3Label.text = String.localized("car_grade_average_option3_label")
        aOption4Label.text = String.localized("car_grade_average_option4_label")
        
        fTitleLabel.text = String.localized("car_grade_fair_label")
        fOption1Label.text = String.localized("car_grade_fair_option1_label")
        fOption2Label.text = String.localized("car_grade_fair_option2_label")
        fOption3Label.text = String.localized("car_grade_fair_option3_label")
        fOption4Label.text = String.localized("car_grade_fair_option4_label")
        fOption5Label.text = String.localized("car_grade_fair_option5_label")
        fOption6Label.text = String.localized("car_grade_fair_option6_label")
        fOption7Label.text = String.localized("car_grade_fair_option7_label")
        fOption8Label.text = String.localized("car_grade_fair_option8_label")
        fOption9Label.text = String.localized("car_grade_fair_option9_label")
        fOption10Label.text = String.localized("car_grade_fair_option10_label")
        fOption11Label.text = String.localized("car_grade_fair_option11_label")
        
        pTitleLabel.text = String.localized("car_grade_poor_label")
        pOption1Label.text = String.localized("car_grade_poor_option1_label")
        pOption2Label.text = String.localized("car_grade_poor_option2_label")
        pOption3Label.text = String.localized("car_grade_poor_option3_label")
        pOption4Label.text = String.localized("car_grade_poor_option4_label")
        pOption5Label.text = String.localized("car_grade_poor_option5_label")
        pOption6Label.text = String.localized("car_grade_poor_option6_label")
        pOption7Label.text = String.localized("car_grade_poor_option7_label")
        pOption8Label.text = String.localized("car_grade_poor_option8_label")
        pOption9Label.text = String.localized("car_grade_poor_option9_label")

        xOptionLabel.text = String.localized("car_grade_x_label")
        yOptionLabel.text = String.localized("car_grade_y_label")

    }

    func doSomething()
    {
        let request = GradeCar.Something.Request()
        interactor?.doSomething(request: request)
    }
    //MARK: Presenter
    func displaySomething(viewModel: GradeCar.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    func displayGradeResult(viewModel: GradeCar.Something.ViewModel) {
        gradeLabel.text = viewModel.grade
    }
    
    //MARK: CheckBox Exellence
    @IBAction func e1checkTapped(_ sender: Any) { e1Chehck.toggle { [weak self] in self?.interactor?.e1Chehck(request: GradeCar.Something.Request(e1Chehck: $0))} }
    @IBAction func e2checkTapped(_ sender: Any) { e2Chehck.toggle { [weak self] in self?.interactor?.e2Chehck(request: GradeCar.Something.Request(e2Chehck: $0))} }
    @IBAction func e3checkTapped(_ sender: Any) { e3Chehck.toggle { [weak self] in self?.interactor?.e3Chehck(request: GradeCar.Something.Request(e3Chehck: $0))} }
    @IBAction func e4checkTapped(_ sender: Any) { e4Chehck.toggle { [weak self] in self?.interactor?.e4Chehck(request: GradeCar.Something.Request(e4Chehck: $0))} }
    @IBAction func e5checkTapped(_ sender: Any) { e5Chehck.toggle { [weak self] in self?.interactor?.e5Chehck(request: GradeCar.Something.Request(e5Chehck: $0))} }
    
    //MARK: CheckBox Good
    @IBAction func g1checkTapped(_ sender: Any) { g1Chehck.toggle { [weak self] in self?.interactor?.g1Chehck(request: GradeCar.Something.Request(g1Chehck: $0))} }
    @IBAction func g2checkTapped(_ sender: Any) { g2Chehck.toggle { [weak self] in self?.interactor?.g2Chehck(request: GradeCar.Something.Request(g2Chehck: $0))}}
    @IBAction func g3checkTapped(_ sender: Any) { g3Chehck.toggle { [weak self] in self?.interactor?.g3Chehck(request: GradeCar.Something.Request(g3Chehck: $0))} }
    @IBAction func g4checkTapped(_ sender: Any) { g4Chehck.toggle { [weak self] in self?.interactor?.g4Chehck(request: GradeCar.Something.Request(g4Chehck: $0))} }
    
    
    //MARK: CheckBox AveraTappedge
    @IBAction func a1checkTapped(_ sender: Any) { a1Chehck.toggle { [weak self] in self?.interactor?.a1Chehck(request: GradeCar.Something.Request(a1Chehck: $0))} }
    @IBAction func a2checkTapped(_ sender: Any) { a2Chehck.toggle { [weak self] in self?.interactor?.a2Chehck(request: GradeCar.Something.Request(a2Chehck: $0))} }
    @IBAction func a3checkTapped(_ sender: Any) { a3Chehck.toggle { [weak self] in self?.interactor?.a3Chehck(request: GradeCar.Something.Request(a3Chehck: $0))} }
    @IBAction func a4checkTapped(_ sender: Any) { a4Chehck.toggle { [weak self] in self?.interactor?.a4Chehck(request: GradeCar.Something.Request(a4Chehck: $0))} }
    
    //MARK: CheckBox Fair
    @IBAction func f1checkTapped(_ sender: Any) { f1Chehck.toggle { [weak self] in self?.interactor?.f1Chehck(request: GradeCar.Something.Request(f1Chehck: $0))} }
    @IBAction func f2checkTapped(_ sender: Any) { f2Chehck.toggle { [weak self] in self?.interactor?.f2Chehck(request: GradeCar.Something.Request(f2Chehck: $0))} }
    @IBAction func f3checkTapped(_ sender: Any) { f3Chehck.toggle { [weak self] in self?.interactor?.f3Chehck(request: GradeCar.Something.Request(f3Chehck: $0))} }
    @IBAction func f4checkTapped(_ sender: Any) { f4Chehck.toggle { [weak self] in self?.interactor?.f4Chehck(request: GradeCar.Something.Request(f4Chehck: $0))} }
    @IBAction func f5checkTapped(_ sender: Any) { f5Chehck.toggle { [weak self] in self?.interactor?.f5Chehck(request: GradeCar.Something.Request(f5Chehck: $0))} }
    @IBAction func f6checkTapped(_ sender: Any) { f6Chehck.toggle { [weak self] in self?.interactor?.f6Chehck(request: GradeCar.Something.Request(f6Chehck: $0))} }
    @IBAction func f7checkTapped(_ sender: Any) { f7Chehck.toggle { [weak self] in self?.interactor?.f7Chehck(request: GradeCar.Something.Request(f7Chehck: $0))} }
    @IBAction func f8checkTapped(_ sender: Any) { f8Chehck.toggle { [weak self] in self?.interactor?.f8Chehck(request: GradeCar.Something.Request(f8Chehck: $0))} }
    @IBAction func f9checkTapped(_ sender: Any) { f9Chehck.toggle { [weak self] in self?.interactor?.f9Chehck(request: GradeCar.Something.Request(f9Chehck: $0))} }
    @IBAction func f10checTappedk(_ sender: Any) { f10Chehck.toggle { [weak self] in self?.interactor?.f10Chehck(request: GradeCar.Something.Request(f10Chehck: $0))} }
    @IBAction func f11checTappedk(_ sender: Any) { f11Chehck.toggle { [weak self] in self?.interactor?.f11Chehck(request: GradeCar.Something.Request(f11Chehck: $0))} }
    
    //MARK: CheckBox Poor
    @IBAction func p1checkTapped(_ sender: Any) { p1Chehck.toggle { [weak self] in self?.interactor?.p1Chehck(request: GradeCar.Something.Request(p1Chehck: $0))} }
    @IBAction func p2checkTapped(_ sender: Any) { p2Chehck.toggle { [weak self] in self?.interactor?.p2Chehck(request: GradeCar.Something.Request(p2Chehck: $0))} }
    @IBAction func p3checkTapped(_ sender: Any) { p3Chehck.toggle { [weak self] in self?.interactor?.p3Chehck(request: GradeCar.Something.Request(p3Chehck: $0))} }
    @IBAction func p4checkTapped(_ sender: Any) { p4Chehck.toggle { [weak self] in self?.interactor?.p4Chehck(request: GradeCar.Something.Request(p4Chehck: $0))} }
    @IBAction func p5checkTapped(_ sender: Any) { p5Chehck.toggle { [weak self] in self?.interactor?.p5Chehck(request: GradeCar.Something.Request(p5Chehck: $0))} }
    @IBAction func p6checkTapped(_ sender: Any) { p6Chehck.toggle { [weak self] in self?.interactor?.p6Chehck(request: GradeCar.Something.Request(p6Chehck: $0))} }
    @IBAction func p7checkTapped(_ sender: Any) { p7Chehck.toggle { [weak self] in self?.interactor?.p7Chehck(request: GradeCar.Something.Request(p7Chehck: $0))} }
    @IBAction func p8checkTapped(_ sender: Any) { p8Chehck.toggle { [weak self] in self?.interactor?.p8Chehck(request: GradeCar.Something.Request(p8Chehck: $0))} }
    @IBAction func p9checkTapped(_ sender: Any) { p9Chehck.toggle { [weak self] in self?.interactor?.p9Chehck(request: GradeCar.Something.Request(p9Chehck: $0))} }
    
    //MARK: CheckBox X
    @IBAction func x1checkTapped(_ sender: Any) { x1Chehck.toggle { [weak self] in self?.interactor?.x1Chehck(request: GradeCar.Something.Request(x1Chehck: $0))} }
    
    //MARK: CheckBox Y
    @IBAction func y1checkTapped(_ sender: Any) { y1Chehck.toggle { [weak self] in self?.interactor?.y1Chehck(request: GradeCar.Something.Request(y1Chehck: $0))} }
    
    
    
    func prepareData() {
        let model = DataController.shared.inspectionCarModel
        gradeLabel.text = model.grade ?? "-"
        e1Chehck.check = model.e1Chehck
        e2Chehck.check = model.e2Chehck
        e3Chehck.check = model.e3Chehck
        e4Chehck.check = model.e4Chehck
        e5Chehck.check = model.e5Chehck
        g1Chehck.check = model.g1Chehck
        g2Chehck.check = model.g2Chehck
        g3Chehck.check = model.g3Chehck
        g4Chehck.check = model.g4Chehck
        a1Chehck.check = model.a1Chehck
        a2Chehck.check = model.a2Chehck
        a3Chehck.check = model.a3Chehck
        a4Chehck.check = model.a4Chehck
        f1Chehck.check = model.f1Chehck
        f2Chehck.check = model.f2Chehck
        f3Chehck.check = model.f3Chehck
        f4Chehck.check = model.f4Chehck
        f5Chehck.check = model.f5Chehck
        f6Chehck.check = model.f6Chehck
        f7Chehck.check = model.f7Chehck
        f8Chehck.check = model.f8Chehck
        f9Chehck.check = model.f9Chehck
        f10Chehck.check = model.f10Chehck
        f11Chehck.check = model.f11Chehck
        p1Chehck.check = model.p1Chehck
        p2Chehck.check = model.p2Chehck
        p3Chehck.check = model.p3Chehck
        p4Chehck.check = model.p4Chehck
        p5Chehck.check = model.p5Chehck
        p6Chehck.check = model.p6Chehck
        p7Chehck.check = model.p7Chehck
        p8Chehck.check = model.p8Chehck
        p9Chehck.check = model.p9Chehck
        x1Chehck.check = model.x1Chehck
        y1Chehck.check = model.y1Chehck
        
        
        let request = GradeCar.Something.Request(e1Chehck:   e1Chehck.check,
                                                 e2Chehck:   e2Chehck.check,
                                                 e3Chehck:   e3Chehck.check,
                                                 e4Chehck:   e4Chehck.check,
                                                 e5Chehck:   e5Chehck.check,
                                                 g1Chehck:   g1Chehck.check,
                                                 g2Chehck:   g2Chehck.check,
                                                 g3Chehck:   g3Chehck.check,
                                                 g4Chehck:   g4Chehck.check,
                                                 a1Chehck:   a1Chehck.check,
                                                 a2Chehck:   a2Chehck.check,
                                                 a3Chehck:   a3Chehck.check,
                                                 a4Chehck:   a4Chehck.check,
                                                 f1Chehck:   f1Chehck.check,
                                                 f2Chehck:   f2Chehck.check,
                                                 f3Chehck:   f3Chehck.check,
                                                 f4Chehck:   f4Chehck.check,
                                                 f5Chehck:   f5Chehck.check,
                                                 f6Chehck:   f6Chehck.check,
                                                 f7Chehck:   f7Chehck.check,
                                                 f8Chehck:   f8Chehck.check,
                                                 f9Chehck:   f9Chehck.check,
                                                 f10Chehck: f10Chehck.check,
                                                 f11Chehck: f11Chehck.check,
                                                 p1Chehck:   p1Chehck.check,
                                                 p2Chehck:   p2Chehck.check,
                                                 p3Chehck:   p3Chehck.check,
                                                 p4Chehck:   p4Chehck.check,
                                                 p5Chehck:   p5Chehck.check,
                                                 p6Chehck:   p6Chehck.check,
                                                 p7Chehck:   p7Chehck.check,
                                                 p8Chehck:   p8Chehck.check,
                                                 p9Chehck:   p9Chehck.check,
                                                 x1Chehck:   x1Chehck.check,
                                                 y1Chehck:   y1Chehck.check)
        
        interactor?.prapareCheck(request : request)
        interactor?.evaluateGrade()
    }
    
    func calculateRegistrationYearAndMiles() {
        

        if let year = DataController.shared.receiverCarModel.registrationYear {
            let currentYear = Date().year
            let intYear = Int(year) ?? currentYear
            let registration = currentYear - intYear
            
            if registration <= 1 {
//                e2checkTapped(e2Chehck!)
                DataController.shared.inspectionCarModel.e2Chehck = true
                DataController.shared.inspectionCarModel.g2Chehck = false
                DataController.shared.inspectionCarModel.a2Chehck = false
                DataController.shared.inspectionCarModel.f1Chehck = false

            } else if registration > 1 , registration <= 2 {
//                g2checkTapped(g2Chehck!)
                DataController.shared.inspectionCarModel.g2Chehck = true
                DataController.shared.inspectionCarModel.e2Chehck = false
                DataController.shared.inspectionCarModel.a2Chehck = false
                DataController.shared.inspectionCarModel.f1Chehck = false

            } else if registration > 2 , registration <= 5 {
//                a2checkTapped(a2Chehck!)
                DataController.shared.inspectionCarModel.a2Chehck = true
                DataController.shared.inspectionCarModel.g2Chehck = false
                DataController.shared.inspectionCarModel.e2Chehck = false
                DataController.shared.inspectionCarModel.f1Chehck = false
            } else {
//                f1checkTapped(f1Chehck!)
                DataController.shared.inspectionCarModel.f1Chehck = true
                DataController.shared.inspectionCarModel.a2Chehck = false
                DataController.shared.inspectionCarModel.g2Chehck = false
                DataController.shared.inspectionCarModel.e2Chehck = false
            }
        }
        if let miles = DataController.shared.receiverCarModel.miles?.replacingOccurrences(of: ",", with: ""){
            let mileage = Int(miles) ?? 0
            if mileage <= 20_000 {
                DataController.shared.inspectionCarModel.e1Chehck = true
                DataController.shared.inspectionCarModel.g1Chehck = false
                DataController.shared.inspectionCarModel.a1Chehck = false
                DataController.shared.inspectionCarModel.f1Chehck = false

            } else if mileage > 20_000 , mileage <= 50_000 {
                DataController.shared.inspectionCarModel.g1Chehck = true
                DataController.shared.inspectionCarModel.e1Chehck = false
                DataController.shared.inspectionCarModel.a1Chehck = false
                DataController.shared.inspectionCarModel.f1Chehck = false
            } else if mileage > 50_000 , mileage <= 100_000 {
                DataController.shared.inspectionCarModel.a1Chehck = true
                DataController.shared.inspectionCarModel.g1Chehck = false
                DataController.shared.inspectionCarModel.e1Chehck = false
                DataController.shared.inspectionCarModel.f1Chehck = false
            } else {
                DataController.shared.inspectionCarModel.f1Chehck = true
                DataController.shared.inspectionCarModel.a1Chehck = false
                DataController.shared.inspectionCarModel.g1Chehck = false
                DataController.shared.inspectionCarModel.e1Chehck = false
            }
        }

    }
}


extension GradeCarViewController  {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registKeyboardNotification()
        calculateRegistrationYearAndMiles()
        prepareData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.resignKeyboardNotification()
    }
}
