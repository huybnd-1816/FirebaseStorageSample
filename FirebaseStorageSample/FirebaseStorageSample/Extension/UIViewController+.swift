//
//  UIViewController+.swift
//  FirebaseStorageSample
//
//  Created by nguyen.duc.huyb on 7/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
}
