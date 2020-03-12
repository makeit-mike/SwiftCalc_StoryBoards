//
//  ViewController.swift
//  calculator
//
//  Created by Michael Jones on 2/19/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import UIKit

class ViewController:
UIViewController {
    @IBOutlet weak var inputBox: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    @IBOutlet weak var history0: UILabel!
    @IBOutlet weak var history1: UILabel!
    @IBOutlet weak var history2: UILabel!
    @IBOutlet weak var history3: UILabel!
    @IBOutlet weak var history4: UILabel!
    @IBOutlet weak var history5: UILabel!
    
    @IBOutlet weak var decimal: UIButton!
    @IBOutlet weak var changeSignBtn: UIButton!
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var equalsBtn: UIButton!
    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    @IBOutlet weak var leftParen: UIButton!
    @IBOutlet weak var rightParen: UIButton!
    var historyArr: [String] = []
    let impact = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        history0.isHidden = true
        inputBox.isScrollEnabled = false
        inputBox.isEditable = false
        resultLabel.adjustsFontSizeToFitWidth = true
        history1.adjustsFontSizeToFitWidth = true
        history2.adjustsFontSizeToFitWidth = true
        history3.adjustsFontSizeToFitWidth = true
        history4.adjustsFontSizeToFitWidth = true
        history5.adjustsFontSizeToFitWidth = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func touchClear(_ sender: Any) {
        impact.impactOccurred()
        if(inputBox.text == ""){
            clearBtn.setTitle("AC", for: .normal)
            resultLabel.text = ""
            historyArr.removeAll()
            history0.text = ""
            history1.text = ""
            history2.text = ""
            history3.text = ""
            history4.text = ""
            history5.text = ""
        }
        else{
            inputBox.text = ""
            clearBtn.setTitle("AC", for: .normal)
        }
    }
    
    @IBAction func deleteTouch(_ sender: Any) {
        impact.impactOccurred()
        var inputString = inputBox.text
        if(inputString!.count>0){
            inputString?.removeLast()
            inputBox.text = inputString
            if(inputBox.text != ""){
                clearBtn.setTitle("CE", for: .normal)
            }
            else{
                clearBtn.setTitle("AC", for: .normal)
            }        }
        else{
            clearBtn.setTitle("AC", for: .normal)
        }
    }

    @IBAction func insertExpressionTouch(_ sender: UIButton) {
        // adds +,-,/,x
        impact.impactOccurred()
        let expression = sender.titleLabel?.text
        if(inputBox.text == "" && (expression != "-" && expression != "(")){
           return
        }
        let inputString = inputBox.text + expression!
        inputBox.text = inputString
        if(expression == "-"){
            subtractBtn.isEnabled = false
        }
        addBtn.isEnabled = false
        multiplyBtn.isEnabled = false
        divideBtn.isEnabled = false
        powerBtn.isEnabled = false
    }
    
    @IBAction func insertNumberTouch(_ sender: UIButton) {
        //this event handles 0-9 and '.'
        impact.impactOccurred()
        let number = sender.titleLabel?.text
        let inputString = inputBox.text + number!
        inputBox.text = inputString
        addBtn.isEnabled = true
        subtractBtn.isEnabled = true
        multiplyBtn.isEnabled = true
        divideBtn.isEnabled = true
        powerBtn.isEnabled = true
        if(inputBox.text != ""){
            clearBtn.setTitle("CE", for: .normal)
        }
        else{
            clearBtn.setTitle("AC", for: .normal)
        }
    }
    
    @IBAction func powerTouch(_ sender: UIButton) {
        impact.impactOccurred()
        if(inputBox.text == ""){
            return
        }
        let inputString = (inputBox.text + "^")
        inputBox.text = inputString
        addBtn.isEnabled = false
        subtractBtn.isEnabled = true
        multiplyBtn.isEnabled = false
        divideBtn.isEnabled = false
        powerBtn.isEnabled = false
    }
    
    @IBAction func openingParenTouch(_ sender: UIButton) {
        impact.impactOccurred()
        let expression: String = sender.titleLabel!.text!
        var inputString: String = inputBox.text!
        if(inputString == ""){
            inputBox.text = "("
            return
        }
        var lastChar = Array(inputString)
        lastChar.reverse()
        if(lastChar[0].isNumber){
            inputString = "\(inputString)*\(expression)"
            inputBox.text = inputString
            addBtn.isEnabled = false
            multiplyBtn.isEnabled = false
            divideBtn.isEnabled = false
            powerBtn.isEnabled = false
        }
        else{
            inputString = "\(inputString)\(expression)"
            inputBox.text = inputString
        }
    }
    @IBAction func closingParenTouch(_ sender: UIButton) {
        impact.impactOccurred()
        if(inputBox.text == ""){
            return
        }
        let parenthesis = sender.titleLabel?.text
        let inputString = inputBox.text + parenthesis!
        inputBox.text = inputString
        addBtn.isEnabled = true
        subtractBtn.isEnabled = true
        multiplyBtn.isEnabled = true
        divideBtn.isEnabled = true
        powerBtn.isEnabled = true
    }
    

    @IBAction func equalsTouch(_ sender: Any) {
        impact.impactOccurred()
        if(inputBox.text == ""){
            return
        }
        let labelArr = [history0,history1,history2,history3,history4,history5]
        var inputString = inputBox.text.replacingOccurrences(of: "÷", with: "/")
        inputString = inputString.replacingOccurrences(of: "×", with: "*")
        
        
        
        //STRING MANIPULATION FOR POWER FUNCTION
        while(inputString.contains("^")){
            let symbol = inputString.firstIndex(of: "^")!
            let rightOfSymbol = inputString.index(symbol, offsetBy: 1)
            print(symbol)
            var leftStr = String(inputString[..<symbol])
            var rightStr = String(inputString[rightOfSymbol...])
            leftStr = String(leftStr.reversed())
            if(leftStr.hasPrefix(")")){
                leftStr = String(leftStr[...leftStr.firstIndex(of: "(")!])
            }
            else{
                leftStr = String(leftStr.prefix(while: {
                    ("0"..."9" ~= $0) ||
                    ("("...")" ~= $0) ||
                    ("." ~= $0)
                }))
            }
            leftStr = String(leftStr.reversed())
            print("initial right string:",rightStr)
            if(rightStr.hasPrefix("(")){
                rightStr = String(rightStr[...rightStr.firstIndex(of: ")")!])
            }
            else{
                rightStr = String(rightStr.prefix(while: {
                    ("0"..."9" ~= $0) ||
                    ("("...")" ~= $0) ||
                    ("." ~= $0)
                }))
            }
            
            //leftStr = leftStr.replacingOccurrences(of: "(", with: "")
            //rightStr = rightStr.replacingOccurrences(of: ")", with: "")
            print("L expr-",leftStr)
            print("R expr-", rightStr)
//            if(leftStr.hasPrefix("pow")){
//                do{
//                let lExpr = Expression(leftStr)
//                let lRes = try lExpr.evaluate()
//                leftStr = String(lRes)
//                }
//                catch {
//                    print("error")
//                    resultLabel.text = "Bad expression"
//                    return
//                }
//            }
            
            let powerStr = String(leftStr + "^" + rightStr)
            inputString = inputString.replacingOccurrences(of: powerStr, with: "pow(\(leftStr),\(rightStr))")
            print(inputString)
        }
        do {
            let testExpression = Expression(inputString)
            let result = try testExpression.evaluate()
            let resultString:String = String(format: "%g", result)
            inputString = inputString.replacingOccurrences(of: "pow", with: "")
            inputString = inputString.replacingOccurrences(of: ",", with: "^")
            resultLabel.text = inputString+" = "+resultString
            inputBox.text = resultString
            historyArr.reverse()
            historyArr.append(resultLabel.text!)
            historyArr.reverse()
            print("\npushed the result to history:")
            dump(historyArr)
            if(historyArr.count == 7){
                historyArr.popLast()
                print("\nDumped 7th element:")
                dump(historyArr)
            }
            for i in 0..<historyArr.count{
                    let label = labelArr[i]
                    label?.text = historyArr[i].description
            }
        } catch {
            print("error")
            resultLabel.text = "Bad expression"
            inputBox.text = inputString
        }
    }
}
