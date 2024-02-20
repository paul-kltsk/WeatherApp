//
//  Extension+UILabel.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 16/02/2024.
//

import Foundation
import UIKit

extension UILabel {
    
    //in DayWeatherView
    func setupLabelsInDayView() {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.7
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = .white
        self.textAlignment = .center
    }
    
}
