//
//  PickUpCarPDFWorker.swift
//  Inspection
//
//  Created by Thanawat prathumset on 29/3/2564 BE.
//

import Foundation
import PDFKit

typealias responsePDFHandler = (_ response:PickUpCar.Something.Response) -> ()
class PickUpCarPDFWorker {
    deinit {
        print("🔸🐶 deinit PickUpCarPDFWorker")
    }
    func generatePDFForReceiver(receiverCarModel:ReceiverCarModel, completion: @escaping responsePDFHandler){
        
        
        // 1 create a dictionary with the PDF’s metadata using predefined keys.
        let pdfMetaData = [
                kCGPDFContextCreator: "Inspection",
                kCGPDFContextAuthor: "mottoauction.com",
            ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        // 2  that PDF files use a coordinate system with 72 points per inch.
        //    size A4 8.27 × 11.69 inch
        let pageWidth = 8.27 * 72.0
        let pageHeight = 11.69 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        //width = 595,  height = 841
        
        
        // 3 create PDFRender
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        // 4 includes a block
        let data = renderer.pdfData { [weak self] (context) in
            guard let weakself = self else { return }
        // 5 starts a new PDF page. You must call beginPage() one time before giving any other drawing instructions.
            for numberOfPage in 0...1 {

                let updateDate = receiverCarModel.latestUpdatedDate
                let latestUpdateDate = weakself.getLatestUpdateDate(updateDate: updateDate)
                print("🔸\(latestUpdateDate)")
                
                context.beginPage()
                
                let margin = CGFloat(5)
                
                //MARK: logo
                let logo = UIImage(named: "icon-pdf")!
                let logoWidth = CGFloat(pageWidth/3)
                logo.draw(in: CGRect(x: margin + 10, y: margin + 10,
                                     width: logoWidth, height: CGFloat(logoWidth/150*31)))
                //MARK: Title
                let title = "ใบรับมอบรถยนต์ / Vehicle Receiving Report"
                let titleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                                 NSAttributedString.Key.backgroundColor: UIColor.black,
                                 NSAttributedString.Key.foregroundColor: UIColor.white]
                let attributedPDFTitle = NSAttributedString(string: title, attributes: titleAttr)
                let stringSize = attributedPDFTitle.size()
                let attributedPDFTitleRect = weakself.drawString(attrString: attributedPDFTitle,
                                            x: (pageRect.width  - stringSize.width) - (margin + 10),
                                            y: margin + 10)
              
                
                //MARK: QRCode
                let receiverNumber = receiverCarModel.bookinNo?.pdfValidateString ?? "-"
                let qrString = "inspectionandbookin://id=\(receiverNumber)"
                if let qrcode = weakself.generateQRCode(from: qrString) {
                    let qrSquareSize = CGFloat(50)

                    qrcode.draw(in: CGRect(x: CGFloat(pageWidth) - qrSquareSize - (margin + 10) ,
                                           y: attributedPDFTitleRect.maxY + margin,
                                           width: qrSquareSize, height: qrSquareSize))
                    
                   
                }
                //MARK: Copy
                var copyName = "ต้นฉบับ"
                if numberOfPage == 1 {
                    copyName = "สำเนา"
                }else{
                    copyName = "ต้นฉบับ"
                }
                let attrCopySpec = weakself.getTitle(mainString: copyName, value: "",
                                                     fontSize: 12)
                let copySize = attrCopySpec.size()
                let _ = weakself.drawString(attrString: attrCopySpec,
                                            x: attributedPDFTitleRect.minX - (copySize.width + margin + 10),
                                            y: attributedPDFTitleRect.minY)
              
                
                //MARK: ReceiverRunNumber
                let vehicleId = DataController.shared.receiverCarModel.vehicleId
                var imatNumberSpec = "IMAT NUMBER:  \(vehicleId.pdfValidateString)"
                if vehicleId.trimWhiteSpace.isEmpty {
                    imatNumberSpec = "IMAT NUMBER:  _____________________________"
                }else{
                    imatNumberSpec = "IMAT NUMBER:  \(vehicleId.pdfValidateString)"
                }
                let attrImatNumberSpec = weakself.getTitle(mainString: imatNumberSpec, value: "")
                let _ = weakself.drawString(attrString: attrImatNumberSpec,
                                            x: attributedPDFTitleRect.minX,
                                            y: attributedPDFTitleRect.maxY + (margin + 2))
                
                
               
                let underLogo = logo.size.height + margin
                let columnWidth = CGFloat(pageWidth/3)
                let centerPosition = CGFloat(pageWidth/2) - columnWidth/2
                let trailingPosition = CGFloat(pageWidth) - columnWidth
                
                //MARK: ReceiverRunNumber
                let receiverNumberValue = receiverCarModel.bookinNo?.pdfValidateString ?? "-"
                let receiverNumberTitle = "เลขที่ใบรับมอบรถ  \(receiverNumberValue)"
                let attrReceiverNumber = weakself.getTitle(mainString: receiverNumberTitle, value: receiverNumberValue)
                let stringReceiverNumberRect = weakself.drawString(attrString: attrReceiverNumber,
                                                          x: margin + 10,
                                                          y: underLogo)
                
                
                //MARK: ContractNumber
                let contractValue = receiverCarModel.contractNumber?.pdfValidateString ?? "-"
                let contractTitle = "เลขที่สัญญา  \(contractValue)"
                let attrContractPDF = weakself.getTitle(mainString: contractTitle, value: contractValue )
                let _ = weakself.drawString(attrString: attrContractPDF,
                                                       x: centerPosition,
                                                       y: underLogo)
                
                
                //MARK: DayReceiver
                let dayValue = receiverCarModel.dayString?.pdfValidateString ?? "-"
                let dayTitle = "วันที่รับรถ  \(dayValue)"
                let attrDayPDF = weakself.getTitle(mainString: dayTitle, value: dayValue)
                let _ = weakself.drawString(attrString: attrDayPDF,
                                                  x: trailingPosition,
                                                  y: underLogo)
                
                
                
                let underReceiverRunNumber =  stringReceiverNumberRect.maxY + margin
              
                //MARK: TimeReceiver
                let timeValue = "\(receiverCarModel.timeString?.pdfValidateString ?? "-") น."
                let timeTitle = "เวลา  \(timeValue)"
                let attrTimePDF = weakself.getTitle(mainString: timeTitle, value: timeValue)
                let stringTimePDFRect = weakself.drawString(attrString: attrTimePDF,
                                                   x: margin + 10,
                                                   y: underReceiverRunNumber)
                
                 
                
                //MARK: Place Receiver
                let placeValue = receiverCarModel.receiverPlace?.pdfValidateString ?? "-"
                let placeTitle = "สถานที่รับรถ  \(placeValue)"
                let attrPlaceReceiverCarPDF = weakself.getTitle(mainString: placeTitle, value: placeValue)
                let _ = weakself.drawString(attrString: attrPlaceReceiverCarPDF,
                                                               x: centerPosition,
                                                               y: underReceiverRunNumber)
                
               
                
                //MARK: Province Place Receiver
    //            let privinceValue = receiverCarModel.receiverPlace?.pdfValidateString ?? "-"
    //            let provinceTitle = "จังหวัด  \(privinceValue)"
    //            let attrProvincePlacePDF = getTitle(mainString: provinceTitle, value: privinceValue)
    //            let _ = drawString(attrString: attrProvincePlacePDF,
    //                                                        x: trailingPosition,
    //                                                        y: underReceiverRunNumber)
                
                
                let underTime =  stringTimePDFRect.maxY + margin
              
                //MARK: Sender Name
                let sender1Value = receiverCarModel.nameSender?.pdfValidateString ?? "-"
                let sender1Title = "ข้าพเจ้า  \(sender1Value)"
                let attrSenderNamePDF  = weakself.getTitle(mainString: sender1Title, value: sender1Value)
                let stringSenderNamePDFRect = weakself.drawString(attrString: attrSenderNamePDF,
                                                         x: margin + 10,
                                                         y: underTime)
                 
                
                //MARK: Company
                let companyValue = receiverCarModel.companyName?.pdfValidateString ?? "-"
                let companyTitle = "ผู้รับมอบอำนาจในการส่งมอบรถของบริษัท  \(companyValue)"
                let attrCompanyPDF = weakself.getTitle(mainString: companyTitle, value: companyValue)
                let _ = weakself.drawString(attrString: attrCompanyPDF,
                                                      x: centerPosition,
                                                      y: underTime)
                
                 
                
                let underSenderName = stringSenderNamePDFRect.maxY + margin

                //MARK: SenderName2
                let senderValue = receiverCarModel.nameSender?.pdfValidateString ?? "-"
                let senderTitle = "ลงชื่อ  \(senderValue)"
                let attrSenderName2PDF  = weakself.getTitle(mainString: senderTitle, value: senderValue)
                let stringSenderName2PDFRect = weakself.drawString(attrString: attrSenderName2PDF,
                                                          x: margin + 10,
                                                          y: underSenderName)
                
                
                //MARK: Phone
                let phoneValue = receiverCarModel.phoneNumber?.pdfValidateString ?? "-"
                let phoneTitle = "เบอร์โทร.  \(phoneValue)"
                let attrPhonePDF = weakself.getTitle(mainString: phoneTitle, value: phoneValue)
                let _ = weakself.drawString(attrString: attrPhonePDF,
                                                    x: stringSenderName2PDFRect.maxX + 5,
                                                    y: underSenderName)
                
                
                //MARK: Latest Update Date
                let latestUpdateDateTitle = "แก้ไขเมื่อ  \(latestUpdateDate)"
                let attrlatestUpdateDatePDF = weakself.getTitle(mainString: latestUpdateDateTitle, value: latestUpdateDate)
                let _ = weakself.drawString(attrString: attrlatestUpdateDatePDF,
                                                    x: centerPosition,
                                                    y: underSenderName)
               
                
                let underSenderName2 = stringSenderName2PDFRect.maxY + margin
                //MARK: Text sender
                let attrTextSenderPDF = weakself.getTitle(mainString: "(ผู้ส่งมอบรถยนต์) ได้ส่งมอบรถยนต์ให้แก่ตัวแทนของบริษัท มอตโต้ อ๊อคชั่น (ประเทศไทย) จำกัด ดังนี้", value: "")
                let attrTextSenderPDFSize = attrTextSenderPDF.size()
                let stringTextSenderPDFRect = weakself.drawString(attrString: attrTextSenderPDF,
                                                         x: margin + 10,
                                                         y: underSenderName2)
                
              
                
                let underOfText = stringTextSenderPDFRect.maxY + margin
                let heightOffset = attrTextSenderPDFSize.height  + margin
                //MARK: Table
                let mapPoint = weakself.createTableDrawLine(drawContext: context.cgContext,
                                    pageWidth: CGFloat(pageWidth),
                                    underOfText: underOfText,
                                    heightOffset: heightOffset,
                                    margin: margin)
                
                //MARK: Type Car
                let attrTypeCarTitlePDF = weakself.getTitle(mainString: "ประเภทรถ", value: "")
                let _ = weakself.drawString(attrString: attrTypeCarTitlePDF,
                                                           x: mapPoint["v1"]!,
                                                           y: mapPoint["h1"]!,
                                                           isTable: true)
                 
                
                //MARK: Type Car Value
                let attrTypeCarValueTitlePDF = weakself.getTitle(mainString: receiverCarModel.bodyDesc_BU?.pdfValidateString.uppercased() ?? "-",
                                                        value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrTypeCarValueTitlePDF,
                                                                x: mapPoint["v2"]!,
                                                                y: mapPoint["h1"]!,
                                                                isTable: true)
     
                //MARK: Model Car
                let attrModelCarTitlePDF = weakself.getTitle(mainString: "รุ่น", value: "")
                let _ = weakself.drawString(attrString: attrModelCarTitlePDF,
                                                            x: mapPoint["v1"]!,
                                                            y: mapPoint["h2"]!,
                                                            isTable: true)
                 
                
                //MARK: Model Car Value
                var carModelvalue = "\(receiverCarModel.modelCar?.pdfValidateString ?? "-")  "
                carModelvalue += "\(receiverCarModel.variants?.pdfValidateString ?? "")"
                let attrModelCarValuePDF = weakself.getTitle(mainString: carModelvalue.uppercased(),
                                                    value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrModelCarValuePDF,
                                                            x: mapPoint["v2"]!,
                                                            y: mapPoint["h2"]!,
                                                            isTable: true)
                
                
                
                //MARK: Color Car
                let attrColorTitlePDF = weakself.getTitle(mainString: "สี", value: "")
                let _ =  weakself.drawString(attrString: attrColorTitlePDF,
                                                          x: mapPoint["v1"]!,
                                                          y: mapPoint["h3"]!,
                                                          isTable: true)
                
                
                //MARK: Color Car Value
                let attrColorValuePDF = weakself.getTitle(mainString: receiverCarModel.colorCar?.pdfValidateString.uppercased() ?? "-",
                                                 value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrColorValuePDF,
                                                         x: mapPoint["v2"]!,
                                                         y: mapPoint["h3"]!,
                                                         isTable: true)
                 
                
                //MARK: engineNumberCar
                let attrEngineNumberTitlePDF = weakself.getTitle(mainString: "หมายเลขเครื่อง", value: "")
                let _ = weakself.drawString(attrString: attrEngineNumberTitlePDF,
                                                                x: mapPoint["v1"]!,
                                                                y: mapPoint["h4"]!,
                                                                isTable: true)
                
                
                //MARK: engineNumberCar Value
                let notValidateEngineCar = receiverCarModel.isInValidEngineNumber ?? false
                let reasonInvalidEngineNumber = "\(receiverCarModel.reasonInValidEngineNumber?.pdfValidateString2 ?? "-")"
                let engineNumber2 = "\(receiverCarModel.engineNumber?.pdfValidateString ?? "-")"
                var engineNumber = notValidateEngineCar ? "ตรวจสอบไม่ได้  " : ""
                engineNumber += notValidateEngineCar ? reasonInvalidEngineNumber : engineNumber2
                let attrEngineNumberValuePDF = weakself.getTitle(mainString: engineNumber.uppercased(),
                                                        value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrEngineNumberValuePDF,
                                                                x: mapPoint["v2"]!,
                                                                y: mapPoint["h4"]!,
                                                                isTable: true)
                
                
                
                //MARK: code model
                let attrCodeModelTitlePDF = weakself.getTitle(mainString: "รหัสรุ่นรถ", value: "")
                let _ = weakself.drawString(attrString: attrCodeModelTitlePDF,
                                                             x: mapPoint["v1"]!,
                                                             y: mapPoint["h5"]!,
                                                             isTable: true)
                
              
                
                //MARK: code model value
                let attrCodeModelValuePDF = weakself.getTitle(mainString: receiverCarModel.codeModelCar?.pdfValidateString.uppercased() ?? "-",
                                                     value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrCodeModelValuePDF,
                                                             x: mapPoint["v2"]!,
                                                             y: mapPoint["h5"]!,
                                                             isTable: true)
                 
                
                //MARK: brand
                let attrBrandTitlePDF = weakself.getTitle(mainString: "ยี่ห้อ", value: "")
                let _ = weakself.drawString(attrString: attrBrandTitlePDF,
                                                         x: mapPoint["v3"]!,
                                                         y: mapPoint["h1"]!,
                                                         isTable: true)
                
                
                //MARK: brand value
                let attrBrandValuePDF = weakself.getTitle(mainString: receiverCarModel.make_BU?.pdfValidateString.uppercased() ?? "-",
                                                 value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrBrandValuePDF,
                                                         x: mapPoint["v4"]!,
                                                         y: mapPoint["h1"]!,
                                                         isTable: true)
                
               
                
                //MARK: CC
                let attrCCTitlePDF = weakself.getTitle(mainString: "CC", value: "")
                let _ = weakself.drawString(attrString: attrCCTitlePDF,
                                                      x: mapPoint["v3"]!,
                                                      y: mapPoint["h2"]!,
                                                      isTable: true)
                 
                
                //MARK: CC Value
                var capacityCarText = "\(receiverCarModel.engineCapacity?.pdfValidateString ?? "-")  "
                capacityCarText += "\tปีผลิต \(receiverCarModel.year?.pdfValidateString ?? "-")  "
                capacityCarText += "ปีจดทะเบียน \(receiverCarModel.registrationYear?.pdfValidateString ?? "-")"
                let attrCCValuePDF = weakself.getTitle(mainString: capacityCarText.uppercased(),
                                              value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrCCValuePDF,
                                                      x: mapPoint["v4"]!,
                                                      y: mapPoint["h2"]!,
                                                      isTable: true)
                 
                //MARK: Registration
                let attrRegistrationTitlePDF = weakself.getTitle(mainString: "หมายเลขทะเบียน", value: "")
                let _ = weakself.drawString(attrString: attrRegistrationTitlePDF,
                                                                x: mapPoint["v3"]!,
                                                                y: mapPoint["h3"]!,
                                                                isTable: true)
                
                 
                
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
                
                let attrRegistrationValuePDF = weakself.getTitle(mainString: registrationText.uppercased(),
                                                        value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrRegistrationValuePDF,
                                                                x: mapPoint["v4"]!,
                                                                y: mapPoint["h3"]!,
                                                                isTable: true)
                
                
                //MARK: VIN
                let attrVinTitlePDF = weakself.getTitle(mainString: "หมายเลขตัวถัง", value: "")
                let _ = weakself.drawString(attrString: attrVinTitlePDF,
                                                       x: mapPoint["v3"]!,
                                                       y: mapPoint["h4"]!,
                                                       isTable: true)
                 
                //MARK: VIN Value
                let notValidateVinNumber = receiverCarModel.isInValidVinNumber ?? false
                let reasonInValidVinNumber = "\(receiverCarModel.reasonInValidVinNumber?.pdfValidateString2 ?? "")"
                let vinNumber2 = "\(receiverCarModel.vinNumber?.pdfValidateString ?? "-")"
                var vinNumber = notValidateVinNumber ? "ตรวจสอบไม่ได้  " : ""
                vinNumber += notValidateVinNumber ?  reasonInValidVinNumber : vinNumber2
                let attrVinValuePDF = weakself.getTitle(mainString: vinNumber.uppercased(),
                                               value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrVinValuePDF,
                                                       x: mapPoint["v4"]!,
                                                       y: mapPoint["h4"]!,
                                                       isTable: true)
                 
                
                //MARK: Gas Number
                let attrGasNumberTitlePDF = weakself.getTitle(mainString: "เลขถังแก๊ส", value: "")
                let _ = weakself.drawString(attrString: attrGasNumberTitlePDF,
                                                             x: mapPoint["v3"]!,
                                                             y: mapPoint["h5"]!,
                                                             isTable: true)
                
                //MARK: Gas Number Value
                let notValidateGasNumber = receiverCarModel.isInValidGasNumber ?? false
                let reasonInValidGasNumber = "\(receiverCarModel.reasonInValidGasNumber?.pdfValidateString2 ?? "")"
                let gasNumber2 = "\(receiverCarModel.gasNumber?.pdfValidateString ?? "-")"
                var gasNumber = notValidateGasNumber ? "ตรวจสอบไม่ได้  " : ""
                gasNumber += notValidateGasNumber ? reasonInValidGasNumber : gasNumber2
                let attrGasNumberValuePDF = weakself.getTitle(mainString: gasNumber.uppercased(),
                                                     value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrGasNumberValuePDF,
                                                             x: mapPoint["v4"]!,
                                                             y: mapPoint["h5"]!,
                                                             isTable: true)
                
              
                
                
                //MARK: Receiver Name
                let underTable = mapPoint["h5"]! + margin
                let valuenametext1 = "\(receiverCarModel.nameReceiver?.pdfValidateString ?? "-")"
                let attrReceiverNamePDF = weakself.getTitle(mainString: "ข้าพเจ้า  \t\(valuenametext1)",
                                                   value: valuenametext1)
                let stringReceiverNamePDFRect = weakself.drawString(attrString: attrReceiverNamePDF,
                                                           x: margin + 10,
                                                           y: underTable)
                
                
                
                //MARK: Receiver Text
                let attrReceiverTextPDF = weakself.getTitle(mainString: "  \tตัวแทนของบริษัท มอตโต้ อ๊อคชั่น (ประเทศไทย) จำกัด \"ผู้รับมอบรถยนต์\" และ \"ผู้ส่งมอบรถยนต์\"", value: "")
                let stringReceiverTextPDFRect = weakself.drawString(attrString: attrReceiverTextPDF,
                                                           x: stringReceiverNamePDFRect.maxX + margin,
                                                           y: underTable)
                 
                
                let underReceiverText = stringReceiverTextPDFRect.maxY + margin
                
                //MARK: Receiver Text2
                let receiverText2 = "ได้ร่วมกันตรวจสอบสภาพและรายละเอียดรถยนต์หมายเลขทะเบียน"
                let attrReceiverText2PDF = weakself.getTitle(mainString: receiverText2,
                                                    value: "")
                let stringReceiverText2PDFRect = weakself.drawString(attrString: attrReceiverText2PDF,
                                                            x: margin + 10,
                                                            y: underReceiverText)
               
                
                //MARK: Receiver Text3
                let text3 = "  \t\(registrationText.uppercased())\t  ดังกล่าวเรียบร้อยแล้ว"
                let attrReceiverText3PDF = weakself.getTitle(mainString: text3, value: registrationText.uppercased())
                let _ = weakself.drawString(attrString: attrReceiverText3PDF,
                                                            x: stringReceiverText2PDFRect.maxX + margin,
                                                            y: underReceiverText)
                
                let underReceiverText2 = stringReceiverText2PDFRect.maxY + margin
                
                //MARK: Receiver Text4
                let receiverText4 = "และขอรับรองว่าข้อมูลตามที่ระบุไว้ในข้างต้นนั้นถูกต้องตรงกับความเป็นจริงทุกประการ ลงชื่อ"
                let attrReceiverText4PDF = weakself.getTitle(mainString: receiverText4,
                                                    value: "")
                let stringReceiverText4PDFRect = weakself.drawString(attrString: attrReceiverText4PDF,
                                                            x: margin + 10,
                                                            y: underReceiverText2)
                
                //MARK: Receiver Text3
                let valuetext5 = "\(receiverCarModel.nameReceiver?.pdfValidateString ?? "-")"
                let attrReceiverText5PDF = weakself.getTitle(mainString: "  \t\(valuetext5)  \t(ผู้รับมอบรถยนต์)", value: valuetext5)
                let stringReceiverText5PDFRect = weakself.drawString(attrString: attrReceiverText5PDF,
                                                            x: stringReceiverText4PDFRect.maxX + margin,
                                                            y: underReceiverText2)
                
                 
                 
                let underReceiverText5 = stringReceiverText5PDFRect.maxY + margin
                  
                
                //MARK: 🔸Draw Signature
                let sig1ValueText = "ลงชื่อ___________________________ผู้ส่งมอบ"
                let sig1ValueTextPDF = weakself.getTitle(mainString: sig1ValueText, value: "")
                let _ = weakself.drawString(attrString: sig1ValueTextPDF,
                                                             x: centerPosition,
                                                             y: underReceiverText5 + (margin + 2))
                
                //MARK: 🔸Draw Signature
                let sig2ValueText = "ลงชื่อ___________________________ผู้รับมอบ"
                let sig2ValueTextPDF = weakself.getTitle(mainString: sig2ValueText, value: "")
                let _ = weakself.drawString(attrString: sig2ValueTextPDF,
                                                             x: trailingPosition,
                                                             y: underReceiverText5 + (margin + 2))
                
//                let underSig1ValueText = sig1ValueTextPDFRect.maxY + margin
                
                //MARK: External Car
                let externalTitle = "สภาพภายนอก\t\t\t"
                let externalTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                                 NSAttributedString.Key.backgroundColor: UIColor.black,
                                 NSAttributedString.Key.foregroundColor: UIColor.white]
                let attrExternalTitlePDFTitle = NSAttributedString(string: externalTitle,
                                                                   attributes: externalTitleAttr)
                let attrExternalPDFSizeRect = weakself.drawString(attrString: attrExternalTitlePDFTitle,
                                                         x: margin + 10,
                                                         y: underReceiverText5 + margin)
                
                
                //MARK: Draw Underline
                weakself.drawUnlderLine(drawContext: context.cgContext,
                               startX: margin + 10,
                               startY: attrExternalPDFSizeRect.maxY,
                               endX: CGFloat(pageWidth) - (margin + 10),
                               endY: attrExternalPDFSizeRect.maxY)
                
               
                let underExternalTitle = attrExternalPDFSizeRect.maxY + margin
                
                                
                
                //MARK: External OverAll
                let overAllValueText = receiverCarModel.externalOverall?.pdfValidateString ?? "-"
                let overallText = "สภาพภายนอกโดยรวม  \(overAllValueText)"
                let attrExternalOverAllTitlePDFTitle = weakself.getTitle(mainString: overallText,
                                                                value: overAllValueText)
                let _ = weakself.drawString(attrString: attrExternalOverAllTitlePDFTitle,
                                                            x: margin + 10,
                                                            y: underExternalTitle)
                 
               
                
                //MARK: Color OverAll
                let colorValueText = receiverCarModel.colorOverall?.pdfValidateString ?? "-"
                let colorOverAllText = "สภาพสีโดยรวม  \(colorValueText)"
                let attrColorOverAllPDF = weakself.getTitle(mainString: colorOverAllText, value: colorValueText)
                let _ = weakself.drawString(attrString: attrColorOverAllPDF,
                                                             x: centerPosition,
                                                             y: underExternalTitle)
              
                
                //MARK: Spoiler
                let spoilerValueText = receiverCarModel.isSpoiler ?? false ? "มี" : "ไม่มี"
                let spoilerText = "สปอยเลอร์  \(spoilerValueText)"
                let attrSpoilerPDF = weakself.getTitle(mainString: spoilerText, value: spoilerValueText)
                let attrSpoilerPDFSizeRect = weakself.drawString(attrString: attrSpoilerPDF,
                                                        x: trailingPosition,
                                                        y: underExternalTitle)
                
                 
                let underSpoiler = attrSpoilerPDFSizeRect.maxY + margin
                
                //MARK: Mag Wheel
                let magWheelValue = receiverCarModel.isMagWheel ? "มี" : "ไม่มี"
                let magWheelText = "ล้อแม็กซ์  \(magWheelValue)"
                let attrMagWheelPDF = weakself.getTitle(mainString: magWheelText, value: magWheelValue)
                let attrMagWheelPDFSizeRect = weakself.drawString(attrString: attrMagWheelPDF,
                                                         x: margin + 10,
                                                         y: underSpoiler)
                                                          
                
                //MARK: Mag Wheel Amount
                let magWheelAmountValue = receiverCarModel.magWheelAmount?.pdfValidateString ?? "-"
                let magWheelAmountText = "  จำนวน  \(magWheelAmountValue)  วง"
                let attrMagWheelAmountPDF = weakself.getTitle(mainString: magWheelAmountText,
                                                     value: magWheelAmountValue)
                let _ = weakself.drawString(attrString: attrMagWheelAmountPDF,
                                                               x: attrMagWheelPDFSizeRect.maxX + margin,
                                                               y: underSpoiler)
                 
                //MARK: Tire
                let isTireValue = receiverCarModel.isTire ?? false ? "มี" : "ไม่มี"
                let isTireText = "ยาง  \(isTireValue)"
                let attrIsTirePDF = weakself.getTitle(mainString: isTireText, value: isTireValue)
                let attrIsTirePDFSizeRect = weakself.drawString(attrString: attrIsTirePDF,
                                                       x: centerPosition,
                                                       y: underSpoiler)
               
                
                //MARK: Tire Quality
                let tireQualityValue = receiverCarModel.tireQuality?.pdfValidateString ?? "-"
                let tireQualityText = "  สภาพ  \(tireQualityValue)  %"
                let attrTireQualityPDF = weakself.getTitle(mainString: tireQualityText, value: tireQualityValue)
                let attrTireQualityPDFSizeRect = weakself.drawString(attrString: attrTireQualityPDF,
                                                            x: attrIsTirePDFSizeRect.maxX + margin,
                                                            y: underSpoiler)
                
                
                
                //MARK: Tire Brand
                let tireBrandValue = receiverCarModel.brandTire?.pdfValidateString ?? "-"
                let tireBrandText = "  ยี่ห้อ  \(tireBrandValue)"
                let attrTireBrandPDF = weakself.getTitle(mainString: tireBrandText, value: tireBrandValue)
                let _ = weakself.drawString(attrString: attrTireBrandPDF,
                                                          x: attrTireQualityPDFSizeRect.maxX + margin,
                                                          y: underSpoiler)
                
                 
                
                let underMagWheel = attrMagWheelPDFSizeRect.maxY + margin
                
                //MARK: Damage Detail
                let damageDetailValue = receiverCarModel.damageDetail?
                                        .pdfValidateString
                                        .pdfReFormString(title: "รายละเอียดร่องรอยความเสียหาย  ")  ?? "-"
                let damageDetailText = "รายละเอียดร่องรอยความเสียหาย  \(damageDetailValue)"
                let attrDamageDetailPDF = weakself.getTitle(mainString: damageDetailText, value: damageDetailValue)
                let attrDamageDetailPDFSizeRect = weakself.drawString(attrString: attrDamageDetailPDF,
                                                             x: margin + 10,
                                                             y: underMagWheel)
                
                
                let underDamageDetail = attrDamageDetailPDFSizeRect.maxY + margin
                
                
                //MARK: Cabin
                let cabinTitle = "สภาพภายในห้องโดยสาร\t"
                let cabinTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                                 NSAttributedString.Key.backgroundColor: UIColor.black,
                                 NSAttributedString.Key.foregroundColor: UIColor.white]
                let attrCabinTitlePDFTitle = NSAttributedString(string: cabinTitle,
                                                                   attributes: cabinTitleAttr)
                let attrCabinPDFSizeRect = weakself.drawString(attrString: attrCabinTitlePDFTitle,
                                                      x: margin + 10,
                                                      y: underDamageDetail)
               
                
                
                //MARK: Draw Underline Cabin
                weakself.drawUnlderLine(drawContext: context.cgContext,
                               startX: margin + 10,
                               startY: attrCabinPDFSizeRect.maxY,
                               endX: CGFloat(pageWidth) - (margin + 10),
                               endY: attrCabinPDFSizeRect.maxY)
                
                let underCabinTitle = attrCabinPDFSizeRect.maxY + margin
                
                //MARK: Cabin OverAll
                let cabinOverAllValueText = receiverCarModel.cabinOverall?.pdfValidateString ?? "-"
                let cabinOverAllText = "สภาพภายในโดยรวม  \(cabinOverAllValueText)"
                let attrCabinOverAllPDFTitle = weakself.getTitle(mainString: cabinOverAllText,
                                                                value: cabinOverAllValueText)
                let _ = weakself.drawString(attrString: attrCabinOverAllPDFTitle,
                                                             x: margin + 10,
                                                             y: underCabinTitle)
                 
                
                //MARK: Cabin Miles
                let milesType = receiverCarModel.typeMiles?.pdfValidateString ?? "-"
                let milesValueText = receiverCarModel.miles?.pdfValidateString ?? "-"
                var milesValueR = "\(milesValueText)  \(milesType)"
                var milesText = "เลขไมล์  \(milesValueR)"
                
                if let isInValid = receiverCarModel.isInvalidMileage, (isInValid == true) {
                    let reason  = receiverCarModel.invalidMileageReason?.pdfValidateString2 ?? ""
                    milesValueR = "ตรวจสอบไม่ได้ \(reason)"
                    milesText = "เลขไมล์ \(milesValueR)"
                }
                
                let attrMilesPDFTitle = weakself.getTitle(mainString: milesText,  value: milesValueR)
                let _ = weakself.drawString(attrString: attrMilesPDFTitle,
                                                      x: centerPosition,
                                                      y: underCabinTitle)
                
               
                
                //MARK: Oil Amount
                let amountOilValueText = receiverCarModel.oilAmount?.pdfValidateString ?? "-"
                let amountOilText = "ปริมาณน้ำมัน  \(amountOilValueText)"
                let attrAmountOilPDFTitle = weakself.getTitle(mainString: amountOilText,  value: amountOilValueText)
                let attrAmountOilPDFSizeRect = weakself.drawString(attrString: attrAmountOilPDFTitle,
                                                          x: trailingPosition,
                                                          y: underCabinTitle)
             
                
                let underCabinOverAllValue = attrAmountOilPDFSizeRect.maxY + margin
                
                
                //MARK: Airback
                let airbackValue = receiverCarModel.isAirback ?? false ? "มี" : "ไม่มี"
                let airbackText = "แอร์แบ็ค  \(airbackValue)"
                let attrAirbackPDFTitle = weakself.getTitle(mainString: airbackText, value: airbackValue)
                let attrAirbackPDFSizeRect = weakself.drawString(attrString: attrAirbackPDFTitle,
                                                        x: margin + 10,
                                                        y: underCabinOverAllValue)
                
                //MARK: Type Gear
               
                var typeGearValue = "AT"
                switch receiverCarModel.gearbox?.trimWhiteSpace {
                case "1":
                    typeGearValue = "N/A"
                case "A":
                    typeGearValue = "AT"
                case "M":
                    typeGearValue = "MT"
                default:
                    typeGearValue = "AT"
                }
                let typeGearText = "เกียร์  \(typeGearValue)"
                let attrTypeGearPDFTitle = weakself.getTitle(mainString: typeGearText, value: typeGearValue)
                let _ = weakself.drawString(attrString: attrTypeGearPDFTitle,
                                                         x: centerPosition,
                                                         y: underCabinOverAllValue)
               
                
                let underAirback = attrAirbackPDFSizeRect.maxY + margin
                //MARK: Player
                var playerValue = "\(receiverCarModel.isPlayer ? "มี" : "ไม่มี")  "
                playerValue += "\(receiverCarModel.isPlayerRadio ?? false ? "วิทยุ" : "")  "
                playerValue += "\(receiverCarModel.isPlayerTape ?? false ? "เทป" : "")  "
                playerValue += "\(receiverCarModel.isPlayerCD ?? false ? "CD" : "")  "
                playerValue += "\(receiverCarModel.isPlayerUSB ?? false ? "USB" : "")  "
                let playerText = "เครื่องเล่น  \(playerValue)"
                let attrPlayerPDFTitle = weakself.getTitle(mainString: playerText, value: playerValue)
                let attrPlayerPDFSizeRect = weakself.drawString(attrString: attrPlayerPDFTitle,
                                                       x: margin + 10,
                                                       y: underAirback)
       
                
                //MARK: Player brand
                let playerBrandValue = receiverCarModel.brandPlayer?.pdfValidateString ?? "-"
                let playerBrandText = "  ยี่ห้อ  \(playerBrandValue)"
                let attrPlayerBrandPDFTitle = weakself.getTitle(mainString: playerBrandText, value: playerBrandValue)
                let attrPlayerBrandPDFSizeRect = weakself.drawString(attrString: attrPlayerBrandPDFTitle,
                                                            x: attrPlayerPDFSizeRect.maxX + margin,
                                                            y: underAirback)
                 
                
                //MARK: HeadGear
                let headGearValue = receiverCarModel.isHeadGear ?? false ? "มี" : "ไม่มี"
                let headGearText = "หัวเกียร์  \(headGearValue)"
                let attrHeadGearPDFTitle = weakself.getTitle(mainString: headGearText, value: headGearValue)
                let _ = weakself.drawString(attrString: attrHeadGearPDFTitle,
                                                         x: centerPosition,
                                                         y: underAirback)
                
                
                let underPlayer = attrPlayerBrandPDFSizeRect.maxY + margin

                
                //MARK: PowerAmp
                let powerAmpValue = receiverCarModel.isPowerAmp ?? false ? "มี" : "ไม่มี"
                let powerAmpText = "พาวเวอร์แอมป์  \(powerAmpValue)"
                let attrPowerAmpPDFTitle = weakself.getTitle(mainString: powerAmpText, value: powerAmpValue)
                let attrPowerAmpPDFSizeRect = weakself.drawString(attrString: attrPowerAmpPDFTitle,
                                                         x: margin + 10,
                                                         y: underPlayer)
              
                
                //MARK: LockGear
                let lockGearValue = receiverCarModel.isLockGear ?? false ? "มี" : "ไม่มี"
                let lockGearText = "ล๊อคเกียร์  \(lockGearValue)"
                let attrLockGearPDFTitle = weakself.getTitle(mainString: lockGearText, value: lockGearValue)
                let _ = weakself.drawString(attrString: attrLockGearPDFTitle,
                                                         x: centerPosition,
                                                         y: underPlayer)
                
                
                let underPowerAmp = attrPowerAmpPDFSizeRect.maxY + margin
                
                //MARK: PreAmp
                let preAmpValue = receiverCarModel.isPreAmp ?? false ? "มี" : "ไม่มี"
                let preAmpText = "ปรีแอมป์  \(preAmpValue)"
                let attrPreAmpPDFTitle = weakself.getTitle(mainString: preAmpText, value: preAmpValue)
                let attrPreAmpPDFSizeRect = weakself.drawString(attrString: attrPreAmpPDFTitle,
                                                       x: margin + 10,
                                                       y: underPowerAmp)
               
                
                //MARK: Book service
                let bsValue = receiverCarModel.isBookService ?? false ? "มี" : "ไม่มี"
                let bsText = "Book Service  \(bsValue)"
                let attrBsPDFTitle = weakself.getTitle(mainString: bsText, value: bsValue)
                let _ = weakself.drawString(attrString: attrBsPDFTitle,
                                                   x: centerPosition,
                                                   y: underPowerAmp)
                
                let underPreAmp = attrPreAmpPDFSizeRect.maxY + margin
                
                //MARK: Speaker
                let speakerValue = receiverCarModel.isSpeaker ?? false ? "มี" : "ไม่มี"
                let speakerText = "ลำโพง  \(speakerValue)"
                let attrSpeakerPDFTitle = weakself.getTitle(mainString: speakerText, value: speakerValue)
                let attrSpeakerPDFSizeRect = weakself.drawString(attrString: attrSpeakerPDFTitle,
                                                        x: margin + 10,
                                                        y: underPreAmp)
               
                
                //MARK: Manual
                let manualValue = receiverCarModel.isManual ?? false ? "มี" : "ไม่มี"
                let manualText = "คู่มือ  \(manualValue)"
                let attrManualPDFTitle = weakself.getTitle(mainString: manualText, value: manualValue)
                let _ = weakself.drawString(attrString: attrManualPDFTitle,
                                                       x: centerPosition,
                                                       y: underPreAmp)
                 
                let underSpeaker = attrSpeakerPDFSizeRect.maxY + margin
                 
                //MARK: Cigarate
                let cigaretteValue = receiverCarModel.isCigaretteLighter ?? false ? "มี" : "ไม่มี"
                let cigaretteText = "ที่จุดบุหรี่  \(cigaretteValue)"
                let attrCigarettePDFTitle = weakself.getTitle(mainString: cigaretteText, value: cigaretteValue)
                let attrCigarettePDFSizeRect = weakself.drawString(attrString: attrCigarettePDFTitle,
                                                          x: margin + 10,
                                                          y: underSpeaker)
                
                
                //MARK: TaxPlate
                let taxPlateValue = receiverCarModel.isTaxPlate ?? false ? "มี" : "ไม่มี"
                let taxPlateText = "ป้ายวงกลม  \(taxPlateValue)"
                let attrTaxPlatePDFTitle = weakself.getTitle(mainString: taxPlateText, value: taxPlateValue)
                let attrTaxPlatePDFSizeRect = weakself.drawString(attrString: attrTaxPlatePDFTitle,
                                                         x: centerPosition,
                                                         y: underSpeaker)
                 
                //MARK: TaxPlate Day
                let taxPlateExpiredValue = receiverCarModel.dateExpiredTaxPlate?.pdfValidateString ?? "-"
                let taxPlateExpiredText = "  วันหมดอายุ  \(taxPlateExpiredValue)"
                let attrTaxPlateExpiredPDFTitle = weakself.getTitle(mainString: taxPlateExpiredText,
                                                           value: taxPlateExpiredValue)
                let _ = weakself.drawString(attrString: attrTaxPlateExpiredPDFTitle,
                                                                x: attrTaxPlatePDFSizeRect.maxX + margin,
                                                                y: underSpeaker)
                
                 
                let underCigarate = attrCigarettePDFSizeRect.maxY + margin
                
                
                //MARK: Keys
                let isKeysValue = receiverCarModel.isKeys ?? false ? "มี" : "ไม่มี"
                let keyValue = "\(isKeysValue) \(receiverCarModel.itemKeys)"
                let keysText = "กุญแจ  \(keyValue)"
                let attrKeysPDFTitle = weakself.getTitle(mainString: keysText, value: keyValue)
                let attrKeysPDFSizeRect = weakself.drawString(attrString: attrKeysPDFTitle,
                                                     x: margin + 10,
                                                     y: underCigarate)
               
                
                let underKeys = attrKeysPDFSizeRect.maxY + margin
                //MARK: Navigation
                var navigatorValue = "\(receiverCarModel.isNavigator ?? false ? "มี" : "ไม่มี")  "
                navigatorValue += "\(receiverCarModel.isNavigatorOnCar ?? false ? "เนวิเกเตอร์ในตัว" : "")  "
                navigatorValue += "\(receiverCarModel.isCd ?? false ? "CD" : "")  "
                navigatorValue += "\(receiverCarModel.isSDCard ?? false ? "SD CARD" : "")  "
                navigatorValue += "\(receiverCarModel.isNoCd ?? false ? "ไม่มี CD" : "")  "
                navigatorValue += "\(receiverCarModel.isNoSdCard ?? false ? "ไม่มี SD CARD" : "")  "
                let navigatorText = "เนวิเกเตอร์  \(navigatorValue)"
                
    //            let isNavigatorValue = receiverCarModel.isNavigator ? "มี" : "ไม่มี"
    //            let navigatorValue = "\(isNavigatorValue) \(receiverCarModel.itemNavigatorString)"
    //            let navigatorText = "เนวิเกเตอร์  \(navigatorValue)"
                let attrNavigatorPDFTitle = weakself.getTitle(mainString: navigatorText, value: navigatorValue)
                let attrNavigatorPDFSizeRect = weakself.drawString(attrString: attrNavigatorPDFTitle,
                                                          x: margin + 10,
                                                          y: underKeys)
                
                
                let underNavigator = attrNavigatorPDFSizeRect.maxY + margin
                //MARK: note Cabin
                let noteCabinValue = receiverCarModel.noteCabin?
                                    .pdfValidateString
                                    .pdfReFormString(title: "อื่นๆ  ")  ?? "-"
                let noteCabinText = "อื่นๆ  \(noteCabinValue)"
                let attrNoteCabinPDF = weakself.getTitle(mainString: noteCabinText, value: noteCabinValue)
                let attrNoteCabinPDFSizeRect = weakself.drawString(attrString: attrNoteCabinPDF,
                                                          x: margin + 10,
                                                          y: underNavigator)
                 
                let underNoteCabin = attrNoteCabinPDFSizeRect.maxY + margin
                
                //MARK: SpareParts
                let spareTitle = "ห้องสัมภาระ\t\t\t\t"
                let spareTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                                 NSAttributedString.Key.backgroundColor: UIColor.black,
                                 NSAttributedString.Key.foregroundColor: UIColor.white]
                let attrSpareTitlePDFTitle = NSAttributedString(string: spareTitle,
                                                                   attributes: spareTitleAttr)
                let attrSparePDFSizeRect = weakself.drawString(attrString: attrSpareTitlePDFTitle,
                                                      x: margin + 10,
                                                      y: underNoteCabin)
                 
                
                //MARK: Draw Underline Spare
                weakself.drawUnlderLine(drawContext: context.cgContext,
                               startX: margin + 10,
                               startY: attrSparePDFSizeRect.maxY,
                               endX: CGFloat(pageWidth) - (margin + 10),
                               endY: attrSparePDFSizeRect.maxY)
                
