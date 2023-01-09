//
//  OnboardVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit

protocol OnboardVCProtocol: AnyObject {
    
}
class OnboardVC: UIViewController {
    var presenter: OnboardPresenterProtocol?
    
    var viewOfOnboard = UIView()
    
    let scrollView = UIScrollView()
}

extension OnboardVC: OnboardVCProtocol {

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .brown
//        createImage()
        presenter?.viewDidLoaded(viewOfOnboard: viewOfOnboard, vc: self)
            
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.configure()
    }
    
    private func configure() {
        scrollView.frame = viewOfOnboard.bounds
        viewOfOnboard.addSubview(scrollView)
        
        let titles = ["Welcome", "Second", "Third"]
//        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 60, height: 120))
//        label.textAlignment = .center
//        label.font = UIFont(name: "Vasek", size: 1000)
//        label.numberOfLines = 1
//        label.adjustsFontSizeToFitWidth = true
//        view.addSubview(label)
//        label.text = "Govno"
        
        for x in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * viewOfOnboard.frame.size.width, y: 0, width: viewOfOnboard.frame.size.width, height: viewOfOnboard.frame.size.height))
            scrollView.addSubview(pageView)

            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width - 20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10 + 120 + 10, width: pageView.frame.size.width - 20, height: pageView.frame.size.height - 60 - 130 - 15))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height - 60, width: pageView.frame.size.width - 20, height: 50))

            label.textAlignment = .center
            label.font = UIFont(name: "Vasek", size: 32)
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true

            pageView.addSubview(label)
            label.text = titles[x]

            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome_\(x+1)")
            pageView.addSubview(imageView)

            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle("Продолжить", for: .normal)
            if x == 2 {
                button.setTitle("Начать", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton(_ :)), for: .touchUpInside)
            button.tag = x + 1
            pageView.addSubview(button)
            print("TTTTTTTTTT")
            
        }
        
        scrollView.contentSize = CGSize(width: viewOfOnboard.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }
    @objc func didTapButton(_ button: UIButton) {
        guard button.tag < 3 else {
            //dissmiss
            //appDelegate?.window.
            Core.shared.setIsNotNewUser()
            presenter?.didTappedLastButton()
            return
        }
        scrollView.setContentOffset(CGPoint(x: viewOfOnboard.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        //scroll to the next page
    }

    
//    func createImage(view: UIView) {
//        viewOfOnboard.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(viewOfOnboard)
//        
//        
//        viewOfOnboard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        viewOfOnboard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        viewOfOnboard.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        viewOfOnboard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//    }
}
