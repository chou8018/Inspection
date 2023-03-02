//
//  MotorbikeInspecPDFWorker.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 5/10/2564 BE.
//

import Foundation
import UIKit

typealias responseMotorBikeInspectionPDFHandler = (_ response:SummaryCar.Something.Response) -> ()


class MotorbikeInspecPDFWorker {
    deinit {
        print("🔸🐶 deinit MotorbikeInspecPDFWorker")
    }
    func generateMBPDFForInspection(model:InspectionCarModel, inspector:String?,  completion: @escaping responseMotorBikeInspectionPDFHandler){
        
        let receiverModel = DataController.shared.receiverCarModel
        let damageLists = DataController.shared.photoCarModel.damageItemLists
        
        //MARK:Height Text Summary
        var hightText = 0
        let exteriorDamageValue = model.exteriorDamage?
                                        .pdfValidateString
                                        .pdfReFormString(title: "ความเสียหายภายนอก  ") ?? "-"
        let exteriorDamageMainString = "ความเสียหายภายนอก  \(exteriorDamageValue)"
        hightText += getHeightText(exteriorDamageMainString)
        
        print(hightText)
        let mod = (damageLists.count % 3)
        let divide = (damageLists.count / 3)
        let sum = divide + ((mod > 0) ? 1 : 0)
        print("photo row \(sum)")
        
        //MARK: Photo Damage
        let photoSize = 2 * 72.0
        let photoRow = divide + ((mod > 0) ? 1 : 0)
        let marginPhotoBottom = Double(20 * photoRow) + Double(hightText)
        let photoTotalHeight = (Double(photoRow) * photoSize) + marginPhotoBottom
        let isDamagePhoto = damageLists.count > 0
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
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: (pageHeight + photoTotalHeight))
        //width = 595,  height = 841
        
        
        // 3 create PDFRender
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        // 4 includes a block
        let data = renderer.pdfData { [weak self] (context) in
            guard let weakself = self else { return }
        // 5 starts a new PDF page. You must call beginPage() one time before giving any other drawing instructions.
            context.beginPage()
            
            let updateDate = model.latestUpdatedDate
            let latestUpdateDate = weakself.getLatestUpdateDate(updateDate: updateDate)
            print("🔸\(latestUpdateDate)")
            
            
            let margin = CGFloat(5)
            
            let columnWidth = CGFloat(pageWidth/3)
          
            let trailingPosition = CGFloat(pageWidth) - columnWidth
            
            
            //MARK: logo
            let logo = UIImage(named: "icon-pdf")!
            let logoWidth = CGFloat(pageWidth/3)
            logo.draw(in: CGRect(x: margin + 10, y: margin + 10,
                                 width: logoWidth, height: CGFloat(logoWidth/150*31)))
            //MARK: Title
            let title = "ใบตรวจสภาพรถจักรยานยนต์ / Inspection Report"
            let titleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attributedPDFTitle = NSAttributedString(string: title, attributes: titleAttr)
            let stringSize = attributedPDFTitle.size()
            let attributedPDFRect = weakself.drawString(attrString: attributedPDFTitle,
                                        x: (pageRect.width  - stringSize.width) - (margin + 10),
                                        y: margin + 10)
          
            
            
            
            let underLogo = logo.size.height + margin
            let underTitle = attributedPDFRect.maxY + margin + margin
          
            
            //MARK: Day Inspection
            let dayValue = "\(model.dayString?.pdfValidateString ?? "-")"
            let dayTitle = "วันที่ตรวจสภาพ  \(dayValue)"
            let attrDayPDF = weakself.getTitle(mainString: dayTitle, value: dayValue, size: 12)
            let stringDayPDFRect = weakself.drawString(attrString: attrDayPDF,
                                               x: (CGFloat(pageWidth) - attrDayPDF.size().width) - (margin + 10),
                                               y: underTitle)
            
          
          
 
            
            let heightOffset = stringDayPDFRect.height  + margin
            
            //MARK: Grade
            let gTitle = "\t GRADE \t"
            let attrGPDF = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                                NSAttributedString.Key.backgroundColor: UIColor.black,
                                NSAttributedString.Key.foregroundColor: UIColor.white]
            let attributedGPDF = NSAttributedString(string: gTitle, attributes: attrGPDF)
            let stringGSize = attributedGPDF.size()
            let stringGPDFRect = weakself.drawString(attrString: attributedGPDF,
                                               x: (CGFloat(pageWidth) - stringGSize.width) - (margin + 10),
                                               y: underLogo)
           
            
            let gradeValue = "\(receiverModel.redBookCondition?.pdfValidateString ?? "-")"
            let gradeTitle = "\(gradeValue)"
            let attrGradePDF = weakself.getTitle(mainString: gradeTitle, value: "", size: 50)
            let _ = weakself.drawString(attrString: attrGradePDF,
                                                x: stringGPDFRect.midX - (attrGradePDF.size().width/2),
                                               y: stringGPDFRect.maxY + margin)
            

            
/*
            //MARK: Gas
            let attrGasPDF = weakself.getTitle(mainString: "เลขถังแก๊ส", value: "")
            let _ = weakself.drawString(attrString: attrGasPDF,
                                            x: mapPoint["v1"]!,
                                            y: mapPoint["h6"]!,
                                            isTable: true)
            
            //MARK: Gas Value
//            let gasValue = (receiverModel.isInValidGasNumber ?? false) ? "ตรวจสอบไม่ได้" : (receiverModel.gasNumber?.pdfValidateString ?? "-")
            let notValidateGasNumber = receiverModel.isInValidGasNumber ?? false
            let reasonInValidGasNumber = "\(receiverModel.reasonInValidGasNumber?.pdfValidateString2 ?? "")"
            let gasNumber2 = "\(receiverModel.gasNumber?.pdfValidateString ?? "-")"
            var gasNumber = notValidateGasNumber ? "ตรวจสอบไม่ได้  " : ""
            gasNumber += notValidateGasNumber ? reasonInValidGasNumber : gasNumber2
            
            
            let attrGasValuePDF = weakself.getTitle(mainString: gasNumber, value: gasNumber)
            let _ = weakself.drawString(attrString: attrGasValuePDF,
                                            x: mapPoint["v2"]!,
                                            y: mapPoint["h6"]!,
                                            isTable: true)
            
          
            //MARK: Driver System
            let attrDriverSystemPDF = weakself.getTitle(mainString: "ระบบขับเคลื่อน", value: "")
            let _ = weakself.drawString(attrString: attrDriverSystemPDF,
                                            x: mapPoint["v3"]!,
                                            y: mapPoint["h6"]!,
                                            isTable: true)

            //MARK: Driver System Value
            let driverSystemValue = receiverModel.driverSystem?.pdfValidateString ?? "-"
            let attrDriverSystemValuePDF = weakself.getTitle(mainString: driverSystemValue,
                                                    value: driverSystemValue)
            let _ = weakself.drawString(attrString: attrDriverSystemValuePDF,
                                            x: mapPoint["v4"]!,
                                            y: mapPoint["h6"]!,
                                            isTable: true)
            
          
            
            
            
          //MARK: Chassis Header
          let underGasSystem = insoectionRect.maxY + margin + margin
            
          let chassisTitle = "สภาพตัวถัง\t\t\t\t"
          let chassisTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                           NSAttributedString.Key.backgroundColor: UIColor.black,
                           NSAttributedString.Key.foregroundColor: UIColor.white]
          let attrChassisTitlePDFTitle = NSAttributedString(string: chassisTitle,
                                                             attributes: chassisTitleAttr)
            let attrChassisPDFSizeRect = weakself.drawString(attrString: attrChassisTitlePDFTitle,
                                                   x: margin + 10,
                                                   y: underGasSystem)
          
          //MARK: Draw Underline
            weakself.drawUnlderLine(drawContext: context.cgContext,
                         startX: margin + 10,
                         startY: attrChassisPDFSizeRect.maxY,
                         endX: CGFloat(pageWidth) - (margin + 10),
                         endY: attrChassisPDFSizeRect.maxY)
            
            let underChassisHeader = attrChassisPDFSizeRect.maxY + margin
            
            //MARK: Chassis
            let chassisValue = model.chessis?.pdfValidateString ?? "-"
            let chassisMainString = "แชสซี  \(chassisValue)"
            let attrChassisValuePDF = weakself.getTitle(mainString: chassisMainString,
                                                    value: chassisValue)
            let _ = weakself.drawString(attrString: attrChassisValuePDF,
                                            x: margin + 10,
                                            y: underChassisHeader)
            
            //MARK: FrontSide
            let frontSideValue = model.frontSide?.pdfValidateString ?? "-"
            let frontSideMainString = "ด้านหน้า  \(frontSideValue)"
            let attrFrontSideValuePDF = weakself.getTitle(mainString: frontSideMainString,
                                                    value: frontSideValue)
            let frontSideRect = weakself.drawString(attrString: attrFrontSideValuePDF,
                                            x: centerPosition,
                                            y: underChassisHeader)
            
            //MARK: BackSide
            let backSideValue = model.backSide?.pdfValidateString ?? "-"
            let backSideMainString = "ด้านหลัง  \(backSideValue)"
            let attrBackSideValuePDF = weakself.getTitle(mainString: backSideMainString,
                                                    value: backSideValue)
            let _ = weakself.drawString(attrString: attrBackSideValuePDF,
                                            x: trailingPosition,
                                            y: underChassisHeader)
            
           
    
            let underFrontSide = frontSideRect.maxY + margin
            
            
            //MARK: RightSideDriver
            let rightSideDriverValue = model.rightSideDriver?.pdfValidateString ?? "-"
            let rightSideDriverMainString = "ด้านขวา(คนขับ)  \(rightSideDriverValue)"
            let attrRightSideDriverValuePDF = weakself.getTitle(mainString: rightSideDriverMainString, value: rightSideDriverValue)
            let RightSideDriverRect = weakself.drawString(attrString: attrRightSideDriverValuePDF,
                                            x: margin + 10,
                                            y: underFrontSide)
            
            //MARK: LeftSide
            let leftSideValue = model.leftSide?.pdfValidateString ?? "-"
            let leftSideMainString = "ด้านซ้าย  \(leftSideValue)"
            let attrLeftSideValuePDF = weakself.getTitle(mainString: leftSideMainString,
                                                    value: leftSideValue)
            let _ = weakself.drawString(attrString: attrLeftSideValuePDF,
                                            x: centerPosition,
                                            y: underFrontSide)
            
            //MARK: Roof
            let roofValue = model.roof?.pdfValidateString ?? "-"
            let roofMainString = "หลังคา  \(roofValue)"
            let attrRoofValuePDF = weakself.getTitle(mainString: roofMainString,
                                                    value: roofValue)
            let _ = weakself.drawString(attrString: attrRoofValuePDF,
                                            x: trailingPosition,
                                            y: underFrontSide)
            
            
            let underRightSideDriver = RightSideDriverRect.maxY + margin
            
            
            //MARK: Drown
            let drownValue = model.isDrowned ? " จมน้ำ " : " ไม่จมน้ำ "
            let drownMainString = "จมน้ำ  \(drownValue)"
            let attrDrownValuePDF = weakself.getTitle(mainString: drownMainString,
                                                    value: drownValue)
            let drownRect = weakself.drawString(attrString: attrDrownValuePDF,
                                            x: margin + 10,
                                            y: underRightSideDriver)
            
            //MARK: Chassis Summary
//            let chassisSummaryValue = model.bodySummary?
//                                            .pdfValidateString
//                                            .pdfReFormString(title: "สรุปสภาพตัวถัง  ") ?? "-"
//            let chassisSummaryMainString = "สรุปสภาพตัวถัง  \(chassisSummaryValue)"
            let attrChassisSummaryValuePDF = weakself.getTitle(mainString: chassisSummaryMainString,
                                                    value: chassisSummaryValue)
            let chassisSummaryRect = weakself.drawString(attrString: attrChassisSummaryValuePDF,
                                            x: margin + 10,
                                            y: drownRect.maxY + margin)
            
            
            
            //MARK: Engine Header
            let underchassisSummary = chassisSummaryRect.maxY + margin
              
            let engineTitle = "สภาพเครื่องยนต์\t\t\t"
            let engineTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attrEngineTitlePDFTitle = NSAttributedString(string: engineTitle,
                                                               attributes: engineTitleAttr)
            let attrEnginePDFSizeRect = weakself.drawString(attrString: attrEngineTitlePDFTitle,
                                                     x: margin + 10,
                                                     y: underchassisSummary)
            
            //MARK: Draw Underline
            weakself.drawUnlderLine(drawContext: context.cgContext,
                           startX: margin + 10,
                           startY: attrEnginePDFSizeRect.maxY,
                           endX: CGFloat(pageWidth) - (margin + 10),
                           endY: attrEnginePDFSizeRect.maxY)
            
            let underEngineTitle = attrEnginePDFSizeRect.maxY + margin
            
            //MARK: EngineOverall Condition
            let engineOverallValue = model.engineOverall?.pdfValidateString ?? "-"
            let engineOverallMainString = "สภาพเครื่องยนต์โดยรวม  \(engineOverallValue)"
            let attrEngineOverallValuePDF = weakself.getTitle(mainString: engineOverallMainString,
                                                    value: engineOverallValue)
            let _ = weakself.drawString(attrString: attrEngineOverallValuePDF,
                                            x: margin + 10,
                                            y: underEngineTitle)
            
          //MARK: Engine Type
            let engineTypeValue = model.typeEngine?.pdfValidateString ?? "-"
            let engineTypeMainString = "ชนิดเครื่องยนต์  \(engineTypeValue)"
            let attrEngineTypeValuePDF = weakself.getTitle(mainString: engineTypeMainString,
                                                    value: engineTypeValue)
            let _ = weakself.drawString(attrString: attrEngineTypeValuePDF,
                                            x: centerPosition,
                                            y: underEngineTitle)
            
            //MARK: Oil Engine
            let oilEngineValue = model.oilEngine?.pdfValidateString ?? "-"
            let oilEngineMainString = "น้ำมันเครื่อง  \(oilEngineValue)"
            let attrOilEngineValuePDF = weakself.getTitle(mainString: oilEngineMainString,
                                                      value: oilEngineValue)
            let oilEngineRect = weakself.drawString(attrString: attrOilEngineValuePDF,
                                              x: trailingPosition,
                                              y: underEngineTitle)
            
            let underOil = oilEngineRect.maxY + margin
            
            //MARK: FuelSystem
            let fuelSystemValue = model.fuelSystem?.pdfValidateString ?? "-"
            let fuelSystemMainString = "ระบบเชื้อเพลิง  \(fuelSystemValue)"
            let attrFuelSystemValuePDF = weakself.getTitle(mainString: fuelSystemMainString,
                                                    value: fuelSystemValue)
            let _ = weakself.drawString(attrString: attrFuelSystemValuePDF,
                                            x: margin + 10,
                                            y: underOil)
            
            //MARK: GasFuelSystem
            let gasFuelSystemValue = model.gasSystem?.pdfValidateString ?? "-"
            let gasFuelSystemMainString = "แก๊ส  \(gasFuelSystemValue)"
            let attrGasfuelSystemValuePDF = weakself.getTitle(mainString: gasFuelSystemMainString,
                                                    value: gasFuelSystemValue)
            let gasFuelSystemRect = weakself.drawString(attrString: attrGasfuelSystemValuePDF,
                                            x: centerPosition,
                                            y: underOil)
            
            //MARK: GereralCondition
            var gereralConditionValue = "\(model.useableGeneral ? "ใช้งานได้" : "")  "
            gereralConditionValue += "\(model.soundAbnormalGeneral ? "เสียงดังผิดปรติ" : "")  "
            gereralConditionValue += "\(model.leakFuelGeneral ? "น้ำมันรั่วซึม" : "")  "
            gereralConditionValue += "\(model.stainWaterGeneral ? "คราบน้ำดันออกจากหม้อพักน้ำ" : "")  "
            gereralConditionValue += "\(model.machineLightShowGeneral ? "ไฟรูปเครื่องโชว์" : "")  "
            gereralConditionValue += "\(model.engineAbnormalGeneral ? "เครื่องยนต์เดินไม่เรียบ" : "")  "
            gereralConditionValue += "\(model.needRepairGeneral ? "ต้องซ่อมก่อนใช้งาน" : "")  "
            let gereralConditionMainString = "สภาพทั่วไป  \(gereralConditionValue.pdfValidateString)"
            let attrGereralConditionValuePDF = weakself.getTitle(mainString: gereralConditionMainString, value: gereralConditionValue)
            let gereralConditionRect = weakself.drawString(attrString: attrGereralConditionValuePDF,
                                            x: margin + 10,
                                            y: gasFuelSystemRect.maxY + margin)
            
            //MARK: EngineSummary
//            let engineSummaryValue = model.summaryEngine?
//                                        .pdfValidateString
//                                        .pdfReFormString(title: "สรุปสภาพเครื่องยนต์  ") ?? "-"
//            let engineSummaryMainString = "สรุปสภาพเครื่องยนต์  \(engineSummaryValue)"
            let attrEngineSummaryValuePDF = weakself.getTitle(mainString: engineSummaryMainString,
                                                    value: engineSummaryValue)
            let engineSummaryRect = weakself.drawString(attrString: attrEngineSummaryValuePDF,
                                            x: margin + 10,
                                            y: gereralConditionRect.maxY + margin)
            
            
            //MARK: Undercarriage Header
            let underEngineSummary = engineSummaryRect.maxY + margin
              
            let underCarTitle = "ช่วงล่าง\t\t\t\t"
            let underCarTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attrUnderCarTitlePDFTitle = NSAttributedString(string: underCarTitle,
                                                               attributes: underCarTitleAttr)
            let attrUnderCarPDFSizeRect = weakself.drawString(attrString: attrUnderCarTitlePDFTitle,
                                                     x: margin + 10,
                                                     y: underEngineSummary)
            
            //MARK: Draw Underline
            weakself.drawUnlderLine(drawContext: context.cgContext,
                           startX: margin + 10,
                           startY: attrUnderCarPDFSizeRect.maxY,
                           endX: CGFloat(pageWidth) - (margin + 10),
                           endY: attrUnderCarPDFSizeRect.maxY)
            
            let underCarHeader = attrUnderCarPDFSizeRect.maxY + margin
            
            //MARK: DriveShaft
            var driveShaftValue = "\(model.driveShaft?.pdfValidateString ?? "-")  "
            driveShaftValue += "\(model.driveShaftNoteOther?.pdfValidateString2 ?? "")"
            let driveShaftMainString = "เพลาขับ  \(driveShaftValue)"
            let attrDriveShaftValuePDF = weakself.getTitle(mainString: driveShaftMainString,
                                                    value: driveShaftValue)
            let _ = weakself.drawString(attrString: attrDriveShaftValuePDF,
                                            x: margin + 10,
                                            y: underCarHeader)
            
            //MARK: UnderCarriage
            var underCarriageValue = "\(model.underCarriage?.pdfValidateString ?? "-")  "
            underCarriageValue += "\(model.underCarriageNoteOther?.pdfValidateString2 ?? "")"
            let underCarriageMainString = "ช่วงล่าง  \(underCarriageValue)"
            let attrUnderCarriageValuePDF = weakself.getTitle(mainString: underCarriageMainString,
                                                    value: underCarriageValue)
            let underCarriageRect = weakself.drawString(attrString: attrUnderCarriageValuePDF,
                                            x: centerPosition,
                                            y: underCarHeader)
            
            
            //MARK: UnderCarriageSummary
//            let underCarriageSummaryValue = model.summaryUnderCarriage?
//                                        .pdfValidateString
//                                        .pdfReFormString(title: "สรุปสภาพช่วงล่าง  ") ?? "-"
//            let underCarriageSummaryMainString = "สรุปสภาพช่วงล่าง  \(underCarriageSummaryValue)"
            let attrUnderCarriageSummaryValuePDF = weakself.getTitle(mainString: underCarriageSummaryMainString,
                                                    value: underCarriageSummaryValue)
            let underCarriageSummaryRect = weakself.drawString(attrString: attrUnderCarriageSummaryValuePDF, x: margin + 10, y: underCarriageRect.maxY + margin)
            
            
            //MARK: GearSystem Header
            let underUnderCarriageSummary = underCarriageSummaryRect.maxY + margin
              
            let gearSystemTitle = "ระบบเกียร์\t\t\t\t"
            let gearSystemTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attrGearSystemTitlePDFTitle = NSAttributedString(string: gearSystemTitle,
                                                               attributes: gearSystemTitleAttr)
            let attrGearSystemPDFSizeRect = weakself.drawString(attrString: attrGearSystemTitlePDFTitle, x: margin + 10, y: underUnderCarriageSummary)
            
            //MARK: Draw Underline
            weakself.drawUnlderLine(drawContext: context.cgContext,
                           startX: margin + 10,
                           startY: attrGearSystemPDFSizeRect.maxY,
                           endX: CGFloat(pageWidth) - (margin + 10),
                           endY: attrGearSystemPDFSizeRect.maxY)
            
            let underGearSystemHeader = attrGearSystemPDFSizeRect.maxY + margin
            
            
            //MARK: GearSystem
            let gearSystemValue = model.gearSystem?.pdfValidateString ?? "-"
            let gearSystemMainString = "ระบบเกียร์  \(gearSystemValue)"
            let attrGearSystemValuePDF = weakself.getTitle(mainString: gearSystemMainString,
                                                    value: gearSystemValue)
            let _ = weakself.drawString(attrString: attrGearSystemValuePDF,
                                            x: margin + 10,
                                            y: underGearSystemHeader)
            
            //MARK: GearCondition
            let gearConditionValue = model.statusGear?.pdfValidateString ?? "-"
            let gearConditionMainString = "สภาพเกียร์  \(gearConditionValue)"
            let attrGearConditionValuePDF = weakself.getTitle(mainString: gearConditionMainString,
                                                    value: gearConditionValue)
            let _ = weakself.drawString(attrString: attrGearConditionValuePDF,
                                            x: centerPosition,
                                            y: underGearSystemHeader)
            
            //MARK: DriveShaftGear
            let driveShaftGearValue = model.driveShaftGear?.pdfValidateString ?? "-"
            let driveShaftGearMainString = "เพลาขับ  \(driveShaftGearValue)"
            let attrDriveShaftGearValuePDF = weakself.getTitle(mainString: driveShaftGearMainString,
                                                    value: driveShaftGearValue)
            let driveShaftGearRect = weakself.drawString(attrString: attrDriveShaftGearValuePDF,
                                            x: trailingPosition,
                                            y: underGearSystemHeader)
            
            //MARK: 4WD
            let gear4WDValue = model.isGear4WD ? "มี" : "ไม่มี"
            let gear4WDMainString = "เกียร์​ 4WD  \(gear4WDValue)"
            let attrGear4WDValuePDF = weakself.getTitle(mainString: gear4WDMainString,
                                                    value: gear4WDValue)
            let gear4WDValueRect = weakself.drawString(attrString: attrGear4WDValuePDF,
                                            x: margin + 10,
                                            y: driveShaftGearRect.maxY + margin)
            
            //MARK: Gear Summary
//            let gearSummaryValue = model.summaryGearSystem?
//                                        .pdfValidateString
//                                        .pdfReFormString(title: "สรุประบบเกียร์  ") ?? "-"
//            let gearSummaryMainString = "สรุประบบเกียร์  \(gearSummaryValue)"
            let attrGearSummaryValuePDF = weakself.getTitle(mainString: gearSummaryMainString,
                                                    value: gearSummaryValue)
            let gearSummaryValueRect = weakself.drawString(attrString: attrGearSummaryValuePDF,
                                            x: margin + 10,
                                            y: gear4WDValueRect.maxY + margin)
            
         
            //MARK: SteerWheel Header
            let underGearSummary = gearSummaryValueRect.maxY + margin
              
            let SteerWheelTitle = "ระบบพวงมาลัย\t\t\t"
            let SteerWheelTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attrSteerWheelTitlePDFTitle = NSAttributedString(string: SteerWheelTitle,
                                                               attributes: SteerWheelTitleAttr)
            let attrSteerWheelPDFSizeRect = weakself.drawString(attrString: attrSteerWheelTitlePDFTitle,
                                                     x: margin + 10,
                                                     y: underGearSummary)
            
            //MARK: Draw Underline
            weakself.drawUnlderLine(drawContext: context.cgContext,
                           startX: margin + 10,
                           startY: attrSteerWheelPDFSizeRect.maxY,
                           endX: CGFloat(pageWidth) - (margin + 10),
                           endY: attrSteerWheelPDFSizeRect.maxY)
            
            let underSteerWheelHeader = attrSteerWheelPDFSizeRect.maxY + margin
            
            
            //MARK: SteerWheelSystem
            let steerWheelValue = model.steerWheelSystem?.pdfValidateString ?? "-"
            let steerWheelMainString = "ระบบพวงมาลัย​  \(steerWheelValue)"
            let attrSteerWheelValuePDF = weakself.getTitle(mainString: steerWheelMainString,
                                                    value: steerWheelValue)
            let _ = weakself.drawString(attrString: attrSteerWheelValuePDF,
                                            x: margin + 10,
                                            y: underSteerWheelHeader)
            
            //MARK: SteerWheelPOWER
            let steerWheelSystemValue = model.isSteerWheelPower ?  "ใช่" : "ไม่ใช่"
            let steerWheelSystemMainString = "พวงมาลัย​พาวเวอร์  \(steerWheelSystemValue)"
            let attrSteerWheelSystemValuePDF = weakself.getTitle(mainString: steerWheelSystemMainString, value: steerWheelSystemValue)
            let steerWheelSystemRect = weakself.drawString(attrString: attrSteerWheelSystemValuePDF,
                                            x: centerPosition,
                                            y: underSteerWheelHeader)
            
            //MARK: SteerWheelSummary
//            let steerWheelSummaryValue = model.summarySteerWheelSystem?
//                                        .pdfValidateString
//                                        .pdfReFormString(title: "สรุประบบพวงมาลัย  ") ?? "-"
//            let steerWheelSummaryMainString = "สรุประบบพวงมาลัย  \(steerWheelSummaryValue)"
            let attrSteerWheelSummaryValuePDF = weakself.getTitle(mainString: steerWheelSummaryMainString, value: steerWheelSummaryValue)
            let steerWheelSummaryValueRect = weakself.drawString(attrString: attrSteerWheelSummaryValuePDF, x: margin + 10, y: steerWheelSystemRect.maxY + margin)
            
            //MARK: Brake Header
            let underSteerWheel = steerWheelSummaryValueRect.maxY + margin
            
            let brakeHeaderTitle = "ระบบเบรก\t\t\t\t"
            let brakeHeaderTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attrBrakeHeaderTitlePDFTitle = NSAttributedString(string: brakeHeaderTitle,
                                                               attributes: brakeHeaderTitleAttr)
            let attrBrakeHeaderPDFSizeRect = weakself.drawString(attrString: attrBrakeHeaderTitlePDFTitle, x: margin + 10, y: underSteerWheel)
            
            //MARK: Draw Underline
            weakself.drawUnlderLine(drawContext: context.cgContext,
                           startX: margin + 10,
                           startY: attrBrakeHeaderPDFSizeRect.maxY,
                           endX: CGFloat(pageWidth) - (margin + 10),
                           endY: attrBrakeHeaderPDFSizeRect.maxY)
            
            let underBrakeHeader = attrBrakeHeaderPDFSizeRect.maxY + margin
            
            //MARK: BrakSystem
            let brakeSystemValue = model.brakeSystem?.pdfValidateString ?? "-"
            let brakeSystemMainString = "ระบบเบรก  \(brakeSystemValue)"
            let attrBrakSystemValuePDF = weakself.getTitle(mainString: brakeSystemMainString,
                                                    value: brakeSystemValue)
            let brakSystemRect = weakself.drawString(attrString: attrBrakSystemValuePDF,
                                            x: margin + 10,
                                            y: underBrakeHeader)
            
            
            //MARK: BrakSystemSummary
//            let brakSystemSummaryValue = model.summarysBrakeSystem?
//                                        .pdfValidateString
//                                        .pdfReFormString(title: "สรุประบบเบรก  ") ?? "-"
//            let brakSystemSummaryMainString = "สรุประบบเบรก  \(brakSystemSummaryValue)"
            let attrBrakSystemSummaryValuePDF = weakself.getTitle(mainString: brakSystemSummaryMainString, value: brakSystemSummaryValue)
            let steerBrakSystemSummaryRect = weakself.drawString(attrString: attrBrakSystemSummaryValuePDF, x: margin + 10, y: brakSystemRect.maxY + margin)
            
            
            //MARK: Air Header
            let underBrake = steerBrakSystemSummaryRect.maxY + margin
            
            let airHeaderTitle = "ระบบแอร์\t\t\t\t\t"
            let airHeaderTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attrAirHeaderTitlePDFTitle = NSAttributedString(string: airHeaderTitle,
                                                               attributes: airHeaderTitleAttr)
            let attrAirHeaderPDFSizeRect = weakself.drawString(attrString: attrAirHeaderTitlePDFTitle, x: margin + 10, y: underBrake)
            
            //MARK: Draw Underline
            drawUnlderLine(drawContext: context.cgContext,
                           startX: margin + 10,
                           startY: attrAirHeaderPDFSizeRect.maxY,
                           endX: CGFloat(pageWidth) - (margin + 10),
                           endY: attrAirHeaderPDFSizeRect.maxY)
            
            let underAirHeader = attrAirHeaderPDFSizeRect.maxY + margin
            
            //MARK: AirSystem
            let airSystemValue = model.airSystem?.pdfValidateString ?? "-"
            let airSystemString = "ระบบแอร์  \(airSystemValue)"
            let attrAirSystemValuePDF = weakself.getTitle(mainString: airSystemString,
                                                    value: airSystemValue)
            let airSystemRect = weakself.drawString(attrString: attrAirSystemValuePDF,
                                            x: margin + 10,
                                            y: underAirHeader)
            
            //MARK: Compressor Air
            let compressorValue = model.isCompresser ? "มี" : "ไม่มี"
            let compressorString = "คอมเพรสเซอร์  \(compressorValue)"
            let attrCompressorValuePDF = weakself.getTitle(mainString: compressorString,
                                                    value: compressorValue)
            let _ = weakself.drawString(attrString: attrCompressorValuePDF,
                                            x: centerPosition,
                                            y: underAirHeader)
            
            //MARK: AirSummary
//            let airSummaryValue = model.summaryAirSystem?
//                                        .pdfValidateString
//                                        .pdfReFormString(title: "สรุประบบแอร์  ") ?? "-"
//            let airSummaryMainString = "สรุประบบแอร์  \(airSummaryValue)"
            let attrAirSummaryValuePDF = weakself.getTitle(mainString: airSummaryMainString,
                                                    value: airSummaryValue)
            let airSummaryRect = weakself.drawString(attrString: attrAirSummaryValuePDF,
                                            x: margin + 10,
                                            y: airSystemRect.maxY + margin)
            
            
            //MARK: GaugeSystem
            let underAirSummary = airSummaryRect.maxY + margin
            
            let gaugeHeaderTitle = "มาตรวัด\t\t\t\t"
            let gaugeHeaderTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attrGaugeHeaderTitlePDFTitle = NSAttributedString(string: gaugeHeaderTitle,
                                                               attributes: gaugeHeaderTitleAttr)
            let attrGaugeHeaderPDFSizeRect = weakself.drawString(attrString: attrGaugeHeaderTitlePDFTitle, x: margin + 10, y: underAirSummary)
            
            //MARK: Draw Underline
            weakself.drawUnlderLine(drawContext: context.cgContext,
                           startX: margin + 10,
                           startY: attrGaugeHeaderPDFSizeRect.maxY,
                           endX: CGFloat(pageWidth) - (margin + 10),
                           endY: attrGaugeHeaderPDFSizeRect.maxY)
            
            let undergaugeHeader = attrGaugeHeaderPDFSizeRect.maxY + margin
            
            //MARK: GaugeSystem
            let gaugeSystemValue = model.gaugeSystem?.pdfValidateString ?? "-"
            let gaugeSystemString = "มาตรวัด  \(gaugeSystemValue)"
            let attrGaugeSystemValuePDF = weakself.getTitle(mainString: gaugeSystemString,
                                                    value: gaugeSystemValue)
            let gaugeSystemRect = weakself.drawString(attrString: attrGaugeSystemValuePDF,
                                            x: margin + 10,
                                            y: undergaugeHeader)
            
            //MARK: MachineLightShow
            let machineLightShowValue = model.machineLightShow?.pdfValidateString ?? "-"
            let machineLightShowString = "ไฟขึ้นโชว์(ระบุ)  \(machineLightShowValue)"
            let attrMachineLightShowValuePDF = weakself.getTitle(mainString: machineLightShowString,
                                                    value: machineLightShowValue)
            let _ = weakself.drawString(attrString: attrMachineLightShowValuePDF,
                                            x: centerPosition,
                                            y: undergaugeHeader)
            
            //MARK: GaugeSummary
//            let gaugeSummaryValue = model.summaryGaugeSystem?
//                                        .pdfValidateString
//                                        .pdfReFormString(title: "สรุปมาตรวัด  ") ?? "-"
//            let gaugeSummaryString = "สรุปมาตรวัด  \(gaugeSummaryValue)"
            let attrGaugeSummaryValuePDF = weakself.getTitle(mainString: gaugeSummaryString,
                                                    value: gaugeSummaryValue)
            let gaugeSummaryRect = weakself.drawString(attrString: attrGaugeSummaryValuePDF,
                                            x: margin + 10,
                                            y: gaugeSystemRect.maxY + margin)
            
            //MARK: ElectronicSystem
            let underGaugeSummary = gaugeSummaryRect.maxY + margin
            
            let electronicHeaderTitle = "อุปกรณ์ไฟฟ้า\t\t\t"
            let electronicHeaderTitleAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
                             NSAttributedString.Key.backgroundColor: UIColor.black,
                             NSAttributedString.Key.foregroundColor: UIColor.white]
            let attrElecHeaderTitlePDFTitle = NSAttributedString(string: electronicHeaderTitle,
                                                               attributes: electronicHeaderTitleAttr)
            let attrElectronicHeaderPDFSizeRect = weakself.drawString(attrString: attrElecHeaderTitlePDFTitle, x: margin + 10, y: underGaugeSummary)
            
            //MARK: Draw Underline
            weakself.drawUnlderLine(drawContext: context.cgContext,
                           startX: margin + 10,
                           startY: attrElectronicHeaderPDFSizeRect.maxY,
                           endX: CGFloat(pageWidth) - (margin + 10),
                           endY: attrElectronicHeaderPDFSizeRect.maxY)
            
            let underElectronicHeader = attrElectronicHeaderPDFSizeRect.maxY + margin
            
         
            //MARK: FrontLight
            let frontLightValue = model.isFrontLight ? "ทำงาน" : "ไม่ทำงาน"
            let frontLightString = "ไฟหน้า  \(frontLightValue)"
            let attrFrontLightValuePDF = weakself.getTitle(mainString: frontLightString,
                                                    value: frontLightValue)
            let frontLightRect = weakself.drawString(attrString: attrFrontLightValuePDF,
                                            x: margin + 10,
                                            y: underElectronicHeader)
            
            //MARK: TurnLight
            let turnLightValue = model.isTurnLight ? "ทำงาน" : "ไม่ทำงาน"
            let turnLightString = "ไฟเลี้ยว  \(turnLightValue)"
            let attrTurnLightValuePDF = weakself.getTitle(mainString: turnLightString,
                                                    value: turnLightValue)
            let _ = weakself.drawString(attrString: attrTurnLightValuePDF,
                                            x: centerPosition,
                                            y: underElectronicHeader)
            
            //MARK: BackLight
            let backLightValue = model.isBackLight ? "ทำงาน" : "ไม่ทำงาน"
            let backLightString = "ไฟท้าย  \(backLightValue)"
            let attrBackLightValuePDF = weakself.getTitle(mainString: backLightString,
                                                    value: backLightValue)
            let _ = weakself.drawString(attrString: attrBackLightValuePDF,
                                            x: trailingPosition,
                                            y: underElectronicHeader)
            
            let underFrontLight = frontLightRect.maxY + margin
           
            //MARK: brakeLight
            let brakeLightValue = model.isBrakeLight ? "ทำงาน" : "ไม่ทำงาน"
            let brakeLightString = "ไฟเบรก  \(brakeLightValue)"
            let attrBrakeLightValuePDF = weakself.getTitle(mainString: brakeLightString,
                                                    value: brakeLightValue)
            let brakeLightRect = weakself.drawString(attrString: attrBrakeLightValuePDF,
                                            x: margin + 10,
                                            y: underFrontLight)
            
            //MARK: Bettery
            let betteryValue = model.isBettery ? "ทำงาน" : "ไม่ทำงาน"
            let betteryString = "แบตเตอรี่  \(betteryValue)"
            let attrBetteryValuePDF = weakself.getTitle(mainString: betteryString,
                                                    value: betteryValue)
            let _ = weakself.drawString(attrString: attrBetteryValuePDF,
                                            x: centerPosition,
                                            y: underFrontLight)
            
            //MARK: Hooter
            let hooterValue = model.isHooter ? "ทำงาน" : "ไม่ทำงาน"
            let hooterString = "แตร  \(hooterValue)"
            let attrHooterValuePDF = weakself.getTitle(mainString: hooterString,
                                                    value: hooterValue)
            let _ = weakself.drawString(attrString: attrHooterValuePDF,
                                            x: trailingPosition,
                                            y: underFrontLight)
            
            //MARK: RoundGauge
            let roundGaugeValue = model.isRoundGauge ? "ทำงาน" : "ไม่ทำงาน"
            let roundGaugeString = "วัดรอบ  \(roundGaugeValue)"
            let attrRoundGaugeValuePDF = weakself.getTitle(mainString: roundGaugeString,
                                                    value: roundGaugeValue)
            let _ = weakself.drawString(attrString: attrRoundGaugeValuePDF,
                                            x: margin + 10,
                                            y: brakeLightRect.maxY + margin)
            
            //MARK: Navigator
            var navigatorValue = "\(model.isNavigator ? "มี" : "ไม่มี")  "
            navigatorValue += "\(model.isNavigatorOnCar ? "เนวิเกเตอร์ในตัว" : "")  "
            navigatorValue += "\(model.isCd ? "CD" : "")  "
            navigatorValue += "\(model.isSDCard ? "SD CARD" : "")  "
            navigatorValue += "\(model.isNoCd ? "ไม่มี CD" : "")  "
            navigatorValue += "\(model.isNoSdCard ? "ไม่มี SD CARD" : "")  "
            let navigatorString = "เนวิเกเตอร์  \(navigatorValue)"
            let attrNavigatorValuePDF = weakself.getTitle(mainString: navigatorString,
                                                    value: navigatorValue)
            let navigatorRect = weakself.drawString(attrString: attrNavigatorValuePDF,
                                            x: centerPosition,
                                            y: brakeLightRect.maxY + margin)
            
            //MARK: Note
            let noteValue = model.note?.pdfValidateString ?? "-"
            let noteString = "หมายเหตุอื่นๆ  \(noteValue)"
            let attrNoteValuePDF = weakself.getTitle(mainString: noteString,
                                                    value: noteValue)
            let noteRect = weakself.drawString(attrString: attrNoteValuePDF,
                                            x: margin + 10,
                                            y: navigatorRect.maxY + margin)
            
            //MARK: ElecSummary
//            let elecSummaryValue = model.summaryElectronicDevice?
//                                        .pdfValidateString
//                                        .pdfReFormString(title: "สรุปอุปกรณ์ไฟฟ้า  ") ?? "-"
//            let elecSummaryString = "สรุปอุปกรณ์ไฟฟ้า  \(elecSummaryValue)"
            let attrElecSummaryPDF = weakself.getTitle(mainString: elecSummaryString,
                                                    value: elecSummaryValue)
            let elecSummaryValueRect = weakself.drawString(attrString: attrElecSummaryPDF,
                                            x: margin + 10,
                                            y: noteRect.maxY + margin)
*/
            
            
            //MARK: Table
            let mapPoint = weakself.createTableDrawLine(drawContext: context.cgContext,
                                pageWidth: CGFloat(pageWidth) - 120,
                                underOfText: underLogo,
                                heightOffset: heightOffset,
                                margin: margin)
            
