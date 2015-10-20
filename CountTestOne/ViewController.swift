//
//  ViewController.swift
//  CountTestOne
//
//  Created by Karissa Sjostrom on 10/14/15.
//  Copyright © 2015 Rock Valley College. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    var ledgerdb:NSManagedObject!

    @IBOutlet weak var balance: UITextField!
    
    @IBOutlet weak var identification: UITextField!
    
    @IBOutlet weak var saving: UITextField!
    
    @IBOutlet weak var spending: UITextField!
    
    @IBOutlet weak var total: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var btnBack: UINavigationBar!
    
    @IBAction func btnBack(sender: AnyObject) {
         self.dismissViewControllerAnimated(false, completion: nil)
    }
    @IBAction func btnSave(sender: AnyObject) {
        
    if (ledgerdb != nil)
    {
    
    ledgerdb.setValue(balance.text, forKey: "balance")
    ledgerdb.setValue(identification.text, forKey: "description")
    ledgerdb.setValue(saving.text, forKey: "saving")
    ledgerdb.setValue(spending.text, forKey: "spending")
    ledgerdb.setValue(total.text, forKey: "total")

    }
    else
    {
    let entityDescription =
    NSEntityDescription.entityForName("ledger",inManagedObjectContext: managedObjectContext)
    
    let ledger = Ledger(entity: entityDescription!,
    insertIntoManagedObjectContext: managedObjectContext)
    
    ledger.balance = balance.text!
    ledger.identification = identification.text!
    ledger.saving = saving.text!
    ledger.spending = spending.text!
    ledger.total = total.text!
    }
    var error: NSError?
    do {
    try managedObjectContext.save()
    } catch let error1 as NSError {
    error = error1
    }
    
    if let err = error {
        status.text = err.localizedFailureReason
    } else {
    self.dismissViewControllerAnimated(false, completion: nil)
    
    }
}
override func viewDidLoad() {
    super.viewDidLoad()
    
    if (ledgerdb != nil)
    {
        balance.text = ledgerdb.valueForKey("balance") as? String
        identification.text = ledgerdb.valueForKey("description") as? String
        saving.text = ledgerdb.valueForKey("saving") as? String
        spending.text = ledgerdb.valueForKey("spending") as? String
        total.text = ledgerdb.valueForKey("total") as? String
        btnSave.setTitle("Update", forState: UIControlState.Normal)
    }
    balance.becomeFirstResponder()
    // Do any additional setup after loading the view.
    //Looks for single or multiple taps
    let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
    //Adds tap gesture to view
    view.addGestureRecognizer(tap)
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch = touches.first as UITouch! {
        DismissKeyboard()
    }
    super.touchesBegan(touches , withEvent:event)
}

func DismissKeyboard(){
    //forces resign first responder and hides keyboard
    balance.endEditing(true)
    identification.endEditing(true)
    saving.endEditing(true)
    spending.endEditing(true)
    total.endEditing(true)
    
}
//8 Add to hide keyboard
func textFieldShouldReturn(textField: UITextField!) -> Bool     {
    textField.resignFirstResponder()
    return true;
}



}


