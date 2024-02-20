//
//  IconModel.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 16/02/2024.
//

import Foundation
import UIKit

struct Icons {
    
    static let shared = Icons()
    
    let iconStorage: [(String,String,String)] = [
        ("01d","sun.max.fill","Чистое небо"),
        ("01n","moon.fill","Чистое небо"),
        ("02d","cloud.sun.fill","Немного облачно"),
        ("02n","cloud.moon.fill","Немного облачно"),
        ("03d","cloud.fill","Облачно без осадков"),
        ("03n","cloud.fill","Облачно без осадков"),
        ("04d","smoke.fill","Облачно с прояснениями"),
        ("04n","smoke.fill","Облачно с прояснениями"),
        ("09d","cloud.heavyrain.fill","Сильный дождь"),
        ("09n","cloud.heavyrain.fill","Сильный дождь"),
        ("10d","cloud.sun.rain.fill","Дождь"),
        ("10n","cloud.moon.rain.fill","Дождь"),
        ("11d","cloud.bolt.rain.fill","Гроза"),
        ("11n","cloud.bolt.rain.fill","Гроза"),
        ("13d","cloud.snow.fill","Снег"),
        ("13n","cloud.snow.fill","Снег"),
        ("50d","cloud.fog","Туман"),
        ("50n","cloud.fog","Туман")
    ]
    
    func getIcon(key: String) -> UIImage {
        var image = UIImage()
        for tuple in iconStorage {
            if tuple.0 == key {
                let imageName = tuple.1
                image = (UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal))!
                break
            }
        }
        return image
    }
    
    func getDesc(key: String) -> String {
        for tuple in iconStorage {
            if tuple.0 == key {
                return tuple.2
            }
        }
        return ""
    }
    
}
