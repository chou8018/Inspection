//
//  CustomProgressView.swift
//  Inspection
//
//  Created by Thanawat prathumset on 12/3/2564 BE.
//

import UIKit

class CustomProgressView: UIView {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var errorLabel : UILabel!
    @IBOutlet weak var progressView : UIProgressView!
    @IBOutlet weak var retryButton : UIButton!
    @IBOutlet weak var successView : UIImageView!
    @IBOutlet weak var stackView : UIStackView!
    
    var retryCallback: ((PhotoCar.PhotoImage)->Void)?
     
    var model : PhotoCar.PhotoImage? {
        didSet{
            bindData()
        }
    }
    var success : Bool = false {
        didSet{
            if success {
                showSuccessView()
            }
        }
    }
    var error : String? {
        didSet{
            showErrorView()
        }
    }
    var progress : Double = 0.0 {
        didSet{
            updateProgressView()
        }
    }
    
    @IBAction func retryTapped(_ sender: Any){
        print("will retry")
        guard let model = model else { return }
        retryButton.hideAnimated(in: stackView)
        errorLabel.hideAnimated(in: stackView)
        progressView.progress = 0.0
        retryCallback?(model)
    }
    
    func bindData(){
        guard let model = model else { return }
        nameLabel.text = model.name
        successView.isHidden = true
        retryButton.isHidden = true
        errorLabel.isHidden = true
        progressView.progress = 0.0
    }
    func updateProgressView(){
        progressView.setProgress(Float(progress), animated: true)
    }
    func showSuccessView(){
        //hide
        retryButton.hideAnimated(in: stackView)
        errorLabel.hideAnimated(in: stackView)
        
        //show
        successView.showAnimated(in: stackView)
    }
    func showErrorView(){
        guard let errorMessage = error else { return }
        errorLabel.text = errorMessage
        
        //hide
        successView.hideAnimated(in: stackView)
        
        //show
        
        errorLabel.showAnimated(in: stackView)
        retryButton.showAnimated(in: stackView)
    }
}
