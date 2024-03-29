//
//  InspectionListViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol InspectionListDisplayLogic: AnyObject
{
  func displaySomething(viewModel: InspectionList.Something.ViewModel)
}

class InspectionListViewController: UIViewController, InspectionListDisplayLogic
{
  var interactor: InspectionListBusinessLogic?
  var router: (NSObjectProtocol & InspectionListRoutingLogic & InspectionListDataPassing)?

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
    let interactor = InspectionListInteractor()
    let presenter = InspectionListPresenter()
    let router = InspectionListRouter()
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
    segmentSetUp()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var containerView: UIView!
    
  func doSomething()
  {
    let request = InspectionList.Something.Request()
    interactor?.doSomething(request: request)
  }
  func displaySomething(viewModel: InspectionList.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
    
    
    func segmentSetUp(){
        segmentView.addSubview(codeSegmented)
        codeSegmented.delegate = self
        updateUIView(from: 0)
    }
    

    lazy var codeSegmented:SegmentControlCustom  =  {
        let codeSegmented = SegmentControlCustom(frame: CGRect(x: 0, y: 0, width: segmentView.frame.width, height: 40), buttonTitle: ["รายการทั้งหมด","รายการตรวจค้าง"] ,fontSize: 30.0)
      
        codeSegmented.bgColor = .clear
        codeSegmented.selectorTextColor = UIColor.orangeColor
        codeSegmented.selectorViewColor = UIColor.orangeColor
        codeSegmented.textColor = UIColor.lightGray
        return codeSegmented
    }()
    private lazy var itemAllListViewController: ItemAllListViewController? = {
  
        var viewController = getViewCOntroller(identifier: "ItemAllListViewController") as! ItemAllListViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var itemPendingListViewController: ItemPendingListViewController? = {
        
        var viewController = getViewCOntroller(identifier: "ItemPendingListViewController") as! ItemPendingListViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)

        return viewController
    }()
    
    private func getViewCOntroller(identifier : String) -> UIViewController {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Instantiate View Controller
        return storyboard.instantiateViewController(withIdentifier: identifier)
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
    private func updateUIView(from index: Int){
        if index == 0 {
            add(asChildViewController: itemAllListViewController)
        } else {
            add(asChildViewController: itemPendingListViewController)
        }
    }
    @IBAction func toRootView(_ sender: Any) {
        popToRootViewController(confirm: false)
    }
    
    deinit {
        print("🔸🐶 deinit InspectionListViewController ")
        itemAllListViewController = nil
        itemPendingListViewController = nil
    }
}
extension InspectionListViewController : CustomSegmentedControlDelegate {
 
    func change(to index: Int , button : UIButton) {
        updateUIView(from: index)
        
    }
}

extension InspectionListViewController  {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: Clear Data
        DataController.shared.clear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    
    }
}
