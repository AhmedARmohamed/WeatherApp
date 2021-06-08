//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Ahmed Mohamed on 06/06/2021.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    var current = UILabel()
     var dayLabel = UILabel()
     var highTempLabel = UILabel()
     var lowTempLabel = UILabel()
     var iconImageView = UIImageView()
    var iconn : String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: daily) {
        let maxTemperature = model.temp.max
        let minTemperature = model.temp.min
        self.lowTempLabel.text =  "\(String(format: "%.0f", minTemperature - 273.15))°"
        self.highTempLabel.text = "\(String(format: "%.0f", maxTemperature - 273.15))°"
        self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))
        
        for icon in model.weather {
            self.iconn = icon.main
        }
        
        let newIcon = iconn.lowercased()
        if newIcon.contains("clear") {
            self.iconImageView.image = UIImage(named: "clear")
        } else if newIcon.contains("rain") {
            self.iconImageView.image = UIImage(named: "rain")
        }
        else {
            // cloud icon
            self.iconImageView.image = UIImage(named: "sunny")
        }
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: inputDate)
    }
    
    private func setupViews() {
//        setupMinTemp()
        setupDay()
        setupIconImageView()
        setupMaxTemp()
    }
    
    private func setupIconImageView() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(named: "sunny")
        iconImageView.contentMode = .scaleAspectFill
        
        addSubview(iconImageView)
        iconImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupMinTemp() {
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lowTempLabel)
        lowTempLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        lowTempLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        lowTempLabel.heightAnchor.constraint(equalToConstant: 66).isActive = true
    }
    
    private func setupDay() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dayLabel)
        dayLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 66).isActive = true
    }
    
    private func setupMaxTemp() {
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(highTempLabel)
        highTempLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        highTempLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        highTempLabel.heightAnchor.constraint(equalToConstant: 66).isActive = true
    }
}

