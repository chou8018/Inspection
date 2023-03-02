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
                alert(message: "คุณต้องการกลับหน้ารายการไหม", title: title) { [weak self] in
                    if let vc  = foundItemList.first {
                        DataController.shared.clear()
                        self?.navigationController?.popToViewController(vc, animated: true)
                        
                        
                    }
                }
            }
        }else{
            alert(message: "คุณต้องการกลับหน้าหลักไหม", title: title) { [weak self] in
                DataController.shared.clear()
                self?.navigationController?.popToRootViewController(animated: true)
                
                
            }
        }
        
        
    }
    
    func alert(message: String, title: String = "" , _ confirm: @escaping () -> Void,
               cancel: (() -> Void)? = nil ) {
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "ตกลง", style: .default, handler: {  _ in
            confirm()
        })
        let cancelAction = UIAlertAction(title: "ยกเลิก", style: .default, handler: {  _ in
            cancel?()
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func alertErrorMessage(message: String, title: String = "", _ retry: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tryAction = UIAlertAction(title: "ลองใหม่", style: .default, handler: {  _ in
            retry()
        })
        let cancelAction = UIAlertAction(title: "ยกเลิก", style: .default, handler: {  _ in
                //ignored
        })
        alertController.addAction(cancelAction)
        alertController.addAction(tryAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertErrorMessageOKAction(message: String, title: String = "", _ action: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: {  _ in
            action()
        })
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    enum CarInspectionPage {
        case PICKUP_CAR
        case CHECK_CAR
        case PHOTO_CAR
        case REPO_CAR

        var VC : UIViewController {
            switch self {
           
            case .PICKUP_CAR:
                return pickUpCarViewController
            case .CHECK_CAR:
                return checkCarViewController
            case .PHOTO_CAR:
                return photoCarViewController
            case .REPO_CAR:
                return repoCarViewController
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
        
        var repoCarViewController : RepoCarViewController {
            let storyboardPhoto = UIStoryboard(name: "RepoCar", bundle: nil)
            let photo = storyboardPhoto.instantiateViewController(withIdentifier: "RepoCarViewController") as! RepoCarViewController
            return photo
        }
    }
    
    
}
