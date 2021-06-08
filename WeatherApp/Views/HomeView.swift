//
//  HomeView.swift
//  WeatherApp
//
//  Created by Ahmed Mohamed on 06/06/2021.
//

import UIKit

final class HomeView: UIView {
    
    var currentDegree = UILabel()
    var currentClimate = UILabel()
    var minDegree = UILabel()
    var minLabel = UILabel()
    var currentLabel = UILabel()
    var maxDegree = UILabel()
    var currentDegreeS = UILabel()
    var maxLabel = UILabel()
    var tableView = UITableView()
    var backgroundImageView = UIImageView()
    var straightLineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 84/255, green: 113/255, blue: 122/255, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupCurrentClimateBackgroundImage()
        setupCurrentDegree()
        setupCurrentClimate()
        setupMinDegreeViews()
        setupCurrentDegreeViews()
        setupMaxDegreeViews()
        createDividerLine()
        setupTableView()
    }
    
    private func setupCurrentClimateBackgroundImage() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "sea_cloudy")
        backgroundImageView.contentMode = .scaleAspectFill
        
        addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func setupCurrentDegree() {
        currentDegree.translatesAutoresizingMaskIntoConstraints = false
        currentDegree.text = ""
        currentDegree.font = .systemFont(ofSize: 48)
        currentDegree.textColor = .label
        
        addSubview(currentDegree)
        currentDegree.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        currentDegree.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func setupCurrentClimate() {
        currentClimate.translatesAutoresizingMaskIntoConstraints = false
        currentClimate.text = ""
        currentClimate.font = .systemFont(ofSize: 40)
        currentClimate.textColor = .label
        
        addSubview(currentClimate)
        currentClimate.topAnchor.constraint(equalTo: currentDegree.bottomAnchor, constant: 10).isActive = true
        currentClimate.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func setupMinDegreeViews() {
        minDegree.translatesAutoresizingMaskIntoConstraints = false
        minDegree.text = ""
        minDegree.textColor = .label
        minDegree.font = .systemFont(ofSize: 20)
        
        addSubview(minDegree)
        minDegree.topAnchor.constraint(equalTo: currentClimate.bottomAnchor, constant: 100).isActive = true
        minDegree.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.text = "min"
        minLabel.textColor = .label
        minLabel.font = .systemFont(ofSize: 17)
        
        addSubview(minLabel)
        minLabel.topAnchor.constraint(equalTo: minDegree.bottomAnchor, constant: 5).isActive = true
        minLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupCurrentDegreeViews() {
        currentDegreeS.translatesAutoresizingMaskIntoConstraints = false
        currentDegreeS.text = ""
        currentDegreeS.textColor = .label
        currentDegreeS.font = .systemFont(ofSize: 20)
        
        addSubview(currentDegreeS)
        currentDegreeS.topAnchor.constraint(equalTo: currentClimate.bottomAnchor, constant: 100).isActive = true
        currentDegreeS.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        currentLabel.translatesAutoresizingMaskIntoConstraints = false
        currentLabel.text = "Current"
        currentLabel.textColor = .label
        currentLabel.font = .systemFont(ofSize: 17)
        
        addSubview(currentLabel)
        currentLabel.topAnchor.constraint(equalTo: currentDegreeS.bottomAnchor, constant: 5).isActive = true
        currentLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func setupMaxDegreeViews() {
        maxDegree.translatesAutoresizingMaskIntoConstraints = false
        maxDegree.text = ""
        maxDegree.textColor = .label
        maxDegree.font = .systemFont(ofSize: 20)
        
        addSubview(maxDegree)
        maxDegree.topAnchor.constraint(equalTo: currentClimate.bottomAnchor, constant: 100).isActive = true
        maxDegree.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.text = "max"
        maxLabel.textColor = .label
        maxLabel.font = .systemFont(ofSize: 17)
        
        addSubview(maxLabel)
        maxLabel.topAnchor.constraint(equalTo: maxDegree.bottomAnchor, constant: 5).isActive = true
        maxLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func createDividerLine() {
        straightLineView.translatesAutoresizingMaskIntoConstraints = false
        straightLineView.layer.borderWidth = 1
        straightLineView.layer.borderColor = UIColor.white.cgColor
        
        addSubview(straightLineView)
        straightLineView.topAnchor.constraint(equalTo: minLabel.bottomAnchor, constant: 20).isActive = true
        straightLineView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        straightLineView.widthAnchor.constraint(equalToConstant: 500).isActive = true
        straightLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = UIColor(red: 80/255, green: 114/255, blue: 129/255, alpha: 0.8)
        
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: straightLineView.bottomAnchor, constant: 10.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}
