//
//  String.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 13/02/2024.
//

import Foundation

extension String {
    // in WeekTableView
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
    
    
}
