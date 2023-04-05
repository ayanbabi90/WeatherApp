//
//  AboutUsView.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import SwiftUI
import UIKit

struct AboutUsView: View {
    var body: some View {
        VStack {
            Text("About Us")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            ScrollView {
                Text("The About Us page for this Code Challenge for iOS by Mphasis was designed and developed by me, Ayan Chakraborty. The page showcases the technology used in creating the project, which includes SwiftUI, UIKit, and Lottie for animation. I am a skilled iOS developer with a passion for creating intuitive, engaging user interfaces. With experience in Swift, I have developed numerous applications for iOS devices. In this project, I have showcased my expertise in SwiftUI, a modern framework for building user interfaces across all Apple platforms. Overall, I have demonstrated my skills as an iOS developer and my ability to leverage new technologies to create innovative solutions. The About Us page is a testament to my talent and commitment to delivering high-quality work.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
            }
        }
    }
}
