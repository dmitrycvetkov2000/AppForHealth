//
//  WaterVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import UIKit

protocol WaterVCProtocol: AnyObject {
    func configureNavigationItems()
    
    func createViewForAnimation()
    
    func createMainPartOfCup() -> CAShapeLayer
    func createBackPartOfCup() -> CAShapeLayer
    func createHandlePartOfCup() -> CAShapeLayer
    
    func setupCup()
    
    func startAnimation()
}

class WaterVC: UIViewController {
    var presenter: WaterPresenterProtocol?

    let leftButton = UIButton()
    
    var labelNumberOfWater = LabelTitle()
    var buttonIncWater = MiniButton()
    
    var viewForAnimation = UIView()
    
    var swipeRecognizer: UISwipeGestureRecognizer?
    
    func setSwipeRecognizer() {
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipeRecognizer!.direction = .right
        view.addGestureRecognizer(swipeRecognizer!)
    }
    @objc func swipeGesture(sender: UISwipeGestureRecognizer) {
        presenter?.didTapLeftButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwipeRecognizer()
        view.backgroundColor = .brown
        presenter?.configureNavigationItems()
        presenter?.getCurDate()
        createButtonForWater(buttonIncWater, self)
        presenter?.showViewForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createLabelNumberOfWater(labelNumberOfWater)
        createLabelNumberOfWaterConstraints(labelNumberOfWater)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter?.setupCup()
    }
}

extension WaterVC: WaterVCProtocol {
    func configureNavigationItems() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.clipsToBounds = true
        leftButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        leftButton.layer.cornerRadius = 0.5 * leftButton.bounds.size.width
        
        leftButton.setBackgroundImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        leftButton.tintColor = .tabBarMainColor
        leftButton.addTarget(self, action: #selector(openMain), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    @objc func openMain() {
        presenter?.didTapLeftButton()
    }
    
    func createLabelNumberOfWater(_ label: UILabel) {
    
        view.addSubview(label)
        
        label.text = "\(presenter?.countingTheAmountOfWater() ?? 0) " + "мл".localized()
    }
    func createLabelNumberOfWaterConstraints(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func createViewForAnimation() {
        
        viewForAnimation.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(viewForAnimation)
    
        viewForAnimation.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            viewForAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewForAnimation.topAnchor.constraint(equalTo: buttonIncWater.bottomAnchor, constant: 40),
            viewForAnimation.heightAnchor.constraint(equalToConstant: 160),
            viewForAnimation.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    func setupCup() {
        let main = presenter?.getMainPartOfCup() ?? CAShapeLayer()
        let handle = presenter?.getHandlePartOfCup() ?? CAShapeLayer()
        let back = presenter?.getBackPartOfCup() ?? CAShapeLayer()
        
        viewForAnimation.layer.addSublayer(main)
        viewForAnimation.layer.addSublayer(handle)
        viewForAnimation.layer.addSublayer(back)
    }
    
    func createMainPartOfCup() -> CAShapeLayer {
        let widthView = viewForAnimation.frame.width
        let heightView = viewForAnimation.frame.height
        
        let mainShape = CAShapeLayer()
        mainShape.frame = viewForAnimation.bounds
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: heightView))
        path.addQuadCurve(to: CGPoint(x: widthView, y: heightView), controlPoint: CGPoint(x: widthView / 2, y: heightView + 18))
        path.addLine(to: CGPoint(x: widthView, y: 0))
        path.addQuadCurve(to: CGPoint(x: 0, y: 0), controlPoint: CGPoint(x: widthView / 2, y: 16))
        path.addLine(to: CGPoint(x: 0, y: heightView))
        
        path.close()
        
        mainShape.fillColor = UIColor.black.cgColor
        mainShape.strokeColor = UIColor.black.cgColor
        mainShape.path = path.cgPath
        
        return mainShape
    }
    
    func createBackPartOfCup() -> CAShapeLayer {
        let widthView = viewForAnimation.frame.width
        
        let backShape = CAShapeLayer()
        backShape.frame = viewForAnimation.bounds
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: widthView, y: 0))
        path.addQuadCurve(to: CGPoint(x: 0, y: 0), controlPoint: CGPoint(x: widthView / 2, y: 16))
        path.addCurve(to: CGPoint(x: widthView, y: 0), controlPoint1: CGPoint(x: 30, y: -20), controlPoint2: CGPoint(x: widthView - 30, y: -20))
        
        path.close()
        
        backShape.fillColor = UIColor.white.cgColor
        backShape.strokeColor = UIColor.black.cgColor
        backShape.path = path.cgPath
        
        return backShape
    }
    
    func createHandlePartOfCup() -> CAShapeLayer {
        let widthView = viewForAnimation.frame.width
        let heightView = viewForAnimation.frame.height
        
        let handleShape = CAShapeLayer()
        handleShape.frame = viewForAnimation.bounds
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: widthView, y: 40))
        path.addCurve(to: CGPoint(x: widthView, y: heightView - 40), controlPoint1: CGPoint(x: widthView + 40, y: 40), controlPoint2: CGPoint(x: widthView + 40, y: heightView - 40))
        path.addLine(to: CGPoint(x: widthView, y: heightView - 20))
        path.addCurve(to: CGPoint(x: widthView, y: 20), controlPoint1: CGPoint(x: widthView + 56, y: heightView - 40), controlPoint2: CGPoint(x: widthView + 56, y: 40))
        
        path.close()
        
        handleShape.fillColor = UIColor.black.cgColor
        handleShape.strokeColor = UIColor.black.cgColor
        handleShape.path = path.cgPath
        
        return handleShape
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")

        animation.duration = 2
        animation.autoreverses = true
        animation.toValue = -Double.pi / 4

        viewForAnimation.layer.add(animation, forKey: nil)
    }
    
    func createButtonForWater(_ button: UIButton, _ vc: UIViewController) {
        button.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(button)
        
        button.backgroundColor = .blue
        
        button.setTitle("Выпил стакан воды".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapWaterButton), for: .touchUpInside)
        
        button.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    }
    
    @objc func tapWaterButton() {
        presenter?.saveDataAndIncWater(label: labelNumberOfWater)
        presenter?.startAnimation()
    }
    
}
