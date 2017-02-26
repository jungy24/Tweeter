//
//  FeedViewController.swift
//  Twitter-Swift-3
//
//  Created by Siraj Zaneer on 2/20/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

protocol FeedViewControllerDelegate {
    func reload()
}
class FeedViewController: UITableViewController, FeedViewControllerDelegate {
    var tweets: [Tweet] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let image : UIImage = UIImage(named: "TwitterLogoBlue.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toTop)))
        self.navigationItem.titleView = imageView
        self.navigationItem.titleView?.isUserInteractionEnabled = true
        self.navigationItem.titleView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toTop)))
        
        refreshControl = UIRefreshControl()
        tableView.insertSubview(refreshControl!, at: 0)
        refreshControl?.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        MBProgressHUD.showAdded(to: self.view, animated: true)
        loadTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweet = tweets[indexPath.row]
        if tweet.isRetweet {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RetweetCell", for: indexPath) as! RetweetCell
            
            
            // Configure the cell...
            cell.nameLabel.text = tweet.user?.name
            cell.retweetLabel.text = (tweet.reUser?.name)! + " Retweeted"
            cell.handleLabel.text = "@" + (tweet.user?.screenName)!
            cell.postLabel.text = tweet.text
            cell.retweetCLabel.text = "\(tweet.retweetCount!)"
            cell.favoriteLabel.text = "\(tweet.favoriteCount!)"
            cell.retweetLabel.adjustsFontSizeToFitWidth = true
            cell.favoriteLabel.adjustsFontSizeToFitWidth = true
            cell.tweet = tweet
            cell.delegate = self
            print(tweet.timestamp?.timeIntervalSinceNow)
            var time = (tweet.timestamp?.timeIntervalSinceNow)! / -1
            var letter = "s"
            if time > 60 {
                time /= 60
                letter = "m"
                if time > 60 {
                    time /= 60
                    letter = "h"
                    if time > 24 {
                        time /= 24
                        letter = "d"
                        if time > 365 {
                            time /= 365
                            letter = "y"
                        }
                    }
                    
                }
            }
            cell.timeLabel.text = "\(Int(round(time)))\(letter)"
            if let rt = tweet.retweeted {
                print(rt)
                if (rt == true) {
                    cell.retweetButton.imageView?.image = UIImage(named: "retweet-icon-green.png")
                    
                }
            }
            if let avatarUrl = tweet.user?.profileURL {
                cell.avatarView.sd_setImage(with: avatarUrl, completed: { (image, error, cache, url) in
                    cell.avatarView.layer.cornerRadius = 5
                })
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
            
            
            // Configure the cell...
            cell.nameLabel.text = tweet.user?.name
            cell.handleLabel.text = "@" + (tweet.user?.screenName)!
            cell.postLabel.text = tweet.text
            cell.retweetLabel.text = "\(tweet.retweetCount!)"
            cell.favoriteLabel.text = "\(tweet.favoriteCount!)"
            cell.retweetLabel.adjustsFontSizeToFitWidth = true
            cell.favoriteLabel.adjustsFontSizeToFitWidth = true
            cell.tweet = tweet
            cell.delegate = self
            print(tweet.timestamp?.timeIntervalSinceNow)
            var time = (tweet.timestamp?.timeIntervalSinceNow)! / -1
            var letter = "s"
            if time > 60 {
                time /= 60
                letter = "m"
                if time > 60 {
                    time /= 60
                    letter = "h"
                    if time > 24 {
                        time /= 24
                        letter = "d"
                        if time > 365 {
                            time /= 365
                            letter = "y"
                        }
                    }
                    
                }
            }
            cell.timeLabel.text = "\(Int(round(time)))\(letter)"
            if let rt = tweet.retweeted {
                print(rt)
                if (rt == true) {
                    cell.retweetButton.imageView?.image = UIImage(named: "retweet-icon-green.png")
                    
                }
            }
            if let avatarUrl = tweet.user?.profileURL {
                cell.avatarView.sd_setImage(with: avatarUrl, completed: { (image, error, cache, url) in
                    cell.avatarView.layer.cornerRadius = 5
                })
            }

            return cell
        }
        
        return UITableViewCell()
        
    }
 
    func loadTweets() {
        self.view.isUserInteractionEnabled = false
        TwitterClient.sharedInstance?.getHomeTimeline(parameters: nil, success: { (tweets) in
            self.tweets = []
            self.tweets = tweets
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.isUserInteractionEnabled = true
            self.refreshControl?.endRefreshing()
        }, failure: { (error) in
            print(error.localizedDescription)
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.isUserInteractionEnabled = true
            self.refreshControl?.endRefreshing()
        })
    }
    
    func toTop() {
        print("hi")
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
    }
    
    internal func reload() {
        loadTweets()
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
