//
//  GradeCarInteractor.swift
//  Inspection
//
//  Created by Thanawat prathumset on 11/3/2564 BE.
//  Copyright (c) 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol GradeCarBusinessLogic
{
  func doSomething(request: GradeCar.Something.Request)
    func evaluateGrade()
    func e1Chehck(request: GradeCar.Something.Request)
    func e2Chehck(request: GradeCar.Something.Request)
    func e3Chehck(request: GradeCar.Something.Request)
    func e4Chehck(request: GradeCar.Something.Request)
    func e5Chehck(request: GradeCar.Something.Request)
    // good
    func g1Chehck(request: GradeCar.Something.Request)
    func g2Chehck(request: GradeCar.Something.Request)
    func g3Chehck(request: GradeCar.Something.Request)
    func g4Chehck(request: GradeCar.Something.Request)
    
    //average
    func a1Chehck(request: GradeCar.Something.Request)
    func a2Chehck(request: GradeCar.Something.Request)
    func a3Chehck(request: GradeCar.Something.Request)
    func a4Chehck(request: GradeCar.Something.Request)
    
    //fair
    func f1Chehck(request: GradeCar.Something.Request)
    func f2Chehck(request: GradeCar.Something.Request)
    func f3Chehck(request: GradeCar.Something.Request)
    func f4Chehck(request: GradeCar.Something.Request)
    func f5Chehck(request: GradeCar.Something.Request)
    func f6Chehck(request: GradeCar.Something.Request)
    func f7Chehck(request: GradeCar.Something.Request)
    func f8Chehck(request: GradeCar.Something.Request)
    func f9Chehck(request: GradeCar.Something.Request)
    func f10Chehck(request: GradeCar.Something.Request)
    func f11Chehck(request: GradeCar.Something.Request)
    
    //poor
    func p1Chehck(request: GradeCar.Something.Request)
    func p2Chehck(request: GradeCar.Something.Request)
    func p3Chehck(request: GradeCar.Something.Request)
    func p4Chehck(request: GradeCar.Something.Request)
    func p5Chehck(request: GradeCar.Something.Request)
    func p6Chehck(request: GradeCar.Something.Request)
    func p7Chehck(request: GradeCar.Something.Request)
    func p8Chehck(request: GradeCar.Something.Request)
    func p9Chehck(request: GradeCar.Something.Request)
    
    //x
    func x1Chehck(request: GradeCar.Something.Request)
    
    //cy
    func y1Chehck(request: GradeCar.Something.Request)
    
    func prapareCheck(request: GradeCar.Something.Request)
}

protocol GradeCarDataStore
{
  //var name: String { get set }
}

class GradeCarInteractor: GradeCarBusinessLogic, GradeCarDataStore
{
  var presenter: GradeCarPresentationLogic?
  var worker: GradeCarWorker?
  //var name: String = ""
    // exellence
    var e1Chehck : Bool = false
    var e2Chehck : Bool = false
    var e3Chehck : Bool = false
    var e4Chehck : Bool = false
    var e5Chehck : Bool = false
    
    // good
    var g1Chehck : Bool = false
    var g2Chehck : Bool = false
    var g3Chehck : Bool = false
    var g4Chehck : Bool = false
    
    // average
    var a1Chehck : Bool = false
    var a2Chehck : Bool = false
    var a3Chehck : Bool = false
    var a4Chehck : Bool = false
    
    // fair
    var f1Chehck : Bool = false
    var f2Chehck : Bool = false
    var f3Chehck : Bool = false
    var f4Chehck : Bool = false
    var f5Chehck : Bool = false
    var f6Chehck : Bool = false
    var f7Chehck : Bool = false
    var f8Chehck : Bool = false
    var f9Chehck : Bool = false
    var f10Chehck :Bool = false
    var f11Chehck :Bool = false
    
    // poor
    var p1Chehck : Bool = false
    var p2Chehck : Bool = false
    var p3Chehck : Bool = false
    var p4Chehck : Bool = false
    var p5Chehck : Bool = false
    var p6Chehck : Bool = false
    var p7Chehck : Bool = false
    var p8Chehck : Bool = false
    var p9Chehck : Bool = false
    
    // x
    var x1Chehck : Bool = false
    
    // y
    var y1Chehck : Bool = false
  
  // MARK: Do something
  
