//
//  MoreInformationVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 16.05.2023.
//

import UIKit

class MoreInformationVC: UIViewController {
    var id = 0
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var imageView = UIImageView()
    
    var firstBlockAboutReceipt = UIView()
    
    var nameOfReceipt = ""
    var time = 0
    
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = true
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 400)
        
        contentView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height + 400)
        
        contentView.backgroundColor = .white
    }
    func addInContentView() {
        contentView.addSubview(imageView)
        contentView.insertSubview(firstBlockAboutReceipt, at: 1)
        setImageView()
        setFirstBlockAboutReceipt()
    }
    func setImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        var aspectR: CGFloat = 0.0
        aspectR = (imageView.image?.size.width ?? 0)/(imageView.image?.size.height ?? 0)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/aspectR).isActive = true
    }
    
    func setFirstBlockAboutReceipt() {
        firstBlockAboutReceipt.layer.cornerRadius = 10
        firstBlockAboutReceipt.clipsToBounds = true
        firstBlockAboutReceipt.backgroundColor = #colorLiteral(red: 0.9606993794, green: 0.9817846417, blue: 0.915786922, alpha: 1)
        
        firstBlockAboutReceipt.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstBlockAboutReceipt.centerYAnchor.constraint(equalTo: imageView.bottomAnchor),
            firstBlockAboutReceipt.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            firstBlockAboutReceipt.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            firstBlockAboutReceipt.heightAnchor.constraint(equalToConstant: imageView.bounds.height/2)
        ])
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        firstBlockAboutReceipt.addSubview(stackView)
        stackView.axis = .vertical
        stackView.backgroundColor = .red
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        //stackView.clipsToBounds = true
        
        stackView.frame = firstBlockAboutReceipt.bounds
        stackView.frame.size.width = firstBlockAboutReceipt.bounds.width
        
        let mainLabel = UILabel()
        mainLabel.text = "Рецепт"
        mainLabel.textColor = .forJustText
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 1
        
        stackView.addArrangedSubview(mainLabel)
        
        let nameLabel = UILabel()
        nameLabel.text = "\(nameOfReceipt)"
        nameLabel.textAlignment = .center
        
        stackView.addArrangedSubview(nameLabel)
        
        let timeLabel = UILabel()
        timeLabel.text = "Время готовки: \(time)"
        timeLabel.textAlignment = .center
        
        stackView.addArrangedSubview(timeLabel)
    }
    let group = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        group.enter()
        ApiManager.shared.getMoreInfoAboutReceipt(id: id) { [weak self] info in
            
            guard let self = self else { return }
            //print("id = \(info.id)")
            //print("image = \(info.image)")
            //print("title = \(info.title)")
            //print("cookingMinutes = \(info.readyInMinutes)")
            print("instructions = \(info.instructions)")
            print("extendedIngredients = \(info.extendedIngredients?[0].nameClean)")
            print("extendedIngredients = \(info.extendedIngredients?[0].image)")
            print("aistle = \(info.nutrition)")
            print("nutr = \(info.nutrition.self)")
//            for i in info.nutrition?.properties {
//
//            }
            print("nutrAmount = \(info.nutrition?.nutrients?[0].name)")
            print("prop2 = \(info.nutrition?.properties?[1].name)")
            print("prop2Amount = \(info.nutrition?.properties?[0].amount)")
            
            
            self.nameOfReceipt = info.title ?? "Не найдено"
            
            
            if let time = info.readyInMinutes {
                    self.time = time
            }
            self.group.leave()
        }
        group.notify(queue: .main) {
            self.createScrollView()
            self.addInContentView()
        }
    }
}
