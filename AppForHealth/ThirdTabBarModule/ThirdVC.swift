//
//  ThirdVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit
import Charts

protocol ThirdVCProtocol: AnyObject {
    func createConstraintsForLineChart1()
    
    func configurateLineChart()
    
    func createLimiteLine()
}

class ThirdVC: UIViewController {
    var presenter: ThirdPresenterProtocol?
    
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fillProducts()
        presenter?.getCurDate()
        lineChart.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.fillChart()
        
        let formatter = ChartStringFormatter()
        formatter.nameValues = presenter?.showMasOfWeek() ?? []
        lineChart.xAxisRenderer.axis.valueFormatter = formatter
        
        
        lineChart.data = presenter?.getDataForChart()
        
        presenter?.setConstraintsForLineChart1()
        presenter?.configureLineChart()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
}

extension ThirdVC: ThirdVCProtocol {
    
    
    func createConstraintsForLineChart1() {
        view.addSubview(lineChart)
        lineChart.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.35)
        }
    }
    
    func configurateLineChart() {
        lineChart.rightAxis.enabled = false
        lineChart.xAxisRenderer.axis.labelPosition = .bottom
        lineChart.leftAxis.axisLineWidth = 4
        lineChart.leftAxis.axisLineColor = .forJustText
        lineChart.xAxisRenderer.axis.axisLineColor = .forJustText
        lineChart.xAxisRenderer.axis.axisLineWidth = 4
        lineChart.xAxisRenderer.axis.labelTextColor = UIColor.forJustText
        lineChart.leftAxis.labelTextColor = UIColor.forJustText
        
        lineChart.leftAxis.axisMinimum = 0.0
        lineChart.leftAxis.axisMaximum = Double((presenter?.getMaxNumberOfWater() ?? 0) * 2)
        
        presenter?.showLimitLine()
    }
    
    func configuratePieChart() {
        
    }
    
    func createLimiteLine() {
        guard let normaWater = presenter?.getMaxNumberOfWater() else { return }
        let highIncomeAverageLine = ChartLimitLine()
        highIncomeAverageLine.limit = Double(normaWater)
        highIncomeAverageLine.lineColor = .green
        highIncomeAverageLine.valueTextColor = UIColor.forJustText
        highIncomeAverageLine.label = "Рекомендуемое количество жидкости:".localized() + " \(normaWater)"
        highIncomeAverageLine.labelPosition = .leftTop
        
        lineChart.leftAxis.removeAllLimitLines()
        lineChart.leftAxis.addLimitLine(highIncomeAverageLine)
    }
}
extension ThirdVC: ChartViewDelegate {
    
}

