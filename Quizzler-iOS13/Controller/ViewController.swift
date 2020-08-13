//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLebel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButtom: UIButton!
    @IBOutlet weak var points: UILabel!
    
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let answerIsCorrect: Bool = quizBrain.checkAnswer(userAnswer)
        let lastQuestion = quizBrain.isLastQuestion()
        print(lastQuestion)
        if answerIsCorrect{
            sender.backgroundColor = UIColor.green
            quizBrain.increasePoints()
            if lastQuestion{
                createTimeDelayAndUpdateUI(ti:5.0)
            }else{
                createTimeDelayAndUpdateUI(ti:0.2)
            }
            
        }else{
            sender.backgroundColor = UIColor.red
            if lastQuestion{
                createTimeDelayAndUpdateUI(ti:5.0)
            }else{
                createTimeDelayAndUpdateUI(ti:0.2)
            }
        }
        
        if lastQuestion{
            quizBrain.reset()
        }else {
            quizBrain.increaseIndex()
        }
        
    }
    
    func createTimeDelayAndUpdateUI(ti:Double) {
         Timer.scheduledTimer(timeInterval: ti, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
         points.text = "Points: \(quizBrain.getPoints())"
         questionLebel.text = quizBrain.getQuestionText()
         progressBar.progress = quizBrain.getProgressFraction()
    }
    
    @objc func updateUI (){
        trueButton.backgroundColor = UIColor.clear
        falseButtom.backgroundColor = UIColor.clear
        points.text = "Points: \(quizBrain.getPoints())"
        questionLebel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgressFraction()
    }
    
}

