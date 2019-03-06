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
    let model = ChecavelModel()
//    var nlmodel = NLModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sentenceTextField.delegate = self
        print("Entrou no viewDidLoad")
        
        
     
        
//        if let url = Bundle.main.url(forResource: "Checavel", withExtension:"mlmodel"){
//            print("Entrou no if")
//            do {
//                nlmodel = try NLModel(contentsOf: url)
//                print("Criou o NLModel")
//            } catch{
//                print("deu merda")
//            }
//        }
        
        
//        if let typed = sentenceTextField.text{
//            sentenceInput = typed
//        }

    }

    @IBAction func checkButton(_ sender: Any) {
        //VER AQUI DPS
        self.predict(sentenceTextField.text!)
    }
    
    func predict(_ sentence: String){
        
//        guard let ChecavelOutput = try? model.prediction(Frase: sentence) else {
//            fatalError("Unexpected runtime error")
//        }
//
//        let checabilityPrediction = ChecavelOutput.Checavel_
//        checabilityLabel.text = checabilityPrediction
        
        
        
//
//        if let assetPath = Bundle.url(forResource: "ChecavelModel", withExtension:"mlmodel", subdirectory: <#String?#>, in: <#URL#>) {
//            do{
//                let compiledUrl = try MLModel.compileModel(at: assetPath)
//                let model = try MLModel(contentsOf: compiledUrl)
//                let nlmodel = try NLModel(mlModel: model)
//                print("Criou o NLModel")
//
//                let prediction = nlmodel.predictedLabel(for: sentence)
//
//                checabilityLabel.text = prediction
//                print("\(sentence)  -- > \(prediction)")
//
//            }
//            catch{
//                print("deu merda aqui no compilado")
//            }
//        }
        
        var prediction = ""
        do {
            prediction = try model.prediction(text: sentence).label
            checabilityLabel.text = prediction
        }catch{
            print("nao rolou a prediction")
            checabilityLabel.text = "Não rolou a prediction"
        }
        print("\(sentence)  -- > \(prediction)")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checabilityLabel.text = ""
    }
    
    
}

