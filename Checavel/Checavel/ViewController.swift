//
//  ViewController.swift
//  Checavel
//
//  Created by Manuella Valença on 26/02/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import UIKit
import CoreML
import NaturalLanguage

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var sentenceTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checabilityLabel: UILabel!
    let model = Checavel()
    var sentenceInput : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sentenceTextField.delegate = self
        
//        if let typed = sentenceTextField.text{
//            sentenceInput = typed
//        }

    }

    @IBAction func checkButton(_ sender: Any) {
        predict(sentenceInput)
    }
    
    func predict(_ sentence: String){
        
        guard let ChecavelOutput = try? model.prediction(Frase: sentence) else {
            fatalError("Unexpected runtime error")
        }
        
        let checabilityPrediction = ChecavelOutput.Checavel_
        checabilityLabel.text = checabilityPrediction
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let typed = textField.text{
            self.sentenceInput = typed
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checabilityLabel.text = ""
    }
    
    
}

