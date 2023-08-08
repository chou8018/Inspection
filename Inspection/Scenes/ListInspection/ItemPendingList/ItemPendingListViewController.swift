//
//  ItemPendingListViewController.swift
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

protocol ItemPendingListDisplayLogic: AnyObject
{
  func displayResultTableView(viewModel: ItemPendingList.Fetch.ViewModel)
    
    func didSelectItemTableView(viewModel: ItemPendingList.Fetch.ViewModel)
    func displayShowDetail(viewModel: ItemPendingList.Fetch.ViewModel)
    func displayShowPdfViewer(viewModel: ItemPendingList.Fetch.ViewModel)
    
    func displayBookInDetail(viewModel: ItemPendingList.Fetch.ViewModel)
    func displayErrorGetBookInDetail(viewModel: ItemPendingList.Fetch.ViewModel)
 
    func displayErrorFetchItem(viewModel: ItemPendingList.Fetch.ViewModel)
}

class ItemPendingListViewController: UIViewController, ItemPendingListDisplayLogic
{
  var interactor: ItemPendingListBusinessLogic?
  var router: (NSObjectProtocol & ItemPendingListRoutingLogic & ItemPendingListDataPassing)?

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
    let interactor = ItemPendingListInteractor()
    let presenter = ItemPendingListPresenter()
    let router = ItemPendingListRouter()
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
        
        if let destinationQR = segue.destination as? DetailViewController {
            destinationQR.callbackSelectOption = {[weak self] option in
                let request = ItemPendingList.Fetch.Request()
                self?.interactor?.fetchBookinDetail(request: request, type: option)
            }
        }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    setUpTableView()
    
    
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerRowView: CustomUIView!
    
    let datasource = PendingListDataSource()
    
    func setUpTableView(){
        fullName.text = "\(String.localized("select_inspection_inspector_label")) \(DataController.shared.getFullName())"
        
        tableView.dataSource = datasource
        tableView.delegate = datasource
        
        datasource.didSelectRowAt = {[weak self] item in
            let request = ItemPendingList.Fetch.Request(didSelectItem: item)
            self?.interactor?.didSelectRow(request: request)
            
        }
    }
    
    func didSelectItemTableView(viewModel: ItemPendingList.Fetch.ViewModel) {
        performSegue(withIdentifier: "descriptionSegue", sender: nil)
    }
    func displayShowDetail(viewModel: ItemPendingList.Fetch.ViewModel) {
        performSegue(withIdentifier: "EditView", sender: nil)
    }
    func displayShowPdfViewer(viewModel: ItemPendingList.Fetch.ViewModel) {
        performSegue(withIdentifier: "ViewPDF", sender: nil)
    }
   
    
  func displayResultTableView(viewModel: ItemPendingList.Fetch.ViewModel)
  {
    datasource.itemList = viewModel.itemList ?? []
    datasource.tableType = viewModel.tableType ?? .NotFound
    tableView.reloadData()
  }
    
    func displayBookInDetail(viewModel: ItemPendingList.Fetch.ViewModel) {
        let request = ItemPendingList.Fetch.Request()
        interactor?.itemSelection(request: request)
    }
    
    
    func displayErrorGetBookInDetail(viewModel: ItemPendingList.Fetch.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return  }
        alertErrorMessageOKAction(message: errorMessage) {
            //pass
        }
    }
    func displayErrorFetchItem(viewModel: ItemPendingList.Fetch.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return  }
        alertErrorMessage(message: errorMessage) { [weak self] in
            self?.fetchPendingList()
        }
    }
    
    func fetchPendingList(){
        let request = ItemPendingList.Fetch.Request()
        interactor?.fetchPendingList(request: request)
    }
}


extension ItemPendingListViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        fetchPendingList()
    }
}