            //MARK: IMAP
            let attrImatatPDF = weakself.getTitle(mainString: "IMAT", value: "")
            let _ = weakself.drawString(attrString: attrImatatPDF,
                                            x: mapPoint["v1"]!,
                                            y: mapPoint["h1"]!,
                                            isTable: true)
            
            let imatValue = receiverModel.vehicleId.pdfValidateString
            let attrImaTValuePDF = weakself.getTitle(mainString: imatValue, value: imatValue)
            let _ = weakself.drawString(attrString: attrImaTValuePDF,
                                            x: mapPoint["v2"]!,
                                            y: mapPoint["h1"]!,
                                            isTable: true)
   
            //MARK: Registration
            let attrRegistrationPDF = weakself.getTitle(mainString: "ทะเบียน", value: "")
            let _ = weakself.drawString(attrString: attrRegistrationPDF,
                                            x: mapPoint["v3"]!,
                                            y: mapPoint["h3"]!,
                                            isTable: true)
            
            //MARK: Registration Value
            var registrationValue = ""
            
            /// Mapping Data Book-In
            if let province = DataController.shared.inspectionCarModel.registrationProvince ,
               let registration = DataController.shared.inspectionCarModel.registration {
                registrationValue = "\(registration.pdfValidateString)"
                registrationValue += " \(province.pdfValidateString)"
            }else{
                let provinceBookIn = DataController.shared.receiverCarModel.province
                let registrationBookIn = DataController.shared.receiverCarModel.registration
              
                registrationValue = "\(registrationBookIn?.pdfValidateString ?? "-")"
                registrationValue += " \(provinceBookIn?.pdfValidateString ?? "-")"
            }
            
