//
//  Utility.swift
//  WallMart_Test
//
//  Created on 19/06/21.
//

import Foundation
let AstronomyFile  =  "AstronomyDataFile.json"

extension Date {

 static func getCurrentDateAndTime() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-yyyy HH:mm:ss"

        return dateFormatter.string(from: Date())

    }
    static func getCurrentDate() -> String {

           let dateFormatter = DateFormatter()

           dateFormatter.dateFormat = "yyyy-MM-dd"

           return dateFormatter.string(from: Date())

       }
}
