//
//  UserInViewController.swift
//  guessWhat_T12
//
//  Created by Chloe Kim on 2019-03-22.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit

class UserInViewController: UIViewController {

    @IBAction func signOut(_ sender: Any) {
        var Userlogged: Bool
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        Userlogged = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        print(Userlogged)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: <#T##Bundle?#>)
    }
    
    /*
    @IBAction func signOut(_ sender: Any) {
        var Userlogged: Bool
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        Userlogged = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        print(Userlogged)
    }
 
 */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
