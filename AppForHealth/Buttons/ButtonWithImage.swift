//
//  ButtonWithImage.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.05.2023.
//

import UIKit
struct ButtonWithImageViewModel {
    let title: String
    let imageName: String
    
}
class ButtonWithImage: UIButton {
    let titleLabelForButton: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    let imageViewForButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var viewModel: ButtonWithImageViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    init(with viewModel: ButtonWithImageViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        addSubviews()
        configure(with: viewModel)
    }
    func addSubviews() {
        guard !titleLabelForButton.isDescendant(of: self) else { return }
        addSubview(titleLabelForButton)
        addSubview(imageViewForButton)
    }
    
    func configure(with viewModel: ButtonWithImageViewModel) {
        addSubviews()
        titleLabelForButton.text = viewModel.title
        titleLabelForButton.textColor = .black
        imageViewForButton.image = UIImage(systemName: viewModel.imageName)
        imageViewForButton.tintColor = .forJustText
        
        self.backgroundColor = .tabBarMainColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal Error")
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        titleLabelForButton.frame = CGRect(x: 5, y: 5, width: frame.width - frame.height-5, height: frame.height - 10)
        imageViewForButton.frame = CGRect(x: frame.width - frame.height-5, y: 0, width: frame.height, height: frame.height)        
    }
}