            let attrRegistrationValuePDF = weakself.getTitle(mainString: registrationValue,
                                                    value: registrationValue)
            let _ = weakself.drawString(attrString: attrRegistrationValuePDF,
                                            x: mapPoint["v4"]!,
                                            y: mapPoint["h3"]!,
                                            isTable: true)
            
            
            //MARK: Make
            let attrBrandPDF = weakself.getTitle(mainString: "ยี่ห้อรถ", value: "")
            let _ = weakself.drawString(attrString: attrBrandPDF,
                                            x: mapPoint["v1"]!,
                                            y: mapPoint["h2"]!,
                                            isTable: true)
            
            let brandValue = receiverModel.make_BU?.pdfValidateString ?? "-"
            let attrBrandValuePDF = weakself.getTitle(mainString: brandValue, value: brandValue)
            let _ = weakself.drawString(attrString: attrBrandValuePDF,
                                            x: mapPoint["v2"]!,
                                            y: mapPoint["h2"]!,
                                            isTable: true)
            
            
            //MARK: Model
            let attrModelPDF = weakself.getTitle(mainString: "รุ่น", value: "")
            let _ = weakself.drawString(attrString: attrModelPDF,
                                            x: mapPoint["v3"]!,
                                            y: mapPoint["h2"]!,
                                            isTable: true)
            
