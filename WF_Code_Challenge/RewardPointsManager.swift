//
//  RewardPointsManager.swift
//  WF_Code_Challenge
//
//  Created by Jamal Jones on 9/22/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import Foundation
import UIKit

class RewardPointsManager {

    let baseURL = "http://54.191.35.66:8181/pfchang/api/buy"
    
    var points = 0
    
    func loadPoints(completion: @escaping () -> ()) {
    
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        let postString = "username=Michael&grandTotal=0"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //after request
            if let urlContent = data {
                do {
                    //convert to JSON
                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                    //attemp to cast to dictionary
                    guard let
                        jsonDict = jsonResult as? [String:AnyObject]
                        else{
                            //unable to cast dictionary
                            completion()
                            return
                    }
                    
                    print("JSON: \(jsonDict)")
                    
                    if let points = jsonDict["rewardPoints"] as! Int? {
                        self.points = points
                    }
                    completion()
                } catch {
                    
                    //unable to get json data
                    completion()
                    
                }
                
            } else {
                //no data returned
                completion()
            }
            
        }
        
        task.resume()
        
    }


}
