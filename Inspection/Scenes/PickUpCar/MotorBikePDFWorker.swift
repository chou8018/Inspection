//
//  MotorBikePDFWorker.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 28/9/2564 BE.
//

import Foundation
import PDFKit

typealias responseMotorBikePDFHandler = (_ response:PickUpCar.Something.Response) -> ()

class MotorBikePDFWorker {
    
    deinit {
        print("🔸🛵 deinit MotorBikePDFWorker")
    }
    func generateMotorBikePDFForBookIn(model:ReceiverCarModel, completion: @escaping responseMotorBikePDFHandler){
        
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

                let updateDate = model.latestUpdatedDate
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
                let title = String.localized("motorbike_pdf_title_label")
                let titleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                                 NSAttributedString.Key.backgroundColor: UIColor.black,
                                 NSAttributedString.Key.foregroundColor: UIColor.white]
                let attributedPDFTitle = NSAttributedString(string: title, attributes: titleAttr)
                let stringSize = attributedPDFTitle.size()
                let attributedPDFTitleRect = weakself.drawString(attrString: attributedPDFTitle,
                                            x: (pageRect.width  - stringSize.width) - (margin + 10),
                                            y: margin + 10)
              
                
                //MARK: QRCode
                let receiverNumber = model.bookinNo?.pdfValidateString ?? "-"
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
                    copyName = String.localized("car_pdf_copy_label")
                }else{
                    copyName = String.localized("car_pdf_primitive_label")
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
                let receiverNumberValue = model.bookinNo?.pdfValidateString ?? "-"
                let receiverNumberTitle = "\(String.localized("car_pdf_receipt_number_label"))  \(receiverNumberValue)"
                let attrReceiverNumber = weakself.getTitle(mainString: receiverNumberTitle, value: receiverNumberValue)
                let stringReceiverNumberRect = weakself.drawString(attrString: attrReceiverNumber,
                                                          x: margin + 10,
                                                          y: underLogo)
                
                
                //MARK: ContractNumber
                let contractValue = model.contractNumber?.pdfValidateString ?? "-"
                let contractTitle = "\(String.localized("receiver_car_contract_number_label"))  \(contractValue)"
                let attrContractPDF = weakself.getTitle(mainString: contractTitle, value: contractValue )
                let _ = weakself.drawString(attrString: attrContractPDF,
                                                       x: centerPosition,
                                                       y: underLogo)
                
                
                //MARK: DayReceiver
                let dayValue = model.dayString?.pdfValidateString ?? "-"
                let dayTitle = "\(String.localized("car_pdf_pick_up_date_label"))  \(dayValue)"
                let attrDayPDF = weakself.getTitle(mainString: dayTitle, value: dayValue)
                let _ = weakself.drawString(attrString: attrDayPDF,
                                                  x: trailingPosition,
                                                  y: underLogo)
                
                
                
                let underReceiverRunNumber =  stringReceiverNumberRect.maxY + margin
              
                //MARK: TimeReceiver
                let timeValue = "\(model.timeString?.pdfValidateString ?? "-") \(String.localized("motorbike_pdf_hours_label"))"
                let timeTitle = "\(String.localized("car_pdf_pick_up_time_label"))  \(timeValue)"
                let attrTimePDF = weakself.getTitle(mainString: timeTitle, value: timeValue)
                let stringTimePDFRect = weakself.drawString(attrString: attrTimePDF,
                                                   x: margin + 10,
                                                   y: underReceiverRunNumber)
                
                 
                
                //MARK: Place Receiver
                let placeValue = model.receiverPlace?.pdfValidateString ?? "-"
                let placeTitle = "\(String.localized("receiver_car_receive_location_label"))  \(placeValue)"
                let attrPlaceReceiverCarPDF = weakself.getTitle(mainString: placeTitle, value: placeValue)
                let _ = weakself.drawString(attrString: attrPlaceReceiverCarPDF,
                                                               x: centerPosition,
                                                               y: underReceiverRunNumber)
                
               
                
                //MARK: Province Place Receiver
    //            let privinceValue = model.receiverPlace?.pdfValidateString ?? "-"
    //            let provinceTitle = "จังหวัด  \(privinceValue)"
    //            let attrProvincePlacePDF = getTitle(mainString: provinceTitle, value: privinceValue)
    //            let _ = drawString(attrString: attrProvincePlacePDF,
    //                                                        x: trailingPosition,
    //                                                        y: underReceiverRunNumber)
                
                
                let underTime =  stringTimePDFRect.maxY + margin
              
                //MARK: Sender Name
                let sender1Value = model.nameSender?.pdfValidateString ?? "-"
                let sender1Title = "\(String.localized("car_pdf_me_label"))  \(sender1Value)"
                let attrSenderNamePDF  = weakself.getTitle(mainString: sender1Title, value: sender1Value)
                let stringSenderNamePDFRect = weakself.drawString(attrString: attrSenderNamePDF,
                                                         x: margin + 10,
                                                         y: underTime)
                 
                
                //MARK: Company
                let companyValue = model.companyName?.pdfValidateString ?? "-"
                let companyTitle = "\(String.localized("car_pdf_company_delivery_label"))  \(companyValue)"
                let attrCompanyPDF = weakself.getTitle(mainString: companyTitle, value: companyValue)
                let _ = weakself.drawString(attrString: attrCompanyPDF,
                                                      x: centerPosition,
                                                      y: underTime)
                
                 
                
                let underSenderName = stringSenderNamePDFRect.maxY + margin

                //MARK: SenderName2
                let senderValue = model.nameSender?.pdfValidateString ?? "-"
                let senderTitle = "\(String.localized("car_pdf_autograph_label"))  \(senderValue)"
                let attrSenderName2PDF  = weakself.getTitle(mainString: senderTitle, value: senderValue)
                let stringSenderName2PDFRect = weakself.drawString(attrString: attrSenderName2PDF,
                                                          x: margin + 10,
                                                          y: underSenderName)
                
                
                //MARK: Phone
                let phoneValue = model.phoneNumber?.pdfValidateString ?? "-"
                let phoneTitle = "\(String.localized("car_pdf_telephone_number_label"))  \(phoneValue)"
                let attrPhonePDF = weakself.getTitle(mainString: phoneTitle, value: phoneValue)
                let _ = weakself.drawString(attrString: attrPhonePDF,
                                                    x: stringSenderName2PDFRect.maxX + 5,
                                                    y: underSenderName)
                
                
                //MARK: Latest Update Date
                let latestUpdateDateTitle = "\(String.localized("car_pdf_during_editing_label"))  \(latestUpdateDate)"
                let attrlatestUpdateDatePDF = weakself.getTitle(mainString: latestUpdateDateTitle, value: latestUpdateDate)
                let _ = weakself.drawString(attrString: attrlatestUpdateDatePDF,
                                                    x: centerPosition,
                                                    y: underSenderName)
               
                
                
                let underOfText = stringSenderName2PDFRect.maxY + margin
                let heightOffset = stringSenderName2PDFRect.height  + margin
                //MARK: Table
                let mapPoint = weakself.createTableDrawLine(drawContext: context.cgContext,
                                    pageWidth: CGFloat(pageWidth),
                                    underOfText: underOfText,
                                    heightOffset: heightOffset,
                                    margin: margin,
                                    rows: 6,
                                    columns: 10,
                                    tableType: 1)
                
              
     
                //MARK: Model Car
                let attrModelCarTitlePDF = weakself.getTitle(mainString: "\(String.localized("create_model_mode_label"))/\(String.localized("car_detail_variant_label"))", value: "")
                let _ = weakself.drawString(attrString: attrModelCarTitlePDF,
                                                            x: mapPoint["v1"]!,
                                                            y: mapPoint["h2"]!,
                                                            isTable: true)
                 
                
                //MARK: Model Car Value
                var carModelvalue = "\(model.modelCar?.pdfValidateString ?? "-")  "
                carModelvalue += "\(model.variants?.pdfValidateString ?? "")"
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
                let attrColorValuePDF = weakself.getTitle(mainString: model.colorCar?.pdfValidateString.uppercased() ?? "-",
                                                 value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrColorValuePDF,
                                                         x: mapPoint["v2"]!,
                                                         y: mapPoint["h3"]!,
                                                         isTable: true)
                 
                
                //MARK: Mileage
                let milesType = model.typeMiles?.pdfValidateString ?? "-"
                let milesValueText = model.miles?.pdfValidateString ?? "-"
                var milesValueR = "\(milesValueText)  \(milesType)"
                
                if let isInValid = model.isInvalidMileage, (isInValid == true) {
                    let reason  = model.invalidMileageReason?.pdfValidateString2 ?? ""
                    milesValueR = "\(String.localized("car_detail_unable_to_verified_label")) \(reason)"
                    
                }
                
                let attrMileageTitlePDF = weakself.getTitle(mainString: String.localized("car_interior_mileage_placeholder_label"), value: "")
                let _ = weakself.drawString(attrString: attrMileageTitlePDF,
                                                           x: mapPoint["v3"]!,
                                                           y: mapPoint["h3"]!,
                                                           isTable: true)


                //MARK: Mileage Value
                let attrTypeMileageValueTitlePDF = weakself.getTitle(mainString: milesValueR,
                                                        value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrTypeMileageValueTitlePDF,
                                                                x: mapPoint["v4"]!,
                                                                y: mapPoint["h3"]!,
                                                                isTable: true)
                
                
                //MARK: gear
                var typeGearValue = "AT"
                switch model.gearbox?.trimWhiteSpace {
                case "1":
                    typeGearValue = "N/A"
                case "A":
                    typeGearValue = "AT"
                case "M":
                    typeGearValue = "MT"
                default:
                    typeGearValue = "AT"
                }
                
                
                let attrCodeModelTitlePDF = weakself.getTitle(mainString: String.localized("car_interior_gear_label"), value: "")
                let _ = weakself.drawString(attrString: attrCodeModelTitlePDF,
                                                             x: mapPoint["v1"]!,
                                                             y: mapPoint["h4"]!,
                                                             isTable: true)
                
              
                
                //MARK: gear value
                let attrCodeModelValuePDF = weakself.getTitle(mainString: typeGearValue,
                                                     value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrCodeModelValuePDF,
                                                             x: mapPoint["v2"]!,
                                                             y: mapPoint["h4"]!,
                                                             isTable: true)
                
                
                //MARK: engineNumberCar
                let attrEngineNumberTitlePDF = weakself.getTitle(mainString: String.localized("car_grade_serial_number_title"), value: "")
                let _ = weakself.drawString(attrString: attrEngineNumberTitlePDF,
                                                                x: mapPoint["v1"]!,
                                                                y: mapPoint["h5"]!,
                                                                isTable: true)
                
                
                //MARK: engineNumberCar Value
                let notValidateEngineCar = model.isInValidEngineNumber ?? false
                let reasonInvalidEngineNumber = "\(model.reasonInValidEngineNumber?.pdfValidateString2 ?? "-")"
                let engineNumber2 = "\(model.engineNumber?.pdfValidateString ?? "-")"
                var engineNumber = notValidateEngineCar ? "\(String.localized("car_detail_unable_to_verified_label"))  " : ""
                engineNumber += notValidateEngineCar ? reasonInvalidEngineNumber : engineNumber2
                let attrEngineNumberValuePDF = weakself.getTitle(mainString: engineNumber.uppercased(),
                                                        value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrEngineNumberValuePDF,
                                                                x: mapPoint["v2"]!,
                                                                y: mapPoint["h5"]!,
                                                                isTable: true)
                
                
                
                
                 
                
                //MARK: brand
                let attrBrandTitlePDF = weakself.getTitle(mainString: String.localized("car_exterior_make_label"), value: "")
                let _ = weakself.drawString(attrString: attrBrandTitlePDF,
                                                         x: mapPoint["v3"]!,
                                                         y: mapPoint["h1"]!,
                                                         isTable: true)
                
                
                //MARK: brand value
                let attrBrandValuePDF = weakself.getTitle(mainString: model.make_BU?.pdfValidateString.uppercased() ?? "-",
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
                var capacityCarText = "\(model.engineCapacity?.pdfValidateString ?? "-")  "
                capacityCarText += "\t\(String.localized("create_model_build_year_label")) \(model.year?.pdfValidateString ?? "-")  "
                capacityCarText += "\(String.localized("car_detail_year_regis_label")) \(model.registrationYear?.pdfValidateString ?? "-")"
                let attrCCValuePDF = weakself.getTitle(mainString: capacityCarText.uppercased(),
                                              value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrCCValuePDF,
                                                      x: mapPoint["v4"]!,
                                                      y: mapPoint["h2"]!,
                                                      isTable: true)
                 
                //MARK: Registration
                let attrRegistrationTitlePDF = weakself.getTitle(mainString: String.localized("car_detail_registration_label"), value: "")
                let _ = weakself.drawString(attrString: attrRegistrationTitlePDF,
                                                                x: mapPoint["v1"]!,
                                                                y: mapPoint["h1"]!,
                                                                isTable: true)
                
                 
                
                //MARK: Registration Value
                let registration = model.registration
                var registrationText = "\(registration?.pdfValidateString ?? "-")"
                registrationText += " \(model.province ?? "")"
                
                
                if let plate = model.registrationPlate , !plate.trimWhiteSpace.isEmpty {
                    let note = model.registrationNote
                    let isRegistrationMismatch = model.isRegistrationMismatch ?? false
                    
                    let isNotValidRegistration = registration?.uppercased().contains("PLATE") ?? false
                    
                    if isRegistrationMismatch {
                        registrationText = " \(note?.pdfValidateString2 ?? "")"
                        registrationText += " \(plate.pdfValidateString2)"
                    }else{
                        
                        registrationText = isNotValidRegistration ? "" : "\(registration?.pdfValidateString2 ?? "")"
                        registrationText += " \(model.province ?? "")"
                        registrationText += " \(note?.pdfValidateString2 ?? "")"
                        registrationText += " \(plate.pdfValidateString2)"
                    }
                    
                }
                
                let attrRegistrationValuePDF = weakself.getTitle(mainString: registrationText.uppercased(),
                                                        value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrRegistrationValuePDF,
                                                                x: mapPoint["v2"]!,
                                                                y: mapPoint["h1"]!,
                                                                isTable: true)
                
                
                //MARK: VIN
                let attrVinTitlePDF = weakself.getTitle(mainString: String.localized("car_detail_vin_number_label"), value: "")
                let _ = weakself.drawString(attrString: attrVinTitlePDF,
                                                       x: mapPoint["v3"]!,
                                                       y: mapPoint["h4"]!,
                                                       isTable: true)
                 
                //MARK: VIN Value
                let notValidateVinNumber = model.isInValidVinNumber ?? false
                let reasonInValidVinNumber = "\(model.reasonInValidVinNumber?.pdfValidateString2 ?? "")"
                let vinNumber2 = "\(model.vinNumber?.pdfValidateString ?? "-")"
                var vinNumber = notValidateVinNumber ? "\(String.localized("car_detail_unable_to_verified_label"))  " : ""
                vinNumber += notValidateVinNumber ?  reasonInValidVinNumber : vinNumber2
                let attrVinValuePDF = weakself.getTitle(mainString: vinNumber.uppercased(),
                                               value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: attrVinValuePDF,
                                                       x: mapPoint["v4"]!,
                                                       y: mapPoint["h4"]!,
                                                       isTable: true)
                 
                
                //MARK: Annotation
                let attrGasNumberTitlePDF = weakself.getTitle(mainString: String.localized("car_trunk_remarks_placeholder"), value: "")
                let _ = weakself.drawString(attrString: attrGasNumberTitlePDF,
                                                             x: mapPoint["v3"]!,
                                                             y: mapPoint["h5"]!,
                                                             isTable: true)
                
                //MARK: Annotation Value
                let annotationValue = model.annotation?.pdfValidateString ?? "-"
                let newAnnotation = annotationValue.replacingOccurrences(of: "\n", with: " ")
                let annotationValuePDF = weakself.getTitle(mainString: newAnnotation,
                                                     value: "", textColor: .darkGray)
                let _ = weakself.drawString(attrString: annotationValuePDF,
                                                             x: mapPoint["v4"]!,
                                                             y: mapPoint["h5"]!,
                                                             isTable: true)
                
              
                let underTable = mapPoint["h5"]! + margin
                
                
                let underReceiverText5 = underTable + 10
                  
                //MARK: 🔸Draw Signature
                let sig1ValueText = "\(String.localized("car_pdf_autograph_label"))___________________________\(String.localized("pick_up_deliverer_title"))"
                let sig1ValueTextPDF = weakself.getTitle(mainString: sig1ValueText, value: "")
                let sig1ValueTextPDFRect = weakself.drawString(attrString: sig1ValueTextPDF,
                                                             x: centerPosition,
                                                             y: underReceiverText5 + (margin + 2))
                
                //MARK: 🔸Draw Signature
                let sig2ValueText = "\(String.localized("car_pdf_autograph_label"))___________________________\(String.localized("car_pdf_recipient_label"))"
                let sig2ValueTextPDF = weakself.getTitle(mainString: sig2ValueText, value: "")
                let _ = weakself.drawString(attrString: sig2ValueTextPDF,
                                                             x: trailingPosition,
                                                             y: underReceiverText5 + (margin + 2))
                
                
                let underSig1ValueText = sig1ValueTextPDFRect.maxY + 10
                //MARK: Table
                let mapPoint2 = weakself.createTableDrawLine(drawContext: context.cgContext,
                                    pageWidth: CGFloat(pageWidth),
                                    underOfText: underSig1ValueText,
                                    heightOffset: 12,
                                    margin: margin,
                                    rows: 29,
                                    columns: 10,
                                    tableType: 2)
                
//                for (k , v) in mapPoint2.sorted(by: { $0.key.compare($1.key, options: .numeric) == .orderedAscending }) {
//                    
//                    print("point ▻\(k)  pos ▻\(v)")
//                }

                setTextWithPosition(title: String.localized("motorbike_pdf_rear_turn_lamp_label_r"),
                                    value: model.rearTurnSignalR?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h1"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h1"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_r_flank_lamp_label"),
                                    value: model.bodyCladdingR?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h2"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h2"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_exhaust_pipe_label"),
                                    value: model.exhaustPipe?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h3"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h3"]!)
                
                setTextWithPosition(title: "\(String.localized("motorbike_pdf_rest_legs_label")) R/L",
                                    value: model.rearFootRest?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h4"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h4"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_konstak_label"),
                                    value: model.starterLever?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h5"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h5"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_footrest_r/l_label"),
                                    value: model.frontFootRest?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h6"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h6"]!)
                
                
                setTextWithPosition(title: String.localized("motorbike_exterior_single_stand_label"),
                                    value: model.sideStand?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h7"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h7"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_double_stand_label"),
                                    value: model.doubleStand?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h8"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h8"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_wind_shield_r_label"),
                                    value: model.windScreenR?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h9"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h9"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_compartment_r_label"),
                                    value: model.multiPurposeR?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h10"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h10"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_side_mirror_r_label"),
                                    value: model.mirrorR?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h11"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h11"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_hand_brake_r_label"),
                                    value: model.handBreakR?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h12"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h12"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_dashboard_label"),
                                    value: model.milesDisplay?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h13"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h13"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_maks_label"),
                                    value: model.mask?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h14"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h14"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_head_light_label"),
                                    value: model.frontLight?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h15"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h15"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_turn_light_r_label"),
                                    value: model.frontTurnSignalR?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h16"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h16"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_front_fender_label"),
                                    value: model.frontFender?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h17"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h17"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_front_tire_label"),
                                    value: "\(model.frontWheel?.pdfValidateString ?? "-")  \t\t\(model.frontWheelType?.pdfValidateString2 ?? "")",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h18"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h18"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_tire_label"),
                                    value: model.frontTire?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h19"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h19"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_front_brake_label"),
                                    value: "\(model.frontBrake?.pdfValidateString ?? "-")  \t\t\(model.frontBrakeType?.pdfValidateString2 ?? "")",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h20"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h20"]!)
              
                setTextWithPosition(title: String.localized("motorbike_exterior_disk_brake_pump_label"),
                                    value: model.frontPumpDiscBrakes?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h21"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h21"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_disk_brake_oil_canister_label"),
                                    value: model.frontOilTankDiscBrakes?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h22"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h22"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_shock_absorber_label"),
                                    value: model.frontShockup?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h23"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h23"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_chain_guard_label"),
                                    value: model.chainCover?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h24"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h24"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_hand_brake_l_label"),
                                    value: model.handBreakL?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h1"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h1"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_clutch_label"),
                                    value: model.handClutch?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h2"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h2"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_turn_light_l_label"),
                                    value: model.frontTurnSignalL?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h3"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h3"]!)
                
                setTextWithPosition(title:String.localized("motorbike_exterior_side_mirror_l_label"),
                                    value: model.mirrorL?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h4"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h4"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_wind_shield_l_label"),
                                    value: model.windScreenL?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h5"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h5"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_side_l_label"),
                                    value: model.bodyCladdingL?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h6"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h6"]!)
                
                                    setTextWithPosition(title: String.localized("motorbike_exterior_seat_label"),
                                    value: model.seat?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h7"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h7"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_seat_iron_frame_label"),
                                    value: model.rearSeatRack?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h8"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h8"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_rear_turn_lamp_label_l"),
                                    value: model.rearTurnSignalL?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h9"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h9"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_tail_light_label"),
                                    value: model.rearLight?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h10"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h10"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_rear_fender_label"),
                                    value: model.rearFender?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h11"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h11"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_compartment_l_label"),
                                    value: model.multiPurposeL?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h12"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h12"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_rear_wheel_label"),
                                    value: "\(model.rearWheel?.pdfValidateString ?? "-") \t\t\(model.rearWheelType?.pdfValidateString2 ?? "")",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h13"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h13"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_rear_tire_label"),
                                    value: model.rearTire?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h14"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h14"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_rear_brake_label"),
                                    value: "\(model.rearBrake?.pdfValidateString ?? "-") \t\t\(model.rearBrakeType?.pdfValidateString2 ?? "")",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h15"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h15"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_rear_brake_pump_label"),
                                    value: model.rearPumpDiscBrakes?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h16"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h16"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_rear_brake_cylinder_label"),
                                    value: model.rearOilTankDiscBrakes?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h17"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h17"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_rear_shock_label"),
                                    value: model.rearShockup?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h18"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h18"]!)
                
                setTextWithPosition(title: "U-BOX",
                                    value: model.ubox?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h19"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h19"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_tank_label"),
                                    value: model.oilTank?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h20"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h20"]!)
                
                setTextWithPosition(title: String.localized("car_engine_battery_label"),
                                    value: model.battery?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h21"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h21"]!)
                
                setTextWithPosition(title: String.localized("motorbike_exterior_cdi_label"),
                                    value: model.cdiBox?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h22"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h22"]!)
                
                setTextWithPosition(title: String.localized("car_trunk_tools_label"),
                                    value: model.toolSpare?.pdfValidateString ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h23"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h23"]!)
                
                
                
                setTextWithPosition(title: String.localized("motorbike_inspection_engine_hand_start_label"),
                                    value: model.isHandStart ?? false ? string_pdf_yes : string_pdf_no,
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h24"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h24"]!)
                
                setTextWithPosition(title: String.localized("motorbike_inspection_engine_foot_start_label"),
                                    value: model.isKickStart ?? false ? string_pdf_yes : string_pdf_no,
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h25"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h25"]!)
                
                setTextWithPosition(title: String.localized("motorbike_inspection_engine_registration_plate_label"),
                                    value: model.isRegistrationPlate ?? false ? string_pdf_yes : string_pdf_no,
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h25"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h25"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_fuel_system_label"),
                                    value: model.fuelDeliveryName?.pdfValidateString2 ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h26"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h26"]!)
                
                setTextWithPosition(title: String.localized("inspection_engine_title"),
                                    value: model.engineCondition?.pdfValidateString2 ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h26"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h26"]!)
                
                setTextWithPosition(title: String.localized("create_model_gearbox_label"),
                                    value: model.gearCondition?.pdfValidateString2 ?? "-",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h27"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h27"]!)
                
                setTextWithPosition(title: String.localized("motorbike_pdf_brake_label"),
                                    value: model.brakeCondition?.pdfValidateString2 ?? "-",
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h27"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h27"]!)
                
                
                //MARK: Keys
                setTextWithPosition(title: String.localized("car_interior_key_label"),
                                    value: "\(model.itemKeys2) \(String.localized("motorbike_pdf_flower_label"))",
                                    titleX: mapPoint2["v1"]!, titleY: mapPoint2["h28"]!,
                                    valueX: mapPoint2["v2"]!, valueY: mapPoint2["h28"]!)
               
               
                var redBookCondition = "-"
                switch model.redBookCondition?.uppercased() {
                case "G":
                    redBookCondition = String.localized("motorbike_pdf_good_label")
                case "A":
                    redBookCondition = String.localized("motorbike_pdf_average_label")
                case "F":
                    redBookCondition = String.localized("motorbike_pdf_fair_label")
                case "P":
                    redBookCondition = String.localized("motorbike_pdf_poor_label")
                case "Y":
                    redBookCondition = String.localized("motorbike_pdf_scrap_label")
                default:
                    break
                }
                
                setTextWithPosition(title: String.localized("motorbike_inspection_engine_condition_label"),
                                    value: redBookCondition,
                                    titleX: mapPoint2["v3"]!, titleY: mapPoint2["h28"]!,
                                    valueX: mapPoint2["v4"]!, valueY: mapPoint2["h28"]!)
                
                
                  

                let underTable2 = mapPoint2["h28"]! + 10
 
                
                let noteOtherValue = model.otherNote?
                                    .pdfValidateString
                                    .pdfReFormString(title: "\(String.localized("car_interior_others_label")) ")  ?? "-"
                let noteOtherText = "\(String.localized("car_interior_others_label"))  \(noteOtherValue)"
                
                let attrNoteOtherPDF = weakself.getTitle(mainString: noteOtherText, value: noteOtherValue)
                let attrNoteOtherPDFSizeRect = weakself.drawString(attrString: attrNoteOtherPDF,
                                                          x: margin + 10,
                                                          y: underTable2)
                
                let underNote = attrNoteOtherPDFSizeRect.maxY + margin
                weakself.drawUnlderLine(drawContext: context.cgContext,
                               startX: margin + 10,
                               startY: underNote,
                               endX: CGFloat(pageWidth) - (margin + 10),
                               endY: underNote)
                
                //MARK: vin rubbing
                let vinRubbingText = String.localized("car_pdf_pasting_peel_label")
                let attrVinRubbingPDFTitle = weakself.getTitle(mainString: vinRubbingText,
                                                         value: "")
                let _ = weakself.drawString(attrString: attrVinRubbingPDFTitle,
                                               x: margin + 10,
                                               y: underNote + margin)
                
            }
        }
        
        
        let response  = PickUpCar.Something.Response(documentData: data)
        completion(response)
        
    }
}


