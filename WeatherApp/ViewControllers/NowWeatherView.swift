//
//  NowWeatherView.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 09/02/2024.
//

import UIKit

class NowWeatherView: UIView {
    
    private var placeNameLabel = UILabel()
    private var currentTemperatureLabel = UILabel()
    private var temperatureDescribingLabel = UILabel()
    private var minMaxLabel = UILabel()
    
    private var stackView = UIStackView()

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
    
    func updateLabels(weatherData: WeatherModel, lon: Double, lat: Double) {
        
        LocationManager.shared.cityNameForCoordinates(latitude: lat, longitude: lon) { name in
            self.placeNameLabel.text = name
        }
        
        let temp = String(weatherData.list[0].main.temp).beforeDotWithCelsius()
        currentTemperatureLabel.text = temp
        
        let descKey = weatherData.list[0].weather[0].icon.rawValue
        temperatureDescribingLabel.text = Icons.shared.getDesc(key: descKey)
        
        let minMax = findMinMax(weatherData: weatherData)
        minMaxLabel.text = "Мин: " + minMax.0 + ", Макс: " + minMax.1
    }
    
    private func findMinMax(weatherData: WeatherModel) -> (String,String) {
        var tempArr = [Double]()
        for i in weatherData.list[0...7] {
            tempArr.append(i.main.temp)
        }
        
        let min = tempArr.min()!
        let max = tempArr.max()!
        
        return ((String(min).beforeDotWithCelsius())!,(String(max).beforeDotWithCelsius())!)
    }
    
    //MARK: - Setup view
    private func setupView() {
        setupLabel(label: placeNameLabel, fontSize: 40, weight: .semibold)
        setupLabel(label: currentTemperatureLabel, fontSize: 60, weight: .semibold)
        setupLabel(label: temperatureDescribingLabel, fontSize: 20, weight: .medium)
        setupLabel(label: minMaxLabel, fontSize: 20, weight: .medium)
        
        stackView = UIStackView(arrangedSubviews: [placeNameLabel,
                                                  currentTemperatureLabel,
                                                  temperatureDescribingLabel,
                                                  minMaxLabel],
                                axis: .vertical,
                                spacing: 0,
                                distribution: .fillProportionally)
        
        addSubview(stackView)
    }
    
    private func setupLabel(label: UILabel, fontSize: CGFloat, weight: UIFont.Weight) {
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
