//
//  CaloriesVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 25.02.2023.
//

import Foundation
import UIKit
import SnapKit
import CoreData

protocol CaloriesVCProtocol: AnyObject {
    func createButtonForCalendar()
    func createCalendar()
    func createButtonForCloseCalendar()
    
    func createStackForStatistics()
    
    func createTableViewForFood()
    
    func createButtonForAddFood()
}

class CaloriesVC: UIViewController {
    var presenter: CaloriesPresenterProtocol?
    
    var tableViewForFood = UITableView()
    var helper = HelperForTableView()
    
    let buttonForCalend = MainButton()
    let buttonForCloseCalend = MainButton()
    let calendarView = UICalendarView()
    
    
    let progressOfProtein = UIProgressView()
    let progressOfFat = UIProgressView()
    let progressOfCarbonates = UIProgressView()
    let progressOfCalories = UIProgressView()
    
    let labelProtein = UILabel()
    let labelFat = UILabel()
    let labelCarbonates = UILabel()
    let labelCalories = UILabel()
    
    let labelForProtein = UILabel()
    let labelForFat = UILabel()
    let labelForCarbonates = UILabel()
    let labelForCalories = UILabel()
    
    let stackForProtein = UIStackView()
    let stackForFat = UIStackView()
    let stackForCarbonates = UIStackView()
    let stackForCalories = UIStackView()
    
    let stackForStatistics = UIStackView()
    
    
    let buttonForAddFood = UIButton()
    
    let foodVc = AddFoodVC()
    
    var returLeftBarButton = UIButton()
    var rightBarButton = UIButton()
    
    var labelForStatisticFood = LabelTitle()
    
    var scrolAllView = UIScrollView()
    var contentView = UIView()

    func setupLayout() {
        createScrollView()
        createContentView()
        prepareScrollView()
    }
    
    func createScrollView() {
        scrolAllView.showsVerticalScrollIndicator = true
        scrolAllView.alwaysBounceVertical = true
    }
    func createContentView() {
        //contentView.backgroundColor = .yellow
    }
    func prepareScrollView() {
        view.addSubview(scrolAllView)
        scrolAllView.addSubview(contentView)
        
        scrolAllView.snp.makeConstraints { make in
            make.top.equalTo(labelForStatisticFood.snp.bottom).inset(0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(0)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrolAllView.snp.top)
            make.left.equalTo(scrolAllView.snp.left)
            make.right.equalTo(scrolAllView.snp.right)
            make.bottom.equalTo(scrolAllView.snp.bottom)
            
            make.width.equalTo(scrolAllView.snp.width)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewForFood.separatorColor = .black
        configureNavigationItems()
        
        createLabelForTitle()
        setupLayout()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: date as Date)
        self.helper.date = formatteddate
        print("self.helper.date = \(self.helper.date)")
        
        presenter?.viewDidLoaded()
        view.backgroundColor = .brown
        tableViewForFood.backgroundColor = .brown
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        calendarView.delegate = self
        
        self.helper.viewController = self
    }
    
