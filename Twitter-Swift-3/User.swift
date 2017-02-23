//
//  User.swift
//  Twitter-Swift-3
//
//  Created by Siraj Zaneer on 2/21/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    
    static var _currentUser: User? // Current user
    static let userDidLogoutNotification = NSNotification.Name(rawValue: "UserDidLogout") // Notifcation name for logging out
    var info: NSDictionary? // JSON of user information
    var name: String? // Name of user
    var screenName: String? // Username
    var bio: String? // User biography
    var friendCount: Int? // Number of friends
    var followerCount: Int? // Number of followers
    var location: String? // User location
    var profileURL: URL? // Profile image URL
    
    init(info: NSDictionary) {
        // Initialize user information
        self.info = info
        name = info["name"] as? String
        screenName = info["screen_name"] as? String
        bio = info["description"] as? String
        friendCount = info["friends_count"] as? Int
        
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let data = defaults.object(forKey: "currentUser") as? Data
                
                if let info = data {
                    let json = try! JSONSerialization.jsonObject(with: info, options: []) as! NSDictionary
                    _currentUser = User(info: json)
                }
            }
            
            return _currentUser
        }
        
        set(user) {
            let defaults = UserDefaults.standard
            
            guard let user = user else {
                defaults.set(nil, forKey: "currentUser")
                defaults.synchronize()
                return
            }
            
            let info = try! JSONSerialization.data(withJSONObject: user.info!, options: [])
            defaults.set(info, forKey: "currentUser")
            defaults.synchronize()
        }
    }
}