            var carModelvalue = "\(receiverModel.modelCar?.pdfValidateString ?? "-")  "
            carModelvalue += "\(receiverModel.variants?.pdfValidateString ?? "")"
            let attrModelValuePDF = weakself.getTitle(mainString: carModelvalue, value: carModelvalue)
            let _ = weakself.drawString(attrString: attrModelValuePDF,
                                            x: mapPoint["v4"]!,
                                            y: mapPoint["h2"]!,
                                            isTable: true)
            
            
            //MARK: Engine
            let attrEnginePDF = weakself.getTitle(mainString: "หมายเลขเครื่อง", value: "")
            let _ = weakself.drawString(attrString: attrEnginePDF,
                                            x: mapPoint["v1"]!,
                                            y: mapPoint["h3"]!,
                                            isTable: true)
          
            

            let notValidateEngineCar = receiverModel.isInValidEngineNumber ?? false
            let reasonInvalidEngineNumber = "\(receiverModel.reasonInValidEngineNumber?.pdfValidateString2 ?? "-")"
            let engineNumber2 = "\(receiverModel.engineNumber?.pdfValidateString ?? "-")"
            var engineNumber = notValidateEngineCar ? "ตรวจสอบไม่ได้  " : ""
            engineNumber += notValidateEngineCar ? reasonInvalidEngineNumber : engineNumber2
            
