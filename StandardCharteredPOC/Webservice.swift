//
//  Webservice.swift
//  StandardCharteredPOC
//
//  Created by Chordia, Amisha (US - Mumbai) on 10/20/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import Foundation

let fxURL = "http://USBLRLOANER6.us.deloitte.com:9992/services/getforex"
private let sharedVariable = Webservice()

class Webservice {
    
    class var sharedInstance : Webservice {
        return sharedVariable
    }
    
    
    func getFXRates(currency : String ,completionHandler:(( fxValue : String ) -> Void))  {
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
        
        
        let requestURL = NSURL(string: fxURL)
        
        let request = NSMutableURLRequest(URL: requestURL!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTaskWithRequest(request) { (data, response, error) -> Void in

            if data != nil && error == nil {
                do {
                    let jsonObj = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    if let jsonDict = jsonObj as? NSDictionary {
                        if let fxData = jsonDict.valueForKey("data") as? NSDictionary {
                            
                            var fxString : String = "1398000"
                            
                            if currency.containsString("Yen") {
                               fxString = fxData.valueForKey("yen") as! String
                            }
                            else if currency.containsString("inr") {
                                fxString = fxData.valueForKey("inr") as! String
                            }
                            else if currency.containsString("us") {
                               fxString = fxData.valueForKey("usd") as! String
                            }
                            completionHandler(fxValue: fxString)

                        }
                    }
                    

                }
                catch {
                    
                }
                
            }
        }.resume()
        
    }
    
}