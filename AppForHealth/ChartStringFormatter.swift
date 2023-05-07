//
//  ChartStringFormatter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 22.04.2023.
//

import UIKit
import Charts

class ChartStringFormatter: IndexAxisValueFormatter {
    
    var nameValues: [String] = []

    public override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(describing: nameValues[Int(value)])
    }
}
