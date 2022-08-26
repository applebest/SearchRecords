//
//  ViewController.swift
//  test1
//
//  Created by clt on 2022/8/15.
//

import UIKit

class ViewController: UIViewController {

    lazy var scaleCircleView:ScaleCircle = {
        let temp = ScaleCircle.init(frame: CGRect(x: 120, y: 300, width: 300, height: 200))
        temp.lineWith = 21.38
        temp.centerLable?.text = "净资产"
        return temp
    }()
    
    lazy var searchRecords:SearchRecordsView = {
        
        let dataSource = [  ["的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了递四方速递发","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲1123213123了","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了454545","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","说的","都是非凡哥","豆腐干","的是否会京东数科了富家第三方回家看水电费就电视看了费劲打开了司法鉴定抗裂砂浆发可拉倒是减肥卡兰蒂斯荆防颗粒的健身房"],
            ["的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了递四方速递发","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲1123213123了","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了454545","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","说的","都是非凡哥","豆腐干","的是否会京东数科了富家第三方回家看水电费就电视看了费劲打开了司法鉴定抗裂砂浆发可拉倒是减肥卡兰蒂斯荆防颗粒的健身房"],
            ["的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了递四方速递发","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲1123213123了","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了454545","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","说的","都是非凡哥","豆腐干","的是否会京东数科了富家第三方回家看水电费就电视看了费劲打开了司法鉴定抗裂砂浆发可拉倒是减肥卡兰蒂斯荆防颗粒的健身房"],
            ["的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了递四方速递发","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲1123213123了","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了454545","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","说的","都是非凡哥","豆腐干","的是否会京东数科了富家第三方回家看水电费就电视看了费劲打开了司法鉴定抗裂砂浆发可拉倒是减肥卡兰蒂斯荆防颗粒的健身房"],
            ["的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","的数据付款了时代峻峰","的是否会","水电费加速度快了费劲了递四方速递发","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲1123213123了","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了454545","水电费","的爽肤水巅峰赛都","水费","的是否会","水电费加速度快了费劲了","水电费","的爽肤水巅峰赛都","水费","说的","都是非凡哥","豆腐干","的是否会京东数科了富家第三方回家看水电费就电视看了费劲打开了司法鉴定抗裂砂浆发可拉倒是减肥卡兰蒂斯荆防颗粒的健身房"]
        ]

        
        
    
        
        
        let temp = SearchRecordsView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.size.height),dataSource: dataSource)
        
        temp.didSelectedBlock = {(index)->Void in
            
            print("index:  \(index) \ndata:  \(temp.dataSource[index.section][index.item])")
        }
        
        return temp
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchRecords)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.searchRecords.dataSource = [["地方","大是大非","递四方速递房东说","第三方的首付多少发"]]
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        struct viewSize {
//            static var  count : Int = 0
//        }
//
//
//        viewSize.count += 1
//        var frame =  CGRect(x: 120, y: 300, width: 300, height: 200)
//        if viewSize.count % 2 == 0 {
//            frame =  CGRect(x: 120, y: 400, width: 350, height: 250)
//        }
//
//
//        UIView.animate(withDuration: 0.6) {
//            self.scaleCircleView.frame = frame
//        }
//
//        self.scaleCircleView.settingCenterLabelFrame()
//        self.scaleCircleView.restart()
//
//
////        scaleCircleView.frame = frame
////        scaleCircleView.settingCenterLabelFrame()
////        scaleCircleView.restart()
//
//
//    }
    


}

