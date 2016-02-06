//
//  TwitterClient.swift
//  Twitter
//
//  Created by Nicholas Miller.
//  Copyright © 2016 Nicholas Miller. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterbaseURL = NSURL(string: "https://api.twitter.com/")
let twitterConsumerKey: String = "VsSAwljv8SsELIsA3w6O8qrjk"
let twitterConsumerSecret: String = "s0voKIp4Iqe36RpW7ZjnFWBYFPAHa0U79PoUSXXCSXPXxEEOZm"

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterbaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
