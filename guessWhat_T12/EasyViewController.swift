//
//  EasyViewController.swift
//  guessWhat_T12
//
//  Created by Chloe Kim on 2019-04-09.
//  Copyright © 2019 T12. All rights reserved.
//

import UIKit

class EasyViewController: UIViewController {

    
    @IBOutlet weak var guessField: UITextField!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    

    var numberOfGuess = 0
    var score = 0
    var correctAnswer = "Sweet"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func checkButton(_ sender: Any) {
        
        //checking user answer in consol (debuggin purpose)
        print("Player guessed: \(guessField.text as Optional)")

        
        numberOfGuess = numberOfGuess + 1
        guessLabel.text = "Number of Guesses: \(numberOfGuess)"
        
        let guessAnswer = guessField.text;
        
        
        //when the answer is correct
        if (guessAnswer == correctAnswer) {
            let alert = UIAlertController(title: "You guessed right!", message: "Would like to go to the next level?", preferredStyle: UIAlertController.Style.alert)
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
        
    }//end of checkAnswer func
    
    
}//very last
