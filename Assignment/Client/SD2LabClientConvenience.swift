//
//  SD2LabClientConvenience.swift
//  Assignment
//
//  Created by Sushobhit Jain on 24/09/17.
//  Copyright © 2017 Sushobhit Jain. All rights reserved.
//

import Foundation

extension SD2LabClient {
    
    func getUsers(_ parameters:[String:AnyObject], completionHandlerForUsers:@escaping (_ response:(Bool?,[User])?, _ error:Error?)->Void)
    {
        let mutableMethod:String = Methods.users
        getMethod(mutableMethod, parameters: parameters, headers: [:] as! [String : String]) { (responseData, error) in
            if error == nil {
                let response = responseData as? NSDictionary
                let data = response?.value(forKey: "data") as? NSDictionary
                let hasMore = data?.value(forKey: "has_more") as? Bool
                guard let jsonUserArray = data?.value(forKey: "users") as? NSArray else
                {
                    return
                }
                let users = User.getUserListFrom(dic: jsonUserArray)
                let responseTuple = (hasMore,users)
                completionHandlerForUsers(responseTuple,error)
            }
            else{
                completionHandlerForUsers(nil,error)
            }
        }
    }
}
