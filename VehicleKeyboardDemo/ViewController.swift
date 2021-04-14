//
//  ViewController.swift
//  VehicleKeyboardDemo
//
//  Created by 杨志豪 on 2018/4/8.
//  Copyright © 2018年 yangzhihao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PWHandlerDelegate {
    
    let handler = PWHandler()


    @IBOutlet weak var plateInputVIew: UIView!
    
    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var newEnergyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //选择以下两种键盘样式之一
        
        //UITextField绑定车牌键盘(输入框形式)
        setupSystemTextfield()
        
        //将自己创建的UIView绑定车牌键盘(格子形式)
        setupPWTextfield()
        
    }
    
    func setupPWTextfield() {
        //将自己创建的UIView绑定车牌键盘(格子形式)
        handler.delegate = self
        
        //改变主题色
        handler.mainColor = UIColor.blue
        //改变字体大小
        handler.textFontSize = 18
        //在格子间增加间隔
        handler.itemSpacing = 10
//        handler.cellBorderColor = UIColor.gray
        handler.cornerRadius = 5
        //格子中间的背景色
        handler.itemColor = UIColor.white
        
        
        handler.setKeyBoardView(view: plateInputVIew)
        
        print("当前键盘的输入值\(self.handler.paletNumber)")//获取当前输入的值
        print(self.handler.isComplete() ? "输入完整" : "不完整")//获取当前键盘的完整性
        //手动弹出键盘
//        handler.vehicleKeyBoardBecomeFirstResponder()
    }
    
    func setupSystemTextfield() {
        
        //UITextField绑定车牌键盘(输入框形式)
        myTextField.changeToPlatePWKeyBoardInpurView()
        
        //监听键盘的改变
        myTextField.plateChange = { (text,complete) in
            print("系统输入框键盘改变了text:\(text)\n是否完成车牌输入:\(complete ? "是" : "否")")
        }
        
        myTextField.pwKeyBoardShow = {
           print("系统框车牌键盘显示了")
        }
        
        myTextField.pwKeyBoardHidden = {
           print("系统框车牌键盘隐藏了")
        }
    }
    

    @IBAction func changeModeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        //uitextField输入框改变新能源
        myTextField.changePlateInputType(isNewEnergy:sender.isSelected)
        
        //格子输入框改变新能源
        handler.changeInputType(isNewEnergy: sender.isSelected)
    }
    
    //隐藏键盘
    @IBAction func buttonAction(_ sender: UIButton) {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    //填充格子输入框的值
    @IBAction func setCollectionInputButtonAction(_ sender: UIButton) {
        newEnergyButton.isSelected = false
        self.handler.setPlate(plate: "湘JR0001", type: .auto)
    }
    
    //填充uitextfield的值
    @IBAction func setTextFieldPlateButtonAction(_ sender: UIButton) {
        newEnergyButton.isSelected = false
        myTextField.setPlate(plate: "粤BR0001", type: .auto)
    }
    
    //MARK:车牌键盘代理方法-格子输入框专用
    //输入完成点击确定后的回调
    func plateInputComplete(plate: String) {
        print("输入完成车牌号为:" + plate)
    }
    //车牌输入发生变化时的回调
    func palteDidChnage(plate:String,complete:Bool) {
        print("输入车牌号为:" + plate + "\n输入是否完整？:" + (complete ? "完整" : "不完整"))
    }
    //车牌键盘出现的回调
    func plateKeyBoardShow() {
        print("格式输入框车牌键盘显示")
    }
    //车牌键盘消失的回调
    func plateKeyBoardHidden() {
        print("格式输入框车牌键盘隐藏")
    }
}

