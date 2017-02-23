//
//  TwitterClient.swift
//  Twitter-Swift-3
//
//  Created by Siraj Zaneer on 2/21/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    // Singleton for using TwitterClient
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "uHZzJImSpwlBRE9dSJcpKnkF6", consumerSecret: "o0ua4cJRduoo9p6RXF49u33Y0CQzJ3rM4A1xWONYKN4YzMecJJ")
    
    // Login and failure callbacks for login
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    // Login user using OAuth flow
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        // Get token and then ask user to authorize otherwise return error using completion handler
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "tweeter://oauth"), scope: nil, success: { (credential) in
            guard let credential = credential else {
                return
            }
            
            // Create and open URL for authentication
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(credential.token!)")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }) { (error) in
            guard let error = error else {
                return
            }
            
            // Return error
            failure(error)
        }
    }
    
    // Handle returning to app from authentication
    func handleOpenURL(url: URL) {
        // Save request token into variable
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        // Get access token using request token otherwise print error
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (credential) in
            guard let credential = credential else {
                return
            }
            
            // Get current user information and save it to persistant storage
            self.currentAccount(success: { (user) in
                User.currentUser = user
                self.loginSuccess!()
            }, failure: { (error) in
                // Print error
                print(error.localizedDescription)
            })
        }) { (error) in
            guard let error = error else {
                return
            }
            
            // Return error
            self.loginFailure!(error)
        }
    }
    
    // Get current user information
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        // Get request to endpoint for user information given that application is authorized
        self.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
            guard let response = response as? NSDictionary else {
                return
            }
            
            // Create user using information
            let user = User(info: response)
            success(user)
        }) { (task, error) in
            // Return error
            failure(error)
        }
    }
    
    // Logout user 
    func logout() {
        // Clear current user
        User.currentUser = nil
        deauthorize()
        
        // Post notification to logout
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
    }
    
    // Get user's timeline
    func getHomeTimeline(parameters: [String: Int]?, success: ([NSDictionary]) -> (), failure: @escaping (Error) -> ()) {
        // Get request using token
        self.get("1.1/statuses/home_timeline.json", parameters: parameters, progress: nil, success: { (task, response) in
            guard let response = response else {
                return
            }
            
            
            
        }) { (task, error) in
            
            //Return error
            failure(error)
        }
        
    }
}
