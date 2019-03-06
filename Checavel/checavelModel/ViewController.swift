//
//  ViewController.swift
//  checavelModel
//
//  Created by Manuella Valença on 28/02/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import Cocoa
import CreateML
import NaturalLanguage

class ViewController: NSViewController {
    
    var dataTable = MLDataTable()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parse csvFile to MLDataTable
        let csvFile = Bundle.main.url(forResource:"DatasetChecavel", withExtension: "csv")!
        
        do {
            dataTable = try MLDataTable(contentsOf: csvFile, options: MLDataTable.ParsingOptions(delimiter: ";"))
            print(dataTable)
        } catch {
            print(error)
        }
        
        // Create classifier with MLDataTable
        let classifierColumns = ["Frase", "Checavel"]
        let classifierTable = dataTable[classifierColumns]
        let (classifierEvaluationTable, classifierTrainingTable) = classifierTable.randomSplit(by: 0.20, seed: 5)
        
        do {
            let modelParameters = MLTextClassifier.ModelParameters(validationData: classifierEvaluationTable, language: NLLanguage.portuguese)
            let classifier = try MLTextClassifier(trainingData: classifierTrainingTable, textColumn: "Frase", labelColumn: "Checavel", parameters: modelParameters)
            let trainingError = classifier.trainingMetrics.classificationError
            let trainingAccuracy = (1.0 - trainingError) * 100
            
            let classifierEvaluation = classifier.evaluation(on: classifierEvaluationTable)
            let evaluationError = classifierEvaluation.classificationError
            let evaluationAccuracy = (1.0 - evaluationError) * 100
            
            let classifierMetadata = MLModelMetadata(author: "Manuella Valença",
                                                     shortDescription: "Predicts if a sentence is or isn't suitable for fact-checking",
                                                     version: "1.0")
            let desktopPath = NSURL(fileURLWithPath: "/Users/manuellavalenca/Desktop")
            try classifier.write(to: (desktopPath.appendingPathComponent("ChecavelModel.mlmodel"))!, metadata: classifierMetadata)
            
            
        } catch {
            print(error)
        }
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

