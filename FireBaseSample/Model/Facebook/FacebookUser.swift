//
//  FacebookUser.swift
//  hero
//
//  Created by 西村 拓 on 2015/11/22.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import ObjectMapper

class FacebookUser: Mappable {
    
    private(set) var userID = ""
    private(set) var tokenString = ""
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        userID <- map["userID"]
        tokenString <- map["tokenString"]
    }
    
    final class func map(token token: FBSDKAccessToken) -> FacebookUser? {
        let parameters = [
            "userID": token.userID,
            "tokenString": token.tokenString
        ]
        
        if let mapper = Mapper<FacebookUser>().map(parameters) {
            return mapper
        } else {
            return nil
        }
    }
}