    func configureNavigationItems() {
        returLeftBarButton.translatesAutoresizingMaskIntoConstraints = false
        returLeftBarButton.clipsToBounds = true
        returLeftBarButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        returLeftBarButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        returLeftBarButton.layer.cornerRadius = 0.5 * returLeftBarButton.bounds.size.width
        
        returLeftBarButton.setBackgroundImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        returLeftBarButton.tintColor = .tabBarMainColor
        returLeftBarButton.addTarget(self, action: #selector(comeback), for: .touchUpInside)
        
        rightBarButton.translatesAutoresizingMaskIntoConstraints = false
        rightBarButton.clipsToBounds = true
        rightBarButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        rightBarButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        rightBarButton.layer.cornerRadius = 0.5 * returLeftBarButton.bounds.size.width
        
        let leftBarButtonItem = UIBarButtonItem(customView: returLeftBarButton)
        let rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    @objc func comeback() {
        dismiss(animated: true)
    }
    
    func createLabelForTitle() {
        view.addSubview(labelForStatisticFood)
        labelForStatisticFood.text = "Cтатистика питания".localized()
        
        labelForStatisticFood.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        let formatteddate = formatter.string(from: date as Date)
        self.helper.date = formatteddate
        
        self.helper.products = self.helper.realm.objects(ProductToday.self) // Заполняем массив базы данных
        
        if let products = self.helper.products {
            for prod in products {
                print("prod.date = \(prod.date)")
                print("self.helper.date = \(self.helper.date)")
                if prod.date == self.helper.date {
                        self.helper.arraysForDate.append(prod)
                        print("array = \(self.helper.arraysForDate)")
                }
            }
            print(self.helper.arraysForDate.count)
        }
        updateProgressView()
        self.tableViewForFood.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.helper.arraysForDate.removeAll()
    }
}



extension CaloriesVC: CaloriesVCProtocol {
    func createButtonForCalendar() {
        buttonForCalend.setTitle(self.helper.date, for: .normal)
        
        contentView.addSubview(buttonForCalend)
        buttonForCalend.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(20)
            make.right.equalTo(contentView.snp.right).inset(20)
            make.top.equalTo(contentView.snp.top).inset(0)
        }
        buttonForCalend.addTarget(self, action: #selector(didTapCalendar), for: .touchUpInside)
    }
    @objc func didTapCalendar() {
        buttonForCalend.isHidden = true
        
        calendarView.isHidden = false
        buttonForCloseCalend.isHidden = false
        
        stackForStatistics.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(buttonForCloseCalend.snp.bottom).inset(-20)
        }
    }
    
    
    func createButtonForCloseCalendar() {
        buttonForCloseCalend.isHidden = true
        
        buttonForCloseCalend.setTitle("Свернуть календарь".localized(), for: .normal)
        
        contentView.addSubview(buttonForCloseCalend)
        buttonForCloseCalend.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(calendarView.snp.bottom).inset(0)
        }
        buttonForCloseCalend.addTarget(self, action: #selector(didTapCloseCalendar), for: .touchUpInside)
    }
    @objc func didTapCloseCalendar() {
        calendarView.isHidden = true
        
        buttonForCloseCalend.isHidden = true
        buttonForCalend.isHidden = false
        
        stackForStatistics.snp.remakeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(250)
            make.top.equalTo(buttonForCalend.snp.bottom).inset(-20)
        }
    }
    
    func createCalendar() {
            calendarView.calendar = .current
            calendarView.locale = .current
        contentView.addSubview(calendarView)
            
            calendarView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.top.equalTo(contentView.snp.top).inset(0)
            }
        calendarView.tintColor = .buttonBackColor
        
