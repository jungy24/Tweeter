//
//  RetweetCell.swift
//  Twitter-Swift-3
//
//  Created by Siraj Zaneer on 2/25/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class RetweetCell: UITableViewCell {
    
    var delegate: FeedViewControllerDelegate?
    var tweet: Tweet?
    @IBOutlet weak var nameLeft: NSLayoutConstraint!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetCLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var verifiedView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func onReply(_ sender: Any) {
        
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if (!(tweet?.retweeted)!) {
            TwitterClient.sharedInstance?.retweet(id: self.tweet!.id!, success: {
                print("retweeted \(self.tweet!.id!)")
                DispatchQueue.main.async {
                    self.retweetButton.imageView?.image = UIImage(named: "retweet-icon-green.png")
                    self.tweet?.retweeted = true
                    self.tweet?.retweetCount = (self.tweet?.retweetCount)! + 1
                    self.retweetLabel.text = "\((self.tweet?.retweetCount)!)"
                }
            }, failure: { (error) in
                print("error")
            })
        } else {
            TwitterClient.sharedInstance?.unRetweet(id: self.tweet!.id!, success: {
                print("unretweeted \(self.tweet!.id!)")
                DispatchQueue.main.async {
                    self.retweetButton.imageView?.image = UIImage(named: "retweet-icon.png")
                    self.tweet?.retweeted = true
                    self.tweet?.retweetCount = (self.tweet?.retweetCount)! + 1
                    self.retweetLabel.text = "\((self.tweet?.retweetCount)!)"
                }
            }, failure: { (error) in
                print("error")
            })
        }
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        if (!(tweet?.favorited)!) {
            TwitterClient.sharedInstance?.favorite(id: self.tweet!.id!, success: {
                print("favorited \(self.tweet!.id!)")
                DispatchQueue.main.async {
                    self.favoriteButton.imageView?.image = UIImage(named: "favor-icon-red.png")
                    self.tweet?.favorited = true
                    self.tweet?.favoriteCount = (self.tweet?.favoriteCount)! + 1
                    self.retweetLabel.text = "\((self.tweet?.favoriteCount)!)"
                }
            }, failure: { (error) in
                print("error")
            })
        } else {
            TwitterClient.sharedInstance?.unFavorite(id: self.tweet!.id!, success: {
                print("unfavorited \(self.tweet!.id!)")
                DispatchQueue.main.async {
                    self.favoriteButton.imageView?.image = UIImage(named: "favor-icon.png")
                    self.tweet?.favorited = false
                    self.tweet?.favoriteCount = (self.tweet?.favoriteCount)! - 1
                    self.favoriteLabel.text = "\((self.tweet?.favoriteCount)!)"
                }
            }, failure: { (error) in
                print("error")
            })
        }
    }
    
    @IBAction func onMessage(_ sender: Any) {
        
    }
}

