//
//  ViewController.swift
//  FirebaseStorageSample
//
//  Created by nguyen.duc.huyb on 7/26/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import FirebaseAuth

final class MainViewController: UIViewController {
    @IBOutlet private weak var audioTableView: UITableView!
    
    private var viewModel: MainViewModel!
    private var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButton()
        setupLoadingView()
        config()
    }

    private func setupBarButton() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOutTapped))
    }
    
    @objc
    private func handleSignOutTapped() {
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error while signing out!")
        }
    }
    
    private func setupLoadingView() {
        loadingView = LoadingView(frame: (navigationController?.view.bounds)!)
        navigationController?.view.addSubview(loadingView)
        navigationController?.view.bringSubviewToFront(loadingView)
    }
    
    private func config() {
        navigationItem.title = "Audio"
        viewModel = MainViewModel()
        audioTableView.register(UINib(nibName: "AudioCell", bundle: nil), forCellReuseIdentifier: "AudioCell")
        audioTableView.delegate = viewModel
        audioTableView.dataSource = viewModel
        audioTableView.tableFooterView = UIView(frame: .zero)
        audioTableView.rowHeight = UITableView.automaticDimension
        audioTableView.estimatedRowHeight = 64
        
        viewModel.didChanged = { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.audioTableView.reloadData()
            case .failure(let error):
                self.showAlert(title: "Error", message: error?.localizedDescription)
            }
        }
        
        FirebaseService.shared.didShowPercentage = { [weak self] percent in
            guard let self = self else { return }
            self.loadingView.isHidden = false
            self.loadingView.setProgressValue(Float(percent))
        }
        
        FirebaseService.shared.didUploadCompleted = { [weak self] in
            guard let self = self else { return }
            self.loadingView.isHidden = true
        }
    }
}

extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
