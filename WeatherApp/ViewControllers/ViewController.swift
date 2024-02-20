//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 09/02/2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private let screenSize = UIScreen.main.bounds
    
    private var scrollView = UIScrollView()
    
    private var nowWeatherView = NowWeatherView()
    private var dayWeatherView = DayWeatherView()
    private var weekWeatherView = UITableView()
    
    private var weatherData: WeatherModel?

    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupView()
        
        setConstraints()
        
        addDayWeatherView()
        addNowWeatherView()
        
        startUpdateWeather()
        
    }
    
    //MARK: - Logic functions
    private func startUpdateWeather() {
        LocationManager.shared.requestLocation { result in
            switch result {
            case .success(let coordinate):
                let lon = coordinate.longitude
                let lat = coordinate.latitude
                NetworkManager.shared.fetchData(lat: lat, lon: lon) { result in
                    switch result {
                    case .success(let weatherData):
                        DispatchQueue.main.async {
                            guard let data = try? JSONDecoder().decode(WeatherModel.self, from: weatherData) else { return }
                            self.dayWeatherView.scrollViewSetting(weatherData: data)
                            self.weekWeatherView = WeekTableView(frame: CGRectZero, style: .insetGrouped, data: data)
                            self.addWeekWeatherView()
                            self.nowWeatherView.updateLabels(weatherData: data, lon: lon, lat: lat)
                        }
                    
                    case .failure(let error):
                        print("Error to get weather data: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Error to get lcoation: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - UI elements setting
    private func setupUI() {
        //scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled  = true
        scrollView.bounds = self.view.bounds
        //background color
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemCyan.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    //MARK: - Setup view
    private func setupView() {
        
        setupUI()
        view.addSubview(scrollView)
        setConstraints()
        addDayWeatherView()
        addNowWeatherView()
        
    }
    
    //Add NowWeatherView
    private func addNowWeatherView() {
        
        nowWeatherView.frame = CGRect(x: 5,
                                  y: 10,
                                  width: Int(scrollView.bounds.width) - 10,
                                  height: Int(screenSize.height * 0.25))
        scrollView.addSubview(nowWeatherView)

        nowWeatherView.setNeedsDisplay()

    }
    
    //Add DayWeatherView
    private func addDayWeatherView() {
        dayWeatherView.frame = CGRect(x: 15,
                                      y: Int(nowWeatherView.frame.maxY) + 20,
                                      width: Int(scrollView.bounds.width) - 30,
                                      height: Int(screenSize.height * 0.20))
        scrollView.addSubview(dayWeatherView)

 
        dayWeatherView.setNeedsDisplay()
    }
    
    //Add WeekWeatherView
    private func addWeekWeatherView() {
        weekWeatherView.frame = CGRect(x: 15,
                                       y: dayWeatherView.frame.maxY + 20,
                                       width: scrollView.bounds.width - 30,
                                       height: 250)
        
        scrollView.addSubview(weekWeatherView)
        
        weekWeatherView.setNeedsDisplay()
    }
    
    //MARK: - Constaints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

