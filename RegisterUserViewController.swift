//
//  RegisterUserViewController.swift
//  guessWhat_T12
//
//  Created by Minji Kim on 2019-03-21.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController {

    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func register(_ sender: UIButton) {
        let regusername = userName.text;
        let regpassword = password.text;
        let conPass = confirmPass.text;
        
        if userName.text?.isEmpty ?? true{
            //fields are empty
            displayAlert(userMessage: "All fields are required");
        }
            
        else if password.text?.isEmpty ?? true {
            displayAlert(userMessage: "Password is required");
        }
        else if(regpassword != conPass){
            //passwords don't match
            displayAlert(userMessage: "Passwords do not match");

        }
        else{
           //Attempt to register user
            displayAlert(userMessage: "Registration successful!");
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
            let signInViewController = storyBoard.instantiateViewController(withIdentifier: "signin") as! SignInViewController;
            self.present(signInViewController, animated: true, completion: nil);
            
        }
        
        // Storing User Data
        UserDefaults.standard.set(regusername, forKey: "username");
        UserDefaults.standard.set(regpassword, forKey: "password");
        UserDefaults.standard.synchronize();
        
//        self.presentedViewController()
        
        
        // Displaying alert message with Confirmation
//        var myAlert = UIAlertController(title: "Alert", message: "Registration is sucessful.", preferredStyle: UIAlertControllerStyle.alert);
//        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
//
        
        
    }

    
    func displayAlert(userMessage: String){
        //Display message to user
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action in self.dismiss(animated: true, completion: nil)
            
            
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

