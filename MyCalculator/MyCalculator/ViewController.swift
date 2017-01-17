//
//  ViewController.swift
//  MyCalculator
//
//  Created by hunterchen on 2017/1/11.
//  Copyright © 2017年 hunterchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
@IBOutlet weak var lb_result: UILabel!

    var i_preNum = 0,i_secOperand = 0,i_doubleOpt=0
    var b_keep=false;
    var str_preOpt:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculate(_ sender: UIButton) {
        if(!str_preOpt.isEmpty && i_preNum == 0){
            if(i_preNum != 0){
                i_preNum = Int(lb_result.text!)!
            }
        }
        if((lb_result.text?.characters.count)!>0){
            lb_result.text=checkChar(input: lb_result.text!)
        }
        if(!(sender.tag==15)){
            i_doubleOpt=0
        }
        if(sender.tag > 10 && sender.tag < 15){
            b_keep=true
        }
        switch sender.tag{
        case 0...9:
            debugPrint("lb_result.text=\(lb_result.text)")
            if(lb_result.text! == "0"){
                lb_result.text = String(sender.tag)
            }else{
                if (b_keep==true){
                    lb_result.text=""
                    b_keep=false
                }
                lb_result.text = lb_result.text! + String(sender.tag)
            }
            break
        case 11://+
            if(!str_preOpt.isEmpty && i_secOperand == 0){
                self.lb_result.text = String(calbyOperator(Opt: str_preOpt))
                i_preNum=0
            }else{
                i_preNum = (Int(lb_result.text!))!
                debugPrint("i_preNum=\(i_preNum)")
            }
            str_preOpt = "+"
            break
        case 12://-
            if(!str_preOpt.isEmpty && i_secOperand == 0){
                lb_result.text = String(calbyOperator(Opt: str_preOpt))
                i_preNum=0
            }else{
                i_preNum = Int(lb_result.text!)!
            }
            str_preOpt = "-"
            break
        case 13://*
            if(!str_preOpt.isEmpty && i_secOperand == 0){
                lb_result.text = String(calbyOperator(Opt: str_preOpt))
                i_preNum=0
            }else{
                i_preNum = Int(lb_result.text!)!
            }
            str_preOpt = "*"
            break
        case 14:// /
            if(!str_preOpt.isEmpty && i_secOperand == 0 ){
                lb_result.text = String(calbyOperator(Opt: str_preOpt))
                i_preNum=0
            }else{
                i_preNum = Int(lb_result.text!)!
            }
            str_preOpt = "/"
            break
        case 15://=
            i_doubleOpt+=1
            if(!str_preOpt.isEmpty){
                if(i_secOperand == 0){
                    debugPrint("pre..."+lb_result.text!)
                    i_secOperand = Int(lb_result.text!)!
                }
                debugPrint("pre..."+lb_result.text!)
                lb_result.text = String(calbyOperator(Opt: str_preOpt))
                i_preNum=i_secOperand
            }else{
                if(!(lb_result.text?.isEmpty)!){
                    i_preNum = Int(lb_result.text!)!
                }
                lb_result.text=""
            }
            break
        case 16:// C
            i_doubleOpt=0
            lb_result.text = String(0)
            i_preNum=0
            i_secOperand=0
            str_preOpt=""
            break
        default :
            return
        }
    }
    func calbyOperator(Opt: String) -> Int{
        switch Opt
        {
            case "+":
                debugPrint("lb_result=\(lb_result.text)")
                return i_preNum &+ Int(lb_result.text!)!
            case "-":
                if(i_doubleOpt>=2){
                    debugPrint(lb_result.text!)
                    debugPrint(i_preNum)
                    debugPrint("after..."+String(Int(lb_result.text!)! - i_preNum))
                    return Int(lb_result.text!)! - i_preNum
                }else{
                    return i_preNum &- Int(lb_result.text!)!
                }
            case "*":
                return i_preNum &* Int(lb_result.text!)!
            case "/":
                if(i_doubleOpt>=2){
                    return Int(lb_result.text!)! / i_preNum
                }else{
                    return i_preNum / Int(lb_result.text!)!
            }
            default:
                return 0
        }
    }
    func checkChar(input:String) -> String{
        let index = input.index(input.startIndex, offsetBy: 1)
        if(input.substring(to: index)=="0"){
            if(input.substring(from: index)==""){
                return input
            }else{
                return input.substring(from: index)
            }
        }else{
            return input
        }
    }
}

