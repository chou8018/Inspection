//
//  IMatQrcodePDFWorker.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 17/6/2564 BE.
//

import Foundation
import PDFKit

typealias responseQRCodePDFHandler = (_ response:PickUpCar.Something.Response) -> ()
class IMatQRCodePDFWorker {
    deinit {
        print("🔸🐶 deinit PickUpCarPDFWorker")
    }
    func generateIMATQRCodePDF(receiverCarModel:ReceiverCarModel, completion: @escaping responseQRCodePDFHandler){
        
        
        // 1 create a dictionary with the PDF’s metadata using predefined keys.
        let pdfMetaData = [
                kCGPDFContextCreator: "Inspection",
                kCGPDFContextAuthor: "mottoauction.com",
            ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        // 2  that PDF files use a coordinate system with 72 points per inch.
        //    size A4 8.27 × 11.69 inch
        //    5.8cm = 2.28inch
        let pageWidth = 2.28 * 72.0
        let pageHeight = 1.18 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        //width = 595,  height = 841
        
        
        // 3 create PDFRender
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        // 4 includes a block
        let data = renderer.pdfData { [weak self] (context) in
            guard let weakself = self else { return }
        // 5 starts a new PDF page. You must call beginPage() one time before giving any other drawing instructions.
            context.beginPage()
            
            let margin = CGFloat(5)
            
            let centerPosition = CGFloat(pageWidth/2)
            
          
            //MARK: logo
//            let logo = UIImage(named: "icon-pdf")!
//            let logoWidth = CGFloat(pageWidth/2)
//            let logoHeight = CGFloat(logoWidth/150*31)
//            logo.draw(in: CGRect(x: centerPosition - (logoWidth/2),
//                                 y: 10,
//                                 width: logoWidth, height: logoHeight))
//
//            let underLogo = logoHeight + margin
//
//
//            let underSenderName2 =  margin
//            //MARK: Text sender
//            let attrTextSenderPDF = weakself.getTitle(mainString: " ", value: "")
//            let attrTextSenderPDFSize = attrTextSenderPDF.size()
//            let stringTextSenderPDFRect = weakself.drawString(attrString: attrTextSenderPDF,
//                                                     x: margin,
//                                                     y: underSenderName2)

          
            
            //MARK: Table
            let mapPoint = weakself.createTableDrawLine(drawContext: context.cgContext,
                                pageWidth: CGFloat(pageWidth),
                                underOfText: CGFloat(15),
                                heightOffset: CGFloat(10),
                                margin: margin)
            
            //MARK: Type Car
//            let attrTypeCarTitlePDF = weakself.getTitle(mainString: "ประเภทรถ", value: "")
//            let _ = weakself.drawString(attrString: attrTypeCarTitlePDF,
//                                                       x: mapPoint["v1"]!,
//                                                       y: mapPoint["h1"]!,
//                                                       isTable: true)
             
           
            //MARK: vehicleId
//            let attrVehicleTitlePDF = weakself.getTitle(mainString: receiverCarModel.vehicleId,
//                                                        value: "", textColor: .black)
//            let _ = weakself.drawString(attrString: attrVehicleTitlePDF,
//                                                            x: mapPoint["v2"]!,
//                                                            y: mapPoint["h0"]!,
//                                                            isTable: true)
            //MARK: Type Car Value
            let attrTypeCarValueTitlePDF = weakself.getTitle(mainString: receiverCarModel.bodyDesc_BU?.pdfValidateString.uppercased() ?? "-",
                                                    value: "", textColor: .black)
            let _ = weakself.drawString(attrString: attrTypeCarValueTitlePDF,
                                                            x: mapPoint["v2"]!,
                                                            y: mapPoint["h1"]!,
                                                            isTable: true)
 
            //MARK: Model Car
//            let attrModelCarTitlePDF = weakself.getTitle(mainString: "รุ่น", value: "")
//            let _ = weakself.drawString(attrString: attrModelCarTitlePDF,
//                                                        x: mapPoint["v1"]!,
//                                                        y: mapPoint["h3"]!,
//                                                        isTable: true)
             
            
            //MARK: Model Car Value
            var carModelvalue = "\(receiverCarModel.modelCar?.pdfValidateString ?? "-")  "
            carModelvalue += "\(receiverCarModel.variants?.pdfValidateString ?? "")"
            let attrModelCarValuePDF = weakself.getTitle(mainString: carModelvalue.uppercased(),
                                                value: "", textColor: .black)
            let _ = weakself.drawString(attrString: attrModelCarValuePDF,
                                                        x: mapPoint["v2"]!,
                                                        y: mapPoint["h3"]!,
                                                        isTable: true)
            
            
            
            //MARK: Color Car
//            let attrColorTitlePDF = weakself.getTitle(mainString: "สี", value: "")
//            let _ =  weakself.drawString(attrString: attrColorTitlePDF,
//                                                      x: mapPoint["v1"]!,
//                                                      y: mapPoint["h4"]!,
//                                                      isTable: true)
            
            
            //MARK: Color Car Value
            let attrColorValuePDF = weakself.getTitle(mainString: receiverCarModel.colorCar?.pdfValidateString.uppercased() ?? "-",
                                             value: "", textColor: .black)
            let _ = weakself.drawString(attrString: attrColorValuePDF,
                                                     x: mapPoint["v2"]!,
                                                     y: mapPoint["h4"]!,
                                                     isTable: true)
             
            
            //MARK: brand
//            let attrBrandTitlePDF = weakself.getTitle(mainString: "ยี่ห้อ", value: "")
//            let _ = weakself.drawString(attrString: attrBrandTitlePDF,
//                                                     x: mapPoint["v1"]!,
//                                                     y: mapPoint["h2"]!,
//                                                     isTable: true)


            //MARK: brand value
            let attrBrandValuePDF = weakself.getTitle(mainString: receiverCarModel.make_BU?.pdfValidateString.uppercased() ?? "-",
                                             value: "", textColor: .black)
            let _ = weakself.drawString(attrString: attrBrandValuePDF,
                                                     x: mapPoint["v2"]!,
                                                     y: mapPoint["h2"]!,
                                                     isTable: true)
            
           
            //MARK: Registration
//            let attrRegistrationTitlePDF = weakself.getTitle(mainString: "ทะเบียน", value: "")
//            let _ = weakself.drawString(attrString: attrRegistrationTitlePDF,
//                                                            x: mapPoint["v1"]!,
//                                                            y: mapPoint["h5"]!,
//                                                            isTable: true)


    
            //MARK: Registration Value
            let registration = receiverCarModel.registration
            var registrationText = "\(registration?.pdfValidateString ?? "-")"
            registrationText += " \(receiverCarModel.province ?? "")"
            
            
            if let plate = receiverCarModel.registrationPlate , !plate.trimWhiteSpace.isEmpty {
                let note = receiverCarModel.registrationNote
                let isRegistrationMismatch = receiverCarModel.isRegistrationMismatch ?? false
                
                let isNotValidRegistration = registration?.uppercased().contains("PLATE") ?? false
                
                if isRegistrationMismatch {
                    registrationText = " \(note?.pdfValidateString2 ?? "")"
                    registrationText += " \(plate.pdfValidateString2)"
                }else{
                    
                    registrationText = isNotValidRegistration ? "" : "\(registration?.pdfValidateString2 ?? "")"
                    registrationText += " \(receiverCarModel.province ?? "")"
                    registrationText += " \(note?.pdfValidateString2 ?? "")"
                    registrationText += " \(plate.pdfValidateString2)"
                }
                
            }
            let attrRegistrationValuePDF = weakself.getTitle(mainString: registrationText.uppercased(), value: "", textColor: .black)
            let _ = weakself.drawString(attrString: attrRegistrationValuePDF,
                                                            x: mapPoint["v2"]!,
                                                            y: mapPoint["h5"]!,
                                                            isTable: true)
            
            
        
            //MARK: QRCode
            
            let qrSquareSize = CGFloat(56)
            
            let receiverNumber = receiverCarModel.vehicleId
            if receiverNumber.trimWhiteSpace.isEmpty {
                let placeholder = UIImage(named: "placeholder-image")!
//                placeholder.draw(in: CGRect(x: centerPosition - 60 ,
//                                       y: mapPoint["h5"]! + (margin + 10),
//                                       width: qrSquareSize, height: qrSquareSize))
                
                placeholder.draw(in: CGRect(x: mapPoint["v1"]!,
                                            y: mapPoint["h0"]!,
                                            width: qrSquareSize, height: qrSquareSize))
                
            }else{
                let qrString = "\(receiverNumber.trimWhiteSpace)"
                if let qrcode = weakself.generateQRCode(from: qrString) {

//                    qrcode.draw(in: CGRect(x: centerPosition - 60 ,
//                                           y: mapPoint["h5"]! + (margin + 10),
//                                           width: qrSquareSize, height: qrSquareSize))
                    
                   
                    qrcode.draw(in: CGRect(x: mapPoint["v1"]!,
                                           y: mapPoint["h0"]!,
                                           width: qrSquareSize, height: qrSquareSize))
                    
                }
                
                let attrIMATBNumberPDF = weakself.getTitle(mainString: "IMAT NO.",
                                                    value: "",
                                                    textColor: .black)
                let _ = weakself.drawString(attrString: attrIMATBNumberPDF,
                                            x: mapPoint["v1"]! + 12,
                                            y: mapPoint["h0"]!,
                                            isTable: true)
                
                let attrIMATPDF = weakself.getTitle(mainString: qrString,
                                                    value: "",
                                                    textColor: .black)
                let _ = weakself.drawString(attrString: attrIMATPDF,
                                            x: mapPoint["v2"]!,
                                            y: mapPoint["h0"]!,
                                            isTable: true)
            }
           

            
            
        }
        
        
        let response  = PickUpCar.Something.Response(documentData: data)
        completion(response)
        
    }
}


//MARK: Extension
extension IMatQRCodePDFWorker {
    
