//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        //TODO: Set up a new user on our Firbase database
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!)
        {
            (authResult, error) in
            if error == nil {
                self.performSegue(withIdentifier: "goToChat", sender: self)
                SVProgressHUD.dismiss()
            } else {
                print("Error signing up user")
                SVProgressHUD.dismiss()
            }
        }
        // createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!,completion: onRegistration as? AuthDataResultCallback)
    }
    
    func onRegistration(authResult: AuthDataResult, error: Error) {
        if error == nil {
            self.performSegue(withIdentifier: "goToChat", sender: self)
        } else {
            print("Error signing up user")
        }
    }
    
    
}
