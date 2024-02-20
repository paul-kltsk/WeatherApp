//
//  TableViewHeader.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 16/02/2024.
//

import Foundation
import UIKit

class TableViewHeader: UIView {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        imageView.frame = CGRect(x: 10,
                                 y: 0,
                                 width: 20,
                                 height: self.frame.height)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray4
        imageView.image = UIImage(systemName: "calendar")
        addSubview(imageView)
        
        label.frame = CGRect(x: imageView.frame.maxX + 5,
                             y: 0,
                             width: self.frame.width - 25,
                             height: self.frame.height)
        label.text = "Прогноз на 5 дней"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .systemGray4
        addSubview(label)
    }
    
}
