//
//  SecondVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit
import Charts
import SnapKit

protocol SecondVCProtocol: AnyObject {
    func createConstraintsForBarChart1()
    func createConstraintsForPieChart1()
    
    func configurateBarChart()
    func configuratePieChart()
    
    func createLimiteLine()
}

class SecondVC: UIViewController {
    var presenter: SecondPresenterProtocol?
    
    var barChart = BarChartView()
    
    var pieChart = PieChartView()
    
    var highIncomeAverageLine: ChartLimitLine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fillProducts()
        presenter?.getCurDate()
        barChart.delegate = self
        pieChart.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.fillChart()
        presenter?.fillPieChart()
        
        let formatter = ChartStringFormatter()
        formatter.nameValues = presenter?.showMasOfWeek() ?? []
        barChart.xAxisRenderer.axis.valueFormatter = formatter
        
        barChart.data = presenter?.getDataForChart()
        
        pieChart.data = presenter?.getDataForPieChart()
        
        presenter?.setConstraintsForBarChart1()
        presenter?.setConstraintsForPieChart1()
        presenter?.configureBarChart()
        presenter?.configuratePieChart()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension SecondVC: SecondVCProtocol {
    func createConstraintsForBarChart1() {
        view.addSubview(barChart)
        barChart.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.35)
        }
    }
    
    func createConstraintsForPieChart1() {
        view.addSubview(pieChart)
        pieChart.snp.makeConstraints { make in
            make.top.equalTo(barChart.snp.bottom).inset(0)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configurateBarChart() {
        barChart.rightAxis.enabled = false
        barChart.xAxisRenderer.axis.labelPosition = .bottom
        barChart.leftAxis.axisLineWidth = 4
        barChart.leftAxis.axisLineColor = .forJustText
        barChart.xAxisRenderer.axis.axisLineColor = .forJustText
        barChart.xAxisRenderer.axis.axisLineWidth = 4
        barChart.xAxisRenderer.axis.labelTextColor = UIColor.forJustText
        barChart.leftAxis.labelTextColor = UIColor.forJustText
        
        barChart.leftAxis.axisMinimum = 0.0
        barChart.leftAxis.axisMaximum = Double((presenter?.getMaxCcal() ?? 0) * 2)
        
        presenter?.showLimitLine()
    }
    
    func configuratePieChart() {
        
    }
    
    func createLimiteLine() {
        guard let normaCcal = presenter?.getMaxCcal() else { return }
        highIncomeAverageLine = ChartLimitLine()
        highIncomeAverageLine!.limit = Double(normaCcal)
        highIncomeAverageLine!.lineColor = .green
        highIncomeAverageLine!.valueTextColor = UIColor.forJustText
        highIncomeAverageLine!.label = "Рекомендуемое количество ккал:".localized() + " \(normaCcal)"
        highIncomeAverageLine!.labelPosition = .leftTop
        barChart.leftAxis.removeAllLimitLines()
        barChart.leftAxis.addLimitLine(highIncomeAverageLine!)
    }
}

extension SecondVC: ChartViewDelegate {
    
}
