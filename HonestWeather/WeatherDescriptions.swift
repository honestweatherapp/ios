//
//  WeatherDescriptions.swift
//  HonestWeather
//
//  Created by Adam Siekierski on 16/02/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import SwiftyJSON

class WeatherDescriptions {
  static func shortDescription(weather: JSON) -> String {
    var description = ""
    if (weather["main"]["feels_like"].int! <= 5) {
      description = "Piździ w chuj"
    }
    return description
  }
}
