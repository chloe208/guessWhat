//
//  ViewController.swift
//  guessWhat_T12
//
//  Created by Chloe Kim on 2019-03-13.
//  Copyright © 2019 T12. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var idTxt: UILabel!
    
    @IBOutlet weak var usernameTxt: UILabel!
    
    @IBOutlet weak var scoreTxt: UILabel!
    
    var score: Score?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        if let c = score {
            idTxt.text = "\(c.id)"
            usernameTxt.text = c.username
            scoreTxt.text = "\(c.score)"
        }
    }
    
    
}
