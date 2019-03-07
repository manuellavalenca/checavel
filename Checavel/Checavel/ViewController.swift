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
    
    @IBOutlet weak var probabilityLabel: UILabel!
    @IBOutlet weak var sentenceTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checabilityLabel: UILabel!
    let model = ChecavelModel()
//    var nlmodel = NLModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 191/255, green: 237/255, blue: 242/255, alpha: 1.0)
        
        
        self.checabilityLabel.text = ""
        
        self.sentenceTextField.delegate = self
        self.checabilityLabel.isHidden = true
        
        print("Entrou no viewDidLoad")

    }

    @IBAction func checkButton(_ sender: Any) {
        //VER AQUI DPS
        self.predict(sentenceTextField.text!)
        self.checabilityLabel.isHidden = false
        self.view.endEditing(true)
    }
    
    func predict(_ sentence: String){
        
        do {
            let input = ChecavelModelInput(text: sentence)
            let options = MLPredictionOptions()
            let prediction = try model.prediction(input: input, options: options)
            //let probability = prediction?.classLabel
            
            //probabilityLabel.text = "\(probability.)"
            
            checabilityLabel.text = prediction.label
            
            if prediction.label == "SIM"{
                self.checabilityLabel.backgroundColor = UIColor(red: 45/255, green: 113/255, blue: 127/255, alpha: 1.0)
            } else{
                self.checabilityLabel.backgroundColor = UIColor(red: 225/255, green: 181/255, blue: 211/255, alpha: 1.0)
            }
            
            print("\(sentence)  -- > \(prediction.label)")
            
        } catch{
            checabilityLabel.text = "Não rolou a prediction"
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checabilityLabel.text = ""
        self.checabilityLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    func hideKeyboardWithTap() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//    }
//
//    @objc func dismissKeyboard(){
//        self.view.endEditing(true)
//    }
}