                let underSpare = attrSparePDFSizeRect.maxY + margin
                
                //MARK: SpareOverAll
                let spareOverallValue = receiverCarModel.spareOverAll?.pdfValidateString ?? "-"
                let spareOverallText = "สภาพห้องสัมภาระโดยรวม  \(spareOverallValue)"
                let attrSpareOverAllPDFTitle = weakself.getTitle(mainString: spareOverallText, value: spareOverallValue)
                let attrSpareOverAllPDFSizeRect = weakself.drawString(attrString: attrSpareOverAllPDFTitle,
                                                             x: margin + 10,
                                                             y: underSpare)
                 
                
                //MARK: SpareOverAll Note
                let spareOverallNoteValue = receiverCarModel.spareOverAllNote?.pdfValidateString ?? "-"
                let spareOverallNoteText = "  หมายเหตุ  \(spareOverallNoteValue)"
                let attrSpareOverAllNotePDFTitle = weakself.getTitle(mainString: spareOverallNoteText,
                                                            value: spareOverallNoteValue)
                let _ = weakself.drawString(attrString: attrSpareOverAllNotePDFTitle,
                                                                 x: attrSpareOverAllPDFSizeRect.maxX + margin,
                                                                 y: underSpare)
                 
                let underSpareOverAll = attrSpareOverAllPDFSizeRect.maxY + margin
                
