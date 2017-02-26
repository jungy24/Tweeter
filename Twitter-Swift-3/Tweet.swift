//
//  Tweet.swift
//  Twitter-Swift-3
//
//  Created by Siraj Zaneer on 2/23/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import SwiftyJSON
class Tweet: NSObject {
    
    var info: NSDictionary?
    var user: User?
    var reUser: User?
    var isRetweet = false
    var text: String?
    var timestamp: Date?
    var retweetCount: Int?
    var favoriteCount: Int?
    var id: Int?
    var favorited: Bool? = false
    var retweeted: Bool? = false

    init(info: NSDictionary) {
        self.info = info
        if let reTweet = info["retweeted_status"] as? NSDictionary {
            isRetweet = true
            user = User(info: reTweet["user"] as! NSDictionary)
            reUser = User(info: info["user"] as! NSDictionary)
            text = reTweet["text"] as? String
            retweetCount = reTweet["retweet_count"] as? Int
            favoriteCount = reTweet["favorite_count"] as? Int
            id = reTweet["id"] as? Int
            if let favorited = reTweet["favorited"] as? Bool {
                self.favorited = favorited
            }
            if let retweeted = reTweet["retweeted"] as? Bool {
                self.retweeted = retweeted
            }
            let timestampString = reTweet["created_at"] as? String
            if let timestampString = timestampString {
                let formatter = DateFormatter()
                formatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
                timestamp = formatter.date(from: timestampString)
            }
        } else {
            user = User(info: info["user"] as! NSDictionary)
            text = info["text"] as? String
            retweetCount = info["retweet_count"] as? Int
            favoriteCount = info["favorite_count"] as? Int
            id = info["id"] as? Int
            if let favorited = info["favorited"] as? Bool {
                print(info)
                self.favorited = favorited
            }
            if let retweeted = info["retweeted"] as? Bool {
                self.retweeted = retweeted
            }
            let timestampString = info["created_at"] as? String
            if let timestampString = timestampString {
                let formatter = DateFormatter()
                formatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
                timestamp = formatter.date(from: timestampString)
            }
        }
        if user?.screenName == "sirajz007" {
            print(info)
        }
    }
    
    class func tweetsWithArray(infos: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for info in infos {
            let tweet = Tweet(info: info)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
