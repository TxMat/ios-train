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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        secretNumber = Int.random(in: 1...100)
    }
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var LastGuess: UILabel!
    
    @IBOutlet weak var Stepper: UIStepper!
    
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var GuessLabel: UILabel!
    
    @IBAction func OnPreciseControl(_ sender: UIStepper, forEvent event: UIEvent) {
        print("Slider changed")
        numberLabel.text = String(Int(sender.value))
        sliderValue = Int(sender.value)
        Slider.value = Float(sliderValue)
        
    }
    
    @IBAction func OnValueChanged(_ sender: UISlider, forEvent event: UIEvent) {
        print("Slider changed")
        numberLabel.text = String(Int(sender.value))
        sliderValue = Int(sender.value)
        Stepper.value = Double(sliderValue)
    }
    
    @IBAction func OnGuess(_ sender: UIButton) {
        print("Pressed")
        numberOfGuesses += 1
        if sliderValue > secretNumber {
            GuessLabel.text = "Too high"
        } else if sliderValue < secretNumber {
            GuessLabel.text = "Too low"
        } else {
            GuessLabel.text = "You win in \(numberOfGuesses) guesses"
        }
        LastGuess.text = String(sliderValue)
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
