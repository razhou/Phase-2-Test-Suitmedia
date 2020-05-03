//
//  ModelScreenFour.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation

class ModelScreenFour: NSObject {
    
    var ad : Ad!
    var data : [DataUser]!
    var page : Int!
    var perPage : Int!
    var total : Int!
    var totalPages : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let adData = dictionary["ad"] as? [String:Any]{
            ad = Ad(fromDictionary: adData)
        }
        data = [DataUser]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = DataUser(fromDictionary: dic)
                data.append(value)
            }
        }
        page = dictionary["page"] as? Int
        perPage = dictionary["per_page"] as? Int
        total = dictionary["total"] as? Int
        totalPages = dictionary["total_pages"] as? Int
    }

}

class DataUser: NSObject {
    
    var avatar : String!
    var email : String!
    var firstName : String!
    var id : Int!
    var lastName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        avatar = dictionary["avatar"] as? String
        email = dictionary["email"] as? String
        firstName = dictionary["first_name"] as? String
        id = dictionary["id"] as? Int
        lastName = dictionary["last_name"] as? String
    }

}

class Ad: NSObject {
    var company : String!
    var text : String!
    var url : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        company = dictionary["company"] as? String
        text = dictionary["text"] as? String
        url = dictionary["url"] as? String
    }

}
