//
//  RegisterUserViewController.swift
//  guessWhat_T12
//
//  Created by Chloe Kim on 2019-03-21.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        
        let userName = userNameTextField.text;
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = repeatPasswordTextField.text;
        
        
        //checking if there are any empty fields
        if userNameTextField.text?.isEmpty ?? true {
            
            displayAlert(userMessage: "All fields are required");
            return;
        }
            
        else if userPasswordTextField.text?.isEmpty ?? true {
            displayAlert(userMessage: "Password is required");
            return;
            
        }
            //checking if passwords are matching
        else if (userPassword != userRepeatPassword){
            //passwords don't match
            displayAlert(userMessage: "Passwords do not match");
            return;
            
        }
        else {
            
            //When registration is success
            _ = UIAlertController(title: "Alert", message: "Registration is sucessful.", preferredStyle: UIAlertController.Style.alert);
            
            _ = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in self.dismiss(animated: true, completion: nil)
                
            }
        }
        
    
   
        
        // Storing User Data
        UserDefaults.standard.set(userName, forKey: "userName");
        UserDefaults.standard.set(userPassword, forKey: "userPassword");
        UserDefaults.standard.synchronize();
        
        //        self.presentedViewController()
        

        
    }
    
    
    func displayAlert(userMessage: String){
        //Display message to user
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in self.dismiss(animated: true, completion: nil)
            
            
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

