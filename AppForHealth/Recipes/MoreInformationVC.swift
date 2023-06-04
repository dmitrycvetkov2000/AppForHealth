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
    var image = UIImage()
    
    var firstBlockAboutReceipt = UIView()
    
    var nameOfReceipt = ""
    var time = 0
    
    var instructionsOfReceipt = ""
    
    var ingredients = [(image: UIImage, amount: Double, type: String, name: String)]()
    
    
    
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
    func addInContentView() {
        //contentView.addSubview(imageView)
        imageView = UIImageView(image: self.image)
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
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let mainLabel = UILabel()
        mainLabel.text = "Рецепт"
        mainLabel.textColor = #colorLiteral(red: 0.1688624322, green: 0.1845664382, blue: 0.206782639, alpha: 1)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 1
        
        stackView.addArrangedSubview(mainLabel)
        
        
        let nameLabel = UILabel()
        nameLabel.text = "\(nameOfReceipt)"
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 16)
        
        stackView.addArrangedSubview(nameLabel)
        
        let timeLabel = UILabel()
        timeLabel.text = "Время готовки: \(time)"
        timeLabel.textColor = #colorLiteral(red: 0.1688624322, green: 0.1845664382, blue: 0.206782639, alpha: 1)
        timeLabel.textAlignment = .center
        
        stackView.addArrangedSubview(timeLabel)
    }
    
    
    
    
    let labelInstructions: UILabel = {
        let label = UILabel()
        label.text = "Инструкции по приготовлению"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
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
    
    func createStackForIngredients() {
        contentView.addSubview(stackForIngredients)
        stackForIngredients.snp.makeConstraints { make in
            make.top.equalTo(firstBlockAboutReceipt.snp.bottom).inset(-20)
            make.left.right.equalToSuperview().inset(0)
        }
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelInstructions).inset(26)
        }
    }
    var masImages = [UIImage]()
    
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("DDD id = \(id)")

        group.enter()
        
        ApiManager.shared.getMoreInfoAboutReceipt(id: id) { [weak self] info in
            guard let self = self else { return }

            if let ingredients = info.extendedIngredients {
                var dataOfIngredient: (image: UIImage, amount: Double, type: String, name: String) = (image: UIImage(), amount: Double(), type: String(), name: String())
                for ingredient in ingredients {
                    if let imageOfIngredient = ingredient.image {
                        if let url = URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(imageOfIngredient)") {
                            group.enter()
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                defer {
                                    self.group.leave()
                                }
                                if let imageData = data {
                                    self.masImages.append(UIImage(data: imageData) ?? UIImage())
                                }
                            }.resume()
                        }
                    }
                    group.enter()
                    if let amount = ingredient.amount {
                        dataOfIngredient.amount = amount
                    }
                    if let type = ingredient.measures?.metric?.unitLong {
                        dataOfIngredient.type = type
                    }
                    if let name = ingredient.nameClean {
                        dataOfIngredient.name = name
                    }
                    
                    
                        self.ingredients.append(dataOfIngredient)
                    group.leave()
                }
            }

            self.nameOfReceipt = info.title ?? "Не найдено"
            self.instructionsOfReceipt = info.instructions ?? "Не найдено"

            if let time = info.readyInMinutes {
                    self.time = time
            }
            self.group.leave()
        }
       
        group.notify(queue: .main) {
            self.createScrollView()
            self.addInContentView()

            self.createStackForIngredients()
            for (indexOfImage, ingredient) in self.ingredients.indexed() {
                self.createStackIngredient(image: indexOfImage, name: ingredient.name, type: ingredient.type, amount: ingredient.amount)
            }

            self.createLabelInstructions()
            self.createLabelForInstruction(text: self.instructionsOfReceipt)
        }
    }
    

    func createStackIngredient(image: Int, name: String, type: String, amount: Double) {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        //stack.distribution = .equalSpacing
        let imageView = UIImageView()
        imageView.image = masImages[image]
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
        var types = String()
        
        switch type {
        case "servings": types = "кубиков"
        case "mediums": types = "средних"
        case "milliliters": types = "мл"
        case "cloves": types = "долек"
        case "Tbsps": types = "ложки"
        case "grams": types = "гр"
        case "large": types = "больших"
        case "liters": types = "литров"
        case "medium": types = "средний"
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
        stack.addArrangedSubview(labelName)
        
        amountLabel.text = "\(amount) \(types)"
        stack.addArrangedSubview(amountLabel)

        stackForIngredients.addArrangedSubview(stack)
    }
}
