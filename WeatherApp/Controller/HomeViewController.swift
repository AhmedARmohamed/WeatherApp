//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ahmed Mohamed on 06/06/2021.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var models = [daily]()
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    var tableview = UITableView()
    
    let cellId = "cell"
    
    var tempLabel = UILabel()
    var descriptionLabel = UILabel()
    var minDegreeLabel = UILabel()
    var currentDegreeLabel = UILabel()
    var maxDegreeLabel = UILabel()
    var backgroundImage = UIImageView()
    
    var curentWeather: CurrentWeather?
    var day: daily?
    var climate : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        configureTableView()
    }

    override func loadView() {
        let home = HomeView()
        view = home
        tableview = home.tableView
        tempLabel = home.currentDegree
        descriptionLabel = home.currentClimate
        minDegreeLabel = home.minDegree
        currentDegreeLabel = home.currentDegreeS
        maxDegreeLabel = home.maxDegree
        backgroundImage = home.backgroundImageView
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    // Location
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let longitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        
        print(longitude)
        print(latitude)
        
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&appid=ba4627a535e4a389660a210125a70fa7"
        
//        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=ba4627a535e4a389660a210125a70fa7"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            // Validation
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            // Convert data to models/ some object
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            } catch {
                print("error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            let entries = result.daily
            print(entries)
            self.models.append(contentsOf: entries)
            
            let current = result.current
            self.curentWeather = current
            
            let daily = result.daily
            for day in daily {
                self.day = day
            }
            
            // Update user interface
            DispatchQueue.main.async {
                self.tableview.reloadData()
                self.updateCurrentDegreeLabel()
            }
        })
        .resume()
    }
    
    func configureTableView() {
        setTableViewDelegates()
        tableview.rowHeight = 80
        tableview.allowsSelection = false
        tableview.separatorStyle = .singleLine
        tableview.isScrollEnabled = true
        tableview.tableFooterView = UIView()

    }

    func setTableViewDelegates() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(WeatherTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func updateCurrentDegreeLabel () {
        guard let currentWeatherr = curentWeather else {
            return
        }
        
        guard let dailyWeatherr = day else {
            return
        }
        let currentDegree = currentWeatherr.temp
        let maxTemperature = dailyWeatherr.temp.max
        let minTemperature = dailyWeatherr.temp.min
        
        tempLabel.text = "\(String(format: "%.0f", currentDegree - 273.15))°"
        minDegreeLabel.text =  "\(String(format: "%.0f", minTemperature - 273.15))°"
        maxDegreeLabel.text = "\(String(format: "%.0f", maxTemperature - 273.15))°"
        currentDegreeLabel.text = "\(String(format: "%.0f", currentDegree - 273.15))°"
        
        for climates in dailyWeatherr.weather {
            self.climate = climates.main
        }
        
        if climate.contains("Rain") {
            self.backgroundImage.image = UIImage(named: "sea_rainy")
            view.backgroundColor = UIColor(red: 87/255, green: 87/255, blue: 93/255, alpha: 1)
            tableview.backgroundColor = UIColor(red: 87/255, green: 87/255, blue: 93/255, alpha: 1)
        } else if climate.contains("Clouds") {
            self.backgroundImage.image = UIImage(named: "sea_cloudy")
            view.backgroundColor = UIColor(red: 84/255, green: 113/255, blue: 122/255, alpha: 1)
            tableview.backgroundColor = UIColor(red: 84/255, green: 113/255, blue: 122/255, alpha: 1)
        } else {
            self.backgroundImage.image = UIImage(named: "sea_sunnypng")
            view.backgroundColor = UIColor(red: 71/255, green: 171/255, blue: 47/255, alpha: 1)
            tableview.backgroundColor = UIColor(red: 71/255, green: 171/255, blue: 47/255, alpha: 1)
        }
        
        descriptionLabel.text = climate.uppercased()
    }
    
}

extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WeatherTableViewCell
        
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
}

