//
//  GameViewController.swift
//  NumberGussr
//
//  Created by Mathieu Ponal on 05/02/2025.
//

import UIKit

class GameViewController: UIViewController {
    
    var numberOfGuesses = 0
    var secretNumber = 0
    var sliderValue: Int = 0

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var lastGuessLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var resetGameBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        secretNumber = Int.random(in: 1...100)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetGame()
    }
    
    private func updateSliderAndStepper(value: Int) {
        numberLabel.text = String(value)
        sliderValue = value
        slider.value = Float(value)
        stepper.value = Double(value)
    }
    
    private func resetGame() {
        secretNumber = Int.random(in: 1...100)
        numberOfGuesses = 0
        sliderValue = 50
        updateSliderAndStepper(value: sliderValue)
        guessLabel.text = "Make a guess!"
        lastGuessLabel.text = "-"
        resetGameBtn.isEnabled = false
    }
    
    @IBAction func onPreciseControl(_ sender: UIStepper, forEvent event: UIEvent) {
        updateSliderAndStepper(value: Int(sender.value))
    }
    
    @IBAction func onValueChanged(_ sender: UISlider, forEvent event: UIEvent) {
        updateSliderAndStepper(value: Int(sender.value))
    }
    
    @IBAction func onGuess(_ sender: UIButton) {
        numberOfGuesses += 1
        if sliderValue > secretNumber {
            guessLabel.text = "Too high"
        } else if sliderValue < secretNumber {
            guessLabel.text = "Too low"
        } else {
            guessLabel.text = "You win in \(numberOfGuesses) guesses!"
            resetGameBtn.isEnabled = true
        }
        lastGuessLabel.text = String(sliderValue)
    }
    
    @IBAction func onResetGame(_ sender: UIButton) {
        resetGame()
    }
}

