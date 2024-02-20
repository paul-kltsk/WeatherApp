//
//  String.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 13/02/2024.
//

import Foundation

extension String {
    
    //in DayWeatherView
    func extractHour() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: self) {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                return String(format: "%02d", hour)
            }
            return ""
        }
    
    //in WeekTableView
    func isNight() -> Bool {
        let nightHours = ["00", "03"]
        return nightHours.contains(self) ? true : false
    }    
    
    
    func findNightIndex() -> Int {
        let hoursArr = ["00","03","06","09","12","15","18","21"]
        let currentIndex = hoursArr.firstIndex(of: self)!
        return 7 - Int(currentIndex) + 2
    }
    
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: date)
            
            switch weekday {
            case 1:
                return "Вс"
            case 2:
                return "Пн"
            case 3:
                return "Вт"
            case 4:
                return "Ср"
            case 5:
                return "Чт"
            case 6:
                return "Пт"
            case 7:
                return "Сб"
            default:
                return nil
            }
        }
        
        return nil
    }
    
    // Use in all views
    func beforeDotWithCelsius() -> String? {
        if let dotIndex = self.firstIndex(of: ".") {
            return String(self[..<dotIndex]) + "°"
        }
        return nil
    }
    
}