  func doSomething(request: GradeCar.Something.Request)
  {
    worker = GradeCarWorker()
    worker?.doSomeWork()
    
    let response = GradeCar.Something.Response()
    presenter?.presentSomething(response: response)
  }
    
    
    func evaluateGrade() {
        
        var grade = "-"
        
        if e1Chehck && e2Chehck && e3Chehck && e4Chehck && e5Chehck {
            grade = "E"
        }
        if g1Chehck && g2Chehck && g3Chehck && g4Chehck {
            grade = "G"
        }
        if a1Chehck && a2Chehck && a4Chehck && g4Chehck {
            grade = "A"
        }
        if a1Chehck && a2Chehck && a3Chehck && a4Chehck {
            grade = "A"
        }
        if f1Chehck || f2Chehck || f3Chehck || f4Chehck || f5Chehck || f6Chehck || f7Chehck || f8Chehck || f9Chehck || f10Chehck || f11Chehck {
            grade = "F"
        }
        if p1Chehck || p2Chehck || p3Chehck || p4Chehck || p5Chehck || p6Chehck || p7Chehck || p8Chehck || p9Chehck {
            grade = "P"
        }
        if x1Chehck  {
            grade = "X"
        }
        if y1Chehck  {
            grade = "Y"
        }
        let modelInspection = DataController.shared.inspectionCarModel
        modelInspection.e1Chehck = e1Chehck
        modelInspection.e2Chehck = e2Chehck
        modelInspection.e3Chehck = e3Chehck
        modelInspection.e4Chehck = e4Chehck
        modelInspection.e5Chehck = e5Chehck
        modelInspection.g1Chehck = g1Chehck
        modelInspection.g2Chehck = g2Chehck
        modelInspection.g3Chehck = g3Chehck
        modelInspection.g4Chehck = g4Chehck
        modelInspection.a1Chehck = a1Chehck
        modelInspection.a2Chehck = a2Chehck
        modelInspection.a3Chehck = a3Chehck
        modelInspection.a4Chehck = a4Chehck
        modelInspection.f1Chehck = f1Chehck
        modelInspection.f2Chehck = f2Chehck
        modelInspection.f3Chehck = f3Chehck
        modelInspection.f4Chehck = f4Chehck
        modelInspection.f5Chehck = f5Chehck
        modelInspection.f6Chehck = f6Chehck
        modelInspection.f7Chehck = f7Chehck
        modelInspection.f8Chehck = f8Chehck
        modelInspection.f9Chehck = f9Chehck
        modelInspection.f10Chehck = f10Chehck
        modelInspection.f11Chehck = f11Chehck
        modelInspection.p1Chehck = p1Chehck
        modelInspection.p2Chehck = p2Chehck
        modelInspection.p3Chehck = p3Chehck
        modelInspection.p4Chehck = p4Chehck
        modelInspection.p5Chehck = p5Chehck
        modelInspection.p6Chehck = p6Chehck
        modelInspection.p7Chehck = p7Chehck
        modelInspection.p8Chehck = p8Chehck
        modelInspection.p9Chehck = p9Chehck
        modelInspection.x1Chehck = x1Chehck
        modelInspection.y1Chehck = y1Chehck
        modelInspection.grade = grade
        
        let response = GradeCar.Something.Response(grade: grade)
        presenter?.presentGradeResult(response: response)
    }
    
    func prapareCheck(request: GradeCar.Something.Request) {
        e1Chehck =  request.e1Chehck ?? false
        e2Chehck =  request.e2Chehck ?? false
        e3Chehck =  request.e3Chehck ?? false
        e4Chehck =  request.e4Chehck ?? false
        e5Chehck =  request.e5Chehck ?? false
        g1Chehck =  request.g1Chehck ?? false
        g2Chehck =  request.g2Chehck ?? false
        g3Chehck =  request.g3Chehck ?? false
        g4Chehck =  request.g4Chehck ?? false
        a1Chehck =  request.a1Chehck ?? false
        a2Chehck =  request.a2Chehck ?? false
        a3Chehck =  request.a3Chehck ?? false
        a4Chehck =  request.a4Chehck ?? false
        f1Chehck =  request.f1Chehck ?? false
        f2Chehck =  request.f2Chehck ?? false
        f3Chehck =  request.f3Chehck ?? false
        f4Chehck =  request.f4Chehck ?? false
        f5Chehck =  request.f5Chehck ?? false
        f6Chehck =  request.f6Chehck ?? false
        f7Chehck =  request.f7Chehck ?? false
        f8Chehck =  request.f8Chehck ?? false
        f9Chehck =  request.f9Chehck ?? false
        f10Chehck = request.f10Chehck ?? false
        f11Chehck = request.f11Chehck ?? false
        p1Chehck =  request.p1Chehck ?? false
        p2Chehck =  request.p2Chehck ?? false
        p3Chehck =  request.p3Chehck ?? false
        p4Chehck =  request.p4Chehck ?? false
        p5Chehck =  request.p5Chehck ?? false
        p6Chehck =  request.p6Chehck ?? false
        p7Chehck =  request.p7Chehck ?? false
        p8Chehck =  request.p8Chehck ?? false
        p9Chehck =  request.p9Chehck ?? false
        x1Chehck =  request.x1Chehck ?? false
        y1Chehck =  request.y1Chehck ?? false
    }
    
    
    func e1Chehck(request: GradeCar.Something.Request) { e1Chehck = request.e1Chehck ?? false
        evaluateGrade()}
    func e2Chehck(request: GradeCar.Something.Request) { e2Chehck = request.e2Chehck ?? false
        evaluateGrade()}
    func e3Chehck(request: GradeCar.Something.Request) { e3Chehck = request.e3Chehck ?? false
        evaluateGrade()}
    func e4Chehck(request: GradeCar.Something.Request) { e4Chehck = request.e4Chehck ?? false
        evaluateGrade()}
    func e5Chehck(request: GradeCar.Something.Request) { e5Chehck = request.e5Chehck ?? false
        evaluateGrade()}
    // good
    func g1Chehck(request: GradeCar.Something.Request) { g1Chehck = request.g1Chehck ?? false
        evaluateGrade()}
    func g2Chehck(request: GradeCar.Something.Request) { g2Chehck = request.g2Chehck ?? false
        evaluateGrade()}
    func g3Chehck(request: GradeCar.Something.Request) { g3Chehck = request.g3Chehck ?? false
        evaluateGrade()}
    func g4Chehck(request: GradeCar.Something.Request) { g4Chehck = request.g4Chehck ?? false
        evaluateGrade()}
    
