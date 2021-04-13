//
//  ViewController.swift
//  CatchTheGargamel
//
//  Created by UMUT GUDUL on 11.04.2021.
//

import UIKit

class ViewController: UIViewController {
    // variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var gargamelArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
     // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var gargamel1: UIImageView!
    @IBOutlet weak var gargamel2: UIImageView!
    @IBOutlet weak var gargamel3: UIImageView!
    @IBOutlet weak var gargamel4: UIImageView!
    @IBOutlet weak var gargamel5: UIImageView!
    @IBOutlet weak var gargamel6: UIImageView!
    @IBOutlet weak var gargamel7: UIImageView!
    @IBOutlet weak var gargamel8: UIImageView!
    @IBOutlet weak var gargamel9: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        // highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)" 
        }
        
        
        
        // images
        gargamel1.isUserInteractionEnabled = true
        gargamel2.isUserInteractionEnabled = true
        gargamel3.isUserInteractionEnabled = true
        gargamel4.isUserInteractionEnabled = true
        gargamel5.isUserInteractionEnabled = true
        gargamel6.isUserInteractionEnabled = true
        gargamel7.isUserInteractionEnabled = true
        gargamel8.isUserInteractionEnabled = true
        gargamel9.isUserInteractionEnabled = true

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        gargamel1.addGestureRecognizer(recognizer1)
        gargamel2.addGestureRecognizer(recognizer2)
        gargamel3.addGestureRecognizer(recognizer3)
        gargamel4.addGestureRecognizer(recognizer4)
        gargamel5.addGestureRecognizer(recognizer5)
        gargamel6.addGestureRecognizer(recognizer6)
        gargamel7.addGestureRecognizer(recognizer7)
        gargamel8.addGestureRecognizer(recognizer8)
        gargamel9.addGestureRecognizer(recognizer9)
        gargamelArray = [gargamel1, gargamel2, gargamel3, gargamel4, gargamel5, gargamel6, gargamel7, gargamel8, gargamel9]
        
         // timer
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGargamel), userInfo: nil, repeats: true)
        hideGargamel()


    }
    @objc func hideGargamel() {
        
        for gargamel in gargamelArray {
            gargamel.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(gargamelArray.count-1)))
        gargamelArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score+=1
        scoreLabel.text = "Score: \(score)"
        
    }
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for gargamel in gargamelArray {
                gargamel.isHidden = true
            }
            // high score
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            // Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] (UIAlertAction) in
                // replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideGargamel), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
    }


}

