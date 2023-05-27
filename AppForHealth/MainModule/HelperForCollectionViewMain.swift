//
//  HelperForCollectionViewMain.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.05.2023.
//

import UIKit

class HelperForCollectionViewMain: NSObject {
    
    var presenter: MainPresenterProtocol?
    
    var model: ModelOfDataMain?
    var mockData: MockData?
    private let sections: [ListSection]
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        self.model = ModelOfDataMain(genderAndAge: presenter.showGenderAgeLabel(), imt: presenter.showIMTLabel(), heightAndWeight: presenter.showHeightWeightBodyFatLabel(), reccomnedCcal: presenter.showReccomendCaloriesLabel(), reccomnedWater: presenter.showRecomendWaterLabel(), imageParametry: "Рулетка", imageIMT: "ИМТ", imageCcal: "КалорииКартинка", imageWater: "СтаканВоды")

        self.mockData = MockData(model: model!)
        self.sections = mockData!.pageData
    }
    let identifierForMini = "MiniCollectViewCell"
    let identifierForButtons = "CellForButtons"
    let identifierForMain = "MainCollectViewCell"

    let identifierForHeader = "Header"
}

extension HelperForCollectionViewMain {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            
            let section = self.sections[sectionIndex]
            switch section {
            case .menuScrollMini(_):
                return self.createMiniSection()
            case .buttons(_):
                return self.createButtonsSection()
            case .menuScrollMain(_):
                return self.createMainSection()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    private func createMiniSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(0.16)), subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 5,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 0)
        return section
    }
    
    private func createButtonsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)), subitems: [item])
        group.interItemSpacing = .flexible(10)
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    private func createMainSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.45)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 0,
                                          supplementaryItems: [],
                                          contentInsets: false)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}

extension HelperForCollectionViewMain: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
        case .menuScrollMini(let menuMini):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierForMini, for: indexPath) as? CellForMiniSection
                    
            else {
                return UICollectionViewCell()
            }
            cell.configurateCell(imageName: menuMini[indexPath.row].image, labelText: menuMini[indexPath.row].title)
            return cell
            
        case .buttons(let menuButtons):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierForButtons, for: indexPath) as? CellForButtons
                    
            else {
                return UICollectionViewCell()
            }
            cell.configurateCell(imageName: menuButtons[indexPath.row].image, labelText: menuButtons[indexPath.row].title.localized())
            return cell
            
        case .menuScrollMain(let menuMain):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierForMain, for: indexPath) as? CellForMainSection
                    
            else {
                return UICollectionViewCell()
            }
            cell.configurateCell(labelText: menuMain[indexPath.row].title, descriptionText: menuMain[indexPath.row].description)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifierForHeader, for: indexPath) as! Header
            header.configureHeader(sectionName: sections[indexPath.section].headerTitle)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .menuScrollMini(_):
            collectionView.scrollToItem(at: NSIndexPath(row: indexPath.row, section: 2) as IndexPath, at: .centeredHorizontally, animated: true)
        case .buttons(let button):
            switch button[indexPath.row].title {
            case "Рецепты":
                presenter?.tapOnRecipes()
            case "Вода":
                presenter?.tapOnWater()
            case "Тренировка":
                presenter?.tapOnTrain()
            case "Калории":
                presenter?.tapOnCcal()
            case "Карта":
                presenter?.tapOnMap()
            case "Настройки":
                presenter?.tapOnSetting()
            default:
                break
            }
        case .menuScrollMain(_):
            print("menuScrollMain")
        }
    }
}