                //MARK: SpareTire
                let spareTireValue = receiverCarModel.isSpareTire ?? false ? "มี" : "ไม่มี"
                let spareTireText = "ยางอะไหล่  \(spareTireValue)"
                let attrSpareTirePDFTitle = weakself.getTitle(mainString: spareTireText, value: spareTireValue)
                let attrSpareTirePDFSizeRect = weakself.drawString(attrString: attrSpareTirePDFTitle,
                                                          x: margin + 10,
                                                          y: underSpareOverAll)
                
                //MARK: SpareTools
                let spareToolsValue = receiverCarModel.isHandTool ?? false ? "มี" : "ไม่มี"
                let spareToolsText = "เครื่องมือ  \(spareToolsValue)"
                let attrSpareToolsPDFTitle = weakself.getTitle(mainString: spareToolsText, value: spareToolsValue)
                let _ = weakself.drawString(attrString: attrSpareToolsPDFTitle,
                                                           x: centerPosition,
                                                           y: underSpareOverAll)
                 
                
                //MARK: Maxliner
                let maxlinerValue = receiverCarModel.isMaxliner ?? false ? "มี" : "ไม่มี"
                let maxlinerText = "แม็กไลน์เนอร์  \(maxlinerValue)"
                let attrMaxlinerPDFTitle = weakself.getTitle(mainString: maxlinerText, value: maxlinerValue)
                let _ = weakself.drawString(attrString: attrMaxlinerPDFTitle,
                                                         x: trailingPosition,
                                                         y: underSpareOverAll)
               
                
                let underSpareTire = attrSpareTirePDFSizeRect.maxY + margin
                
