//
//  TrainVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.04.2023.
//

import UIKit
import AVFoundation


protocol TrainVCProtocol: AnyObject {
    func configureNavifationItems()
    func createLabelForTitle()
    
    func setConstrainsForButtonStart()
    
    func setConstrainsForTimerLabel()
    
    func createButtonForStartTrain()
    
    func createActiveCircular()
    
    func basicAnimation()
    
    func createViewForVideo()
    
    func createImageView()
    
    func createCircular()
    
    func createViewForTimer()
    
    func createVideo()
    
    func blockButtonTitle()
    
    func unblockButtonTitle()
    
    func decrementDurationTime()
    
    func returnCurrentDurationTime() -> Int
    
    func updatePlayer(name: String)
    
    func VideosAreOver()
    
    func setTimerLabelText(text: String)
    
    func determAndUpdateDurationTime()
    
}

class TrainVC: UIViewController {
    var presenter: TrainPresenterProtocol?
    
    let labelForTitle = LabelTitle()
    
    let buttonForStartTrain = MainButton()
    let viewForTimer = UIView()
    
    let viewForVideo = UIView()
    var imageView = UIImageView()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 84)
        label.textColor = #colorLiteral(red: 0.4952206612, green: 0.09120831639, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var timer = Timer()
    var durationTime: Int?
    
    let shapeLayer = CAShapeLayer()
    
    
    var player: AVPlayer?
    var layer = AVPlayerLayer()
    
    func getPlayer() {
        let path = Bundle.main.path(forResource: "Отжимания", ofType: "mov")
        guard let path = path else { return }
        //let url = URL(filePath: path)
        let url = URL(fileURLWithPath: path)

        player = AVPlayer(url: url)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        presenter?.determDurationTime()
        timerLabel.text = "\(durationTime ?? 15)"
        presenter?.viewDidLoaded()
        getPlayer()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }
    
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        player?.seek(to: CMTime.zero)
        player?.play()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter?.createCircular()
        presenter?.createActiveCircular()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        if player != nil{
            player?.pause()
            player?.replaceCurrentItem(with: nil)
            player = nil
            layer.player = nil
            timer.invalidate()
        }
    }
}

extension TrainVC: TrainVCProtocol {
    func setConstrainsForButtonStart() {
        buttonForStartTrain.snp.makeConstraints { button in
            button.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            button.left.right.equalToSuperview().inset(20)
            button.height.equalTo(56)
        }
    }
    
    func setConstrainsForTimerLabel() {
        viewForTimer.addSubview(timerLabel)
        
        timerLabel.snp.makeConstraints { label in
            label.centerX.equalTo(viewForTimer.snp.centerX)
            label.centerY.equalTo(viewForTimer.snp.centerY)
        }
    }
    
