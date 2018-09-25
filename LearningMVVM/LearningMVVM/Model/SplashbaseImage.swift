//
//  SplashbaseImage.swift
//  LearningMVVM
//
//  Created by Thi Vo on 2018/9/25.
//  Copyright © 2018 UIT. All rights reserved.
//
import UIKit
import ObjectMapper

class SplashbaseImage : NSObject,Mappable{
    var large_url : String? = ""
    var url : String? = ""
    
    override init() {
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        large_url <- map["large_url"]
        url <- map["url"]
    }
}
