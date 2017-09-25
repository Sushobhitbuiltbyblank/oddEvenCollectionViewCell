//
//  User.swift
//  Assignment
//
//  Created by Sushobhit Jain on 24/09/17.
//  Copyright © 2017 Sushobhit Jain. All rights reserved.
//

import Foundation
import  UIKit
class User: NSObject {
    
    let name:String?
    let image:String?
    let items:Array<String>?
    
    init(dic:NSDictionary) {
        self.name = dic["name"] as? String
        self.image = dic["image"] as? String
        self.items = dic["items"] as? Array<String>
    }
    
    class func getUserListFrom(dic:NSArray) -> [User]
    {
        var users = [User]()
        
        for result in dic {
            let user = User(dic: result as! NSDictionary)
            users.append(user)
        }
        return users
    }
}
