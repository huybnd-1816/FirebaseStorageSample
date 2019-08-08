//
//  LoginViewController.swift
//  FirebaseStorageSample
//
//  Created by nguyen.duc.huyb on 7/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import FirebaseAuth

final class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.set(defaultMaskType: .clear)
        IHProgressHUD.set(maximumDismissTimeInterval: 1.0)
        
        //Check if user logined
        if Auth.auth().currentUser != nil {
            let vc = MainViewController.instantiate()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func handleSignInButtonTapped(_ sender: Any) {
        IHProgressHUD.show()
        Auth.auth().signInAnonymously() { [weak self] (authResult, error) in
            IHProgressHUD.dismiss()
            guard let self = self else { return }
            if let error = error {
                print("Sign in failed:", error.localizedDescription)

            } else {
//                print ("Signed in with uid:", authResult?.user.uid)
                let vc = MainViewController.instantiate()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
