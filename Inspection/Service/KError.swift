//
//  KError.swift
//  Test1
//
//  Created by thnawat on 18/9/2563 BE.
//  Copyright © 2563 thnawat. All rights reserved.
//

import Foundation
import Alamofire

enum KError:Error {
    case commonError(message:String )
    case internalError( _ code:Int )
    //case httpServiceError(_ baseResponse:BaseRespond)
    case httpRespondError(_ respond:HTTPURLResponse,_ errorMessage:String? = "")
    case httpAFError(_ afError:AFError)
    case undefind
    
    var getMessage:KErrorMessage{
        switch self {
        case .commonError(let message):
            return KErrorMessage(message: message, errorCode: 0, debugMessage: nil)
            
        case .internalError(let code):
            return KErrorMessage(internalErrorCode: code)
        
        //case .httpServiceError(let baseResponse):
        //    return KErrorMessage(baseResponse: baseResponse)
            
        case .httpRespondError(let respond, let errorMessage):
            return KErrorMessage( respondError: respond , errorMessage: errorMessage ?? "")
            
        
        case .httpAFError(let respond):
            return KErrorMessage(message: respond.localizedDescription, errorCode: respond.responseCode, debugMessage: "error_html")
            
        default:
            return KErrorMessage(message: "undefind", errorCode: 0, debugMessage: nil)
        }
    }
}

struct KErrorMessage {
    var message:String?
    var errorCode:Int?
    var debugMessage:String?
    
 
    init( message: String?, errorCode: Int?, debugMessage: String? ) {
        self.message = message
        self.errorCode = errorCode
        self.debugMessage = debugMessage
        
    }
     
}

extension KErrorMessage {
    init( respondError:HTTPURLResponse , errorMessage:String) {

        self.message = (errorMessage == "") ? respondError.debugDescription : errorMessage
        self.errorCode = respondError.statusCode
        self.debugMessage = respondError.debugDescription
    }
    
     
    init( internalErrorCode:Int ) {
        self.message = "internalError"
        self.errorCode = internalErrorCode
        switch internalErrorCode {
        case -2000:
            debugMessage = "Can't transform json to object mapper."
            message = debugMessage
        case -2001:
            debugMessage = "Respond object is not integrate protocol \"BaseRespond\". That need to check internal error."
            message = debugMessage
        case -2002:
            debugMessage = "Decrypt error for some reason."
            message = debugMessage
        default:
            debugMessage = "No debugMessage case error ?.This is bad isn't it ? "
            message = debugMessage
        }
    }
    
   
}
