//
//  RegisterViewController.swift
//  guessWhat_T12
//
//  Created by Chloe Kim on 2019-03-21.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let userName = userNameTextField.text;
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = repeatPasswordTextField.text;
        
    
    
    
    //checking if there are any empty fields
        
    if (userNameTextField.text?.isEmpty ?? true) {
    
        let alert = UIAlertController(title: "Error!", message: "Username, cannot be empty", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    else if (userPasswordTextField.text?.isEmpty ?? true) {
   
        let alert = UIAlertController(title: "Error!", message: "Password cannot be empty", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    
    }
        
    //checking if passwords are matching
        
    else if (userPassword != userRepeatPassword){
        let alert = UIAlertController(title: "Error!", message: "Paaswords do not match", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
        
    }
        
    else {
        
        //When The User restration is successful, it redirects to sign in page
        let alert = UIAlertController(title: "Congraturation!", message: "Registration is sucessful.", preferredStyle: UIAlertController.Style.alert);
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let signInViewController = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController;
            self.present(signInViewController, animated: true, completion: nil);
        }
        
        alert.addAction(action);
        self.present(alert, animated: true){};


        
        }
        
   
    // Storing User Data
    UserDefaults.standard.set(userName, forKey: "userName");
    UserDefaults.standard.set(userPassword, forKey: "userPassword");
    UserDefaults.standard.synchronize();
    
 
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