    //average
    func a1Chehck(request: GradeCar.Something.Request) { a1Chehck = request.a1Chehck ?? false
        evaluateGrade()}
    func a2Chehck(request: GradeCar.Something.Request) { a2Chehck = request.a2Chehck ?? false
        evaluateGrade()}
    func a3Chehck(request: GradeCar.Something.Request) { a3Chehck = request.a3Chehck ?? false
        evaluateGrade()}
    func a4Chehck(request: GradeCar.Something.Request) { a4Chehck = request.a4Chehck ?? false
        evaluateGrade()}
    
    //fair
    func f1Chehck(request: GradeCar.Something.Request) { f1Chehck = request.f1Chehck ?? false
        evaluateGrade()}
    func f2Chehck(request: GradeCar.Something.Request) { f2Chehck = request.f2Chehck ?? false
        evaluateGrade()}
    func f3Chehck(request: GradeCar.Something.Request) { f3Chehck = request.f3Chehck ?? false
        evaluateGrade()}
    func f4Chehck(request: GradeCar.Something.Request) { f4Chehck = request.f4Chehck ?? false
        evaluateGrade()}
    func f5Chehck(request: GradeCar.Something.Request) { f5Chehck = request.f5Chehck ?? false
        evaluateGrade()}
    func f6Chehck(request: GradeCar.Something.Request) { f6Chehck = request.f6Chehck ?? false
        evaluateGrade()}
    func f7Chehck(request: GradeCar.Something.Request) { f7Chehck = request.f7Chehck ?? false
        evaluateGrade()}
    func f8Chehck(request: GradeCar.Something.Request) { f8Chehck = request.f8Chehck ?? false
        evaluateGrade()}
    func f9Chehck(request: GradeCar.Something.Request) { f9Chehck = request.f9Chehck ?? false
        evaluateGrade()}
    func f10Chehck(request: GradeCar.Something.Request) { f10Chehck = request.f10Chehck ?? false
        evaluateGrade()
    }
    func f11Chehck(request: GradeCar.Something.Request) { f11Chehck = request.f11Chehck ?? false
        evaluateGrade()
    }
    
    //poor
    func p1Chehck(request: GradeCar.Something.Request) { p1Chehck = request.p1Chehck ?? false
        evaluateGrade()
    }
    func p2Chehck(request: GradeCar.Something.Request) { p2Chehck = request.p2Chehck ?? false
        evaluateGrade()
    }
    func p3Chehck(request: GradeCar.Something.Request) { p3Chehck = request.p3Chehck ?? false
        evaluateGrade()
    }
    func p4Chehck(request: GradeCar.Something.Request) { p4Chehck = request.p4Chehck ?? false
        evaluateGrade()
    }
    func p5Chehck(request: GradeCar.Something.Request) { p5Chehck = request.p5Chehck ?? false
        evaluateGrade()
    }
    func p6Chehck(request: GradeCar.Something.Request) { p6Chehck = request.p6Chehck ?? false
        evaluateGrade()
    }
    func p7Chehck(request: GradeCar.Something.Request) { p7Chehck = request.p7Chehck ?? false
        evaluateGrade()
    }
    func p8Chehck(request: GradeCar.Something.Request) { p8Chehck = request.p8Chehck ?? false
        evaluateGrade()
    }
    func p9Chehck(request: GradeCar.Something.Request) { p9Chehck = request.p9Chehck ?? false
        evaluateGrade()
    }
    
    //x
    func x1Chehck(request: GradeCar.Something.Request) { x1Chehck = request.x1Chehck ?? false
        evaluateGrade()
    }
    
    //cy
    func y1Chehck(request: GradeCar.Something.Request) { y1Chehck = request.y1Chehck ?? false
        evaluateGrade()
    }
}