            let attrEngineValuePDF = weakself.getTitle(mainString: engineNumber, value: engineNumber)
            let _ = weakself.drawString(attrString: attrEngineValuePDF,
                                            x: mapPoint["v2"]!,
                                            y: mapPoint["h3"]!,
                                            isTable: true)
            
            //MARK: VIN
            let attrVINPDF = weakself.getTitle(mainString: "หมายเลขตัวถัง", value: "")
            let _ = weakself.drawString(attrString: attrVINPDF,
                                            x: mapPoint["v1"]!,
                                            y: mapPoint["h4"]!,
                                            isTable: true)
            
            
            let notValidateVinNumber = receiverModel.isInValidVinNumber ?? false
            let reasonInValidVinNumber = "\(receiverModel.reasonInValidVinNumber?.pdfValidateString2 ?? "")"
            let vinNumber2 = "\(receiverModel.vinNumber?.pdfValidateString ?? "-")"
            var vinNumber = notValidateVinNumber ? "ตรวจสอบไม่ได้  " : ""
            vinNumber += notValidateVinNumber ?  reasonInValidVinNumber : vinNumber2
            
            let attrVINValuePDF = weakself.getTitle(mainString: vinNumber, value: vinNumber)
            let _ = weakself.drawString(attrString: attrVINValuePDF,
                                            x: mapPoint["v2"]!,
                                            y: mapPoint["h4"]!,
                                            isTable: true)
            
          
            //MARK: STORAGE
            let attrStorgePDF = weakself.getTitle(mainString: "STORAGE", value: "")
            let _ = weakself.drawString(attrString: attrStorgePDF,
                                            x: mapPoint["v3"]!,
                                            y: mapPoint["h1"]!,
                                            isTable: true)
            
            let storageValue = receiverModel.storePlace?.pdfValidateString ?? "-"
            let attrStorgeValuePDF = weakself.getTitle(mainString: storageValue, value: storageValue)
            let _ = weakself.drawString(attrString: attrStorgeValuePDF,
                                            x: mapPoint["v4"]!,
                                            y: mapPoint["h1"]!,
                                            isTable: true)
            
          
            
            
            //MARK: Miles
            let attrMilesPDF = weakself.getTitle(mainString: "เลขไมล์", value: "")
            let _ = weakself.drawString(attrString: attrMilesPDF,
                                            x: mapPoint["v3"]!,
                                            y: mapPoint["h4"]!,
                                            isTable: true)
            
            let milesValue = "\(receiverModel.miles?.pdfValidateString ?? "-") \(receiverModel.typeMiles?.pdfValidateString ?? "-")"
            let attrMilesValuePDF = weakself.getTitle(mainString: milesValue, value: milesValue)
            let _ = weakself.drawString(attrString: attrMilesValuePDF,
                                            x: mapPoint["v4"]!,
                                            y: mapPoint["h4"]!,
                                            isTable: true)
        
