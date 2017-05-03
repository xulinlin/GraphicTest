//
//  PieCharView.swift
//  GraphicTest
//
//  Created by 徐林琳 on 17/4/26.
//  Copyright © 2017年 徐林琳. All rights reserved.
//

import UIKit

struct ChartData {
    let percent: Double
    let color: UIColor
    let text: String
}

class PieChartView: UIView {
    fileprivate var radius: CGFloat = 100
    fileprivate static let fontSize = 15
    fileprivate var dataAry: [ChartData] = []
    fileprivate lazy var textAttr = {
        [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: CGFloat(PieChartView.fontSize))]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        radius = (frame.width / 2 - 10) / 2
    }
    
    convenience init(frame: CGRect, dataAry: [ChartData]) {
        self.init(frame: frame)
        self.dataAry = dataAry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        var angle = -M_PI / 2
        for data in dataAry {
            drawPie(color: data.color, startAngle: angle, percent: data.percent)
            drawText(angle, percent: data.percent, text: data.text)
            angle += 2 * M_PI*data.percent
        }
        angle = -M_PI / 2
        for data in dataAry {
            drawText(angle, percent: data.percent, text: data.text)
            angle += 2 * M_PI*data.percent
        }
    }

    fileprivate func drawPie(color: UIColor, startAngle: Double, percent: Double) {
        let path = UIBezierPath()
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        color.setFill()
        let endAngle = CGFloat(startAngle + 2 * M_PI*percent)
        path.addArc(withCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: endAngle, clockwise: true)
        path.addLine(to: center)
        path.close()
        path.fill()
    }
    
     fileprivate func drawText(_ startAngle: Double, percent: Double, text: String) {
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let angle = -(startAngle + (M_PI * percent))
        
        let x = center.x + radius * 0.7 * CGFloat(cos(angle))
        let y = center.y - radius * 0.7 * CGFloat(sin(angle))
        
        let point1 = CGPoint(x: x, y: y)
        let right = x > center.x
        let bottom = y > center.y
        let spacing: CGFloat = 20
        let point2 = CGPoint(x: right ? x + spacing : x - spacing, y: bottom ? y + spacing : y - spacing)
        
        let endX = right ? point2.x + spacing : point2.x - spacing
//        let endY = bottom ? point2.y + spacing : point2.y - spacing
        let point3 = CGPoint(x: endX, y: point2.y)
        
        let path = UIBezierPath()
        path.lineWidth = 2
        UIColor.white.setStroke()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.stroke()
        
        let str = NSString(string: text)
        str.draw(at: point3, withAttributes: textAttr)
    }
}