        calendarView.isHidden = true
    }
    
    func createStackForStatistics() {
        contentView.addSubview(stackForStatistics)
    
        stackForProtein.addArrangedSubview(labelProtein)
        stackForFat.addArrangedSubview(labelFat)
        stackForCarbonates.addArrangedSubview(labelCarbonates)
        stackForCalories.addArrangedSubview(labelCalories)
        
        stackForProtein.addArrangedSubview(progressOfProtein)
        stackForFat.addArrangedSubview(progressOfFat)
        stackForCarbonates.addArrangedSubview(progressOfCarbonates)
        stackForCalories.addArrangedSubview(progressOfCalories)
        
        stackForProtein.addArrangedSubview(labelForProtein)
        stackForFat.addArrangedSubview(labelForFat)
        stackForCarbonates.addArrangedSubview(labelForCarbonates)
        stackForCalories.addArrangedSubview(labelForCalories)
    
        stackForProtein.axis = .vertical
        stackForFat.axis = .vertical
        stackForCarbonates.axis = .vertical
        stackForCalories.axis = .vertical
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        progressOfProtein.snp.makeConstraints { make in
            make.height.equalTo(20)
            //make.top.equalTo(0)
            make.left.right.equalToSuperview().inset(6)
        }
        progressOfFat.snp.makeConstraints { make in
            make.height.equalTo(20)
            //make.centerY.equalTo(stackForFat)
            make.left.right.equalToSuperview().inset(6)
        }
        progressOfCarbonates.snp.makeConstraints { make in
            make.height.equalTo(20)
            //make.centerY.equalTo(stackForCarbonates)
            make.left.right.equalToSuperview().inset(6)
        }
        progressOfCalories.snp.makeConstraints { make in
            make.height.equalTo(20)
            //make.centerY.equalTo(stackForCalories)
            make.left.right.equalToSuperview().inset(6)
        }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        labelProtein.snp.makeConstraints { make in
            make.height.equalTo(20)
            //make.top.equalTo(progressOfProtein.snp.bottom).inset(-60)
            //make.centerY.equalTo(progressOfProtein)
            make.left.right.equalTo(0)
        }
        labelFat.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.right.equalTo(0)
        }
        labelCarbonates.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.right.equalTo(0)
        }
        labelCalories.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.right.equalTo(0)
        }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        labelForProtein.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(labelProtein.snp.bottom).inset(-10)
            make.left.right.equalTo(0)
        }
        labelForFat.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(labelFat.snp.bottom).inset(-10)
            make.left.right.equalTo(0)
        }
        labelForCarbonates.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(labelCarbonates.snp.bottom).inset(-10)
            make.left.right.equalTo(0)
        }
        labelForCalories.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(labelCalories.snp.bottom).inset(-10)
            make.left.right.equalTo(0)
        }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        stackForStatistics.addArrangedSubview(stackForProtein)
        stackForStatistics.addArrangedSubview(stackForFat)
        stackForStatistics.addArrangedSubview(stackForCarbonates)
        stackForStatistics.addArrangedSubview(stackForCalories)
        
        stackForStatistics.axis = .vertical
        stackForStatistics.distribution = .equalSpacing

        progressOfProtein.trackTintColor = .gray
        progressOfFat.trackTintColor = .gray
        progressOfCalories.trackTintColor = .gray
        progressOfCarbonates.trackTintColor = .gray
        
        stackForStatistics.backgroundColor = .buttonBackColor
        
        stackForStatistics.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.height.equalTo(250)
                make.top.equalTo(buttonForCalend.snp.bottom).inset(-20)
        }
    }
    
    func createTableViewForFood() {
        let viewForTableView = UIView()
        viewForTableView.backgroundColor = .brown
        contentView.addSubview(viewForTableView)
        viewForTableView.snp.makeConstraints { make in
            make.top.equalTo(stackForStatistics.snp.bottom).inset(-20)
            make.left.right.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
            make.bottom.equalToSuperview().inset(20)
        }
        
        self.tableViewForFood.register(TableViewCellForFood.self, forCellReuseIdentifier: TableViewCellForFood.identificator)
        tableViewForFood.dataSource = self.helper
        tableViewForFood.delegate = self.helper
        viewForTableView.addSubview(tableViewForFood)
        tableViewForFood.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func createButtonForAddFood() {
        view.addSubview(buttonForAddFood)
        
        buttonForAddFood.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(90)
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(64)
        }
        
        buttonForAddFood.layer.cornerRadius = 0.5 * buttonForAddFood.bounds.size.width
        buttonForAddFood.clipsToBounds = true
        
        buttonForAddFood.setBackgroundImage(UIImage(systemName: "text.badge.plus"), for: .normal)
        buttonForAddFood.tintColor = .titleColor
        
        buttonForAddFood.addTarget(self, action: #selector(addFood), for: .touchUpInside)
    }
    @objc func addFood() {
        let vc = FindFoodVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CaloriesVC: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        UICalendarView.Decoration.default()
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let date = dateComponents?.date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        
        if let date = date {
            let formatteddate = formatter.string(from: date as Date)
            self.helper.date = formatteddate
            buttonForCalend.setTitle(formatteddate, for: .normal)
            print("self.helper.date   \(self.helper.date)")
            
            if let products = self.helper.products {
                self.helper.arraysForDate.removeAll()
                for prod in products {
                    print("prod.date = \(prod.date)")
                    print("self.helper.date = \(self.helper.date)")
                    if prod.date == self.helper.date {
                            self.helper.arraysForDate.append(prod)
                            print("array = \(self.helper.arraysForDate)")
                    }
                }
                print("self.helper.arraysForDate.count = \(self.helper.arraysForDate.count)")
            }
            updateProgressView()
            self.tableViewForFood.reloadData()
        }
    }
}
extension CaloriesVC {
    func updateProgressView() {
        self.progressOfProtein.progress = 0
        self.progressOfFat.progress = 0
        self.progressOfCarbonates.progress = 0
        self.progressOfCalories.progress = 0
        
        var maxCcal = 0
        var goal: String = ""
        var gender: String = ""
        var multiForProt: Double = 0.0
        var multiForFats: Double = 0.0
        var multiForCarb: Double = 0.0
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                maxCcal = Int(result.reccomendCcal)
                goal = result.goal ?? ""
                gender = result.gender ?? ""
            }
        } catch {
            print(error)
        }
        
        switch goal {
        case Goals.norma.rawValue:
            if gender == Genders.man.rawValue {
                    multiForProt = 0.3
                    multiForFats = 0.3
                    multiForCarb = 0.4
            } else if gender == Genders.woman.rawValue {
                    multiForProt = 0.3
                    multiForFats = 0.3
                    multiForCarb = 0.4
                }
                break
        case Goals.weightUp.rawValue:
                if gender == Genders.man.rawValue {
                    multiForProt = 0.2
                    multiForFats = 0.2
                    multiForCarb = 0.6
                } else if gender == Genders.woman.rawValue {
                    multiForProt = 0.3
                    multiForFats = 0.2
                    multiForCarb = 0.5
                }
        case Goals.leaveWeight.rawValue:
                if gender == Genders.man.rawValue {
                    multiForProt = 0.6
                    multiForFats = 0.1
                    multiForCarb = 0.3
                } else if gender == Genders.woman.rawValue {
                    multiForProt = 0.5
                    multiForFats = 0.2
                    multiForCarb = 0.3
                }
        default:
            print("error")
        }
        
        let maxProt = multiForProt * Double(maxCcal)      // ?
        let maxFats = multiForFats * Double(maxCcal)     // ?
        let maxCarb = multiForCarb * Double(maxCcal)      // ?
        
        var countProt = 0.0
        var countFats = 0.0
        var countCarb = 0.0
        var countCcal = 0.0
        
        for product in self.helper.arraysForDate {
            countProt += product.proteins
            countFats += product.fats
            countCarb += product.carb
            countCcal += Double(product.ccal)
        }
        
        let percentOfProt = countProt / maxProt
        let percentOfFats = countFats / maxFats
        let percentOfCarb = countCarb / maxCarb
        let percentOfCcal: Float = Float(countCcal) / Float(maxCcal)
        
        self.progressOfProtein.progress += Float(percentOfProt)
        self.progressOfFat.progress += Float(percentOfFats)
        self.progressOfCarbonates.progress += Float(percentOfCarb)
        self.progressOfCalories.progress += percentOfCcal
        
        labelProtein.text = "Лимит белков на сегодня".localized() + " \(Int(Double(maxProt)))" + "(ккал)".localized() + ", \(Int(Double(maxProt) * 0.4))" + "(г.)".localized()
        labelFat.text = "Лимит жиров на сегодня".localized() + " \(Int(Double(maxFats)))" + "(ккал)".localized() + ", \(Int(Double(maxFats) * 0.9))" + "(г.)".localized()
        labelCarbonates.text = "Лимит углеводов на сегодня".localized() + " \(Int(Double(maxCarb)))" + "(ккал)".localized() + ", \(Int(Double(maxCarb) * 0.4))" + "(г.)".localized()
        labelCalories.text = "Лимит калорий на сегодня".localized() + " \(maxCcal)" + "(ккал)".localized()
        
        labelForProtein.text = "\(String(NSString(format:"%.2f", percentOfProt)))% (\(countProt) " + "ккал".localized() + ", \(String(NSString(format:"%.2f", countProt * 0.4)))" + "г.)".localized()
        labelForFat.text = "\(String(NSString(format:"%.2f", percentOfFats)))% (\(String(NSString(format:"%.2f", countFats * 0.9)))" + "г.)".localized()
        labelForCarbonates.text = "\(String(NSString(format:"%.2f", percentOfCarb)))% (\(countCarb) " + "ккал".localized() + ", \(String(NSString(format:"%.2f", countCarb * 0.4)))" + "г.)".localized()
        labelForCalories.text = "\(String(NSString(format:"%.2f", percentOfCcal)))% (\(String(NSString(format:"%.1f", countCcal))) " + "ккал)".localized()
    }
}

