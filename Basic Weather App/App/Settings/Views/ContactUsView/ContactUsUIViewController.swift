//
//  ContactUsUIViewController.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import Foundation
import UIKit

class ContactUsUIViewController: UIViewController {
    var onEmailButtonTapped: (() -> Void)?
    var onCallButtonTapped: (() -> Void)?
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
        // Adjust layout based on size class
        if traitCollection.horizontalSizeClass == .compact {
            headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            emailButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            callButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Adjust layout based on size class
        if traitCollection.horizontalSizeClass == .compact {
            headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            emailButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            callButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        } else {
            headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            emailButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            callButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        }
    }
    
    func updateUI() {
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.text = "Contact Us"
        headerLabel.textAlignment = .center
        
        emailButton.setTitle("Email Me", for: .normal)
        emailButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        emailButton.tintColor = .white
        emailButton.backgroundColor = .blue
        emailButton.layer.cornerRadius = 10
        
        callButton.setTitle("Call Me", for: .normal)
        callButton.setImage(UIImage(systemName: "phone"), for: .normal)
        callButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        callButton.tintColor = .white
        callButton.backgroundColor = .blue
        callButton.layer.cornerRadius = 10
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        onEmailButtonTapped?()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
        onCallButtonTapped?()
        navigationController?.popViewController(animated: true)
    }
}
