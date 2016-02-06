////
////  YelpClient.swift
////  Yelp
////
////  Created by Nicholas Miller
////  Copyright (c) 2016 Nicholas Miller. All rights reserved.
////
//
//import UIKit
//
//import AFNetworking
//import BDBOAuth1Manager
//import CoreLocation
//
//// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
//let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
//let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
//let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
//let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
//
//enum YelpSortMode: Int {
//    case BestMatched = 0, Distance, HighestRated
//}
//
//class YelpClient: BDBOAuth1RequestOperationManager, CLLocationManagerDelegate {
//    var accessToken: String!
//    var accessSecret: String!
//    var locationManager : CLLocationManager!
//    var longitude: CLLocationDegrees = 0.0
//    var latitude: CLLocationDegrees = 0.0
//    
//    class var sharedInstance : YelpClient {
//        struct Static {
//            static var token : dispatch_once_t = 0
//            static var instance : YelpClient? = nil
//        }
//        
//        dispatch_once(&Static.token) {
//            Static.instance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
//        }
//        return Static.instance!
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
//        self.accessToken = accessToken
//        self.accessSecret = accessSecret
//        let baseUrl = NSURL(string: "https://api.yelp.com/v2/")
//        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
//        
//        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
//        self.requestSerializer.saveAccessToken(token)
//        
//        // Grab the location
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.distanceFilter = 200
//        locationManager.requestWhenInUseAuthorization()
//
//    }
//    
//    func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
//        // Grab location
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.distanceFilter = 200
//        locationManager.requestWhenInUseAuthorization()
//
//        return searchWithTerm(term, sort: nil, categories: nil, deals: nil, completion: completion)
//    }
//    
//    func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
//        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
//        
//        var parameters: [String : AnyObject] = ["term": term, "ll": "\(latitude),\(longitude)"]
//
//        if sort != nil {
//            parameters["sort"] = sort!.rawValue
//        }
//        
//        if categories != nil && categories!.count > 0 {
//            parameters["category_filter"] = (categories!).joinWithSeparator(",")
//        }
//        
//        if deals != nil {
//            parameters["deals_filter"] = deals!
//        }
//        
////        print(parameters)
//        
//        return self.GET("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
//            let dictionaries = response["businesses"] as? [NSDictionary]
//            if dictionaries != nil {
//                completion(Business.businesses(array: dictionaries!), nil)
//            }
//            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError!) -> Void in
//                completion(nil, error)
//        })!
//    }
//    
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//        }
//    }
//    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            
//            longitude = location.coordinate.longitude
//            latitude = location.coordinate.latitude
//        }
//        
//    }
//}