//MARK: Extension
extension MotorBikePDFWorker {
    
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
                             margin : CGFloat,
                             rows:Int,
                             columns:Int,
                             tableType:Int) -> [String: CGFloat] {
        var mapPoint : [String:CGFloat] = [:]
        
        let heightOffset = heightOffset
        let heightTable = heightOffset * CGFloat(rows - 1 )
        let underText = underOfText
        let yPosition = underText
        let margin = margin  + 10
        
        drawContext.setStrokeColor(UIColor.lightGray.cgColor)
        drawContext.setLineWidth(0.5)
        drawContext.saveGState()
        
        let tabWidth = pageWidth / 9
        // Draw content's  vertical lines
        for verticalLineIndex in 0..<columns {
            if tableType == 1 {
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
                
                
                if verticalLineIndex == 4 {
                    tabX += margin + 5
                    mapPoint["v3"] = tabX
                }
                
                
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
                
            }else{
                if verticalLineIndex == 1 || verticalLineIndex == 3 || verticalLineIndex == 5 ||
                   verticalLineIndex == 7 || verticalLineIndex == 8 {
                    continue
                }
                var tabX = CGFloat(verticalLineIndex) * tabWidth
               
                if verticalLineIndex == 0 {
                    tabX += margin
                    
                    mapPoint["v1"] = tabX
                }
                if verticalLineIndex == 2 {
                    tabX += margin
                    mapPoint["v2"] = tabX //value1
                }
                
                
                if verticalLineIndex == 4 {
                    tabX += margin + 5
                    mapPoint["v3"] = tabX
                }
                
                
                if verticalLineIndex == 6 {
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
            
        }
        
        // Draw content's element bottom horizontal line
        for  horizontalLine in 0..<rows{
            
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

extension MotorBikePDFWorker {
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
    
    
    fileprivate func setTextWithPosition(title:String, value:String, titleX:CGFloat, titleY:CGFloat, valueX:CGFloat, valueY:CGFloat){
        let titleAttr = getTitle(mainString: title, value: "")
        let _ = drawString(attrString: titleAttr, x: titleX, y: titleY, isTable: true)
        
        let valuePDF = getTitle(mainString: value, value: "", textColor: .darkGray)
        let _ = drawString(attrString: valuePDF, x: valueX, y: valueY, isTable: true)
    }
}
