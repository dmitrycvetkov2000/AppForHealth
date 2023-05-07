//
//  TrainPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.04.2023.
//

import UIKit

protocol TrainPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func createCircular()
    
    func updateTimerLabel()
    
    func createActiveCircular()
    
    func startAnimation()
    
    func blockButtonTitle()
    
    func unblockButtonTitle()
    
    func createVideo()
    
    func createImageView()
    
    func determeGoal() -> String
    
    func didTapBack()
    
    func decrementDurationTime()
    
    func returnCurrentDurationTime() -> Int
    
    func updatePlayer(name: String)
    
    func VideosAreOver()
    
    func setTimerLabelText(text: String)
    
    func determDurationTime()
}

class TrainPresenter {
    weak var view: TrainVCProtocol?
    var router: TrainRouterProtocol
    var interactor: TrainInteractorProtocol
    
    init(interactor: TrainInteractorProtocol, router: TrainRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension TrainPresenter: TrainPresenterProtocol {
    
    func viewDidLoaded() {
        view?.configureNavifationItems()
        view?.createLabelForTitle()
        view?.createButtonForStartTrain()
        view?.createViewForTimer()
        view?.createViewForVideo()
        view?.createImageView()
        view?.setConstrainsForTimerLabel()
    }
        
    func createImageView() {
        view?.createImageView()
    }
    
    func updateTimerLabel() {
        interactor.decrementDurationTime()
    }
    
    
    func createCircular() {
        view?.createCircular()
    }
    
    
    func createActiveCircular() {
        view?.createActiveCircular()
    }
    
    func startAnimation() {
        view?.basicAnimation()
    }
    
    
    func blockButtonTitle() {
        view?.blockButtonTitle()
    }
    func unblockButtonTitle() {
        view?.unblockButtonTitle()
    }
    
    
    func createVideo() {
        view?.createVideo()
    }
    
    
    func determeGoal() -> String {
        let goal: String? = CoreDataManager.instance.getElementFromBD(find: "goal")
        print(goal ?? "No")
        return goal ?? ""
    }
    
    func didTapBack() {
        router.dismiss()
    }
    
    func decrementDurationTime() {
        view?.decrementDurationTime()
    }
    
    func returnCurrentDurationTime() -> Int {
        view?.returnCurrentDurationTime() ?? 15
    }
    
    func updatePlayer(name: String) {
        view?.updatePlayer(name: name)
    }
    
    func VideosAreOver() {
        view?.VideosAreOver()
    }
    
    func setTimerLabelText(text: String) {
        view?.setTimerLabelText(text: text)
    }
    
    func determDurationTime() {
        view?.determAndUpdateDurationTime()
    }
}
