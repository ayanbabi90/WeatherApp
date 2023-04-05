//
//  ContactUsView.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import SwiftUI
import UIKit

struct ContactUsView: UIViewControllerRepresentable {
    var onEmailButtonTapped: (() -> Void)?
    var onCallButtonTapped: (() -> Void)?
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ContactUsUIViewController(nibName: "ContactUsUIViewController", bundle: nil)
        viewController.onEmailButtonTapped = {
            let recipientEmail = "ayan.babi90@email.com"
            if let emailURL = URL(string: "mailto:\(recipientEmail)") {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            }
            onEmailButtonTapped?() ?? {}()
        }
        viewController.onCallButtonTapped = {
            if let phoneCallURL = URL(string: "tel://+91-8759252443") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
            onCallButtonTapped?() ?? {}()
        }
        return viewController
    }

    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
