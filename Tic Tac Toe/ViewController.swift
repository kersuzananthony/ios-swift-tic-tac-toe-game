//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Kersuzan on 21/09/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // activePlayer, 1 = nought, 2 = cross
    var activePlayer: Int = 1;
    
    var scorePlayer1 = 0
    
    var scorePlayer2 = 0
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winningCombinations = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9],[3,5,7]]
    
    var gameOver = false
    
    var emptySquare = 9
    
    @IBOutlet var scorePlayer1Label: UILabel!
    
    @IBOutlet var scorePlayer2Label: UILabel!
    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var bordImage: UIImageView!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        // Check if the game status is over or not
        if !gameOver {
            // Check with button has been pressed and check if the game state equal to 0 or not
            let buttonPressedTag = sender.tag - 1
            
            if gameState[buttonPressedTag] == 0 {
                // Update the gameState variable
                gameState[buttonPressedTag] = activePlayer
                
                // Define an image
                var image = UIImage()
                
                // Set the image depending on the current active player
                if activePlayer == 1 {
                    image = UIImage(named: "nought.png")!
                    activePlayer = 2
                } else {
                    image = UIImage(named: "cross.png")!
                    activePlayer = 1
                }
                
                sender.setImage(image, forState: .Normal)
                
                // Decrement the number of empty squares
                emptySquare--
                
                // Check if we have a winner
                for combination in winningCombinations {
                    if gameState[combination[0] - 1] != 0 && gameState[combination[0] - 1] == gameState[combination[1] - 1] && gameState[combination[1] - 1] == gameState[combination[2] - 1] {
                        let winner = gameState[combination[0] - 1]
                        var messageToPopup: String
                        // Configure the message and increase the score of the winner
                        if(winner == 1) {
                            messageToPopup = "Noughts have won!"
                            scorePlayer1++
                            scorePlayer1Label.text = "Noughts: \(scorePlayer1)"
                        } else {
                            messageToPopup = "Crosses have won!"
                            scorePlayer2++
                            scorePlayer2Label.text = "Crosses: \(scorePlayer2)"
                        }
                        // Set the game status to over
                        gameOver = true
                        
                        popAlert(messageToPopup, message: "Congratulations!!!")
                        
                    } // End check
                } // End for loop check winner
                
                // Check if game over
                if emptySquare == 0 {
                    print("Sorry, game is over")
                    gameOver = true
                    
                    popAlert("Nobody win :(", message: "The game is over")
                }
                
            } else {
                print("No you cannot choose this place")
            }
        } else {
            print("Game is over")
        }
        
    }
    
    func popAlert(title: String, message: String) {
        // Pop the alert message
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Reset the game", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            
            self.resetGame()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Reset the game and the score", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            
            // resetGame
            self.resetGame()
            
            self.scorePlayer1 = 0
            self.scorePlayer2 = 0
            
            self.scorePlayer1Label.text = "Noughts: \(self.scorePlayer1)"
            self.scorePlayer2Label.text = "Crosses: \(self.scorePlayer2)"
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)

    }
    
    func resetGame() ->Void {
        self.gameOver = false
        
        self.activePlayer = 1
        
        self.gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        self.emptySquare = 9
        
        var button = UIButton()
        
        for var i = 1; i < 10; i++ {
            print("Loop i =\(i)")
            button = self.view.viewWithTag(i) as! UIButton
            
            button.setImage(nil, forState: UIControlState.Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

