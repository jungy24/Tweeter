//
//  ProfileViewController.swift
//  Twitter-Swift-3
//
//  Created by Jungyoon Yu on 3/6/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetCounter: UILabel!
    @IBOutlet weak var follerCounter: UILabel!
    @IBOutlet weak var follingCounter: UILabel!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(user)
        if user == nil {
            user = User.currentUser
        }
        profPic.sd_setImage(with: user?.profileURL)
        username.text = user?.name
        tweetCounter.text = "\(user?.twitCount)"
        
        follerCounter.text = "\(user?.followerCount)"
        follingCounter.text = "\(user?.followingCount)"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
