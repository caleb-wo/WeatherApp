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
    var zipCodes: [ZipCode] = [ZipCode(code: "83440", name: "Rexburg, ID")]
    
    init(){}
    
    func addZipCode(_ zipcode: String, name: String){
        zipCodes.append(ZipCode(code: zipcode, name: name))
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
    
    init(code: String, name: String){
        self.code = code
        self.name = name
    }
}