                //MARK: Roofrack
                let roofrackValue = receiverCarModel.isRoofrack ?? false ? "มี" : "ไม่มี"
                let roofrackText = "แร็คหลังคา  \(roofrackValue)"
                let attrRoofrackPDFTitle = weakself.getTitle(mainString: roofrackText, value: roofrackValue)
                let attrRoofrackPDFSizeRect = weakself.drawString(attrString: attrRoofrackPDFTitle,
                                                         x: margin + 10,
                                                         y: underSpareTire)
            
                
                //MARK: Crane
                let craneValue = receiverCarModel.isJackCar ?? false ? "มี" : "ไม่มี"
                let craneText = "แม่แรง  \(craneValue)"
                let attrCranePDFTitle = weakself.getTitle(mainString: craneText, value: craneValue)
                let _ = weakself.drawString(attrString: attrCranePDFTitle,
                                                      x: centerPosition,
                                                      y: underSpareTire)
                
                
                //MARK: CableChargeEV
                let cableChargeValue = receiverCarModel.isCableChargeEV ?? false ? "มี" : "ไม่มี"
                let cableChargeEVText = "สายชาร์จไฟ EV  \(cableChargeValue)"
                let attrCableChargeEVPDFTitle = weakself.getTitle(mainString: cableChargeEVText, value: cableChargeValue)
                let _ = weakself.drawString(attrString: attrCableChargeEVPDFTitle,
                                                              x: trailingPosition,
                                                              y: underSpareTire)
                
                
                
                
                let underRoofrack = attrRoofrackPDFSizeRect.maxY + margin
                
