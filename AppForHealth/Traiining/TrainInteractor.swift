//
//  TrainInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.04.2023.
//

import Foundation
//import AVFoundation

protocol TrainInteractorProtocol: AnyObject {
    func decrementDurationTime()
}

class TrainInteractor: TrainInteractorProtocol {
    weak var presenter: TrainPresenterProtocol?
    
    var masVideos: [String] = ["Отжимания", "Приседания", "Бёрпи", "Пресс"]
    var score: Int = 0
    
    func decrementDurationTime() {
        presenter?.decrementDurationTime()
        presenter?.setTimerLabelText(text: "\(presenter?.returnCurrentDurationTime() ?? 15)")
        
        if presenter?.returnCurrentDurationTime() ?? 15 < 0 {
            score += 1
            presenter?.determDurationTime()
            //let durationTimer = (presenter?.determDurationTimeForGoal() ?? 15) + 1
            presenter?.setTimerLabelText(text: "\(presenter?.returnCurrentDurationTime() ?? 15)")

            if score <= masVideos.count - 1 {
                presenter?.updatePlayer(name: masVideos[score])
                presenter?.updateTimerLabel()
                presenter?.startAnimation()

            } else {
                score = 0
                presenter?.VideosAreOver()
            }
        }
    }
}
