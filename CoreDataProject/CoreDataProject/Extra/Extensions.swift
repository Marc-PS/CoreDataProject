//
//  Extensions.swift
//  CoreDataProject
//
//  Created by Marc Perelló Sapiña on 20/8/21.
//

import UIKit

enum DeleteAlert: String {
    case delete
    case cancell
}

extension UIViewController {
    func showAlert(_ alertTitle: String, _ alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showDeleteAlert(_ alertTitle: String, _ alertMessage: String, completion: @escaping (DeleteAlert) -> ()) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            completion(.cancell)
        }))
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            completion(.delete)
        }))
        present(alertController, animated: true, completion: nil)
    }
}