    func createButtonForStartTrain() {
        view.addSubview(buttonForStartTrain)
        
        buttonForStartTrain.setTitle("Начать тренировку".localized(), for: .normal)
        buttonForStartTrain.addTarget(self, action: #selector(startTrain), for: .touchUpInside)
       
        self.setConstrainsForButtonStart()
    }
    @objc func startTrain() {
        imageView.removeFromSuperview()
        presenter?.startAnimation()
        presenter?.blockButtonTitle()
        presenter?.createVideo()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction() {
        presenter?.updateTimerLabel()
    }
    
    
    func createActiveCircular() {
        let center = CGPoint(x: viewForTimer.frame.width / 2, y: viewForTimer.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: viewForTimer.frame.height / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 16
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = #colorLiteral(red: 0.4952206612, green: 0.09120831639, blue: 0, alpha: 1)
        viewForTimer.layer.addSublayer(shapeLayer)
    }
    
    func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTime ?? 15)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    func createImageView() {
        viewForVideo.addSubview(imageView)
        imageView.image = UIImage(named: "СпортТренировка")
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(0)
            make.top.equalTo(labelForTitle.snp.bottom).inset(0)
            //make.height.lessThanOrEqualTo(300)
            make.bottom.equalTo(viewForTimer.snp.top).inset(0)
        }
    }
    
    func createViewForVideo() {
        view.addSubview(viewForVideo)
 
        viewForVideo.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(0)
            make.top.equalTo(labelForTitle.snp.bottom).inset(0)
            make.bottom.equalTo(viewForTimer.snp.top).inset(0)
        }
    }
    
    
    func configureNavifationItems() {
        let leftButton = UIButton()
        
        leftButton.clipsToBounds = true
        leftButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        leftButton.layer.cornerRadius = 0.5 * leftButton.bounds.size.width
        
        
        leftButton.setBackgroundImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        leftButton.tintColor = .tabBarMainColor
        leftButton.addTarget(self, action: #selector(comeback), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func comeback() {
        presenter?.didTapBack()
    }
    
    func createLabelForTitle() {
        view.addSubview(labelForTitle)
        
        labelForTitle.text = "Тренировка".localized()
        
        labelForTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func createCircular() {
        let center = CGPoint(x: viewForTimer.frame.width / 2, y: viewForTimer.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: viewForTimer.frame.height / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 12
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        viewForTimer.layer.addSublayer(shapeLayer)
    }
    
    func createViewForTimer() {
        view.addSubview(viewForTimer)
        
        viewForTimer.backgroundColor = .clear
        
        viewForTimer.snp.makeConstraints { view in
            view.bottom.equalTo(buttonForStartTrain.snp.top).inset(-30)
            //
            view.centerX.equalTo(self.view.snp.centerX)
            view.width.equalTo(100)
            view.height.equalTo(100)
            //
            //view.left.right.equalToSuperview().inset(40)
            //view.height.equalTo(self.view.snp.width).inset(80)
        }
    }
    
    func createVideo() {
        layer = AVPlayerLayer(player: player)

        layer.frame = viewForVideo.frame
        layer.videoGravity = .resizeAspect
        view.layer.addSublayer(layer)
        player?.volume = 0
        player?.play()
    }
    
    func blockButtonTitle() {
        buttonForStartTrain.setTitle("Идет тренировка...".localized(), for: .normal)
        buttonForStartTrain.isEnabled = false
    }
    func unblockButtonTitle() {
        buttonForStartTrain.setTitle("Начать тренировку".localized(), for: .normal)
        buttonForStartTrain.isEnabled = true
    }
    
    func decrementDurationTime() {
        durationTime = (durationTime ?? 15) - 1
    }
    
    func returnCurrentDurationTime() -> Int {
        return durationTime ?? 15
    }
    
    func updatePlayer(name: String) {
        player?.pause()
        player = AVPlayer()
        layer.removeFromSuperlayer()
        layer.player = nil
        viewForVideo.layer.sublayers?.removeAll()
        
        let path = Bundle.main.path(forResource: name, ofType: "mov")
        guard let path = path else { return }
        //let url = URL(filePath: path)
        let url = URL(fileURLWithPath: path)
        
        player = AVPlayer(url: url)
        layer = AVPlayerLayer(player: player)
        layer.frame = viewForVideo.frame
        layer.videoGravity = .resizeAspect
        
        view.layer.addSublayer(layer)
        player?.volume = 0
        player?.play()
    }
    
    
    func VideosAreOver() {
        timerLabel.text = "\((durationTime ?? 15) - 1)"
        timer.invalidate()
        player?.pause()
        player = AVPlayer()
        layer.removeFromSuperlayer()
        layer.player = nil
        viewForVideo.layer.sublayers?.removeAll()
        presenter?.createImageView()
        imageView.image = UIImage(named: "Финиш")
        presenter?.unblockButtonTitle()
        
        getPlayer()
        
        layer = AVPlayerLayer(player: player)
        layer.frame = viewForVideo.frame
        layer.videoGravity = .resizeAspect
        
        player?.volume = 0
    }
    
    func setTimerLabelText(text: String) {
        timerLabel.text = text
    }
    
    func determAndUpdateDurationTime() {
        switch presenter?.determeGoal() {
        case Goals.leaveWeight.rawValue:
            if durationTime != nil {
                //durationTime = 31
                durationTime = 7
            } else {
                //durationTime = 30
                durationTime = 6
            }
            break
        case Goals.norma.rawValue:
            if durationTime != nil {
                //durationTime = 21
                durationTime = 9
            } else {
                //durationTime = 20
                durationTime = 8
            }
            break
        case Goals.weightUp.rawValue:
            if durationTime != nil {
                //durationTime = 11
                durationTime = 11
            } else {
                //durationTime = 10
                durationTime = 10
            }
            break
        default:
            print("error")
        }
        //durationTime = presenter?.determDurationTimeForGoal() ?? 15 + 1
    }
}
