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

let API = "https://honestweather-api.herokuapp.com/api/v1"

class ViewController: UIViewController {
  @IBOutlet weak var ShortDescription: UILabel!
  let locationManager = CLLocationManager()

  var longitude:Double? = nil
  var latitude:Double? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self

    getLocation()
  }

  func getWeather() -> Void {
    if (longitude != 0 && latitude != 0) {
      AF.request("\(API)/weather?lat=\(latitude!)&long=\(longitude!)&units=metric&lang=pl").responseJSON { response in
        let json = JSON(response.data!)

        self.ShortDescription.text = json["message"].string
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
