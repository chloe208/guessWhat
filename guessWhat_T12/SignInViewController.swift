//
//  SignInViewController.swift
//  guessWhat_T12
//
//  Created by Chloe Kim on 2019-03-21.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        let userName = userNameTextField.text;
        let userPassword = userPasswordTextField.text;
        
        
        let userNameStored = UserDefaults.standard.string(forKey: "userName");
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword");
        
        if (userNameStored == userName) {
            if(userPasswordStored == userPassword){
                
                //Login is successful
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn");
                UserDefaults.standard.synchronize();
                
                let alert = UIAlertController(title: "Welcome!", message: "Please go to Main to play the game", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
//                self.dismiss(animated: true, completion:nil);
            }
        
        }
        else {
            let alert = UIAlertController(title: "Error!", message: "User Name and Password do not match", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
            
        }
        
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
