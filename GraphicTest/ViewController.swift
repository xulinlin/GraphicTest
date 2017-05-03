//
//  ViewController.swift
//  GraphicTest
//
//  Created by 徐林琳 on 17/4/26.
//  Copyright © 2017年 徐林琳. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addPieChatView()
        addBarChartView()
    }
    
    fileprivate func addPieChatView() {
         let dataAry = [ChartData(percent: 0.3, color: UIColor.yellow, text: "包子"), ChartData(percent: 0.2, color: UIColor.blue, text: "饺子"), ChartData(percent: 0.1, color: UIColor.yellow, text: "煎包"), ChartData(percent: 0.25, color: UIColor.green, text: "炒面"), ChartData(percent: 0.25, color: UIColor.red, text: "水果")]
        let pieChat = PieChartView(frame: CGRect(x: 100, y: 50, width: 250, height: 250), dataAry: dataAry)
        self.view.addSubview(pieChat)
    }
    
    fileprivate func addBarChartView() {
        let dataAry = [ChartData(percent: 0.3, color: UIColor.red, text: "包子"), ChartData(percent: 0.2, color: UIColor.blue, text: "饺子"), ChartData(percent: 0.1, color: UIColor.yellow, text: "煎包"), ChartData(percent: 0.25, color: UIColor.green, text: "炒面"), ChartData(percent: 0.8, color: UIColor.red, text: "水果")]
        
        let barView = BarChartView(frame: CGRect(x: 50, y: 350, width: 300, height: 200), dataAry: dataAry)
        view.addSubview(barView)
    }
}

