//
//  FirebaseUserEntity.swift
//  FireBaseSample
//
//  Created by 西村 拓 on 2016/06/06.
//  Copyright © 2016年 TakuNishimura. All rights reserved.
//

import ObjectMapper

class FirebaseUserEntity: Mappable {

    private(set) var uid = ""
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        uid <- map["uid"]
    }
}
