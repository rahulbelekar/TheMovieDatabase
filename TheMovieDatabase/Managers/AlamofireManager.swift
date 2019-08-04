//
//  AlamofireManager.swift
//  TheMovieDatabase
//
//  Created by Rahul  Belekar on 03/08/19.
//  Copyright © 2019 Rahul  Belekar. All rights reserved.
//

import Alamofire

class AlamofireManager: NSObject {
    //Check connectivity
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    //API Get Method calls
    //@url: url to fetch data
    //@completion: Return Data received from API response and error message
    static func getRequest(url: URL, completion: ((Data?, String?) -> ())?) {
        if !isConnectedToInternet { completion?(nil, "You are not connected to the internet."); return }
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseData { (response) in
                if let error = response.error {
                    completion?(nil, error.localizedDescription)
                    return
                }
                if let data = response.result.value {
                    completion?(data, nil)
                }
        }
    }
    
    static let shared = AlamofireManager()
    //Reachability Manager
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    //Observing changes in reachability
    func startNetworkReachabilityObserver() {
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                break
            case .unknown, .reachable(.ethernetOrWiFi), .reachable(.wwan) :
                UIApplication.getTopViewController()?.refreshView()
                break
            }
        }
        reachabilityManager?.startListening()
    }
    
}
