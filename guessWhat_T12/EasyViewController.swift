//
//  EasyViewController.swift
//  guessWhat_T12
//
//  Created by Chloe Kim on 2019-04-09.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit
import SQLite3

class EasyViewController: UIViewController {

    
    @IBOutlet weak var guessField: UITextField!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    var db: OpaquePointer?
    var numberOfGuess = 0
    var score = 0
    var correctAnswer = "Sweet"
    var highscore = 0
    
    @IBAction func Back(_ sender: UIButton) {
        let userLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "UserInviewController")
        
        if (userLoggedIn) == true{
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // check value of for key
        username.text = UserDefaults.standard.string(forKey: "isUserLoggedIn")
        
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
    }
    
    
    
    @IBAction func checkButton(_ sender: Any) {
        
        //checking user answer in consol (debuggin purpose)
        print("Player guessed: \(guessField.text as Optional)")

        let userNameStored = UserDefaults.standard.string(forKey: "userName");
        let userLoggedIn = UserDefaults.standard.value(forKey: "isUserLoggedIn")
        numberOfGuess = numberOfGuess + 1
        guessLabel.text = "Number of Guesses: \(numberOfGuess)"
        
        let guessAnswer = guessField.text;
        
        
        //when the answer is correct
        if (guessAnswer == correctAnswer) {
            let alert = UIAlertController(title: "You guessed right!", message: "Would like to go to the next level?", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
            let noAction = UIAlertAction(title: "NO", style: .default, handler: { (action) -> Void in })

            
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
            
            answerLabel.text = ""
            scoreLabel.text = "Score: \(score)"
            
            if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true{
                if (highscore < score ){
                    highscore = score

                }
            
            addScore(score: highscore, username: userNameStored!)
            }
        }
        //when textfield is empty
        else if (guessField.text?.isEmpty ?? true) {
            let alert = UIAlertController(title: "Error!", message: "The textfield cannot be empty, please guess your answer", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
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
        
    }//end of checkAnswer func
    
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
