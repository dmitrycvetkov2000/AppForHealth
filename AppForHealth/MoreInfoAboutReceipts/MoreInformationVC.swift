//
//  MoreInformationVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 16.05.2023.
//

import UIKit

protocol MoreInformationVCProtocol: AnyObject {
    func createScrollView()
    func addInContentView(nameOfReceipt: String, time: Int)
    func createStackForIngredients()
    
    func createStackIngredient(image: UIImage, name: String, type: String, amount: Double)
    func createLabelInstructions()
    func createLabelForInstruction(text: String)
    
    func setFirstBlockAboutReceipt(nameOfReceipt: String, time: Int)
}

class MoreInformationVC: UIViewController {
    var presenter: MoreInformationPresenterProtocol?
    
    var id = 0
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var imageView = UIImageView()
    var image = UIImage()
    
    var firstBlockAboutReceipt = UIView()

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
    
    let labelInstructions: UILabel = {
        let label = UILabel()
        label.text = "Инструкции по приготовлению".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let stackForIngredients: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.downloadData(id: id)
    }
}

extension MoreInformationVC: MoreInformationVCProtocol {
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = true
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 1800)
        
        contentView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height + 1800)
        
        contentView.backgroundColor = .white
    }
    
    func addInContentView(nameOfReceipt: String, time: Int) {
        imageView = UIImageView(image: self.image)
        contentView.addSubview(imageView)
        contentView.insertSubview(firstBlockAboutReceipt, at: 1)
        setImageView()
        setFirstBlockAboutReceipt(nameOfReceipt: nameOfReceipt, time: time)
    }
    
    func createStackForIngredients() {
        contentView.addSubview(stackForIngredients)
        stackForIngredients.snp.makeConstraints { make in
            make.top.equalTo(firstBlockAboutReceipt.snp.bottom).inset(-20)
            make.left.right.equalToSuperview().inset(0)
        }
    }
    
    func createStackIngredient(image: UIImage, name: String, type: String, amount: Double) {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints { make in
            make.width.equalTo(76)
            make.height.equalTo(76)
        }
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        stack.addArrangedSubview(imageView)
        
        let amountLabel = UILabel()
        amountLabel.clipsToBounds = true
        amountLabel.textAlignment = .right
        amountLabel.textColor = .black
        var types = String()
        
        switch type {
        case "servings": types = "кубиков".localized()
        case "mediums": types = "средних".localized()
        case "milliliters": types = "мл".localized()
        case "cloves": types = "долек".localized()
        case "Tbsps": types = "ложки".localized()
        case "grams": types = "гр".localized()
        case "large": types = "больших".localized()
        case "liters": types = "литров".localized()
        case "medium": types = "средний".localized()
        default:
            types = ""
        }
        
        let labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(76)
        }
        labelName.text = name
        labelName.textAlignment = .left
        labelName.textColor = .black
        stack.addArrangedSubview(labelName)
        
        amountLabel.text = "\(amount) \(types)"
        stack.addArrangedSubview(amountLabel)

        stackForIngredients.addArrangedSubview(stack)
    }
    
    func createLabelInstructions() {
        contentView.addSubview(labelInstructions)
        labelInstructions.snp.makeConstraints { make in
            make.top.equalTo(stackForIngredients.snp.bottom).inset(-20)
            make.left.right.equalToSuperview()
        }
    }
    
    func createLabelForInstruction(text: String) {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelInstructions).inset(26)
        }
    }
    
    
    func setFirstBlockAboutReceipt(nameOfReceipt: String, time: Int) {
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
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let mainLabel = UILabel()
        mainLabel.text = "Рецепт".localized()
        mainLabel.textColor = #colorLiteral(red: 0.1688624322, green: 0.1845664382, blue: 0.206782639, alpha: 1)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 1
        
        stackView.addArrangedSubview(mainLabel)
        
        
        let nameLabel = UILabel()
        nameLabel.text = "\(nameOfReceipt)"
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textColor = #colorLiteral(red: 0.2451882064, green: 0.2716457546, blue: 0.3039766848, alpha: 1)
        
        stackView.addArrangedSubview(nameLabel)
        
        let timeLabel = UILabel()
        timeLabel.text = "Время готовки:".localized() + " \(time)"
        timeLabel.textColor = #colorLiteral(red: 0.1688624322, green: 0.1845664382, blue: 0.206782639, alpha: 1)
        timeLabel.textAlignment = .center
        
        stackView.addArrangedSubview(timeLabel)
    }
}