                //MARK: DecorationNote
                let decorationNoteValue = receiverCarModel.accessoriesNote?
                                        .pdfValidateString
                                        .pdfReFormString(title: "อุปกรณ์แต่งอื่นๆ  ") ?? "-"
                
                let decorationNoteText = "อุปกรณ์แต่งอื่นๆ  \(decorationNoteValue)"
                let attrDecorationNotePDFTitle = weakself.getTitle(mainString: decorationNoteText,
                                                          value: decorationNoteValue)
                let attrDecorationNotePDFSizeRect = weakself.drawString(attrString: attrDecorationNotePDFTitle,
                                                               x: margin + 10,
                                                               y: underRoofrack)
                 
                
                let underDecorationNoteValue = attrDecorationNotePDFSizeRect.maxY + margin
                
                //MARK: Engine
                let engineTitle = "สภาพภายในห้องเครื่อง\t"
                let engineTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                                 NSAttributedString.Key.backgroundColor: UIColor.black,
                                 NSAttributedString.Key.foregroundColor: UIColor.white]
                let attrEnginePDFTitle = NSAttributedString(string: engineTitle,
                                                                   attributes: engineTitleAttr)
                let attrEnginePDFSizeRect = weakself.drawString(attrString: attrEnginePDFTitle,
                                                       x: margin + 10,
                                                       y: underDecorationNoteValue)
                
                
                //MARK: Draw Underline Engine
                weakself.drawUnlderLine(drawContext: context.cgContext,
                               startX: margin + 10,
                               startY: attrEnginePDFSizeRect.maxY,
                               endX: CGFloat(pageWidth) - (margin + 10),
                               endY: attrEnginePDFSizeRect.maxY)
                
                let underEngineTitle = attrEnginePDFSizeRect.maxY + margin
                
                //MARK: EngineOverall
                let engineOverAllValue = receiverCarModel.engineOverAll?.pdfValidateString  ?? "-"
                let engineOverAllText = "สภาพภายในโดยรวม  \(engineOverAllValue)"
                let attrEngineOverAllPDFTitle = weakself.getTitle(mainString: engineOverAllText,
                                                          value: engineOverAllValue)
                let _ =  weakself.drawString(attrString: attrEngineOverAllPDFTitle,
                                                               x: margin + 10,
                                                               y: underEngineTitle)
                    
                  
                
                //MARK: Bettery
                let betteryValue = receiverCarModel.betteryBrand?.pdfValidateString  ?? "-"
                let betteryText = "แบตเตอรี่ / ยี่ห้อ  \(betteryValue)"
                let attrBetteryPDFTitle = weakself.getTitle(mainString: betteryText, value: betteryValue)
                let attrBetteryPDFSizeRect =  weakself.drawString(attrString: attrBetteryPDFTitle,
                                                         x: centerPosition,
                                                         y: underEngineTitle)
                     
                
                //MARK: Bettery Color
                let betteryColorValue = receiverCarModel.betteryColor?.pdfValidateString  ?? "-"
                let betteryColorText = "  สี  \(betteryColorValue)"
                let attrBetteryColorPDFTitle = weakself.getTitle(mainString: betteryColorText, value: betteryColorValue)
                let _ = weakself.drawString(attrString: attrBetteryColorPDFTitle,
                                                             x: attrBetteryPDFSizeRect.maxX + margin,
                                                             y: underEngineTitle)
                    
                   
                
                //MARK: DriverSystem
                let driverSystemValue = receiverCarModel.driverSystem?.pdfValidateString  ?? "-"
                let driverSystemText = "ระบบขับเคลื่อน  \(driverSystemValue)"
                let attrDriverSystemPDFTitle = weakself.getTitle(mainString: driverSystemText, value: driverSystemValue)
                let _ = weakself.drawString(attrString: attrDriverSystemPDFTitle,
                                                             x: trailingPosition,
                                                             y: underEngineTitle)
                     
                let underEngineOverall = attrBetteryPDFSizeRect.maxY + margin
                
                //MARK: ECU
                let ecuValue = receiverCarModel.isEcu ?? false ? "มี" : "ไม่มี"
                let ecuText = "กล่อง ECU  \(ecuValue)"
                let attrEcuPDFTitle = weakself.getTitle(mainString: ecuText, value: ecuValue)
                let attrEcuPDFSizeRect = weakself.drawString(attrString: attrEcuPDFTitle,
                                                    x: margin + 10,
                                                    y: underEngineOverall)
                  
                //MARK: Compressor
                let compressorValue = receiverCarModel.isCompressor ?? false ? "มี" : "ไม่มี"
                let compressorText = "คอมเพรสเซอร์แอร์  \(compressorValue)"
                let attrCompressorPDFTitle = weakself.getTitle(mainString: compressorText, value: compressorValue)
                let _ = weakself.drawString(attrString: attrCompressorPDFTitle,
                                                           x: centerPosition,
                                                           y: underEngineOverall)
                  
                //MARK: OIL System
                let oilSystemValue = receiverCarModel.oilSystem?.pdfValidateString  ?? "-"
                let oilSystemText = "ระบบเชื้อเพลิง  \(oilSystemValue)"
                let attrOilSystemPDFTitle = weakself.getTitle(mainString: oilSystemText, value: oilSystemValue)
                let _ = weakself.drawString(attrString: attrOilSystemPDFTitle,
                                                          x: trailingPosition,
                                                          y: underEngineOverall)
                
                let underEcu = attrEcuPDFSizeRect.maxY + margin
                
                //MARK: isGas
                let gasSystemValue = receiverCarModel.isGas ?? false ? "มี" : "ไม่มี"
                let gasSystemText = "แก๊ส  \(gasSystemValue)"
                let attrGasSystemPDFTitle = weakself.getTitle(mainString: gasSystemText, value: gasSystemValue)
                let attrGasSystemPDFRect = weakself.drawString(attrString: attrGasSystemPDFTitle,
                                                          x: margin + 10,
                                                          y: underEcu)
                
                //MARK: GasSystem
                let gasTypeSystemValue = receiverCarModel.gasSystem?.pdfValidateString ?? "-"
                let gasTypeSystemText = "  ประเภท  \(gasTypeSystemValue)"
                let attrGasTypeSystemPDFTitle = weakself.getTitle(mainString: gasTypeSystemText,
                                                         value: gasTypeSystemValue)
                let _ = weakself.drawString(attrString: attrGasTypeSystemPDFTitle,
                                               x: attrGasSystemPDFRect.maxX + margin,
                                               y: underEcu)
                
                let underGas = attrGasSystemPDFRect.maxY + margin
                
                //MARK: GasSystem
                let assetInCarValue = receiverCarModel.assetInCar?
                                        .pdfValidateString
                                        .pdfReFormString(title: "ทรัพย์สินภายในรถ  ") ?? "-"
                let assetInCarText = "ทรัพย์สินภายในรถ  \(assetInCarValue)"
                let attrAssetInCarPDFTitle = weakself.getTitle(mainString: assetInCarText,
                                                         value: assetInCarValue)
                let attrAssetInCarPDFRect = weakself.drawString(attrString: attrAssetInCarPDFTitle,
                                               x: margin + 10,
                                               y: underGas)
                
                let underAsset = attrAssetInCarPDFRect.maxY + margin
                
                weakself.drawUnlderLine(drawContext: context.cgContext,
                               startX: margin + 10,
                               startY: underAsset,
                               endX: CGFloat(pageWidth) - (margin + 10),
                               endY: underAsset)
                
                //MARK: vin rubbing
                let vinRubbingText = "ที่ว่างสำหรับติดกระดาษลอกลาย / place for stick VIN rubbing tape"
                let attrVinRubbingPDFTitle = weakself.getTitle(mainString: vinRubbingText,
                                                         value: "")
                let _ = weakself.drawString(attrString: attrVinRubbingPDFTitle,
                                               x: margin + 10,
                                               y: underAsset + margin)
                
             
            }
        }
        
        
        let response  = PickUpCar.Something.Response(documentData: data)
        completion(response)
        
    }
}


