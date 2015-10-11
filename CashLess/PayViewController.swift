//
//  PayViewController.swift
//  CashLess
//
//  Created by chan yu chien on 2015/10/10.
//  Copyright © 2015年 Yu-Chien Chan. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet weak var price: UITextField!
//    var vc:ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load PayViewController")
        self.price.becomeFirstResponder()
        // Do any additional setup after loading the view.
//        vc?.gotQRCode = false
    }
    @IBAction func onChange(sender: AnyObject) {
        if let str = price.text {
            
            if str.isEmpty{
                price.text = "$"
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "paySegue") {
            // pass data to next view
            let cvc = segue.destinationViewController as! CashViewController
            let str = (self.price.text! as NSString).substringFromIndex(1)
            cvc.price = (str as NSString).doubleValue
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
