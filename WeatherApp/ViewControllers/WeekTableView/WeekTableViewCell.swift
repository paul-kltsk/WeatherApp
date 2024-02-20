//
//  WeekTableViewCell.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 13/02/2024.
//

import UIKit

class WeekTableViewCell: UITableViewCell {
    
    var dayLabel = UILabel()
    var nightTempLabel = UILabel()
    var dayTempLabel = UILabel()
    var nightImageView = UIImageView()
    var dayImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - cell setting
    private func setupCell() {
        //dayLabel
        dayLabel.frame = CGRect(x: 5,
                                y: 0,
                                width: self.bounds.width * 0.30,
                                height: self.bounds.height)
        dayLabel.textColor = .white
        dayLabel.textAlignment = .left
        dayLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(dayLabel)
        //nightTempLabel
        nightTempLabel.frame = CGRect(x: dayLabel.frame.maxX,
                                      y: 0,
                                      width: self.bounds.width * 0.24,
                                      height: self.bounds.height)
        nightTempLabel.textColor = .systemGray3
        nightTempLabel.textAlignment = .center
        nightTempLabel.adjustsFontSizeToFitWidth = true
        nightTempLabel.minimumScaleFactor = 0.5
        nightTempLabel.adjustsFontForContentSizeCategory = true
        nightTempLabel.font = UIFont.systemFont(ofSize: 18)
        nightTempLabel.text = "Н: "
        self.addSubview(nightTempLabel)
        //nightImageView
        nightImageView.frame = CGRect(x: nightTempLabel.frame.maxX,
                                      y: self.bounds.height * 0.3 / 2,
                                      width: self.bounds.width * 0.1,
                                      height: self.bounds.height * 0.7)
        nightImageView.contentMode = .scaleAspectFit
        self.addSubview(nightImageView)
        //dayTempLabel
        dayTempLabel.frame = CGRect(x: nightImageView.frame.maxX,
                                    y: 0,
                                    width: self.bounds.width * 0.24,
                                    height: self.bounds.height)
        dayTempLabel.textColor = .white
        dayTempLabel.textAlignment = .center
        dayTempLabel.font = UIFont.systemFont(ofSize: 18)
        dayTempLabel.adjustsFontSizeToFitWidth = true
        dayTempLabel.text = "Д: "
        self.addSubview(dayTempLabel)
        //dayImageView
        dayImageView.frame = CGRect(x: dayTempLabel.frame.maxX,
                                    y: self.bounds.height * 0.3 / 2,
                                    width: self.bounds.width * 0.1,
                                    height: self.bounds.height * 0.7)
        dayImageView.contentMode = .scaleAspectFit
        self.addSubview(dayImageView)
    }

}