//MARK: Extension
extension PickUpCarPDFWorker {
    
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
        let margin = margin  + 10
       
        
        drawContext.setLineWidth(0.5)
        drawContext.saveGState()
        
        let tabWidth = pageWidth / 9
        // Draw content's  vertical lines
        for verticalLineIndex in 0..<10 {
//            if verticalLineIndex == 2 || verticalLineIndex == 3 || verticalLineIndex == 4 ||
//               verticalLineIndex == 7 || verticalLineIndex == 8 {
//                continue
//            }
            if verticalLineIndex == 2 || verticalLineIndex == 3 || verticalLineIndex == 6 ||
               verticalLineIndex == 7 || verticalLineIndex == 8 {
                continue
            }
            var tabX = CGFloat(verticalLineIndex) * tabWidth
           
            if verticalLineIndex == 0 {
                tabX += margin
                
                mapPoint["v1"] = tabX
            }
            if verticalLineIndex == 1 {
                tabX += margin
                mapPoint["v2"] = tabX //value1
            }
            
            //if verticalLineIndex == 5 {
            if verticalLineIndex == 4 {
                tabX += margin + 5
                mapPoint["v3"] = tabX
            }
            
            //if verticalLineIndex == 6 {
            if verticalLineIndex == 5 {
                tabX += margin + 5
                mapPoint["v4"] = tabX //value2
            }
            
            if verticalLineIndex == 9 {
                tabX -= margin
            }
            drawContext.move(to: CGPoint(x: tabX, y: yPosition))
            drawContext.addLine(to: CGPoint(x: tabX, y: yPosition + heightTable))
            drawContext.strokePath()
            
        }
        
