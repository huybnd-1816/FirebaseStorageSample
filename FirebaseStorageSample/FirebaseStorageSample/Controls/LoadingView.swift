//
//  LoadingView.swift
//  FirebaseStorageSample
//
//  Created by nguyen.duc.huyb on 8/8/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class LoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setupView()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        self.isHidden = true
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private let progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

extension LoadingView {
    private func setupView() {
        self.addSubview(progressView)
    }
    
    private func setupConstraint() {
        let leadingConstraint = progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64)
        let centerXConstraint = progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerYConstraint = progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        self.addConstraints([leadingConstraint, centerXConstraint, centerYConstraint])
    }
    
    func setProgressValue(_ percent: Float) {
        progressView.setProgress(percent, animated: true)
    }
}
