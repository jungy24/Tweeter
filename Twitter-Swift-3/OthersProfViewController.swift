//
//  OthersProfViewController.swift
//  Twitter-Swift-3
//
//  Created by Jungyoon Yu on 3/6/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class OthersProfViewController: UIViewController {
    
    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var username: UILabel!

    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var follingCount: UILabel!
    @IBOutlet weak var follerCount: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if user == nil {
            user = User.currentUser
        }
        
        profImage.sd_setImage(with: user?.profileURL)
        username.text = user?.name
        tweetCount.text = "\(user?.twitCount)"
        
        follerCount.text = "\(user?.followerCount)"
        follingCount.text = "\(user?.followingCount)"
        
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