        // Draw content's element bottom horizontal line
        for  horizontalLine in 0..<6{
            
            let yPosition =  CGFloat(horizontalLine) * heightOffset + underText
            
            mapPoint["h\(horizontalLine)"] = yPosition
            
            drawContext.move(to: CGPoint(x: margin, y: yPosition))
            drawContext.addLine(to: CGPoint(x: CGFloat(pageWidth) - margin, y: yPosition))
            drawContext.strokePath()
        }
        drawContext.restoreGState()
        
        return mapPoint
    }
    func getTitle(mainString : String, value : String , textColor : UIColor = .black, fontSize:CGFloat = CGFloat(8)) -> NSMutableAttributedString {
        let range = (mainString as NSString).range(of: value)
        let attr = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize),
                    NSAttributedString.Key.foregroundColor: textColor]
        
        let mutableAttributedString = NSMutableAttributedString(string: mainString, attributes: attr)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: range)
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

extension PickUpCarPDFWorker {
    func generateQRCode(from string: String) -> UIImage?{
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            if let qrImage = filter.outputImage {
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                let scaledQrImage = qrImage.transformed(by: transform)
                let context = CIContext(options: nil)
                if let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
    
    func getLatestUpdateDate(updateDate:Date?) -> String {
        guard let date = updateDate else { return "-"}
        
        var latestUpdateDate = ""
        latestUpdateDate = DateFormatter().dateFormat(from: date, dateFormat: "dd-MM-yyyy")
        latestUpdateDate += " \(DateFormatter().dateFormat(from: date, dateFormat: "HH:mm"))"
        return latestUpdateDate
    }
}

