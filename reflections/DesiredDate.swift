//
//  Date.swift
//  reflections
//
//  Created by Paul Sulikowski on 3/7/20.
//  Copyright © 2020 Paul Sulikowski. All rights reserved.
//

import Foundation
import UIKit
class DesiredDate: NSObject {
    static let shared: DesiredDate = DesiredDate()
    var globalDate = formatDate(date: Date())
}

func formatDate(date: Date) -> String {
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date / server String
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    
    let myString = formatter.string(from: date) // string purpose I add here
    // convert your string to date
    let yourDate = formatter.date(from: myString)
    //then again set the date format whhich type of output you need
    formatter.dateFormat = "dd-MM"
    // again convert your date to string
    return formatter.string(from: yourDate!)
    
    //test
//    return "25-11"
}
