//
//  LoginViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 1/2/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginDisplayLogic: AnyObject
{
    func displayResultLogin(viewModel: Login.getLogin.ViewModel)
    func displayValidateErrorMessage(viewModel: Login.getLogin.ViewModel)
    func displayValidateSuccess(viewModel: Login.getLogin.ViewModel)
    
    func displayErrorLogin(viewModel: Login.getLogin.ViewModel)
}

class LoginViewController: ViewController, LoginDisplayLogic
{
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
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
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
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
        
        
        setUpUIView()
        
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var usernameTextField: CustomTextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    // local strings
    
    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var loginButton: CustomUIButton!
    @IBOutlet weak var tipsMessageLabel: UILabel!
    
    override func initLocalString() {
        super.initLocalString()
        
        loginTitleLabel.text = String.localized("login_title_label")
        usernameTextField.placeholder = String.localized("login_user_name_placeholder")
        passwordTextField.placeholder = String.localized("login_password_placeholder")

        loginButton.setTitle(String.localized("login_title_label"), for: .normal)
        errorLabel.text = String.localized("login_error_name_or_password_message_label")
        tipsMessageLabel.text = String.localized("login_tips_message_label")
    }
    
    func doSomething()
    {
        
    }
    
    
    func login(){
        let request = Login.getLogin.Request(username: usernameTextField.text!,
                                             password: passwordTextField.text!)
        interactor?.validateField(request: request)
    }
    @IBAction func validateLogin(_ sender:Any){
        login()
    }
    
    func displayValidateErrorMessage(viewModel: Login.getLogin.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessageOKAction(message: errorMessage) {
            //ignored
        }
    }
    func displayValidateSuccess(viewModel: Login.getLogin.ViewModel) {
        let request = Login.getLogin.Request(username: usernameTextField.text!,
                                             password: passwordTextField.text!)
        interactor?.getLogin(request: request)
    }
    
    func displayErrorLogin(viewModel: Login.getLogin.ViewModel) {
        guard let errorMessage = viewModel.errorMessage else { return }
        alertErrorMessageOKAction(message: errorMessage) {
            //ignored
        }
        errorLabel.text = errorMessage
    }
    
    func displayResultLogin(viewModel: Login.getLogin.ViewModel) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setUpUIView(){
        versionLabel.text = DataController.shared.getVersion()
        
        errorLabel.text = ""
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        usernameTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .go
        
        usernameTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        usernameTextField.withImage(direction: .Left,
                                    image: UIImage(systemName: "person.fill")!,
                                    tintColor: .white,
                                    colorSeparator: .clear, colorBorder: .clear)
        
        passwordTextField.withImage(direction: .Left,
                                    image: UIImage(systemName: "lock.fill")!,
                                    tintColor: .white,
                                    colorSeparator: .clear, colorBorder: .clear)
        
        
        eyeImageView.isUserInteractionEnabled = true
        eyeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleEyeSlash)))
        eyeImageView.image = UIImage(systemName: "eye.slash.fill")
    }
    
    @objc func toggleEyeSlash(){
        let close =  UIImage(systemName: "eye.slash.fill")
        let open = UIImage(systemName: "eye.fill")
        let checkToggle = eyeImageView.image == close
        
        eyeImageView.image = checkToggle ? open : close
        passwordTextField.isSecureTextEntry = checkToggle ? false : true
    }
}


extension LoginViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.registKeyboardNotification()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.resignKeyboardNotification()
    }
    
    
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            login()
        }
        return true
    }
}
