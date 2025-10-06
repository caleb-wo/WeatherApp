//
//  UserRecord.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 10/5/25.
//

import Foundation
import SwiftData

@Model
class UserRecord {
    var isFarenhiet: Bool = true
    var zipCodes: [ZipCode] = [ZipCode(name: "Rexburg, ID", code: "83440")]
    var selectedZipCodeIdx = 0
    
    init(){}
    
    func addZipCode(_ zipcode: String, name: String){
        zipCodes.append(ZipCode(name: zipcode, code: name))
    }
    
    func deleteZipCode(_ index: Int){
        zipCodes.remove(at: index)
    }
}

@Model
class ZipCode: Identifiable {
    var id = UUID()
    var code: String
    var name: String
    
    init(name: String, code: String){
        self.name = name
        self.code = code
    }
}
