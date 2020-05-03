//
//  Prefs.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation

class Prefs {

    
    private static func getUserDefaults() -> UserDefaults? {
        return UserDefaults.init(suiteName: "uMAl")
    }
    
    // MARK: DATA CLEARANCE
    static func clearAll(){
        if let bundleId = Bundle.main.bundleIdentifier {
            let ud = getUserDefaults()
            ud?.removePersistentDomain(forName: "uMAl")
        }
    }
    
    static func removeData(_ key: Keys){
        getUserDefaults()?.removeObject(forKey: key.rawValue)
    }
    
    
    // MARK: SETTER DATA
    static func setData(_ key: Keys, value: Any) {
        if let value = value as? String {
            getUserDefaults()?.setValue(value.toBase64().replacingOccurrences(of: "=", with: "&#").replacingOccurrences(of: "m", with: ">"),
                                        forKey: key.rawValue)
        } else {
            getUserDefaults()?.setValue(value, forKey: key.rawValue)
        }
    }
    
    
    // MARK: GETTER SECTION
    static func getString(_ key: Keys) -> String {
        let value = getUserDefaults()?.string(forKey: key.rawValue) ?? ""
        return value.replacingOccurrences(of: ">", with: "m").replacingOccurrences(of: "&#", with: "=").fromBase64() ?? ""
    }
    
    static func getBool(_ key: Keys) -> Bool {
        return getUserDefaults()?.bool(forKey: key.rawValue) ?? false
    }
    
    static func getFloat(_ key: Keys) -> Float {
        return getUserDefaults()?.float(forKey: key.rawValue) ?? -99
    }
    
    static func getDouble(_ key: Keys) -> Double {
        return getUserDefaults()?.double(forKey: key.rawValue) ?? -99
    }
    
    static func getInt(_ key: Keys) -> Int {
        return getUserDefaults()?.integer(forKey: key.rawValue) ?? -99
    }
    
    static func getURL(_ key: Keys) -> URL? {
        return getUserDefaults()?.url(forKey: key.rawValue)
    }
    
    static func getArray(_ key: Keys) -> Array<Any>? {
        return getUserDefaults()?.array(forKey: key.rawValue)
    }
    
    static func getObject(_ key: Keys) -> Any?{
        return getUserDefaults()?.object(forKey: key.rawValue)
    }
   

}