            //MARK: Gear
            let attrGearPDF = weakself.getTitle(mainString: "เกียร์", value: "")
            let _ = weakself.drawString(attrString: attrGearPDF,
                                            x: mapPoint["v1"]!,
                                            y: mapPoint["h5"]!,
                                            isTable: true)
            

            //MARK: gear
            var typeGearValue = "AT"
            switch receiverModel.gearbox?.trimWhiteSpace {
            case "1":
                typeGearValue = "N/A"
            case "A":
                typeGearValue = "AT"
            case "M":
                typeGearValue = "MT"
            default:
                typeGearValue = "AT"
            }
            
            let attrGearValuePDF = weakself.getTitle(mainString: typeGearValue, value: typeGearValue)
            let _ = weakself.drawString(attrString: attrGearValuePDF,
                                            x: mapPoint["v2"]!,
                                            y: mapPoint["h5"]!,
                                            isTable: true)
            
            //MARK: Color
            let attrColorPDF = weakself.getTitle(mainString: "สี", value: "")
            let _ = weakself.drawString(attrString: attrColorPDF,
                                            x: mapPoint["v3"]!,
                                            y: mapPoint["h5"]!,
                                            isTable: true)
            

            let colorValue = receiverModel.colorCar?.pdfValidateString ?? "-"
            let attrColorValuePDF = weakself.getTitle(mainString: colorValue, value: colorValue)
            let _ = weakself.drawString(attrString: attrColorValuePDF,
                                            x: mapPoint["v4"]!,
                                            y: mapPoint["h5"]!,
                                            isTable: true)
            
           
            if let inspector = inspector {
                //MARK: EditBy
                let attrEditBy = weakself.getTitle(mainString: "แก้ไขโดย", value: "")
                let _ = weakself.drawString(attrString: attrEditBy,
                                                x: mapPoint["v3"]!,
                                                y: mapPoint["h6"]!,
                                                isTable: true)

                var editByValue = inspector.pdfValidateString
                editByValue += " \(latestUpdateDate)"
                let attrEditByPDF = weakself.getTitle(mainString: editByValue,
                                                        value: editByValue)
                let _ = weakself.drawString(attrString: attrEditByPDF,
                                                x: mapPoint["v4"]!,
                                                y: mapPoint["h6"]!,
                                                isTable: true)
            }
            
            //MARK: Name inspection
            let attrNamePDF = weakself.getTitle(mainString: "ชื่อผู้ตรวจ", value: "")
            let _ = weakself.drawString(attrString: attrNamePDF,
                                            x: mapPoint["v1"]!,
                                            y: mapPoint["h6"]!,
                                            isTable: true)
            
            let nameValue = model.nameInspection?.pdfValidateString ?? "-"
            let attrNameValuePDF = weakself.getTitle(mainString: nameValue, value: nameValue)
            let inspectionRect = weakself.drawString(attrString: attrNameValuePDF,
                                            x: mapPoint["v2"]!,
                                            y: mapPoint["h6"]!,
                                            isTable: true)

            

            let underTable = inspectionRect.maxY + 15
            
