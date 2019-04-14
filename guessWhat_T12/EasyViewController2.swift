//
//  EasyViewController2.swift
//  guessWhat_T12
//
//  Created by Chloe Kim on 2019-04-13.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit
import SQLite3

class EasyViewController2: UIViewController {

    @IBOutlet weak var guessField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    var userLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    var db: OpaquePointer?
    var numberOfGuess = 0
    var score = 0
    var correctAnswer = "trunk"
    var highscore = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // check value of for key
        if self.userLoggedIn {
            var user = UserDefaults.standard.string(forKey: "userName")!
            username.text = "Current player: \(user)"
        } else {
            username.text = "Current player: Guest"
        }
        score = 0
        numberOfGuess = 0
        
        let file = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("database.db")
        
        if sqlite3_open(file.path, &db) != SQLITE_OK {
            print("error opening database")
        } else {
            let create = "CREATE TABLE IF NOT EXISTS Scores (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, score INTEGER)"
            if sqlite3_exec(db, create, nil, nil, nil) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db))
                print("error creating db: \(err)")
            }
        }
    }//end of viewDidLoad()

    @IBAction func backBtn(_ sender: Any) {
        if userLoggedIn {
            print("userLoggedIn")
            // segue to
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "UserInViewController")
            self.present(newViewController, animated: true, completion: nil)
        } else {
            print("userNotLoggedIn")
            //segue to
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "GuestViewController")
            self.present(newViewController, animated: true, completion: nil)
        }
    }//end of backBtn
    
    @IBAction func checkBtn(_ sender: Any) {
        //checking user answer in consol (debuggin purpose)
        //print("Player guessed: \(guessField.text as Optional)")
        let userNameStored = UserDefaults.standard.string(forKey: "userName");
        let userLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        numberOfGuess = numberOfGuess + 1
        guessLabel.text = "Number of Guesses: \(numberOfGuess)"
        
        let guessAnswer = guessField.text?.lowercased();
        
        
        //when the answer is correct
        if (guessAnswer == correctAnswer) {
            let alert = UIAlertController(title: "You guessed right!", message: "Would like to go to the next level?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let IntermediateViewController = storyBoard.instantiateViewController(withIdentifier: "IntermediateViewController") as! IntermediateViewController;
                self.present(IntermediateViewController, animated: true, completion: nil);
            })
            
            let noAction = UIAlertAction(title: "NO", style: .default, handler: { (action) -> Void in
                if !userLoggedIn {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let guestViewController = storyBoard.instantiateViewController(withIdentifier: "GuestViewController") as! GuestViewController;
                    self.present(guestViewController, animated: true, completion: nil);
                } else {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let userLoggedInController = storyBoard.instantiateViewController(withIdentifier: "UserInViewController") as! UserInViewController;
                    self.present(userLoggedInController, animated: true, completion: nil);
                }
                
            })
            
            
            alert.addAction(okAction)
            alert.addAction(noAction)
            self.present(alert, animated: true, completion: nil)
            
            if numberOfGuess == 1 {
                score = score + 10
            }
            else if numberOfGuess == 2 {
                score = score + 5
            }
            else if numberOfGuess == 3 {
                score = score + 1
            }
            
            numberOfGuess = 0
            
            answerLabel.text = ""
            scoreLabel.text = "Score: \(score)"
            
            
            if (highscore < score ){
                highscore = score
                
            }
            
            if userLoggedIn{
                addScore(score: highscore, username: userNameStored!)
            }
            
            
        }
            //when textfield is empty
        else if (guessField.text?.isEmpty ?? true) {
            let alert = UIAlertController(title: "Error!", message: "The textfield cannot be empty, please guess your answer", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
        }
            //when the answer is incorrect
        else {
            //            let alert = UIAlertController(title: "Oh No!", message: "Please Guess Again", preferredStyle: UIAlertController.Style.alert)
            //            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
            //
            //            alert.addAction(okAction)
            //            self.present(alert, animated: true, completion: nil)
            
            answerLabel.text = "Wrong Answer! Please Guess Again"
            answerLabel.textColor = UIColor.red
            
        }
        guessField.resignFirstResponder()
        guessField.text=""
    }//end of checkBtn
    
    func addScore(score: Int, username: String) {
        
        let username = username
        let score = score
        
        let insert = "INSERT INTO Scores(username, score) VALUES (?,?)"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        if sqlite3_bind_text(stmt, 1, username, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error binding username: \(err)")
            return
        }
        if sqlite3_bind_int(stmt, 2, Int32(score)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error binding score: \(err)")
            return
        }
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }
    }
    
    
}//very last
