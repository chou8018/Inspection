//
//  UIImage+extension.swift
//  Inspection
//
//  Created by Thanawat prathumset on 2/3/2564 BE.
//

import Foundation
import UIKit
extension UIImage {
    static var placeHolderImage : UIImage? {
        return UIImage(named: "logoApp-placeholder")
    }
    
    func getFileSize() -> Int? {
        return jpegData(compressionQuality: 1.0)?.count
    }
    
    func getSizeInfo(formatter: ByteCountFormatter, compressionQuality: CGFloat = 1.0) -> String? {
        guard let imageData = jpegData(compressionQuality: compressionQuality) else { return nil }
        return formatter.string(fromByteCount: Int64(imageData.count))
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
           let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
           return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
               _ in draw(in: CGRect(origin: .zero, size: canvas))
           }
       }
    
    func toBase64String() -> String {
        return jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