            let mapPoint2 = weakself.createTableDrawLine2(drawContext: context.cgContext,
                                pageWidth: CGFloat(pageWidth),
                                underOfText: underTable,
                                heightOffset: 12,
                                margin: margin,
                                rows: 29,
                                columns: 10)
            
            
            setTextWithPosition(title: "ไฟเลี้ยวหลัง R",
                                value: receiverModel.rearTurnSignalR?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h1"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h1"]!)
            
            setTextWithPosition(title: "กาบข้าง R",
                                value: receiverModel.bodyCladdingR?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h2"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h2"]!)
            
            setTextWithPosition(title: "ท่อไอเสีย",
                                value: receiverModel.exhaustPipe?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h3"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h3"]!)
            
            setTextWithPosition(title: "พักเท้าหลัง R/L",
                                value: receiverModel.rearFootRest?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h4"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h4"]!)
            
            setTextWithPosition(title: "คันสตาร์ค",
                                value: receiverModel.starterLever?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h5"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h5"]!)
            
            setTextWithPosition(title: "พักเท้าหน้า R/L",
                                value: receiverModel.frontFootRest?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h6"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h6"]!)
            
            
            setTextWithPosition(title: "ขาตั้งเดี่ยว",
                                value: receiverModel.sideStand?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h7"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h7"]!)
            
            setTextWithPosition(title: "ขาตั้งคู่",
                                value: receiverModel.doubleStand?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h8"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h8"]!)
            
            setTextWithPosition(title: "บังลม R",
                                value: receiverModel.windScreenR?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h9"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h9"]!)
            
            setTextWithPosition(title: "ช่องอเนกประสงค์ R",
                                value: receiverModel.multiPurposeR?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h10"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h10"]!)
            
            setTextWithPosition(title: "กระจก R",
                                value: receiverModel.mirrorR?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h11"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h11"]!)
            
            setTextWithPosition(title: "มือเบรค R",
                                value: receiverModel.handBreakR?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h12"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h12"]!)
            
            setTextWithPosition(title: "เรือนไมล์",
                                value: receiverModel.milesDisplay?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h13"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h13"]!)
            
            setTextWithPosition(title: "หน้ากาก",
                                value: receiverModel.mask?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h14"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h14"]!)
            
            setTextWithPosition(title: "ไฟหน้า",
                                value: receiverModel.frontLight?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h15"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h15"]!)
            
            setTextWithPosition(title: "ไฟเลี้ยวหน้า R",
                                value: receiverModel.frontTurnSignalR?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h16"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h16"]!)
            
            setTextWithPosition(title: "บังโคลนหน้า",
                                value: receiverModel.frontFender?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h17"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h17"]!)
            
            setTextWithPosition(title: "ล้อหน้า",
                                value: "\(receiverModel.frontWheel?.pdfValidateString ?? "-")  \t\t\(receiverModel.frontWheelType?.pdfValidateString2 ?? "")",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h18"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h18"]!)
            
            setTextWithPosition(title: "ยางหน้า",
                                value: receiverModel.frontTire?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h19"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h19"]!)
            
            setTextWithPosition(title: "เบรคหน้า",
                                value: "\(receiverModel.frontBrake?.pdfValidateString ?? "-")  \t\t\(receiverModel.frontBrakeType?.pdfValidateString2 ?? "")",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h20"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h20"]!)
          
            setTextWithPosition(title: "ปั้มดิสเบรคหน้า",
                                value: receiverModel.frontPumpDiscBrakes?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h21"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h21"]!)
            
            setTextWithPosition(title: "กระปุกน้ำมันดิสเบรคหน้า",
                                value: receiverModel.frontOilTankDiscBrakes?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h22"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h22"]!)
            
            setTextWithPosition(title: "โช๊คหน้า",
                                value: receiverModel.frontShockup?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h23"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h23"]!)
            
            setTextWithPosition(title: "บังโซ่",
                                value: receiverModel.chainCover?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h24"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h24"]!)
            
            setTextWithPosition(title: "มือเบรค L",
                                value: receiverModel.handBreakL?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h1"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h1"]!)
            
            setTextWithPosition(title: "มือครัช",
                                value: receiverModel.handClutch?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h2"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h2"]!)
            
            setTextWithPosition(title: "ไฟเลี้ยวหน้า L",
                                value: receiverModel.frontTurnSignalL?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h3"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h3"]!)
            
            setTextWithPosition(title: "กระจก L",
                                value: receiverModel.mirrorL?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h4"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h4"]!)
            
            setTextWithPosition(title: "บังลม L",
                                value: receiverModel.windScreenL?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h5"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h5"]!)
            
            setTextWithPosition(title: "กาบข้าง L",
                                value: receiverModel.bodyCladdingL?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h6"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h6"]!)
            
            setTextWithPosition(title: "เบาะ",
                                value: receiverModel.seat?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h7"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h7"]!)
            
            setTextWithPosition(title: "โครงเหล็กท้ายเบาะ",
                                value: receiverModel.rearSeatRack?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h8"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h8"]!)
            
            setTextWithPosition(title: "ไฟเลี้ยวหลัง L",
                                value: receiverModel.rearTurnSignalL?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h9"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h9"]!)
            
            setTextWithPosition(title: "ไฟท้าย",
                                value: receiverModel.rearLight?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h10"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h10"]!)
            
            setTextWithPosition(title: "บังโคลนท้าย",
                                value: receiverModel.rearFender?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h11"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h11"]!)
            
            setTextWithPosition(title: "ช่องอเนกประสงค์ L",
                                value: receiverModel.multiPurposeL?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h12"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h12"]!)
            
            setTextWithPosition(title: "ล้อหลัง",
                                value: "\(receiverModel.rearWheel?.pdfValidateString ?? "-") \t\t\(receiverModel.rearWheelType?.pdfValidateString2 ?? "")",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h13"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h13"]!)
            
            setTextWithPosition(title: "ยางหลัง",
                                value: receiverModel.rearTire?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h14"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h14"]!)
            
            setTextWithPosition(title: "เบรคหลัง",
                                value: "\(receiverModel.rearBrake?.pdfValidateString ?? "-") \t\t\(receiverModel.rearBrakeType?.pdfValidateString2 ?? "")",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h15"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h15"]!)
            
            setTextWithPosition(title: "ปั้มดิสเบรคหลัง",
                                value: receiverModel.rearPumpDiscBrakes?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h16"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h16"]!)
            
            setTextWithPosition(title: "กระปุกน้ำมันดิสเบรคหลัง",
                                value: receiverModel.rearOilTankDiscBrakes?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h17"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h17"]!)
            
            setTextWithPosition(title: "โช๊คหลัง",
                                value: receiverModel.rearShockup?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h18"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h18"]!)
            
            setTextWithPosition(title: "U-BOX",
                                value: receiverModel.ubox?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h19"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h19"]!)
            
            setTextWithPosition(title: "ถังน้ำมัน",
                                value: receiverModel.oilTank?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h20"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h20"]!)
            
            setTextWithPosition(title: "แบตเตอรี่",
                                value: receiverModel.battery?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h21"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h21"]!)
            
            setTextWithPosition(title: "กล่องควบคุม (CDI)",
                                value: receiverModel.cdiBox?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h22"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h22"]!)
            
            setTextWithPosition(title: "เครื่องมือ",
                                value: receiverModel.toolSpare?.pdfValidateString ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h23"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h23"]!)
            
            
            
            setTextWithPosition(title: "สตาร์ทมือ",
                                value: receiverModel.isHandStart ?? false ? "มี" : "ไม่มี",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h24"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h24"]!)
            
            setTextWithPosition(title: "สตาร์ทเท้า",
                                value: receiverModel.isKickStart ?? false ? "มี" : "ไม่มี",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h25"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h25"]!)
            
            setTextWithPosition(title: "แผ่นป้ายทะเบียน",
                                value: receiverModel.isRegistrationPlate ?? false ? "มี" : "ไม่มี",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h25"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h25"]!)
            
            /// data from inspection
            setTextWithPosition(title: "ระบบจ่ายเชื้อเพลิง",
                                value: model.fuelDeliveryType?.pdfValidateString2 ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h26"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h26"]!)
            
            setTextWithPosition(title: "เครื่องยนต์",
                                value: receiverModel.engineCondition?.pdfValidateString2 ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h26"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h26"]!)
            
            setTextWithPosition(title: "เกียร์",
                                value: receiverModel.gearCondition?.pdfValidateString2 ?? "-",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h27"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h27"]!)
            
            setTextWithPosition(title: "เบรค",
                                value: receiverModel.brakeCondition?.pdfValidateString2 ?? "-",
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h27"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h27"]!)
            
            
            //MARK: Keys
            setTextWithPosition(title: "กุญแจ",
                                value: "\(receiverModel.itemKeys2) ดอก",
                                titleX: mapPoint2["v1"]!, titleY: mapPoint2["h28"]!,
                                valueX: mapPoint2["v2"]!, valueY: mapPoint2["h28"]!)
           
           
            var redBookCondition = "-"
            switch receiverModel.redBookCondition?.uppercased() {
            case "G":
                redBookCondition = "Good / ดี"
            case "A":
                redBookCondition = "Average / ปานกลาง"
            case "F":
                redBookCondition = "Fair / พอใช้"
            case "P":
                redBookCondition = "Poor / แย่"
            case "Y":
                redBookCondition = "Scrap / ซาก"
            default:
                break
            }
            
            setTextWithPosition(title: "สภาพรถ",
                                value: redBookCondition,
                                titleX: mapPoint2["v3"]!, titleY: mapPoint2["h28"]!,
                                valueX: mapPoint2["v4"]!, valueY: mapPoint2["h28"]!)
            
            
            
            let underTable2 = mapPoint2["h28"]! + 10
            let centerPosition = mapPoint2["v3"]!
            
            //MARK:ExteriorDamage
            let exteriorRect = drawTextWithPosition(title: exteriorDamageMainString,
                                          value: exteriorDamageValue,
                                          titleX: margin + 10,
                                          titleY: underTable2)
            
            //MARK: FuelDelivery
            let underExterior = exteriorRect.maxY + margin
            
            let fuelDeliveryTypeValue = model.fuelDeliveryType?.pdfValidateString ?? "-"
            let fuelDeliveryString = "ระบบเชื้อเพลิง  \(fuelDeliveryTypeValue)"
            let _ = drawTextWithPosition(title: fuelDeliveryString,
                                                        value: fuelDeliveryTypeValue,
                                                        titleX: margin + 10,
                                                        titleY: underExterior)
            
            let fuelDeliveryDamageTypeValue = model.fuelDeliveryDamage?.pdfValidateString ?? "-"
            let fuelDeliveryDamageString = "ความเสียหาย  \(fuelDeliveryDamageTypeValue)"
            let fuelDeleveryRect = drawTextWithPosition(title: fuelDeliveryDamageString,
                                         value: fuelDeliveryDamageTypeValue,
                                         titleX: centerPosition,
                                         titleY: underExterior)
            
            
            //MARK: Battery
            let underFuelDelivery = fuelDeleveryRect.maxY + margin
           
            let batteryValue = model.isBattery ?? false ? "มี" : "ไม่มี"
            let batteryString = "แบตเตอรี่  \(batteryValue)"
            let _ = drawTextWithPosition(title: batteryString,
                                        value: batteryValue,
                                        titleX: margin + 10,
                                        titleY: underFuelDelivery)
                        
            let batteryDamageValue = model.batteryDamage?.pdfValidateString ?? "-"
            let batteryDamageString = "ความเสียหาย  \(batteryDamageValue)"
            let batteryRect = drawTextWithPosition(title: batteryDamageString,
                                             value: batteryDamageValue,
                                             titleX: centerPosition,
                                             titleY: underFuelDelivery)
            

            //MARK: CDI
            let underBattery = batteryRect.maxY + margin
            
            let cdiValue = model.isCDI ?? false ? "มี" : "ไม่มี"
            let cdiString = "กล่องควมคุมการจุดระเบิด  \(cdiValue)"
            let _ = drawTextWithPosition(title: cdiString,
                                               value: cdiValue,
                                               titleX: margin + 10,
                                               titleY: underBattery)

            let cdiDamageValue = model.cdiDamage?.pdfValidateString ?? "-"
            let cdiDamageString = "ความเสียหาย  \(cdiDamageValue)"
            let cdiRect = drawTextWithPosition(title: cdiDamageString,
                                         value: cdiDamageValue,
                                         titleX: centerPosition,
                                         titleY: underBattery)



            //MARK:Electric Start
            let underCdi = cdiRect.maxY + margin

            let electricStartValue = model.isElectricStart ?? false ? "มี" : "ไม่มี"
            let electricStartString = "สตาร์ทมือ  \(electricStartValue)"
            let _  = drawTextWithPosition(title: electricStartString,
                                          value: electricStartValue,
                                          titleX: margin + 10,
                                          titleY: underCdi)
            
            let electricStartDamageValue = model.electricStartDamage?.pdfValidateString ?? "-"
            let electricStartDamageString = "ความเสียหาย  \(electricStartDamageValue)"
            let electricStartRect  = drawTextWithPosition(title: electricStartDamageString,
                                          value: electricStartDamageValue,
                                          titleX: centerPosition,
                                          titleY: underCdi)
            

            //MARK:Pedal Start
            let underElectricStart = electricStartRect.maxY + margin
            
            let pedelStartValue = model.isPedelStart ?? false ? "มี" : "ไม่มี"
            let pedelStartString = "คันสตาร์ท  \(pedelStartValue)"
            let _  = drawTextWithPosition(title: pedelStartString,
                                          value: pedelStartValue,
                                          titleX: margin + 10,
                                          titleY: underElectricStart)
            
            let pedelStartDamageValue = model.pedelStartDamage?.pdfValidateString ?? "-"
            let pedelStartDamageString = "ความเสียหาย  \(pedelStartDamageValue)"
            let pedelStartRect  = drawTextWithPosition(title: pedelStartDamageString,
                                          value: pedelStartDamageValue,
                                          titleX: centerPosition,
                                          titleY: underElectricStart)
            
            
            //MARK:Odometer
            let underPedalStart = pedelStartRect.maxY + margin
            
            let odometerValue = model.isOdometer ?? false ? "มี" : "ไม่มี"
            let odometerString = "เรือนไมล์  \(odometerValue)"
            let _  = drawTextWithPosition(title: odometerString,
                                          value: odometerValue,
                                          titleX: margin + 10,
                                          titleY: underPedalStart)
            
            let odometerDamageValue = model.odometerDamage?.pdfValidateString ?? "-"
            let odometerDamageString = "ความเสียหาย  \(odometerDamageValue)"
            let odometerRect  = drawTextWithPosition(title: odometerDamageString,
                                          value: odometerDamageValue,
                                          titleX: centerPosition,
                                          titleY: underPedalStart)
            
            //MARK:Plate
            let underOdometer = odometerRect.maxY + margin
            
            let plateValue = model.isPlate ?? false ? "มี" : "ไม่มี"
            let plateString = "แผ่นป้ายทะเบียน  \(plateValue)"
            let _  = drawTextWithPosition(title: plateString,
                                          value: plateValue,
                                          titleX: margin + 10,
                                          titleY: underOdometer)
            
            let plateDamageValue = model.plateDamage?.pdfValidateString ?? "-"
            let plateDamageString = "ความเสียหาย  \(plateDamageValue)"
            let plateRect  = drawTextWithPosition(title: plateDamageString,
                                          value: plateDamageValue,
                                          titleX: centerPosition,
                                          titleY: underOdometer)
            
            //MARK:Tire
            let underPlate = plateRect.maxY + margin
            var tireTreadDepth = " หน้า \(model.frontTreadDepth?.pdfValidateString ?? "-") mm."
            tireTreadDepth += " หลัง \(model.rearTreadDepth?.pdfValidateString ?? "-") mm."
            
            let tireTreadDepthString = "ความลึกดอกยาง \(tireTreadDepth)"
            let tireTreadDepthRect  = drawTextWithPosition(title: tireTreadDepthString,
                                          value: tireTreadDepth,
                                          titleX: margin + 10,
                                          titleY: underPlate)
            
            
            //MARK:Key
            let underTire = tireTreadDepthRect.maxY + margin
            
            var keyValue = "\(model.isKey ?? false ? "• กุญแจธรรมดา" : "")"
            keyValue += "  \(model.isRemote ?? false ? "• รีโมท" : "")"
            keyValue += "  \(model.isRemoteKey ?? false ? "• กุญแจรีโมท" : "")"
            keyValue += "  \(model.isImmobilizarKey ?? false ? "• กุญแจ Immobilizar" : "")"
            let keyString = "กุญแจ  \(keyValue)"
            
            let keyRect = drawTextWithPosition(title: keyString,
                                          value: keyValue,
                                          titleX: margin + 10,
                                          titleY: underTire)
            //MARK:Engine
            let underKey = keyRect.maxY + margin
            
            var engineValue = "\(model.isServiceable ?? false ? "• เช็คสภาพตามอายุการใช้งาน" : "")"
            engineValue += "  \(model.isRequireAttention ?? false ? "• ต้องทำการซ่อมแซม" : "")"
            engineValue += "  \(model.isWillNotStart ?? false ? "• สตาร์ทไม่ติด" : "")"
            engineValue += "  \(model.isMissing ?? false ? "• สูญหาย" : "")"
            let engineString = "เครื่องยนต์  \(engineValue)"
            
            let engineRect = drawTextWithPosition(title: (engineValue.trimWhiteSpace.isEmpty) ? "เครื่องยนต์ -" : engineString ,
                                          value: engineValue,
                                          titleX: margin + 10,
                                          titleY: underKey)
            
          
            
            //MARK: DamagePhoto
            if isDamagePhoto {
                let underEngine = engineRect.maxY + margin

                let damageDesc = "รูปความเสียหาย"
                let attrDamageDescValuePDF = weakself.getTitle(mainString: damageDesc,
                                                               value: damageDesc, size: 20.0)
                let damageCenter = CGFloat(pageWidth/2) - (attrDamageDescValuePDF.size().width/2)
                let damageDescRect = weakself.drawString(attrString: attrDamageDescValuePDF,
                                                         x: damageCenter,
                                                         y: underEngine)

                let mapPointDamage = weakself.createTableDrawLineSize(drawContext: context.cgContext,
                                    pageWidth: CGFloat(pageWidth),
                                    underOfText: damageDescRect.maxY + margin,
                                    heightOffset: CGFloat(photoSize),
                                    margin: margin,
                                    row: photoRow)

                print(mapPointDamage)

                damageLists.enumerated().forEach { (offset, model) in

                    let position = offset/3

                    let offsetV = offset

                    if (offsetV % 3) == 2 {
                        if let image = model.imageData?.base64StringToImage() {
                            image.draw(in: CGRect(x: mapPointDamage["v3"]!,
                                                  y: mapPointDamage["h\(position)"]!,
                                                  width: CGFloat(photoSize),
                                                  height: CGFloat(photoSize)))
                        }


                    }else if (offsetV % 3) == 1 {
                        if let image = model.imageData?.base64StringToImage() {
                            image.draw(in: CGRect(x: mapPointDamage["v2"]!,
                                                  y: mapPointDamage["h\(position)"]!,
                                                  width: CGFloat(photoSize),
                                                  height: CGFloat(photoSize)))
                        }


                    }else{
                        if let image = model.imageData?.base64StringToImage() {
                            image.draw(in: CGRect(x: mapPointDamage["v1"]!,
                                                  y: mapPointDamage["h\(position)"]!,
                                                  width: CGFloat(photoSize),
                                                  height: CGFloat(photoSize)))
                        }


                    }


                } // End Loop

            }
            
            
            
        }
        
        
        let response  = SummaryCar.Something.Response(documentData: data)
        completion(response)
        
    }
}














