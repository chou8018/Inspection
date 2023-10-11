//
//  ImagePickerView.swift
//  Customs2Home
//
//  Created by warodom on 19/11/2562 BE.
//  Copyright © 2562 Wittawas Mukdaprasert. All rights reserved.
//

import Foundation
import UIKit
import PhotosUI
import ZLPhotoBrowser

protocol ImagePickerPresenter : AnyObject {
    func didSelectCallback()
    func pickImageCallback(image : UIImage? , url : URL?)
    func pickImagesCallback(images : [UIImage]?)
}

open class ImagePicker: NSObject {
    
    private var pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    
    weak var delegateImage : ImagePickerPresenter?

    
    // Create configuration for photo picker
    var configuration = PHPickerConfiguration()
    
    // ZLPhotoBrowser
    var selectedImages: [UIImage] = []
    let config = ZLPhotoConfiguration.default()
    let uiConfig = ZLPhotoUIConfiguration.default()
    
    deinit {
        print("🔸🐶 deinit ImagePicker ")
    }
    
    
    public init(presentationController: UIViewController) {
        self.pickerController = UIImagePickerController()
        super.init()
        
        self.presentationController = presentationController

        
        self.pickerController.delegate = self
//        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
        
        
        // Specify type of media to be filtered or picked. Default is all
        configuration.filter = .images
        // For unlimited selections use 0. Default is 1
        configuration.selectionLimit = 0
        
        configZLPhotoBrowser()
    }
    
    private func configZLPhotoBrowser() {
        
        config.maxSelectCount = 100
        
        let minItemSpacing: CGFloat = 2
        let minLineSpacing: CGFloat = 2
        
        uiConfig
//            .navBarColor(.white)
//            .navViewBlurEffectOfAlbumList(nil)
//            .indexLabelBgColor(.black)
//            .indexLabelTextColor(.white)
            .minimumInteritemSpacing(minItemSpacing)
            .minimumLineSpacing(minLineSpacing)
            .columnCountBlock { Int(ceil($0 / (428.0 / 4))) }
        
        if uiConfig.languageType == .arabic {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .unspecified
        }
        
        // Custom image editor
        config
            .editImageConfiguration
            .imageStickerContainerView(ImageStickerContainerView())
            .canRedo(true)
        
        config.editImageConfiguration.tools.removeAll { $0 == .clip }
        config.editImageConfiguration.tools.removeAll { $0 == .imageSticker }
        config.editImageConfiguration.tools.removeAll { $0 == .mosaic }
        config.editImageConfiguration.tools.removeAll { $0 == .filter }
        config.editImageConfiguration.tools.removeAll { $0 == .adjust }
        config.editImageConfiguration.tools.insert(.imageSticker, at: 0)
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Save error  : \(error.localizedDescription)")
        } else {
            print("Saved!  has been saved to your photos.")

        }
    }
    
    private func actionPH(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
       
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            // Create instance of PHPickerViewController
            let picker = PHPickerViewController(configuration: configuration)
            // Set the delegate
            picker.delegate = self
            // Present the picker
//            self.presentationController?.present(picker, animated: true)
            self.showImagePicker(false)
        }
    }
    
    func showImagePicker(_ preview: Bool) {
        
        config.canSelectAsset { _ in
            true
        }
        
        config.noAuthorityCallback { type in
            switch type {
            case .library:
                debugPrint("No library authority")
            case .camera:
                debugPrint("No camera authority")
            case .microphone:
                debugPrint("No microphone authority")
            }
        }
        
        /// Using this init method, you can continue editing the selected photo
        let ac = ZLPhotoPreviewSheet(results: nil)
        
        ac.selectImageBlock = { [weak self] results, isOriginal in
            guard let `self` = self else { return }
            self.selectedImages = results.map { $0.image }
            debugPrint("images: \(self.selectedImages)")
            debugPrint("isEdited: \(results.map { $0.isEdited })")
            debugPrint("isOriginal: \(isOriginal)")
            
            self.delegateImage?.didSelectCallback()
//            self.selectedImages.forEach { (image) in
//                self.delegateImage?.pickImageCallback(image: image , url: URL(string: "https://inspecfakeurl.com/image/\(Date().DateToServerFormatString()).jpeg"))
//            }
//            self.delegateImage?.pickImagesCallback(images: self.selectedImages)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.delegateImage?.pickImagesCallback(images: self.selectedImages)
            }
        }
        ac.cancelBlock = {
            debugPrint("cancel select")
        }
        ac.selectImageRequestErrorBlock = { errorAssets, errorIndexs in
            debugPrint("fetch error assets: \(errorAssets), error indexs: \(errorIndexs)")
        }
        
        if let vc = self.presentationController {
            if preview {
                ac.showPreview(animate: true, sender: vc)
            } else {
                ac.showPhotoLibrary(sender: vc)
            }
        }
 
    }
    
    public func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: String.localized("photos_photograph_button_title")) {
            alertController.addAction(action)
        }

//        if let action = self.action(for: .photoLibrary, title: "เลือกรูป") {
//            alertController.addAction(action)
//        }
        if let action = self.actionPH(for: .photoLibrary, title: String.localized("photos_select_button_title")) {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?,imageURL: URL?) {
        if pickerController.sourceType == .camera {
            if let image = image {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
            
            controller.dismiss(animated: true, completion: { [weak self] in
                self?.delegateImage?.didSelectCallback()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.delegateImage?.pickImageCallback(image: image, url: imageURL)
                }
            })
            
        }else{
            delegateImage?.didSelectCallback()
            controller.dismiss(animated: true, completion: { [weak self] in
                self?.delegateImage?.pickImageCallback(image: image, url: imageURL)
            })
            
        }
        
        
    }
}
extension  ImagePicker : PHPickerViewControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        results.forEach { (image) in
            if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
                  if let error = error {
                    print("Can not load image \(error.localizedDescription)")
                  } else if let image = newImage as? UIImage {
                    // Add new image and pass it back to the main view
                    self?.delegateImage?.didSelectCallback()
                    self?.delegateImage?.pickImageCallback(image: image , url: URL(string: "https://inspecfakeurl.com/image/\(Date().DateToServerFormatString()).jpeg"))
                    //self?.pickImageCallback?(image , URL(string: "https://inspecfakeurl.com/image/\(Date().DateToServerFormatString()).webp"))
                    
                  }
                }
            
            } else {
              print("Can not load asset")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //self.pickerController(picker, didSelect: nil, imageURL: nil)
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil,imageURL: nil)
        }
      
        guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else {
            return self.pickerController(picker, didSelect: image,imageURL: URL(string: "https://inspecfakeurl.com/image/\(Date().DateToServerFormatString()).jpeg"))
            //return self.pickerController(picker, didSelect: image,imageURL: URL(string: "https://inspecfakeurl.com/image/\(Date().DateToServerFormatString()).webp"))
        }
        
        self.pickerController(picker, didSelect: image,imageURL: imageURL)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}
