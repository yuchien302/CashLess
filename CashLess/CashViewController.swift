//
//  CashViewController.swift
//  CashLess
//
//  Created by chan yu chien on 2015/10/10.
//  Copyright © 2015年 Yu-Chien Chan. All rights reserved.
//

import UIKit
import Parse
import Bolts


class CashViewController: UIViewController {

    @IBOutlet weak var cash: UIImageView!
    var price = 0.0
    var orderNumber = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "confirmTrans")
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeGestureRecognizer)
        
        Parse.setApplicationId("ut0dxMA7cr4xPgQhtyYwAQRuycHXcpV38sBisPkA",
            clientKey: "v8Ho5Fgy2CeJho5LE3HBPbUSKubZsucLSjkxiW8A")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    - (void)animateIncomingBill {
//    
//    CGRect basketBottomFrame = self.billImg.frame;
//    basketBottomFrame.origin.y = self.view.bounds.size.height/16.0;
//    
//    [UIView animateWithDuration:2.0
//    delay:0.5
//    options: UIViewAnimationCurveEaseIn
//    animations:^{
//    self.billImg.frame = basketBottomFrame;
//    }
//    completion:^(BOOL finished){
//    NSLog(@"Done!");
//    }];
//    }
    
    func confirmTrans(){
        
        var basketBottomFrame = self.cash.frame
        basketBottomFrame.origin.y = -1000;


        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
            self.cash.frame = basketBottomFrame
            },
            completion:  { (finished: Bool) in
            }
        )

        
        dispatch_after(1, dispatch_get_main_queue(), {
            let query = PFQuery(className:"Orders")
            
            query.countObjectsInBackgroundWithBlock {
                (count: Int32, error: NSError?) -> Void in
                if error == nil {
                    
                    let testObject = PFObject(className: "Orders")
                    self.orderNumber = Int(count+1)
                    testObject["OrderNumber"] = self.orderNumber
                    testObject["Price"] = self.price
                    testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                        print("Object has been saved.")
                        if success {
                            let ojId = testObject.objectId
                            print(ojId)
                            self.performSegueWithIdentifier("confirmTransaction", sender: self)
                        }
                    }
                    
                    
                }
            }


        });

        
        

        
        

        

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "confirmTransaction") {
            // pass data to next view
            let cvc = segue.destinationViewController as! ConfirmViewController
            cvc.price = self.price
            cvc.orderNumber = self.orderNumber
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
