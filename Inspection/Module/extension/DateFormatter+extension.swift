//
//  DateFormatter+extension.swift
//  Inspection
//
//  Created by Thanawat prathumset on 10/2/2564 BE.
//

import Foundation
extension DateFormatter {
    func years<R: RandomAccessCollection>(_ range: R) -> [String] where R.Iterator.Element == Int {
        self.dateFormat = "yyyy"
      //  setLocalizedDateFormatFromTemplate("yyyy")
        let res = range.compactMap { DateComponents(calendar: calendar, year: $0).date }
            .map { self.string(from: $0) }
        return res
    }
    
    func dateFormat(from date: Date ,dateFormat: String) -> String{
        self.calendar = Calendar(identifier:  .buddhist)
        self.dateFormat = dateFormat
        return self.string(from: date)
    }
    
    func toDate(from dateString: String) -> Date? {
        
        
        ///2021-11-17T14:48:48.86
        if let date = getDateByFormatDate(dateString, "yyyy-MM-dd'T'HH:mm:ss.SS") {
            return date
        }
        ///2021-11-17T16:40:50
        if let date = getDateByFormatDate(dateString, "yyyy-MM-dd'T'HH:mm:ss") {
            return date
        }
        ///"2021-11-17T14:40:17.8500000+07:00"
        if let date = getDateByFormatDate(dateString, "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ") {
            return date
        }
        
        return nil

    }
    
    fileprivate func getDateByFormatDate(_ dateString:String, _ dateFormatString:String) -> Date? {
        self.dateFormat = dateFormatString
        calendar = Calendar(identifier: .iso8601)
        return self.date(from: dateString)
    }
    
    
}

extension Date {
    var year: Int {
        let celendar = Calendar(identifier: .iso8601)
        let year = celendar.component(.year, from: self)
        return year
    }
    var month: Int {
        let month = Calendar.current.component(.month, from: self)
        return month
    }
    
    func DateToServerFormatString(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
