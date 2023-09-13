//
//  ViewController+extension.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//

import Foundation
import UIKit


extension UIViewController {
    
    func registTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap);
    }
    
    @objc private func hideKeyboard(gesture: UITapGestureRecognizer){
        self.view.endEditing(true);
    }
    
    
    func popToRootViewController(title:String = "", confirm: Bool){
        if !confirm {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        if DataController.shared.isFromEditView {
            guard let nav = navigationController else { return }
            let foundItemList = nav.viewControllers.filter({ $0 is InspectionListViewController})

            if confirm {
                alert(message: String.localized("main_inspection_leave_edit_page_title"), title: title) { [weak self] in
                    if let vc  = foundItemList.first {
                        DataController.shared.clear()
                        self?.navigationController?.popToViewController(vc, animated: true)
                        
                        
                    }
                }
            }
        }else{
            alert(message: String.localized("main_inspection_back_to_main_title"), title: title) { [weak self] in
                DataController.shared.clear()
                self?.navigationController?.popToRootViewController(animated: true)
                
                
            }
        }
        
        
    }
    
    func alert(message: String, title: String = "" , _ confirm: @escaping () -> Void,
               cancel: (() -> Void)? = nil ) {
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: String.localized("select_inspection_dialog_ok"), style: .default, handler: {  _ in
            confirm()
        })
        let cancelAction = UIAlertAction(title: String.localized("select_inspection_dialog_no"), style: .default, handler: {  _ in
            cancel?()
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func alertErrorMessage(message: String, title: String = "", _ retry: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tryAction = UIAlertAction(title: String.localized("select_inspection_dialog_try"), style: .default, handler: {  _ in
            retry()
        })
        let cancelAction = UIAlertAction(title: String.localized("select_inspection_dialog_no"), style: .default, handler: {  _ in
                //ignored
        })
        alertController.addAction(cancelAction)
        alertController.addAction(tryAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertErrorMessageOKAction(message: String, title: String = "", _ action: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: String.localized("select_inspection_dialog_ok"), style: .default, handler: {  _ in
            action()
        })
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    enum CarInspectionPage {
        case PICKUP_CAR
        case CHECK_CAR
        case PHOTO_CAR
        
        var VC : UIViewController {
            switch self {
           
            case .PICKUP_CAR:
                return pickUpCarViewController
            case .CHECK_CAR:
                return checkCarViewController
            case .PHOTO_CAR:
                return photoCarViewController
            }
        }
        
        var pickUpCarViewController : PickUpCarViewController {
            let storyboardPickUp = UIStoryboard(name: "PickUpCar", bundle: nil)
            let pickup = storyboardPickUp.instantiateViewController(withIdentifier: "PickUpCarViewController") as! PickUpCarViewController
            return pickup
        }
        
        var checkCarViewController : CheckCarViewController {
            let storyboardCheckCar = UIStoryboard(name: "CheckCar", bundle: nil)
            let check = storyboardCheckCar.instantiateViewController(withIdentifier: "CheckCarViewController") as! CheckCarViewController
            return check
        }
        
        var photoCarViewController : PhotoCarViewController {
            let storyboardPhoto = UIStoryboard(name: "PhotoAndResultCar", bundle: nil)
            let photo = storyboardPhoto.instantiateViewController(withIdentifier: "PhotoCarViewController") as! PhotoCarViewController
            return photo
        }
    }
    
}
