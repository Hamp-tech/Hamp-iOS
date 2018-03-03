//
//  LoadingView.swift
//  LoadingScreen
//
//  Created by Aleix Baggerman on 14/11/2017.
//  Copyright © 2017 Aleix Baggerman. All rights reserved.
//

import UIKit

class LoadingViewController: HampViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage (named: "big-bag")
        return imageView
    } ()
    
    private let backgroundImageView:UIImageView = { ()
        let imageView = UIImageView ()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage (named: "laundry-background-pattern")
        return imageView
    } ()
    
    private let infoLabel: UILabel = {
        let label = UILabel ()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    } ()
    
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTimer(timeInterval: 1)
        setupViews ()
    }
    
    func dismissViewController () {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupTimer (timeInterval: TimeInterval) {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector (self.handleTimer), userInfo: nil, repeats: true)
        self.timer.fire()
    }
    
    func setupViews () {
        let logoWidth:CGFloat = 100
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(infoLabel)
        
        backgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 150, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: logoWidth, height: logoWidth)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)
    }
    
    @objc func handleTimer () {
        infoLabel.text = FrasesProvider.getRandomFrase()
    }
}
