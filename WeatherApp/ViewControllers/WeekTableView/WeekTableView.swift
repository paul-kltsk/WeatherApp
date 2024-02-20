//
//  WeekTableView.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 13/02/2024.
//

import Foundation
import UIKit

class WeekTableView: UITableView {
    
    private let cellID = "WeekCell"
    var weatherData: WeatherModel
    
    private var day = ""
    private var isNight = false
    
    private var dayIndex = 0
    private var nightIndex = 0
    
    private let serilQueue = DispatchQueue.global(qos: .userInteractive)
    
    
    init(frame: CGRect, style: UITableView.Style, data: WeatherModel) {
        
        self.weatherData = data
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0.1, alpha: 0.1)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.isScrollEnabled = false

        register(WeekTableViewCell.self, forCellReuseIdentifier: cellID)
        delegate = self
        dataSource = self
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func findMaxTemp(weatherData: WeatherModel, day: String) -> Double {
            var tempsArr = [Double]()
            let dayDate = String(day.dropLast(9))
            for i in self.weatherData.list {
                let currentDat = String(i.dtTxt.dropLast(9))
                if currentDat == dayDate {
                    tempsArr.append(i.main.temp)
                }
            }
            return tempsArr.max()!
    }
    
}

extension WeekTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 // only 5 days in free version openweathermap
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? WeekTableViewCell else { return UITableViewCell() }
        
        DispatchQueue.main.async {
        //DayLabel
        if indexPath.row == 0 {
            cell.dayLabel.text = "Сегодня"
            self.day = self.weatherData.list[0].dtTxt
            self.isNight = self.day.extractHour().isNight() ? true : false
        } else {
            self.day = self.weatherData.list[indexPath.row * 8].dtTxt
            
            cell.dayLabel.text = self.day.dayOfWeek()
            self.dayIndex += 8
        }
        
        // Night
            if self.isNight {
                self.nightIndex += indexPath.row * 8
                let nightTemp = String(self.weatherData.list[self.nightIndex].main.temp).beforeDotWithCelsius()
            cell.nightTempLabel.text = "Н: \(nightTemp!)"
                let imageKey = self.weatherData.list[self.nightIndex].weather[0].icon.rawValue
            cell.nightImageView.image = Icons.shared.getIcon(key: imageKey)
        } else {
            self.nightIndex = Int(self.day.extractHour().findNightIndex()) + (indexPath.row * 8)
            let nightTemp = String(self.weatherData.list[self.nightIndex].main.temp).beforeDotWithCelsius()
            cell.nightTempLabel.text = "Н: \(nightTemp!)"
            let imageKey = self.weatherData.list[self.nightIndex].weather[0].icon.rawValue
            cell.nightImageView.image = Icons.shared.getIcon(key: imageKey)
        }
        
        //Day
            let maxTemp = self.findMaxTemp(weatherData: self.weatherData, day: self.day)
            let dayTemp = String(maxTemp).beforeDotWithCelsius()
            cell.dayTempLabel.text = "Д: \(dayTemp!)"
            let imageKey = self.weatherData.list[self.dayIndex].weather[0].icon.rawValue
            cell.dayImageView.image = Icons.shared.getIcon(key: imageKey)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Прогноз на 5 дней"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableViewHeader(frame: CGRect(x: 0, y: 0, width: self.frame.width - 10, height: 30))
        return view
    }
        
}