    func drawString(attrString : NSAttributedString , x : CGFloat , y : CGFloat, isTable:Bool = false) -> CGRect {
        let attrPDFSize = attrString.size()
        let attrPDFSizeRect = CGRect(x: x + (isTable ? 2 : 0),
                                     y: y - (isTable ? attrPDFSize.height : 0),
                                     width: attrPDFSize.width,  height: attrPDFSize.height)
        attrString.draw(in: attrPDFSizeRect)
        return attrPDFSizeRect
    }
    
     func createTableDrawLine(drawContext : CGContext ,
                             pageWidth : CGFloat,
                             underOfText : CGFloat,
                             heightOffset : CGFloat ,
                             margin : CGFloat) -> [String: CGFloat] {
        var mapPoint : [String:CGFloat] = [:]
        
        let heightOffset = heightOffset
        let heightTable = heightOffset * 5
        let underText = underOfText
        let yPosition = underText
        let margin = margin
       
        
        drawContext.setLineWidth(0.1)
        drawContext.saveGState()
        
        let tabWidth = pageWidth / 9
        // Draw content's  vertical lines
        for verticalLineIndex in 0..<10 {
            if  verticalLineIndex == 1 || verticalLineIndex == 2 ||
                verticalLineIndex == 4 || verticalLineIndex == 5 ||
                verticalLineIndex == 6 || verticalLineIndex == 7 ||
                verticalLineIndex == 8  {
                continue
            }
            var tabX = CGFloat(verticalLineIndex) * tabWidth
           
            if verticalLineIndex == 0 {
                tabX += margin
                
                mapPoint["v1"] = tabX
            }
            if verticalLineIndex == 3 {
                tabX += margin
                mapPoint["v2"] = tabX
            }
//            if verticalLineIndex == 5 {
//                mapPoint["v3"] = tabX
//            }
//            if verticalLineIndex == 6 {
//                mapPoint["v4"] = tabX //value2
//            }
//
            if verticalLineIndex == 9 {
                tabX -= margin
            }
//            drawContext.move(to: CGPoint(x: tabX, y: yPosition))
//            drawContext.addLine(to: CGPoint(x: tabX, y: yPosition + heightTable))
//            drawContext.strokePath()
            
        }
        
        // Draw content's element bottom horizontal line
        for  horizontalLine in 0..<6{
            
            let yPosition =  CGFloat(horizontalLine) * heightOffset + underText
            
            mapPoint["h\(horizontalLine)"] = yPosition
            
//            drawContext.move(to: CGPoint(x: margin, y: yPosition))
//            drawContext.addLine(to: CGPoint(x: CGFloat(pageWidth) - margin, y: yPosition))
//            drawContext.strokePath()
        }
        drawContext.restoreGState()
        
        return mapPoint
    }
    func getTitle(mainString : String, value : String , textColor : UIColor = .black) -> NSMutableAttributedString {
        let range = (mainString as NSString).range(of: value)
        let attr = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 6),
                    NSAttributedString.Key.foregroundColor: textColor]
        
        let mutableAttributedString = NSMutableAttributedString(string: mainString, attributes: attr)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        return mutableAttributedString
    }
    
    func getRectOfTableRow(x: CGFloat , y: CGFloat , pdfSize : CGSize) -> CGRect{
       return CGRect(x: x + 2, y: y - pdfSize.height,
                     width: pdfSize.width,
                     height: pdfSize.height)
    }
    
    func drawUnlderLine(drawContext : CGContext , startX : CGFloat, startY :CGFloat,
                        endX : CGFloat, endY :CGFloat){
        drawContext.setStrokeColor(UIColor.black.cgColor)
        drawContext.setLineWidth(1)
        drawContext.saveGState()
        drawContext.move(to: CGPoint(x: startX, y: startY))
        drawContext.addLine(to: CGPoint(x: endX, y: endY))
        drawContext.strokePath()
        drawContext.restoreGState()
    }
}

extension IMatQRCodePDFWorker {
    func generateQRCode(from string: String) -> UIImage?{
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            if let qrImage = filter.outputImage {
                let transform = CGAffineTransform(scaleX: 6, y: 6)
                let scaledQrImage = qrImage.transformed(by: transform)
                let context = CIContext(options: nil)
                if let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}