//MARK: Extension
extension MotorbikeInspecPDFWorker {
    func createTableDrawLineSize(drawContext : CGContext ,
                            pageWidth : CGFloat,
                            underOfText : CGFloat,
                            heightOffset : CGFloat ,
                            margin : CGFloat,
                            row:Int) -> [String: CGFloat] {
       var mapPoint : [String:CGFloat] = [:]
       
       let heightOffset = heightOffset
       let underText = underOfText

        let tabWidth = heightOffset
       // Draw content's  vertical lines
        var vIndex = 0
        for verticalLineIndex in 0...3 {
            vIndex += 1
           let tabX = CGFloat(verticalLineIndex) * tabWidth + CGFloat((vIndex * 20)) + 45
          
           if verticalLineIndex == 0 {
               mapPoint["v1"] = tabX
           }
           if verticalLineIndex == 1 {
               mapPoint["v2"] = tabX
           }
            if verticalLineIndex == 2 {
                mapPoint["v3"] = tabX
            }
         
       }
       
       // Draw content's element bottom horizontal line
        var index = 0
        for  horizontalLine in 0...(row * 2){
            index += 1
           let yPosition =  CGFloat(horizontalLine) * heightOffset + underText
           
            mapPoint["h\(horizontalLine)"] = yPosition + CGFloat((index * 5))
         
       }
       
       return mapPoint
   }
    func drawString(attrString : NSAttributedString , x : CGFloat , y : CGFloat, isTable:Bool = false) -> CGRect {
        let attrPDFSize = attrString.size()
        let attrPDFSizeRect = CGRect(x: x + (isTable ? 2 : 0),
                                     y: y - (isTable ? attrPDFSize.height : 0),
                                     width: attrPDFSize.width,  height: attrPDFSize.height)
        attrString.draw(in: attrPDFSizeRect)
        return attrPDFSizeRect
    }
    
    func createTableDrawLine2(drawContext : CGContext ,
                            pageWidth : CGFloat,
                            underOfText : CGFloat,
                            heightOffset : CGFloat ,
                            margin : CGFloat,
                            rows:Int,
                            columns:Int) -> [String: CGFloat] {
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
    
     func createTableDrawLine(drawContext : CGContext ,
                             pageWidth : CGFloat,
                             underOfText : CGFloat,
                             heightOffset : CGFloat ,
                             margin : CGFloat) -> [String: CGFloat] {
        var mapPoint : [String:CGFloat] = [:]
        
        let heightOffset = heightOffset
        let heightTable = heightOffset * 6
        let underText = underOfText
        let yPosition = underText
        let margin = margin  + 10
        
        drawContext.setStrokeColor(UIColor.lightGray.cgColor)
        drawContext.setLineWidth(0.5)
        drawContext.saveGState()
        
        let tabWidth = pageWidth / 8
        // Draw content's  vertical lines
        for verticalLineIndex in 0..<9 {
            if verticalLineIndex == 2 || verticalLineIndex == 3 ||
               verticalLineIndex == 6 || verticalLineIndex == 7 {
                continue
            }
            var tabX = CGFloat(verticalLineIndex) * tabWidth
           
            if verticalLineIndex == 0 {
                tabX += margin
                
                mapPoint["v1"] = tabX
            }
            if verticalLineIndex == 1 {
                tabX += margin + 15
                mapPoint["v2"] = tabX //value1
            }
            if verticalLineIndex == 4 {
                mapPoint["v3"] = tabX
            }
            if verticalLineIndex == 5 {
                tabX += margin
                mapPoint["v4"] = tabX //value2
            }
            
            if verticalLineIndex == 8 {
                tabX -= margin
            }
            drawContext.move(to: CGPoint(x: tabX, y: yPosition))
            drawContext.addLine(to: CGPoint(x: tabX, y: yPosition + heightTable))
            drawContext.strokePath()
            
        }
        
        // Draw content's element bottom horizontal line
        for  horizontalLine in 0..<7{
            
            let yPosition =  CGFloat(horizontalLine) * heightOffset + underText
            
            mapPoint["h\(horizontalLine)"] = yPosition
            
            drawContext.move(to: CGPoint(x: margin, y: yPosition))
            drawContext.addLine(to: CGPoint(x: CGFloat(pageWidth) - margin, y: yPosition))
            drawContext.strokePath()
        }
        drawContext.restoreGState()
        
        return mapPoint
    }
    func getTitle(mainString : String, value : String , textColor : UIColor = .black , size: CGFloat = 9) -> NSMutableAttributedString {
        let range = (mainString as NSString).range(of: value)
        let attr = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: size),
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
    
    
    func getHeightText(_ string:String) -> Int {
        let attrs = getTitle(mainString: string, value: string)
        return Int(attrs.size().height)
    }
    
    
    func getLatestUpdateDate(updateDate:Date?) -> String {
        guard let date = updateDate else { return "-"}
        
        var latestUpdateDate = ""
        latestUpdateDate = DateFormatter().dateFormat(from: date, dateFormat: "dd-MM-yyyy")
        latestUpdateDate += " \(DateFormatter().dateFormat(from: date, dateFormat: "HH:mm"))"
        return latestUpdateDate
    }
    
    fileprivate func setTextWithPosition(title:String, value:String, titleX:CGFloat, titleY:CGFloat, valueX:CGFloat, valueY:CGFloat) {
        let titleAttr = getTitle(mainString: title, value: "")
        let _ = drawString(attrString: titleAttr, x: titleX, y: titleY, isTable: true)
        
        let valuePDF = getTitle(mainString: value, value: "", textColor: .darkGray)
        let _ = drawString(attrString: valuePDF, x: valueX, y: valueY, isTable: true)

    }
    
    fileprivate func drawTextWithPosition(title:String, value:String, titleX:CGFloat, titleY:CGFloat) -> CGRect {
        let titleAttr = getTitle(mainString: title, value: value)
        let rect = drawString(attrString: titleAttr, x: titleX, y: titleY, isTable: false)
       
        return rect
    }
}
