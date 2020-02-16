//
//  ViewController.swift
//  HonestWeather
//
//  Created by Adam Siekierski on 09/02/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController {
  @IBOutlet weak var ShortDescription: UILabel!
  let locationManager = CLLocationManager()

  var longitude:Double = 0
  var latitude:Double = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self

    getLocation()
  }

  func getWeather() -> Void {
    if (longitude != 0 && latitude != 0) {
      AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API_KEY)&units=metric").responseJSON { response in
        let json = JSON(response.data!)

        self.ShortDescription.text = WeatherDescriptions.shortDescription(weather: json)
        UIView.animate(withDuration: 1, animations: {
          self.ShortDescription.alpha = 1
        })
      }
    }
  }
  
  func requestLocationPermission() -> Bool {
    var status = CLLocationManager.authorizationStatus()

    if(status == .notDetermined){
      locationManager.requestWhenInUseAuthorization()
      status = CLLocationManager.authorizationStatus()
    }
    
    if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
      let alert = UIAlertController(
        title: "Lokalizacja",
        message: "Pozwolenie na korzystanie z usług lokalizacji nie zostało udzielone. Aby móc korzystać z HonestWeather, musisz udzielić go ręcznie, w Ustawieniach",
        preferredStyle: .alert
      )
      self.present(alert, animated: true)

      return false
    }
    
    return true
  }

  func getLocation() -> Void {
    if (requestLocationPermission()) {
      locationManager.requestLocation()
    }
  }
}

extension ViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      self.longitude = location.coordinate.longitude
      self.latitude = location.coordinate.latitude

      getWeather()
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    let alert = UIAlertController(
      title: "Location",
      message: "Jest problem z twoją lokalizacją. Upewnij się że GPS jest włączony i że masz połączenie z internetem",
      preferredStyle: .alert
    )
    self.present(alert, animated: true)
  }
}
