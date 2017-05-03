//
//  BarChartView.swift
//  GraphicTest
//
//  Created by 徐林琳 on 17/4/27.
//  Copyright © 2017年 徐林琳. All rights reserved.
//

import UIKit

class BarChartView: UIView {
    fileprivate var originPoint: CGPoint = CGPoint.zero
    fileprivate var lengthTotalX: CGFloat = 0
    fileprivate var lengthTotalY: CGFloat = 0
    fileprivate var dataAry: [ChartData] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, dataAry: [ChartData]) {
        self.init(frame: frame)
        self.dataAry = dataAry
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawBackGround()
        
        let barSpacing: CGFloat = lengthTotalY/CGFloat(dataAry.count)
        var startX = originPoint.x + barSpacing*0.3
        for data in dataAry {
            let startPoint = CGPoint(x: startX, y: originPoint.y)
            drawBar(color: data.color, startPoint: startPoint, barPercent: data.percent, barWidth: barSpacing*0.5, text: data.text)
            startX += barSpacing
        }
    }
    
    fileprivate func drawBackGround() {
        let spacing: CGFloat = 20
        originPoint = CGPoint(x: spacing * 2, y: bounds.maxY - spacing*2)
        let axesXPoint = CGPoint(x: originPoint.x, y: spacing + 10)
        let axesYPoint = CGPoint(x: bounds.maxX - spacing, y: originPoint.y)
        
        // x,y line
        var path = UIBezierPath()
        UIColor.white.setStroke()
        path.lineWidth = 3
        path.move(to: axesXPoint)
        path.addLine(to: originPoint)
        path.addLine(to: axesYPoint)
        path.stroke()
        
        // arrow X
        let arrowWidth: CGFloat = 5
        let arrowXLeft = CGPoint(x: axesXPoint.x - arrowWidth, y: axesXPoint.y + arrowWidth)
        let arrowXRight = CGPoint(x: axesXPoint.x + arrowWidth, y: axesXPoint.y + arrowWidth)
        path = UIBezierPath()
        path.lineWidth = 3
        UIColor.white.setStroke()
        path.move(to: arrowXLeft)
        path.addLine(to: axesXPoint)
        path.addLine(to: arrowXRight)
        path.stroke()
        
        // x标识
        let symbolTextAry = ["0", "20", "40", "60", "80", "100"]
        lengthTotalX = originPoint.y - axesXPoint.y - 8
        let symbolPerHeight = lengthTotalX / CGFloat(symbolTextAry.count)
        let symbolWidth: CGFloat = 5
        var symbolY: CGFloat = originPoint.y
        
        for text in symbolTextAry {
            let startPoint = CGPoint(x: originPoint.x, y: symbolY)
            let endPoint = CGPoint(x: originPoint.x + symbolWidth, y: symbolY)
            
            let path = UIBezierPath()
            path.lineWidth = 3
            UIColor.white.setStroke()
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            path.stroke()
            
            let textStr = NSString(string: text)
            let textAttr =
                [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 11)]
            let textPoint = CGPoint(x: startPoint.x - spacing - 3, y: symbolY - 8)
            textStr.draw(at: textPoint, withAttributes: textAttr)

            symbolY -= symbolPerHeight
        }
        
        // arrow Y
        let arrowYLeft = CGPoint(x: axesYPoint.x - arrowWidth, y: axesYPoint.y - arrowWidth)
        let arrowYRight = CGPoint(x: axesYPoint.x - arrowWidth, y: axesYPoint.y + arrowWidth)
        path = UIBezierPath()
        path.lineWidth = 3
        UIColor.white.setStroke()
        path.move(to: arrowYLeft)
        path.addLine(to: axesYPoint)
        path.addLine(to: arrowYRight)
        path.stroke()
        
        lengthTotalY = axesYPoint.x - originPoint.x - 8
    }
    
    fileprivate func drawBar(color: UIColor, startPoint: CGPoint, barPercent: Double, barWidth: CGFloat, text: String) {
        let height = lengthTotalX*CGFloat(barPercent)
        
        let path = UIBezierPath()
        color.setFill()
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y - height))
        path.addLine(to: CGPoint(x: startPoint.x + barWidth, y: startPoint.y - height))
        path.addLine(to: CGPoint(x: startPoint.x + barWidth, y: startPoint.y))
        path.fill()
        
        let textRect = CGRect(x: startPoint.x, y: startPoint.y + 3, width: barWidth, height: 20)
        let textAttr =
            [NSForegroundColorAttributeName: color, NSFontAttributeName: UIFont.systemFont(ofSize: 11)]
        
        let textStr = NSString(string: text)
        textStr.draw(in: textRect, withAttributes: textAttr)
    }

}
