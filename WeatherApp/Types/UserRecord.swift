//
//  UserRecord.swift
//  WeatherApp
//
//  Created by Caleb Wolfe on 10/5/25.
//

import Foundation
import SwiftData

/// Struct to hold user's data. Tracks farenhiet vs celsius,
/// user's zipcodes, and the selected zipcode.
@Model
class UserRecord {
    var isFarenhiet: Bool = true
    var zipCodes: [ZipCode] = [ZipCode(name: "Rexburg, ID", code: "83440")]
    var selectedZipCode: ZipCode?
    
    init(){
        selectedZipCode = zipCodes.first
    }
    
    func addZipCode(_ zipcode: String, name: String){
        zipCodes.append(ZipCode(name: zipcode, code: name))
    }
    
    func deleteZipCode(_ index: Int){
        zipCodes.remove(at: index)
    }
}

/// Zipcode structs. Holds zipcode string, user's name,
/// id, and equivalence checking function.
@Model
class ZipCode: Identifiable, Equatable {
    var id = UUID()
    var code: String
    var name: String
    
    init(name: String, code: String){
        self.name = name
        self.code = code
    }
    
    static func == (lhs: ZipCode, rhs: ZipCode) -> Bool{
        lhs.code == rhs.code
    }
}
