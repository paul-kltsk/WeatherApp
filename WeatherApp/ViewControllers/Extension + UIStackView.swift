//
//  UIStackView.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 09/02/2024.
//

import Foundation
import UIKit


extension UIStackView {
    //in NowWeatherView
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
