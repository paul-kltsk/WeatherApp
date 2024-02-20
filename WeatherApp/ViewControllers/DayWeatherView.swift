//
//  DayWeatherView.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 10/02/2024.
//

import Foundation
import UIKit

class DayWeatherView: UIView {
    
    private var descriptionLabel = UILabel()
    private var lineView = UIView()
    private var scrollView = UIScrollView()
    
    //MARK: - Init / draw
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        setConstraints()
    }
    
    func scrollViewSetting(weatherData: WeatherModel) {
        
        let descKey = weatherData.list[5].weather[0].icon.rawValue
        let desc = Icons.shared.getDesc(key: descKey).lowercased()
        let fullDesc = "Завтра ожидается " + desc
        descriptionLabel.text = fullDesc
        
        let elementWidth = self.bounds.width / 6
        scrollView.contentSize.width = scrollView.frame.maxX * 8/6
        for i in 0...7 {
            
            let hourLabel = UILabel(frame: CGRect(x: elementWidth * CGFloat(i),
                                                  y: 0,
                                                  width: elementWidth,
                                                  height: scrollView.bounds.height * 0.4))
            hourLabel.setupLabelsInDayView()
            let time = weatherData.list[i].dtTxt.extractHour()
            hourLabel.text = time
            scrollView.addSubview(hourLabel)
            
            let imageView = UIImageView(frame: CGRect(x: elementWidth * CGFloat(i),
                                                      y: hourLabel.frame.maxY,
                                                      width: elementWidth,
                                                      height: scrollView.bounds.height * 0.25))
            imageView.contentMode = .scaleAspectFit
            let imageKey = weatherData.list[i].weather[0].icon.rawValue
            imageView.image = Icons.shared.getIcon(key: imageKey)
            scrollView.addSubview(imageView)
            
            let tempLabel = UILabel(frame: CGRect(x: elementWidth * CGFloat(i),
                                                  y: imageView.frame.maxY,
                                                  width: elementWidth,
                                                  height: scrollView.bounds.height * 0.35))
            tempLabel.setupLabelsInDayView()
            let temp = String(weatherData.list[i].main.temp).beforeDotWithCelsius()
            tempLabel.text = temp
            scrollView.addSubview(tempLabel)
        }
        
    }
    
    //MARK: - Setup view
    private func setupView() {
        //descriptionLabel
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        self.addSubview(descriptionLabel)
        //lineView
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0.1, alpha: 0.1)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            // descriptionLabel 35% of view height
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.35),
            // line view
            lineView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            //scroll view
            scrollView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
