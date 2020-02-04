//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by suraj poudel on 4/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {

    enum OperatorType{
        case addition
        case multiplication
        case division
        case subtraction
    }
    
    @IBOutlet weak var outputLabel:UILabel!
    var leftOperand:String?
    var rightOperand:String?
    var operatorType:OperatorType?
    var outputString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftOperand = nil
        rightOperand = nil
        operatorType = nil
        self.attachActionToButtons(parentView: self.view)
        outputLabel.text = "0"
    }
    
    func resetAll(){
        leftOperand = nil
        rightOperand = nil
        operatorType = nil
        outputLabel.text = "0"
    }
    
    func attachActionToButtons(parentView:UIView){
        
            parentView.subviews.forEach { (view) in
            if view is UIButton{
                var buttonView:UIButton!
                buttonView = view as? UIButton
                if(buttonView!.tag == 16){
                    buttonView.setTitle("%", for: .normal)
                }
                buttonView.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            }else{
                self.attachActionToButtons(parentView: view)
            }
        }
        
    }
    
    func dealWithNumbers(_ senderTag:Int){
        
        guard leftOperand != "inf" else{
            return
        }
        
        let text:String
        if(senderTag == 10){
            text = "."
        }else{
            text = "\(senderTag)"
        }
        
        if leftOperand == nil && operatorType == nil{
            if(text  == "."){
                leftOperand = "0."
            }else{
                leftOperand = text
            }
            outputLabel.text = leftOperand
            
        }else if(leftOperand != nil && operatorType == nil){
            
            if leftOperand!.contains(".") && text == "."{
                return
            }else if leftOperand == "0" && text == "0"{
                return
            }else if leftOperand == "0" && text != "0" && text != "."{
                leftOperand = text
            }else{
                leftOperand! += text
            }
            outputLabel.text = leftOperand
        }
        
        if(rightOperand == nil && operatorType != nil){
            if(text == "."){
                rightOperand = "0."
            }else{
               rightOperand = text
            }
           outputLabel.text = rightOperand
            
        }else if(rightOperand != nil && operatorType != nil){
            
            if rightOperand!.contains(".") && text == "."{
                return
            }else if rightOperand == "0" && text == "0"{
                return
            }else if rightOperand == "0" && text != "0" && text != "."{
                rightOperand = text
            }else{
                rightOperand! += text
            }
            outputLabel.text = rightOperand
        }
    }
    
    func calculateOutput()->Double?{
        guard leftOperand != nil ,operatorType != nil , rightOperand  != nil else{
            return nil
        }
        
        var doubleOutput:Double?
        if let operatorType = operatorType,let leftOperand = leftOperand,let rightOperand = rightOperand{
             switch operatorType{
             case .subtraction:
                   
                           doubleOutput = (leftOperand as NSString).doubleValue - (rightOperand as NSString).doubleValue
                    break
             case .addition:
                           doubleOutput = (leftOperand as NSString).doubleValue + (rightOperand as NSString).doubleValue
                    break
             case .multiplication:
                           doubleOutput = (leftOperand as NSString).doubleValue * (rightOperand as NSString).doubleValue
                    break
             case .division:
                           doubleOutput = (leftOperand as NSString).doubleValue / (rightOperand as NSString).doubleValue
                    break
            }
           
        }
        
        return doubleOutput
    }
    func showOutput(){
        
        let calculateOutput = self.calculateOutput()
        
        if let floatOutput = calculateOutput{
            outputString = String(floatOutput)
            outputLabel.text = outputString
            leftOperand = outputString
            rightOperand = nil
            operatorType = nil
        }
    }
    
    func dealWithOperand(_ senderTag:Int){
        
        guard leftOperand != nil || leftOperand  != "inf" else{
            return
        }
        
        if (rightOperand != nil){
            leftOperand = String(self.calculateOutput()!)
            outputLabel.text = leftOperand
            operatorType = nil
            rightOperand = nil
        }
        
        switch senderTag{
        case 12:
            operatorType = .subtraction
            break
        case 13:
            operatorType = .addition
            break
        case 14:
            operatorType = .multiplication
            break
        case 15:
            operatorType = .division
            break
        default:
            break
        }
        
        
        
    }
    func noImplementationAvailable(){
        
        let alertController = UIAlertController(title: "Calculator App", message: "The button hasn't been wired and implemented Yet!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func buttonPressed(_ sender:AnyObject){
    
        let senderTag = sender.tag!
        
        switch senderTag{
        case 0...10:
            self.dealWithNumbers(senderTag)
            break
        case 11:
            self.showOutput()
            break
        case 12...15:
            self.dealWithOperand(senderTag)
            break
        case 16...17:
            self.noImplementationAvailable()
            break
        case 18:
            self.resetAll()
            break
        default:
            break
        }
        
        
        
    }


}

