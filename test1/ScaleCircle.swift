//
//  ScaleCircle.swift
//  test1
//
//  Created by clt on 2022/8/15.
//

import UIKit
private let KEYNSeenW = UIScreen.main.bounds.width
private let KEYNSeenH = UIScreen.main.bounds.height
class ScaleCircle: UIView {

    //中心数据显示标签
    var centerLable : UILabel?
    
    //线宽.
    var lineWith : Float?
    //基准圆环颜色
    var unfillColor : UIColor?
  
    // 百分比数组
    var percentages : [CGFloat]?
    
    var colors:[UIColor]?
    
    //动画时长
    var animation_time:Double?
    
    var bgcLayer:CALayer?
    
    var  radius:Float? //  半径
    
    var CGPoinCerter:CGPoint?
    var endAngle:Float?
    var clockwise:Bool?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCenterLabel()
        self.lineWith = 10.0;
        self.unfillColor = UIColor.lightGray
        self.clockwise = true
        self.backgroundColor = UIColor.clear
        
        self.percentages = [0.094,0.1,0.5,0.2]

        self.colors = [UIColor.red,UIColor.green,UIColor.yellow,UIColor.blue]
        
        
        self.animation_time = 0.3
        
        self.centerLable?.text = "请初始化..."
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.initData()
        self.drawMiddlecircle()
        
        drawOutCCircle()

    }
    
    
    func settingCenterLabelFrame()  {
        let center =  min(self.bounds.size.width/2, self.bounds.size.height/2)
        self.CGPoinCerter = CGPoint(x: center, y: center)
        self.centerLable?.frame = CGRect(x: 0, y: 0, width: 2*center, height: 2*center)
    }
    
    func restart() {
        self.bgcLayer?.sublayers?.removeAll()
        self.setNeedsDisplay()
    }
    

    func drawOutCCircle() {
        
        guard let percentages = percentages else {
            return
        }
        
        var startAngle : CGFloat =  -CGFloat(Double.pi / 2.0)
        for i in 0..<percentages.count {
            let num = percentages[i]
            let bPath_first:UIBezierPath = UIBezierPath.init(arcCenter: self.CGPoinCerter!, radius: CGFloat(radius!), startAngle:startAngle, endAngle: startAngle + num / 1.0 * CGFloat( Double.pi * 2), clockwise: self.clockwise!)
            let lineLayer_first = CAShapeLayer.init(layer: layer)
            lineLayer_first.frame = (self.centerLable?.frame)!
            lineLayer_first.fillColor = UIColor.clear.cgColor
            lineLayer_first.path = bPath_first.cgPath
            lineLayer_first.strokeColor = colors?[i].cgColor
            lineLayer_first.lineWidth  =  CGFloat(self.lineWith!)
            
            self.bgcLayer?.addSublayer(lineLayer_first)

            startAngle = startAngle + num / 1.0 * CGFloat( Double.pi * 2)
        }

    }
    
    
    /*
     *中心标签设置
     */
   func initCenterLabel(){
        let center =  min(self.bounds.size.width/2, self.bounds.size.height/2)
        self.CGPoinCerter = CGPoint(x: center, y: center)
        self.centerLable = UILabel(frame:CGRect(x: 0, y: 0, width: 2*center, height: 2*center))
        self.centerLable?.textAlignment = .center
        self.centerLable?.backgroundColor = UIColor.clear
        self.centerLable?.adjustsFontSizeToFitWidth = true
        self.centerLable?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.contentMode = .redraw
        self.addSubview(self.centerLable!)
    }

    /*
     参数配置
    */
    func initData(){

        //半径计算
        let x = (Float(self.bounds.size.height/2))-(self.lineWith!/2)
        let y = (Float(self.bounds.size.width/2))-(self.lineWith!/2)
        radius = min(x, y)
        self.centerLable?.font = UIFont.systemFont(ofSize: CGFloat(radius!/3))
    }
    
    
    /**
     *  辅助圆环
     */
    func drawMiddlecircle(){

        let cPath = UIBezierPath.init(arcCenter: self.CGPoinCerter!, radius: CGFloat(radius!), startAngle: -CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi * 3 ), clockwise: self.clockwise!)
        let bgLayer =  CAShapeLayer.init(layer: layer)
        bgLayer.fillColor = UIColor.clear.cgColor
        bgLayer.strokeColor = UIColor.lightGray.cgColor
        bgLayer.strokeStart = 0
        bgLayer.strokeEnd = 1
        bgLayer.zPosition = 1
        bgLayer.lineWidth = CGFloat(self.lineWith!)
        bgLayer.path = cPath.cgPath
 
        let bgcLayer = CALayer.init(layer: self.layer)
        self.bgcLayer = bgcLayer
        self.layer.addSublayer(bgcLayer)
        
        bgcLayer.mask = bgLayer
        
        let ani:CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        ani.fromValue = 0
        ani.toValue = 1
        ani.repeatCount = 1
        ani.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        ani.duration = 1.0
        ani.isRemovedOnCompletion = true
        bgLayer.add(ani, forKey: "pieAnimation")
        
        
    }
    

}
