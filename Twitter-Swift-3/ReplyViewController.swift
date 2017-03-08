//
//  ReplyViewController.swift
//  Twitter-Swift-3
//
//  Created by Jungyoon Yu on 3/6/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    
    @IBOutlet weak var replyText: UITextView!

    var tweet : Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        replyText.text = ""
        replyText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(_ sender: Any) {
        
        if (!((replyText.text?.isEmpty)!)){
            TwitterClient.sharedInstance?.reply(id: "", text: replyText.text!, success: { (response: Tweet) in self.dismiss(animated: true, completion: nil) }, failure: { (error: Error) in let errorAlertController = UIAlertController(title: "Error!", message: "Already replied!", preferredStyle: .alert)
                let errorAction = UIAlertAction (title: "K", style: .default) { (action)
                    in}
                errorAlertController.addAction(errorAction)
                self.present(errorAlertController, animated: true) })

        }
        
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
