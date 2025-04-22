//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Amber Pan on 12/07/2019.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var trueButton: UIButton!
    @IBOutlet var falseButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        if quizBrain.checkAnswer(sender.currentTitle!){
            sender.backgroundColor = UIColor.green
        }
        else{
            sender.backgroundColor = UIColor.red
        }
    
        quizBrain.nextQuestion()


        // updateUI()
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc  func updateUI(){
    questionLabel.text = quizBrain.getQuestionText()
//        trueButton.setTitle(quizBrain.getChoices()[0], for: .normal)
//       
//        falseButton.setTitle(quizBrain.getChoices()[1], for: .normal)
//        button3.setTitle( quizBrain.getChoices()[2], for:.normal)
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        scoreLabel.text = "score: \(quizBrain.getScore())"
        progressBar.progress = quizBrain.getProgress()
    
   
    }
}

